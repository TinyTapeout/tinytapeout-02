/* browndeer_rv8u.v
 *
 * Copyright (c) 2022 Brown Deer Technology, LLC. (www.browndeertechnology.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    https://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* DAR */

/*
 * RV8U - 8-bit RISC-V Microcore Processor
 *
 * The rv8u (Barentsburg core) is a custom 8-bit RISC-V core supporting 
 * 8-bit data operations with instructions encoded into 16-bit double-words.
 * The core supports the full RISC-V base ISA with the following exceptions.
 * Register file is reduced to 8 registers, with rs2 access limited to x0-x3.
 * Additionally the auipc instruction was removed.  The non-standard ISA
 * designation 'u' was chosen to mean 'microcore' since the core is very small.
 * Programming is supported by a custom assembler we use for developing custom
 * RISC-V cores.  A simple post-processor could be written for other assemblers
 * to directly map instructions generated for the rv32i base ISA, if the
 * assembly instrucitons comply with the reduced rv8u ISA limitations.
 *
 * Pin definitions:
 * input 	in_clk			base serdes clock
 * input		io_in[1]			reset
 * input		io_in[7:2]		6-bit serdes input
 * output	io_out[7:0]		8-bit serdes output
 * 
 */

//module barentsburg_core(
module browndeer_rv8u(

//	input in_clk,
//	input [7:1] io_in,
	input [7:0] io_in, // ZZZ
	output [7:0] io_out

//	output [BITS-3:0] debug_pc,
//	output [IBITS-1:0] debug_instr,
//	output [3:0] debug_valid_out,
//
//	input [RBITS-1:0] debug_reg_sel,
//	output reg [BITS-1:0] debug_reg_dout
	
);

	wire in_clk; // ZZZ

	///////////////////////////////////////////////////////////////////////////

	////////////////////////////////
	////////// Parameters //////////
	////////////////////////////////

	parameter BITS = 8;
	parameter IBITS = 16;
	parameter RBITS = 3;
	parameter NREG = 8;

	///////////////////////////////////////////////////////////////////////////

	//////////////////////////////////
	////////// Declarations //////////
	//////////////////////////////////

	/// pipeline control
	wire inval;
	wire valid_out0;

	wire valid_out1;

	reg valid_out3;

	/// flow control
	reg [BITS-3:0] pc;
	reg [BITS-3:0] pc_1;
	reg [BITS-3:0] pc_2;
	wire pc_jump;
	reg [BITS-3:0] jump_addr;

	/// instr
	reg [IBITS-1:0] instr;
	reg [IBITS-1:0] instr_2;

	/// hazard
	reg [NREG-1:0] ldr_hzd;

	/// reg control
	wire [RBITS-1:0] rd;
	wire [RBITS-1:0] rs1;
	wire [RBITS-1:0] rs2;
	wire reg_we;
	wire reg_we_arb;
	reg [BITS-1:0] rd_din;
	reg [BITS-1:0] nxt_rd_din;
	reg [RBITS-1:0] rd_sel_arb;
	reg [BITS-1:0] rs1_dout;
	reg [BITS-1:0] rs2_dout;
	reg [RBITS-1:0] rd_3;

	/// imm operand
	wire ri;
	reg [BITS-1:0] imm;

	/// reg dependency
	wire use_rd_e1;
	wire use_rd_e2;
	wire use_rs1;
	wire use_rs2;

	/// IALU
	reg [3:0] op;
	wire [BITS-1:0] op_result;
	wire cc_zero;
	wire cc_neg;
	wire cc_v;

	/// ins_
	wire reg_wen;
	wire ins_br;
	wire ins_jal;
	wire ins_jalr;
	wire ins_str;
	wire ins_ldr;
	wire ins_halt;
	wire ins_lui;
	reg ins_ldr_3;

	reg ri_3;

	/// bits alias probably not necessary
	wire [2:0] funct3;

	///////////////////////////////////////////////////////
	////////// Declarations PIPELINE_STAGE_0_ILR //////////
	///////////////////////////////////////////////////////

	// pipeline control
	reg nxt_valid0;

	// flow control
	reg [BITS-3:0] pc0;
	reg [BITS-3:0] nxt_pc, nxt_pc0;

	reg valid0;

	///////////////////////////////////////////////////////
	/////////// Declarations PIPELINE STAGE 1 IL //////////
	///////////////////////////////////////////////////////

	wire [IBITS-1:0] nxt_instr;
	reg valid1;

	///////////////////////////////////////////////////////////////////////////
	////////// Declarations PIPELINE STAGE 2 ID ///////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	wire en2;

	reg [3:0] imm3210;

	reg valid2;

	///////////////////////////////////////////////////////////////////////////
	////////// Pipeline Stage 3 E1 Declarations ///////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	wire [BITS-1:0] arg0;
	reg [BITS-1:0] arg1;

	reg stall;

	reg ben;

	///////////////////////////////////////////////////////////////////////////
	////////// Pipeline Stage 4 E2 Declarations ///////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	wire en4;

	//////////////////////////////////////////////
	////////// ISA Decoder Declarations //////////
	//////////////////////////////////////////////

	wire rv_itype, rv_stype, rv_btype;
	wire rv_op, rv_op_imm;

	///////////////////////////////////////
	////////// IALU Declarations //////////
	///////////////////////////////////////

	wire [BITS-1:0] a_result_sub;
	wire [BITS-1:0] a_result_srl;
	reg [BITS-1:0] a_result;
	reg [7:0] a_sx;
	reg [BITS-1:0] a_sign_extend;
	wire [4:0] a_shamt;

	wire run;
	wire run_not_stall;

	assign run = (~ rst);
	assign run_not_stall = run & (~ stall);


   /////////////////////////
   ////////// DES //////////
   /////////////////////////

   wire des_clk_out;
   wire [5:0] des_sin;
   wire [7:0] des_sout;
   wire [31:0] des_din;
   wire [23:0] des_dout;

   //////////////////////////
   ////////// core //////////
   //////////////////////////

   wire clk;
   wire rst;
   reg halt;
   wire [BITS-3:0] imem_addr;
   wire [IBITS-1:0] imem_dout;
   wire [BITS-1:0] dmem_addr;
   wire [BITS-1:0] dmem_din;
   wire [BITS-1:0] dmem_dout;
   wire dmem_we;
   wire dmem_en;


   ///////////////////////////////////////////////////////////////////////////

   ///////////////////////////////////////////////////////////////////////////
   //////////   DES   ////////////////////////////////////////////////////////
   ///////////////////////////////////////////////////////////////////////////

	des des(
   	.in_clk (in_clk),
   	.rst (rst),
   	.des_sin (des_sin),
   	.des_sout (des_sout),
   	.des_din (des_din),
   	.des_dout (des_dout),
   	.des_clk_out (des_clk_out)
	);

   assign in_clk = io_in[0]; // ZZZ
   assign rst = io_in[1];
   assign des_sin = io_in[7:2];

   assign io_out = des_sout;


   assign clk = des_clk_out;

   assign imem_dout[15:0] = des_dout[15:0];
   assign dmem_dout = des_dout[23:16];

   assign des_din[5:0] = imem_addr;
   assign des_din[13:6] = dmem_addr;
   assign des_din[21:14] = dmem_din;
   assign des_din[22] = dmem_we;
   assign des_din[23] = dmem_en;
   assign des_din[24] = halt;

	assign des_din[31:25] = 7'd0;

	///////////////////////////////////////////////////////////////////////////

	///////////////////////////////////////////////////////////////////////////
	//////////   PIPELINE STAGE 0 (ILR)   /////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	/// pipeline control ///

	assign valid_out0 = valid0 & ~ inval;

	always @ (posedge clk)
	begin
		if (rst) begin
			valid0 <= 0;
		end
		else if (run) begin
			if (stall) 
				valid0 <= valid_out0;
			else
				valid0 <= 1;
		end
		else begin
			valid0 <= valid_out0;
		end
	end


	/// flow control ///

	always @ (*)
	begin
		if (pc_jump) begin
			nxt_pc0 = jump_addr;
			nxt_pc = jump_addr + 1;
		end
		else if (stall) begin
			nxt_pc0 = pc0;
			nxt_pc = pc;
		end
		else begin
			nxt_pc0 = pc;
			nxt_pc = pc + 1;
		end
	end
	assign imem_addr = nxt_pc0;

	always @ (posedge clk)
	begin
		if (rst) begin
			pc0 <= 0;
			pc <= 0;
		end
		else if (run) begin
			pc0 <= nxt_pc0;
			pc <= nxt_pc;
		end
		else begin
			pc0 <= pc0;
			pc <= pc;
		end
	end


	///////////////////////////////////////////////////////////////////////////
	//////////   PIPELINE STAGE 1 (IL)   //////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	/// pipeline control ///

	assign valid_out1 = valid1 & ~ inval;

	always @ (posedge clk)
	begin
		if (rst) begin
			valid1 <= 0;
			pc_1 <= 0;
		end
		else if (run_not_stall) begin
			valid1 <= valid_out0;
			pc_1 <= pc;
		end
		else begin
			valid1 <= valid_out1;
			pc_1 <= pc_1;
		end
	end


	/// generate instruction ///

	assign nxt_instr = imem_dout[IBITS-1:0];

	always @ (posedge clk)
	begin
		if (rst) 
			instr <= 0;
		else if (run_not_stall & valid_out0) 
			instr <= nxt_instr;
		else 
			instr <= instr;
	end


	///////////////////////////////////////////////////////////////////////////
	//////////   PIPELINE STAGE 2 (ID)   //////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	/// pipeline control ///

	assign en2 = valid_out1;

	always @ (posedge clk)
	begin
		if (rst) begin
			valid2 <= 0;
		end
		else if (run_not_stall) begin
			valid2 <= valid_out1;
		end
		else begin
			valid2 <= valid2;
		end
	end


	/// pc, instr data flow

	always @ (posedge clk)
	begin
		if (rst) begin
			pc_2 <= 0;
			instr_2 <= 0;
		end
		else if (run_not_stall) begin
			pc_2 <= pc_1;
         if (valid_out1)
            instr_2 <= instr;
         else
            instr_2 <= 16'hffff;
		end
		else begin
			pc_2 <= pc_2;
			instr_2 <= instr_2;
		end
	end


	///////////////////////////////////////////////////////////////////////////
	//////////   PIPELINE STAGE 3 (E1)   //////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////


	always @ (posedge clk)
	begin
		if (rst)
			valid_out3 <= 0;
		else if (run_not_stall)
			valid_out3 <= valid2;
		else if (run & en4)
			valid_out3 <= 0;
		else
			valid_out3 <= valid_out3;
	end

	assign rd = instr_2[5:3];
	assign funct3 = instr_2[8:6];
	assign rs1 = instr_2[11:9];
	assign rs2[1:0] = instr_2[13:12];
	assign rs2[2] = 0;

	assign ins_lui	 		= (instr_2[2:0] == 3'b111);
	assign ins_jal		 	= (instr_2[2:0] == 3'b110);
	assign ins_jalr	 	= (instr_2[2:0] == 3'b100);
	assign rv_op_imm 		= (instr_2[2:0] == 3'b001);
	assign rv_op	 		= (instr_2[2:0] == 3'b011);
	assign ins_br	 		= (instr_2[2:0] == 3'b010);
	assign ins_ldr 		= ((instr_2[2:0] == 3'b000) & (~ funct3[2]));
	assign ins_str 		= ((instr_2[2:0] == 3'b000) & funct3[2]);

	assign use_rd_e1 = reg_wen | ins_jal | ins_jalr | ins_lui;
	assign use_rd_e2 = (~ funct3[2]) & ins_ldr;
	assign use_rs1 = ins_ldr | reg_wen | ins_jalr | ins_br | ins_str;
	assign use_rs2 = (reg_wen & ~ ri_3) | ins_br | ins_str;

	assign ins_halt 		= (instr_2[2:0] == 3'b000) & (funct3 == 3'b000);

	assign rv_itype = ins_ldr | rv_op_imm | ins_jalr;
	assign rv_stype = ins_str;
	assign rv_btype = ins_br;

	assign ri = rv_itype | rv_stype;
	assign reg_wen = rv_op | rv_op_imm;

	always @ (*)
	begin
		if (ins_str | ins_ldr | ins_br)
			op[2:0] = 3'b000;
		else 
			op[2:0] = funct3;

		op[3] = ins_br | ((rv_op | ( rv_op_imm & funct3[2])) & instr_2[15]);
	end

	always @ (*)
	begin
		if (rv_itype)
			imm3210 = { instr_2[15:12] };
		else
			imm3210 = { instr_2[14], instr_2[5:3] };
	end
	
	always @ (*)
	begin
		if (rv_itype|rv_btype|rv_stype)
			imm = { instr_2[15], instr_2[15], instr_2[15], instr_2[15], imm3210 };
		else
			imm = instr_2[13:6];
	end


	assign reg_we = valid2
		& (reg_wen|ins_jal|ins_jalr|ins_lui) & (~ stall);

	assign dmem_we = valid2 & ins_str & (~ stall);

	assign arg0 = rs1_dout;

	always @ (*)
	begin
		if (ri) begin
			arg1 = imm[BITS-1:0];
		end
		else
			arg1 = rs2_dout;
	end


	/// IALU ///

	assign a_shamt = arg1[4:0];

	assign a_result_sub = arg0 - arg1;

	assign a_result_srl = arg0 >> a_shamt;

	always @ (*)
	begin
		case (arg1[2:0])
			3'b000: a_sx = 8'b00000000;
			3'b001: a_sx = 8'b10000000;
			3'b010: a_sx = 8'b11000000;
			3'b011: a_sx = 8'b11100000;
			3'b100: a_sx = 8'b11110000;
			3'b101: a_sx = 8'b11111000;
			3'b110: a_sx = 8'b11111100;
			3'b111: a_sx = 8'b11111110;
		endcase
		if (arg0[BITS-1])
			a_sign_extend = a_sx;
		else
			a_sign_extend = 8'd0;
	end


	always @ (*)
	begin
		case (op[2:0])

			3'b000: begin
				if (op[3]) 
					a_result = a_result_sub;
				else
					a_result = arg0 + arg1;
			end

			3'b001: begin
				a_result = arg0 << a_shamt; // sll
			end

			3'b010: begin
				a_result = { 7'd0, cc_neg }; // slt
			end

			3'b011: begin
				a_result = { 7'd0, cc_v}; // sltu
			end

			3'b100: begin
				a_result = arg0 ^ arg1; // xor
			end

			3'b101: begin
				if (op[3])
					a_result = a_sign_extend | a_result_srl; // sra
				else
					a_result = a_result_srl; // srl
			end

			3'b110: begin
				a_result = arg0 | arg1;
			end

			3'b111: begin
				a_result = arg0 & arg1;
			end

		endcase
	end

	assign cc_neg = a_result_sub[BITS-1];
	assign cc_zero = (a_result_sub == 0);
	assign cc_v = ( cc_neg & ~(arg0[BITS-1] ^ arg1[BITS-1])) 
		| ((~arg0[BITS-1]) & arg1[BITS-1] );

	assign op_result = a_result;


	assign dmem_addr = op_result[BITS-1:0];
	assign dmem_din[BITS-1:0] = rs2_dout;
	assign dmem_en = (ins_str | ins_ldr) & valid2 & (~ stall);

	always @ (*)
	begin
		if (ins_lui)
			rd_din = { imm[4:0], 3'd0 };
		else if (ins_jal|ins_jalr) 
			rd_din = { 2'b00, pc_2 };
		else
			rd_din = op_result;
	end

	always @ (*)
	begin
		case(funct3) 
			3'b000 : ben = cc_zero;	// eq
			3'b001 : ben = (~cc_zero); // ne
			3'b010 : ben = 0;
			3'b011 : ben = 0;
			3'b100 : ben = cc_neg; // lt
			3'b101 : ben = (cc_zero | (~cc_neg)); // ge
			3'b110 : ben = cc_v; // ltu
			3'b111 : ben = (cc_zero | (~cc_v)); // geu
		endcase
	end


	always @ (*)
	begin
		if (ins_jalr)
			jump_addr = op_result[BITS-3:0];
		else
			jump_addr = pc_2 + { imm[BITS-3:0] };
	end
	assign pc_jump = valid2 & ((ben & ins_br) | ins_jal | ins_jalr);

	assign inval = pc_jump & (~ stall);

	always @ (posedge clk)
	begin
		if (rst) begin
			halt <= 0;
		end
		else if (run_not_stall & valid2) begin
			halt <= ins_halt;
		end
		else begin
			halt <= halt;
		end
	end

	always @ (posedge clk)
	begin
		if (rst) begin
			ins_ldr_3 <= 0;
			rd_3 <= 0;
			ri_3 <= 0;
		end
		else if (run_not_stall) begin
			ins_ldr_3 <= ins_ldr;
			rd_3 <= rd;
			ri_3 <= ri;
		end
		else begin
			ins_ldr_3 <= ins_ldr_3;
			rd_3 <= rd_3;
			ri_3 <= ri_3;
		end
	end

	always @ (*)
	begin
	
		if ( ldr_hzd == 'd0 )
			stall = 0;
		else if ( (use_rs1 & ldr_hzd[rs1]) | (use_rs2 & ldr_hzd[rs2])) // RAW HZD
			stall = 1;
		else if ( (use_rd_e2 & ldr_hzd[rd]) | (use_rd_e1) ) // WAW conflict
			stall = 1;
		else 
			stall = 0;

	end


	///////////////////////////////////////////////////////////////////////////
	//////////   PIPELINE STAGE 4 (E2)   //////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////

  	assign en4 = valid_out3 & (ins_ldr_3 );

   always @ (*)
   begin

      if (en4 & ins_ldr_3) begin
         rd_sel_arb = rd_3;
      end
      else begin
         rd_sel_arb = rd;
      end

   end
	assign reg_we_arb = reg_we | (en4 & ins_ldr_3);


	///////////////////////////////////////////////////////////////////////////
	////////// REGISTERS //////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	/// write register

	always @ (*)
	begin
      	if (en4 & ins_ldr_3) begin
    	     nxt_rd_din = dmem_dout[BITS-1:0];
    	  end
    	  else begin
    	     nxt_rd_din = rd_din;
    	  end
	end

	registers registers(
   	.clk (clk),
   	.run (run),
   	.we (reg_we_arb),
   	.rd (rd_sel_arb),
   	.rs1 (rs1),
   	.rs2 (rs2),
   	.rd_din (nxt_rd_din),
   	.rs1_dout (rs1_dout),
   	.rs2_dout (rs2_dout)

//   	.debug_reg_sel (debug_reg_sel),
//   	.debug_reg_dout (debug_reg_dout)
	);

	///////////////////////////////////////////////////////////////////////////

	/////////////////////////////
	////////   Hazard   ////////
	/////////////////////////////

	always @ (posedge clk)
	begin
		if (rst) begin
			ldr_hzd <= 0;
		end
		else if (run)
			if (( ~(rd==0)) & (ins_ldr )  & ~ stall) begin
				ldr_hzd <= ('d1 << rd);
			end
			else begin
				ldr_hzd <= 0;
			end
		else begin
			ldr_hzd <= ldr_hzd;
		end
	end

	
	///////////////////////////////////////////////////////////////////////////

	///////////////////////////
	////////   DEBUG   ////////
	///////////////////////////

//	assign debug_pc = pc_2;
//	assign debug_instr[15:0] = instr_2;
//	assign debug_valid_out = { valid_out0, valid_out1, valid2, valid_out3 };

endmodule
