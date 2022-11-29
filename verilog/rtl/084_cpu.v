
//
//	(C) Copyright Paul Campbell 2022 taniwha@gmail.com
//	Released under an Apache License 2.0
//

`default_nettype none

module moonbase_cpu_8bit #(parameter MAX_COUNT=1000) (input [7:0] io_in, output [7:0] io_out);
   
	//
	//	External interface
	//
	//	external address latch
	//		the external 12 bit address latch is loaded [5:0] from io_out[5:0] when io_out[7:6] is 10
	//		the external 12 bit address latch is loaded [11:6] from io_out[5:0] when io_out[7:6] is 11
	//	external SRAM (eg MWS5101AEL3) when io_out[7] is 0
	//	    which nibble is from io_out[6]
	//		the external RAM always produces what is at the latch's addresses on io_in[5:2] when 
	//		the external SRAM is written when io_out[7] is 0 and io_out[5] is 0
	//		io_out[6] can be used as an extra address bit to split the address space between
	//			code (1) and data (0) to use a 256-nibble sram (woot!)
	//  external devices when io_out[7] is 0:
	//	    which nibble is from io_out[6]
	//		external devices can be read from io_in[7:6] (at address pointed to by the address latch)
	//		external devices can be written from io_out[3:0] (at address pointed to by the address latch)
	//			when io_out[4] is 0
	//
	//	SRAM address space (data accesses):
	//		0-0xfff	   external
	//		0x1000-131 internal	(internal ram cells, for filling up the die :-)
	//

	localparam N_LOCAL_RAM = 4;
     
    wire clk			= io_in[0];
    wire reset			= io_in[1];
    wire [3:0]ram_in	= io_in[5:2];
    wire [1:0]data_in	= io_in[7:6];
    
    reg       strobe_out;	// address strobe		- designed to be wired to a 7 bit latch and a MWS5101AEL3
	reg		  nibble;	    // address/data nibble
    reg       write_data_n;	// write enable for data
    reg       write_ram_n;	// write enable for ram
    reg	      addr_pc;
	wire [11:0]data_addr = ((r_v[3]?r_y[11:0]:r_x[11:0])+{8'b000, r_v[2:0]});
	wire	  is_local_ram = (r_v[3]?r_y[12]:r_x[12]);
	wire	  write_local_ram = is_local_ram & !write_ram_n;
	wire	  write_ext_ram_n = is_local_ram | write_ram_n;
	wire [$clog2(N_LOCAL_RAM)-1:0]local_ram_addr = data_addr[$clog2(N_LOCAL_RAM)-1:0];
    wire [11:0]addr_out = addr_pc ? r_pc : data_addr;							// address out mux (PC or X/Y+off)
    wire [5:0]addr_out_mux = (nibble?addr_out[11:6]:addr_out[5:0]);			// mux-d by portion
    assign    io_out   = {strobe_out, nibble, strobe_out? addr_out_mux : {write_ext_ram_n, write_data_n, !nibble?r_a[7:4]:r_a[3:0]}};  // mux address and data out

    reg  [11:0]r_pc, c_pc;	// program counter	// actual flops in the system 
    reg  [12:0]r_x,  c_x;	// x index register	// by convention r_* is a flop, c_* is the combinatorial that feeds it
    reg  [12:0]r_y,  c_y;	// y index register
    reg  [7:0]r_a,  c_a;	// accumulator
    reg  [7:0]r_b,  c_b;	// temp accumulator
    reg       r_c,  c_c;	// carry flag
    reg  [3:0]r_h,  c_h;	// operand temp (high)
    reg  [3:0]r_l,  c_l;	// operand temp (low)
	reg  [4:0]r_ee, c_ee;	// extended const (bits 12:4)
    reg  [3:0]r_v,  c_v;	// operand temp (low)
	reg  [11:0]r_s0, c_s0;	// call stack
	reg  [11:0]r_s1, c_s1;

    //
    //	phase:
    //		0 - instruction fetch addr
    //		1 - instruction fetch dataL		ins
    //		2 - instruction fetch dataH		V
    //		4 - data/const fetch addr		
    //		5 - data/const fetch dataL		tmp
    //		6 - data/const fetch dataH		tmp2
    //		8 - execute/data store addr
    //		9 - data store dataL (might not do this)
    //		a - data store dataH (might not do this)
    //
    reg [3:0]r_phase, c_phase;	// CPU internal state machine

    // instructions
	//
	//	Registers:  a,b 8 bit, x,y 13 bits, pc 12 bits
    //
    //  0v:		add a, v(x/y)	- sets C
    //  1v: 	sub a, v(x/y)	- sets C
    //  2v:		or  a, v(x/y)
    //  3v:		and a, v(x/y)
    //  4v:		xor a, v(x/y)
    //  5v:		mov a, v(x/y)
    //  6v:		movd a, v(x/y)
    //	70:		add a, c
    //	71:		inc a
    //  72:		swap x, y
    //	73:		ret
	//  74:		add y, a
    //	75:		add x, a
	//  76:		inc y
	//  77:		inc x
	//	78:		mov a, y
	//	79:		mov a, x
	//	7a:		mov b, a
	//	7b:		swap b, a
	//	7c:		mov y, a
	//	7d:		mov x, a
	//	7e:		clr a
	//	7f:		mov a, pc
	//	8v:		nop
	//	9v:		nop
    //  av:		movd v(x/y), a
    //  bv:		mov  v(x/y), a
	//	cv:		nop
	//	dv:		nop
	//	ev:		nop
    //	f0 HL:	mov a, #HL
    //  f1 HL:	add a, #HL
    //  f2 HL:	mov y, #EELL
    //  f3 HL:	mov x, #EEHL
    //  f4 HL:	jne a/c, EEHL	if EE[4] then test c otherwise test a
    //  f5 HL:	jeq a/c, EEHL	if EE[4] then test c otherwise test a
    //  f6 HL:	jmp/call EEHL   if EE[4] call else jmp
	//	f7 HL:	nop
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

	wire [8:0]c_add = {1'b0, r_a}+{1'b0, r_h, r_l};	// ALUs
	wire [8:0]c_sub = {1'b0, r_a}-{1'b0, r_h, r_l};
	wire [12:0]c_i_add = {r_v[0]?r_x[12]:r_y[12], (r_v[0]?r_x[11:0]:r_y[11:0])+(r_v[1]?12'b1:{4'b0,r_a})};
	wire [11:0]c_pc_inc = r_pc+1;
	wire [7:0]c_a_inc = r_a + {7'b0, r_c|r_v[0]};
	
	reg	 [7:0]r_local_ram[0:N_LOCAL_RAM-1];

	wire [7:0]local_ram = r_local_ram[local_ram_addr];
	always @(posedge clk)
	if (write_local_ram)
		r_local_ram[local_ram_addr] <= r_a;

    always @(*) begin
		c_ins  = r_ins;	
		c_x    = r_x;
		c_y    = r_y;
		c_a    = r_a;
		c_b    = r_b;
		c_s0   = r_s0;
		c_s1   = r_s1;
		c_l    = r_l;
		c_h	   = r_h;
		c_ee   = r_ee;
		c_pc   = r_pc;
		c_c    = r_c;
		c_v    = r_v;
		write_data_n = 1;
		write_ram_n = 1;
		addr_pc = 'bx;
		nibble = 'bx;
    	if (reset) begin	// reset clears the state machine and sets PC to 0
			c_y = 13'h1000;	// point at internal sram
			c_pc = 0;
			c_phase = 0;
			strobe_out = 1;
    	end else 
    	case (r_phase) // synthesis full_case parallel_case
    	0:	begin					// 0: address latch instruction PC
				strobe_out = 1;
				addr_pc = 1;
				nibble = 0;
				c_phase = 1;
			end
    	1:	begin					// 0: address latch instruction PC
				strobe_out = 1;
				addr_pc = 1;
				nibble = 1;
				c_phase = 2;
			end
    	2:	begin					// 1: read data in r_ins
				strobe_out = 0;
				c_ins = ram_in;
				nibble = 0;
				c_phase = 3;
			end
    	3:	begin					// 3: read data in r_v
				strobe_out = 0;
				c_v = ram_in;
				nibble = 1;
				c_pc = c_pc_inc;
				case (r_ins) // synthesis full_case parallel_case
				7, 8, 9, 10, 11, 12, 13, 14: c_phase = 12;// some instructions don't have a 2nd fetch
				default:	     c_phase = 4;
				endcase
			end
		4:	begin						// 4 address latch for next operand  
				strobe_out = 1;
				addr_pc = r_ins[3:2] == 3;	// some instructions read a 2nd operand, the rest the come here read a memory location
				nibble = 0;
				c_phase = r_ins[3:2] != 3 && is_local_ram ? 7 : 5;
			end
		5:	begin						// 4 address latch for next operand  
				strobe_out = 1;
				addr_pc = r_ins[3:2] == 3;	// some instructions read a 2nd operand, the rest the come here read a memory location
				nibble = 1;
				c_phase = 6;
			end
		6:	begin						// 5 read next operand	r_hi
				strobe_out = 0;
				nibble = 0;
				c_h = ((r_ins[3:1] == 3)? 4'b0 : ram_in);
				c_phase = 7;
			end
		7:	begin						// 5 read next operand	r_lo
				strobe_out = 0;
				nibble = 1;
				if (is_local_ram&&r_ins != 4'hf) begin
					c_h = local_ram[7:4];
					c_l = local_ram[3:0];
				end else begin
					c_l = ((r_ins[3:1] == 3)?{2'b0,data_in}:ram_in);	// read the actial data, movd comes from upper bits
				end
				if (r_ins == 4'hf)		// if we fetched from PC increment it
					c_pc = c_pc_inc;
				c_phase = (r_ins == 4'hf && r_v[3:1] != 0) ? 8: 12;
			end
		8:	begin						// 4 address latch for next operand  
				strobe_out = 1;
				addr_pc = 1;
				nibble = 0;
				c_phase = 9;
			end
		9:	begin						// 4 address latch for next operand  
				strobe_out = 1;
				addr_pc = 1;
				nibble = 1;
				c_phase = 10;
			end
		10:	begin						// 5 read next operand	r_hi
				strobe_out = 0;
				nibble = 0;
				c_ee[4] = ram_in[0];
				c_phase = 11;
			end
		11:	begin						// 5 read next operand	r_lo
				strobe_out = 0;
				nibble = 1;
				c_ee[3:0] = ram_in;
				c_pc = c_pc_inc;
				c_phase = 12;
			end
		12:	begin						// 6 execute stage 
				strobe_out = r_ins[3:1] == 5;	// if writing to anything latch address
				addr_pc = 0;
				c_phase = 0;					// if not writing go back
				nibble = 0;
				case (r_ins)// synthesis full_case parallel_case
				0:	begin c_c = c_add[8]; c_a = c_add[7:0]; end	// add  a, v(x)
				1:	begin c_c = c_sub[8]; c_a = c_sub[7:0]; end	// sub  a, v(x)
				2:	c_a = r_a|{r_h, r_l};						// or   a, v(x)
				3:	c_a = r_a&{r_h, r_l};						// sub  a, v(x)
				4:	c_a = r_a^{r_h, r_l};						// xor  a, v(x)
				5,												// mov  a, v(x)
				6:	c_a = {r_h, r_l};							// movd a, v(x)
				7:	case (r_v) // synthesis full_case parallel_case
					0: c_a = c_a_inc;							// 0	add   a, c
    				1: c_a = c_a_inc;							// 1    inc   a
    				2: begin c_x = r_y; c_y = r_x; end			// 2    swap  y, x
    				3: begin									// 3    ret
							c_pc = r_s0;
							c_s0 = r_s1;
					   end
					4: c_y = c_i_add;							// 4    add   y, a
					5: c_x = c_i_add;							// 5    add   x, a
					6: c_y = c_i_add;							// 6    add   y, #1
					7: c_x = c_i_add;							// 7    add   y, #1
					8:	c_a = r_y[7:0];							// 8	mov a, y
					9:	c_a = r_x[7:0];							// 9	mov a, x
					10:	c_b = r_a;								// a	mov b, a
					11:	begin c_b = r_a; c_a = r_b; end			// b	swap b, a
					12:	c_y[7:0] = r_a;							// c	mov y, a
					13:	c_x[7:0] = r_a;							// d 	mov x, a
					14:	c_a = 0;								// e	clr a
					15:	c_a = r_pc;								// f	mov a, pc
					default: ;
					endcase
				8:   ;  // noop
				9:   ;  // noop
				10,												// movd v(x), a
				11:	c_phase = is_local_ram ? 15:13;				// mov  v(x), a
				12:  ;  // noop
				13:  ;  // noop
				14:  ;  // noop

				15: case (r_v) // synthesis full_case parallel_case
					0:	c_a  = {r_h, r_l};								// mov  a, #HL
					1:	begin c_c = c_add[8]; c_a = c_add[7:0]; end		// add  a, #HL
					2:	c_y  = {r_ee, r_h, r_l};						// mov  y, #VV
					3:	c_x  = {r_ee, r_h, r_l};						// mov  x, #VV
					4:	c_pc = (r_ee[4]?!r_c : r_a != 0) ? {r_ee[3:0], r_h, r_l} : r_pc; // jne	a/c, VV
					5:	c_pc = (r_ee[4]? r_c : r_a == 0) ? {r_ee[3:0], r_h, r_l} : r_pc; // jeq        a/c, VV
					6:	begin c_pc = {r_ee[3:0], r_h, r_l};				// jmp  VV
							if (r_ee[4]) begin	// call
								c_s0 = r_pc;
								c_s1 = r_s0;
							end
						 end
					default: ;
					endcase
				endcase
			end
		13:	begin
				strobe_out = 1;
				addr_pc = 0;
				nibble = 1;
				c_phase = 14;
			end
		14:	begin						// 7 write data stage - assert appropriate write strobe
				strobe_out = 0;
				write_data_n =  r_ins[0];
				write_ram_n  = ~r_ins[0];
				nibble = 0;
				c_phase = 15;
			end
		15:	begin						// 7 write data stage - assert appropriate write strobe
				strobe_out = 0;
				nibble = 1;
				write_data_n =  r_ins[0];
				write_ram_n  = ~r_ins[0];
				c_phase = 0;
			end
    	endcase
    end

    always @(posedge clk) begin
		r_a     <= c_a;
		r_b     <= c_b;
		r_c     <= c_c;
		r_x     <= c_x;
		r_y     <= c_y;
		r_ins   <= c_ins;
		r_v		<= c_v;
		r_l		<= c_l;
		r_h		<= c_h;
		r_ee	<= c_ee;
		r_pc    <= c_pc;
		r_phase <= c_phase;
		r_s0    <= c_s0;
		r_s1    <= c_s1;
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
