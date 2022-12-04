
//
//	(C) Copyright Paul Campbell 2022 taniwha@gmail.com
//	Released under an Apache License 2.0
//

`default_nettype none

module moonbase_cpu_4bit #(parameter MAX_COUNT=1000) (input [7:0] io_in, output [7:0] io_out);
   
	//
	//	External interfacex
	//
	//	external address latch
	//		the external 7 bit address latch is loaded from io_out[6:0] when io_out[7] is 1	
	//	external SRAM (eg MWS5101AEL3):
	//		the external RAM always produces what is at the latch's addresses on io_in[5:2]
	//		the external SRAM is written when io_out[7] is 0 and io_out[5] is 0
	//		io_out[6] can be used as an extra address bit to split the address space between
	//			code (1) and data (0) to use a 256-nibble sram (woot!)
	//  external devices:
	//		external devices can be read from io_in[7:6] (at address pointed to by the address latch)
	//		external devices can be written from io_out[3:0] (at address pointed to by the address latch)
	//			when io_out[7] is 0 and io_out[4] is 0
	//
	//
	//	SRAM address space (data accesses):
	//		0-127	external
	//		128-131 internal	(internal ram cells, for filling up the die :-)
	//

	localparam N_LOCAL_RAM = 24;
     
    wire clk			= io_in[0];
    wire reset			= io_in[1];
    wire [3:0]ram_in	= io_in[5:2];
    wire [1:0]data_in	= io_in[7:6];
    
    reg       strobe_out;	// address strobe		- designed to be wired to a 7 bit latch and a MWS5101AEL3
    reg       write_data_n;	// write enable for data
    reg       write_ram_n;	// write enable for ram
    reg	      addr_pc;
    reg	      data_pc;
	wire [6:0]data_addr = ((r_tmp[3]?r_y[6:0]:r_x[6:0])+{4'b000, r_tmp[2:0]});
	wire	  is_local_ram = (r_tmp[3]?r_y[7]:r_x[7]);
	wire	  write_local_ram = is_local_ram & !write_ram_n;
	wire [$clog2(N_LOCAL_RAM)-1:0]local_ram_addr = data_addr[$clog2(N_LOCAL_RAM)-1:0];
    wire [6:0]addr_out = addr_pc ? r_pc : data_addr;							// address out mux (PC or X/Y+off)
    assign    io_out   = {strobe_out, strobe_out? addr_out : {data_pc, write_ram_n|is_local_ram, write_data_n, r_a}};  // mux address and data out

    reg  [6:0]r_pc, c_pc;	// program counter	// actual flops in the system 
    reg  [7:0]r_x, c_x;		// x index register	// by convention r_* is a flop, c_* is the combinatorial that feeds it
    reg  [7:0]r_y, c_y;		// y index register
    reg  [3:0]r_a, c_a;		// accumulator
    reg       r_c, c_c;		// carry flag
    reg  [3:0]r_tmp2, c_tmp2;// operand temp (high)
    reg  [3:0]r_tmp,  c_tmp;// operand temp (low)
	reg  [6:0]r_s0,   c_s0;	// call stack
	reg  [6:0]r_s1,   c_s1;
	reg  [6:0]r_s2,   c_s2;
	reg  [6:0]r_s3,   c_s3;

    //
    //	phase:
    //		0 - instruction fetch addr
    //		1 - instruction fetch data
    //		2 - const fetch addr 
    //		3 - const fetch data 
    //		4 - data/const fetch addr 
    //		5 - data/const fetch data 
    //		6 - execute/data store addr
    //		7 - data store data (might not do this)
    //
    reg [2:0]r_phase, c_phase;	// CPU internal state machine
	

    // instructions
    //
    //  0 v:	add a, v(x/y)	- sets C
    //  1 v: 	sub a, v(x/y)	- sets C
    //  2 v:	or a, v(x/y)
    //  3 v:	and a, v(x/y)
    //  4 v:	xor a, v(x/y)
    //  5 v:	mov a, v(x/y)
    //  6 v:	movd a, v(x/y)
    //  7 0:	swap x, y
    //	  1:    add a, c
    //	  2:    mov x.l, a
    //	  3:    ret
	//    4:    add y, a
    //	  5:    add x, a
	//    6:    add y, #1
	//    7:    add x, #1
    //	8 v:	mov a, #v
    //  9 v:	add a, #v 
    //  a v:	movd v(x/y), a
    //  b v:	mov  v(x/y), a
    //  c h l:	mov x, #hl
    //  d h l:	jne a/c, hl	if h[3] the test c otherwise test a
    //  e h l:	jeq a/c, hl	if h[3] the test c otherwise test a
    //  f h l:	jmp/call hl
    //
    //  Memory access - addresses are 7 bits - v(X/y) is a 3-bit offset v[2:0]
    //  	if  v[3] it's Y+v[2:0]
    //  	if !v[3] it's X+v[2:0]
    //
    //	The general idea is that X normally points to a bank of in sram 8 'registers',
    //		a bit like an 8051's r0-7, while X is a more general index register
	//		(but you can use both if you need to do	some copying)
    //		

    reg  [3:0]r_ins, c_ins;	// fetched instruction

	wire [4:0]c_add = {1'b0, r_a}+{1'b0, r_tmp};	// ALUs
	wire [4:0]c_sub = {1'b0, r_a}-{1'b0, r_tmp};
	wire [6:0]c_i_add = (r_tmp[0]?r_x:r_y)+(r_tmp[1]?7'b1:{3'b0, r_a});
	wire [6:0]c_pc_inc = r_pc+1;

	
	reg	 [3:0] r_local_ram[0:N_LOCAL_RAM-1];

	wire [3:0] local_ram = r_local_ram[local_ram_addr];
	always @(posedge clk)
	if (write_local_ram)
		r_local_ram[local_ram_addr] <= r_a;

    always @(*) begin
		c_ins  = r_ins;	
		c_x    = r_x;
		c_y    = r_y;
		c_a    = r_a;
		c_s0   = r_s0;
		c_s1   = r_s1;
		c_s2   = r_s2;
		c_s3   = r_s3;
		c_tmp  = r_tmp;
		c_tmp2 = r_tmp2;
		c_pc   = r_pc;
		c_c    = r_c;
		write_data_n = 1;
		write_ram_n = 1;
		addr_pc = 'bx;
		data_pc = 'bx;
    	if (reset) begin	// reset clears the state machine and sets PC to 0
			c_pc = 0;
			c_phase = 0;
			strobe_out = 1;
    	end else 
    	case (r_phase) // synthesis full_case parallel_case
    	0:	begin					// 0: address latch instruction PC
				strobe_out = 1;
				addr_pc = 1;
				c_phase = 1;
			end
    	1:	begin					// 1: read data in
				strobe_out = 0;
				data_pc = 1;
				c_ins = ram_in;
				c_pc = c_pc_inc;
				c_phase = 2;
			end
		2:	begin
				strobe_out = 1;			// 2: address latch operand PC
				addr_pc = 1;
				c_phase = 3;
			end
		3:	begin
				strobe_out = 0;			// 3: read operand
				c_tmp = ram_in;
				c_pc = c_pc_inc;
				data_pc = 1;
				case (r_ins) // synthesis full_case parallel_case
				7, 8, 9, 10, 11: c_phase = 6;// some instructions don't have a 2nd fetch
				default:	     c_phase = 4;
				endcase
			end
		4:	begin						// 4 address latch for next operand  
				strobe_out = 1;
				addr_pc = r_ins[3:2] == 3;	// some instructions read a 2nd operand, the rest the come here read a memory location
				c_phase = 5;
			end
		5:	begin						// 5 read next operand
				strobe_out = 0;
				data_pc = r_ins[3:2] == 3;
				c_tmp2 = r_tmp;				// low->high for 2 byte cases
				c_tmp = (r_ins[3:1] == 3?{2'b0,data_in}:is_local_ram&&r_ins[3:2] != 3?local_ram:ram_in);	// read the actial data, movd comes from upper bits
				if (r_ins[3:2] == 3)		// if we fetched from PC increment it
					c_pc = c_pc_inc;
				c_phase = 6;
			end
		6:	begin						// 6 execute stage 
				strobe_out = r_ins[3:1] == 5;	// if writing to anything latch address
				addr_pc = 0;
				c_phase = 0;					// if not writing go back
				case (r_ins)// synthesis full_case parallel_case
				0,												// add  a, v(x)
				9:	begin c_c = c_add[4]; c_a = c_add[3:0]; end	// add  a, #v
				1:	begin c_c = c_sub[4]; c_a = c_sub[3:0]; end	// sub  a, v(x)
				2:	c_a = r_a|r_tmp;							// or   a, v(x)
				3:	c_a = r_a&r_tmp;							// sub  a, v(x)
				4:	c_a = r_a^r_tmp;							// xor  a, v(x)
				5,												// mov  a, v(x)
				6,												// movd a, v(x)
				8:	c_a = r_tmp;								// mov  a, #v
				7:	case (r_tmp) // synthesis full_case parallel_case
    				0: begin c_x = r_y; c_y = r_x; end			// 0    swap  y, x
					1: c_a = r_a+{3'b000, r_c};					// 1	add   a, c
    				2: c_x[3:0] = r_a;							// 2    mov   x.l, a
    				3: begin									// 3    ret
							c_pc = r_s0;
							c_s0 = r_s1;
							c_s1 = r_s2;
							c_s2 = r_s3;
					   end
					4: c_y = c_i_add;							// 4    add   y, a
					5: c_x = c_i_add;							// 5    add   x, a
					6: c_y = c_i_add;							// 6    add   y, #1
					7: c_x = c_i_add;							// 7    add   y, #1
					default: ;
					endcase
				10,												// movd v(x), a
				11:	c_phase = 7;								// mov  v(x), a
				12:	c_x  = {r_tmp2, r_tmp};						// mov  x, #VV
				13:	c_pc = (r_tmp2[3]?!r_c : r_a != 0) ? {r_tmp2[2:0], r_tmp} : r_pc; // jne	a/c, VV
				14:	c_pc = (r_tmp2[3]? r_c : r_a == 0) ? {r_tmp2[2:0], r_tmp} : r_pc; // jeq        a/c, VV
				15:	begin c_pc = {r_tmp2[2:0], r_tmp};				// jmp  VV
						if (r_tmp2[3]) begin	// call
							c_s0 = r_pc;
							c_s1 = r_s0;
							c_s2 = r_s1;
							c_s3 = r_s2;
						end
					end
				endcase
			end
		7:	begin						// 7 write data stage - assert appropriate write strobe
				strobe_out = 0;
				data_pc = 0;
				write_data_n =  r_ins[0];
				write_ram_n  = ~r_ins[0];
				c_phase = 0;
			end
    	endcase
    end

    always @(posedge clk) begin
		r_a     <= c_a;
		r_c     <= c_c;
		r_x     <= c_x;
		r_y     <= c_y;
		r_ins   <= c_ins;
		r_tmp   <= c_tmp;
		r_tmp2  <= c_tmp2;
		r_pc    <= c_pc;
		r_phase <= c_phase;
		r_s0    <= c_s0;
		r_s1    <= c_s1;
		r_s2    <= c_s2;
		r_s3    <= c_s3;
    end

endmodule

/* For Emacs:   
 * Local Variables:
 * mode:c       
 * indent-tabs-mode:t
 * tab-width:4  
 * c-basic-offset:4
 * End: 
 * For VIM:
 * vim:set softtabstop=4 shiftwidth=4 tabstop=4:
 */
