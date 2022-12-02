// ============================================================================
// Whisk: a 16-bit bit-serial RISC processor (c) Luke Wren 2022
// SPDX-License-Identifier: Apache-2.0
// ============================================================================

// Whisk is a 16-bit bit-serial processor, with external SPI SRAM interface,
// designed in a hurry for Tiny Tapeout 2. See README.md for an overview of
// the instruction set. Supporting hardware:
//
// - SPI SRAM with sequential mode and 16-bit addressing, e.g. Microchip
//   23K256T-I (32 kiB SRAM)
//
// - One 8-bit parallel-to-serial shift register, for input port
//
// - Two 8-bit serial-to-parallel shift registers, for output port
//
// - A host device capable of loading the SPI SRAM, setting it to sequential
//   mode, and releasing Whisk's reset. I'll probably use a Pico.
//
// There will be a board with all of these components ready for bringup, and
// it will be added to this repository (also I will probably make a few of
// them, and will gladly send you one if you ask). However this will not be
// done before tapeout, as I started this project a week before the
// deadline!

`ifdef WHISK_DEFAULT_NETTYPE_NONE
`default_nettype none
`endif

`ifndef WHISK_NO_CELLS
`define WHISK_CELLS_SKY130
`endif

// ============================================================================
// Module wren6991_whisk_tt2_io_wrapper: Top level for TT2 synthesis.
// instantiate whisk_top, and map named ports to numbered TT2 inputs/outputs
// ============================================================================

module wren6991_whisk_tt2_io_wrapper (
	input  wire [7:0] io_in,
	output wire [7:0] io_out
);

// Global signals
wire io_clk = io_in[0];
wire io_rst_n = io_in[1];

// SPI memory interface
wire io_mem_sdi = io_in[2];

wire io_mem_csn;
wire io_mem_sck;
wire io_mem_sdo;

assign io_out[0] = io_mem_csn;
assign io_out[1] = io_mem_sck;
assign io_out[2] = io_mem_sdo;

wire       io_retime_mem_out = io_in[4];
wire [1:0] io_retime_mem_in  = io_in[6:5];
wire       io_retime_ioport_out = io_in[7];

// IO port (shift register interface)
wire io_ioport_sdi = io_in[3];

wire io_ioport_sck;
wire io_ioport_sdo;
wire io_ioport_latch_i;
wire io_ioport_latch_o;


assign io_out[3] = io_ioport_sck;
assign io_out[4] = io_ioport_sdo;
assign io_out[5] = io_ioport_latch_i;
assign io_out[6] = io_ioport_latch_o;

// Be a good neighbour
assign io_out[7] = 1'b0;

whisk_top top_u (
	.io_clk               (io_clk),
	.io_rst_n             (io_rst_n),

	.io_mem_sdi           (io_mem_sdi),
	.io_mem_csn           (io_mem_csn),
	.io_mem_sck           (io_mem_sck),
	.io_mem_sdo           (io_mem_sdo),

	.io_retime_mem_out    (io_retime_mem_out),
	.io_retime_mem_in     (io_retime_mem_in),
	.io_retime_ioport_out (io_retime_mem_out),

	.io_ioport_sdi        (io_ioport_sdi),
	.io_ioport_sck        (io_ioport_sck),
	.io_ioport_sdo        (io_ioport_sdo),
	.io_ioport_latch_i    (io_ioport_latch_i),
	.io_ioport_latch_o    (io_ioport_latch_o)
);

endmodule

// ============================================================================
// Module whisk_top: instantiate the CPU core together with the SPI mem
// serdes and IO port serdes.
// ============================================================================

module whisk_top (
	input  wire       io_clk,
	input  wire       io_rst_n,

	input  wire       io_mem_sdi,
	output wire       io_mem_csn,
	output wire       io_mem_sck,
	output wire       io_mem_sdo,

	input  wire       io_retime_mem_out,
	input  wire [1:0] io_retime_mem_in,
	input  wire       io_retime_ioport_out,

	input  wire       io_ioport_sdi,
	output wire       io_ioport_sck,
	output wire       io_ioport_sdo,
	output wire       io_ioport_latch_i,
	output wire       io_ioport_latch_o
);

// ----------------------------------------------------------------------------
// Clock/reset wrangling

// Don't buffer the clock -- seems like the scripts define a clock on io_in[0]?
wire clk = io_clk;

// Synchronise reset removal to clk
reg [1:0] reset_sync;
wire rst_n = reset_sync[1];

always @ (posedge clk or negedge io_rst_n) begin
	if (!io_rst_n) begin
		reset_sync <= 2'd00;
	end else begin
		reset_sync <= ~(~reset_sync << 1);
	end
end

// ----------------------------------------------------------------------------
// Processor instantiation

wire mem_sck_en_next;
wire mem_sdo_next;
wire mem_csn_next;
wire mem_sdi_prev;

wire ioport_sck_en_next;
wire ioport_sdo_next;
wire ioport_sdi_prev;
wire ioport_latch_i_next;
wire ioport_latch_o_next;

whisk_cpu cpu (
	.clk                 (clk),
	.rst_n               (rst_n),

	.mem_sck_en_next     (mem_sck_en_next),
	.mem_sdo_next        (mem_sdo_next),
	.mem_csn_next        (mem_csn_next),
	.mem_sdi_prev        (mem_sdi_prev),

	.ioport_sck_en_next  (ioport_sck_en_next),
	.ioport_sdo_next     (ioport_sdo_next),
	.ioport_sdi_prev     (ioport_sdi_prev),
	.ioport_latch_i_next (ioport_latch_i_next),
	.ioport_latch_o_next (ioport_latch_o_next)
);

// ----------------------------------------------------------------------------
// Serdes (IO registers)

whisk_spi_serdes mem_serdes_u (
	.clk                  (clk),
	.rst_n                (rst_n),

	.sdo                  (mem_sdo_next),
	.sck_en               (mem_sck_en_next),
	.csn                  (mem_csn_next),
	.sdi                  (mem_sdi_prev),

	.padout_sck           (io_mem_sck),
	.padout_csn           (io_mem_csn),
	.padout_sdo           (io_mem_sdo),
	.padin_sdi            (io_mem_sdi),

	.padin_retime_mem_out (io_retime_mem_out),
	.padin_retime_mem_in  (io_retime_mem_in),
);

whisk_ioport_serdes io_serdes_u (
	.clk                     (clk),
	.rst_n                   (rst_n),

	.sdo                     (ioport_sdo_next),
	.sck_en                  (ioport_sck_en_next),
	.latch_i                 (ioport_latch_i_next),
	.latch_o                 (ioport_latch_o_next),
	.sdi                     (ioport_sdi_prev),

	.padout_sdo              (io_ioport_sdo),
	.padout_sck              (io_ioport_sck),
	.padout_latch_i          (io_ioport_latch_i),
	.padout_latch_o          (io_ioport_latch_o),
	.padin_sdi               (io_ioport_sdi),

	.padin_retime_ioport_out (io_retime_ioport_out)
);

endmodule

// ============================================================================
// Module whisk_cpu: top-level for the Whisk processor, minus the IO wrapper
// and the SPI/IOPORT serdes
// ============================================================================

module whisk_cpu (
	input  wire       clk,
	input  wire       rst_n,

	// SPI SRAM interface
	output wire       mem_sck_en_next,
	output wire       mem_sdo_next,
	output wire       mem_csn_next,
	input  wire       mem_sdi_prev,

	// Shift registers for IO port
	output wire       ioport_sck_en_next,
	output wire       ioport_sdo_next,
	input  wire       ioport_sdi_prev,
	output wire       ioport_latch_i_next,
	output wire       ioport_latch_o_next
);

// ----------------------------------------------------------------------------
// Constants

// Machine size
localparam       W_INSTR        = 16;
localparam       W_DATA         = 16;
localparam       N_REGS         = 6;

// Instruction layout
localparam       INSTR_OP_LSB   = 0;
localparam       INSTR_OP_MSB   = 3;
localparam       INSTR_COND_LSB = 4;
localparam       INSTR_COND_MSB = 6;
localparam       INSTR_RT_LSB   = 7;
localparam       INSTR_RT_MSB   = 9;
localparam       INSTR_RS_LSB   = 10;
localparam       INSTR_RS_MSB   = 12;
localparam       INSTR_RD_LSB   = 13;
localparam       INSTR_RD_MSB   = 15;

// Major opcodes (instr[3:0])
localparam [3:0] OP_ADD         = 4'h0; // rd = rs +  rt
localparam [3:0] OP_SUB         = 4'h1; // rd = rs -  rt
localparam [3:0] OP_AND         = 4'h2; // rd = rs &  rt
localparam [3:0] OP_ANDN        = 4'h3; // rd = rs & ~rt
localparam [3:0] OP_OR          = 4'h4; // rd = rs |  rt
localparam [3:0] OP_SHIFT       = 4'h5; // Minor opcode in rt
localparam [3:0] OP_INOUT       = 4'h6; // Minor opcode in rs

localparam [3:0] OP_LB          = 4'h8; // rd = mem[rs     ];
localparam [3:0] OP_LH_IA       = 4'h9; // rd = mem[rs     ]; rs += rt;
localparam [3:0] OP_LH_ADD      = 4'ha; // rd = mem[rs + rt];
localparam [3:0] OP_LH_IB       = 4'hb; // rd = mem[rs + rt]; rs += rt;

localparam [3:0] OP_SB          = 4'hc; // mem[rs     ] = rd;
localparam [3:0] OP_SH_IA       = 4'hd; // mem[rs     ] = rd; rs += rt;
localparam [3:0] OP_SH_ADD      = 4'he; // mem[rs + rt] = rd;
localparam [3:0] OP_SH_IB       = 4'hf; // mem[rs + rt] = rd; rs += rt;

// Minor opcodes (rt)
localparam [2:0] OP2_SRL        = 3'h0;
localparam [2:0] OP2_SRA        = 3'h1;
localparam [2:0] OP2_ROR        = 3'h2;
localparam [2:0] OP2_SLL        = 3'h4;

// Minor opcodes (rs)
localparam [2:0] OP2_IN         = 3'h0;
localparam [2:0] OP2_OUT        = 3'h4;

// ----------------------------------------------------------------------------
// Main control state machine

reg [W_INSTR-1:0] instr;

wire [INSTR_OP_MSB  -INSTR_OP_LSB  :0] instr_op;
wire [INSTR_COND_MSB-INSTR_COND_LSB:0] instr_cond;
wire [INSTR_RT_MSB  -INSTR_RT_LSB  :0] instr_rt;
wire [INSTR_RS_MSB  -INSTR_RS_LSB  :0] instr_rs;
wire [INSTR_RD_MSB  -INSTR_RD_LSB  :0] instr_rd;

assign {instr_rd, instr_rs, instr_rt, instr_cond, instr_op} = instr;

wire instr_op_ls      = instr_op[3]; // Whether an instruction is a load/store
wire instr_op_st_nld  = instr_op[2]; // Whether a load/store is a load or store
wire instr_op_ls_suma = instr_op[1]; // Whether sum is used for address
wire instr_op_ls_sumr = instr_op[0]; // Whether sum is written back to register

reg [3:0] bit_ctr;
reg [2:0] state;
reg       instr_cond_true;
reg       instr_has_imm_operand;


// Note there is a 2 cycle delay from issuing a bit on SDO to getting a bit
// back on SDI. This is handled with a 1-cycle gap after issuing a read
// address, so that e.g. S_FETCH always has the first instruction bit
// available on the first cycle.

localparam [2:0] S_FETCH      = 3'd0; // Sample 16 instr bits, increment PC
localparam [2:0] S_EXEC       = 3'd1; // Loop all GPRs, write one GPR
localparam [2:0] S_PC_NONSEQ0 = 3'd2; // Issue cmd, then issue 1 PC bit
localparam [2:0] S_PC_NONSEQ1 = 3'd3; // Issue rest of PC, then 1 cyc delay
localparam [2:0] S_LS_ADDR0   = 3'd4; // Deferred LS SPI cmd following immediate
localparam [2:0] S_LS_ADDR1   = 3'd5; // Issue addr then, if load, 1 cyc delay
localparam [2:0] S_LS_DATA    = 3'd6; // Issue store data, or sample load data
localparam [2:0] S_SKIP_IMM   = 3'd7; // Skip immediate following false condition

reg [2:0] state_nxt_wrap;
reg [2:0] state_nxt;

always @ (*) begin
	state_nxt_wrap = state;
	case (state)
		S_FETCH: begin
			if (!instr_cond_true) begin
				if (instr_has_imm_operand) begin
					state_nxt_wrap = S_SKIP_IMM;
				end else begin
					state_nxt_wrap = S_FETCH;
				end
			end else begin
				state_nxt_wrap = S_EXEC;
			end
		end
		S_EXEC: begin
			if (instr_op_ls && instr_has_imm_operand) begin
				// Command was deferred due to immediate read keeping SPI busy
				state_nxt_wrap = S_LS_ADDR0;
			end else if (instr_op_ls) begin
				// Command was issued concurrently, skip straight to address issue
				state_nxt_wrap = S_LS_ADDR1;
			end else if (instr_rd == 3'd7) begin
				state_nxt_wrap = S_PC_NONSEQ0;
			end else begin
				state_nxt_wrap = S_FETCH;
			end
		end
		S_PC_NONSEQ0: begin
			state_nxt_wrap = S_PC_NONSEQ1;
		end
		S_PC_NONSEQ1: begin
			if (!instr_cond_true) begin
				// Have just been reset, instr is invalid
				state_nxt_wrap = S_FETCH;
			end else begin
				state_nxt_wrap = S_FETCH;
			end
		end
		S_LS_ADDR0: begin
			state_nxt_wrap = S_LS_ADDR1;
		end
		S_LS_ADDR1: begin
			state_nxt_wrap = S_LS_DATA;
		end
		S_LS_DATA: begin
			state_nxt_wrap = S_PC_NONSEQ0;
		end
		S_SKIP_IMM: begin
			state_nxt_wrap = S_FETCH;
		end
	endcase
	state_nxt   = &bit_ctr ? state_nxt_wrap   : state;
end

// Start of day:
//
// - The only resettable flops are state, bit_ctr, and instr_cond_true.
//
// - We reset state/bit_ctr to a nonsequential fetch, and reset
//   instr_cond_true=0 (usually unreachable)
//
// - instr_cond_true=0 masks the fetch address to 0, regardless of PC
//
// - The first instruction must be `add pc, zero, #4` to initialise PC

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		state <= S_PC_NONSEQ0;
		bit_ctr <= 4'h0;
	end else begin
		state <= state_nxt;
		bit_ctr <= bit_ctr + 4'h1;
	end
end

// ----------------------------------------------------------------------------
// Instruction shifter and early decode

always @ (posedge clk) begin
	if (state == S_FETCH) begin
		instr <= {mem_sdi_prev, instr[15:1]};
	end
end

// Decode condition and imm operand flags as the instruction comes in, so we
// can use them to steer the state machine at the end of S_FETCH.

reg instr_has_imm_operand_nxt;
reg instr_cond_true_nxt;

// From ALU:
wire [7:0] condition_vec8;

always @ (*) begin
	instr_has_imm_operand_nxt = instr_has_imm_operand;
	instr_cond_true_nxt = instr_cond_true;

	if (instr_has_imm_operand && !instr_cond_true) begin
		// In this case we must be in S_FETCH. Hold instr_cond_true for an
		// additional fetch cycle so that the immediate operand is also
		// dumped, but clear the operand flag so we don't loop forever.
		if (&bit_ctr) begin
			instr_has_imm_operand_nxt = 1'b0;
		end
	end else if (state == S_FETCH) begin
		if (bit_ctr == (INSTR_RT_MSB + 1)) begin
			// Grab rt as it goes past (this is why rt is not the MSBs!)
			instr_has_imm_operand_nxt = instr[W_INSTR-1 -: 3] == 3'd7;
		end
		if (bit_ctr == (INSTR_COND_MSB + 1)) begin
			// Decode condition as it goes past
			instr_cond_true_nxt = condition_vec8[instr[W_INSTR-1 -: 3]];
		end
	end
end

// instr_cond_true must reset to 0, because we use it to recognise the first
// fetch after reset. We don't care about instr_has_imm_operand, because it
// is initialised during S_FETCH before first use.

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		instr_cond_true <= 1'b0;
	end else begin
		instr_cond_true <= instr_cond_true_nxt;
	end
end

always @ (posedge clk) begin
	instr_has_imm_operand <= instr_has_imm_operand_nxt;
end

// ----------------------------------------------------------------------------
// Register file

wire reg_rd_qr;
wire reg_rs_qr, reg_rs_qr_next;
wire reg_rt_qr;

wire alu_result;

wire writeback_wen =
	state == S_EXEC && !(instr_op_ls && !instr_op_ls_sumr)  ||
	state == S_LS_DATA && !instr_op_st_nld;

wire writeback_data = alu_result;

wire [INSTR_RD_MSB-INSTR_RD_LSB:0] writeback_reg =
	instr_op_ls && state != S_LS_DATA ? instr_rs : instr_rd;

whisk_regfile #(
	.W (W_DATA),
	.N (N_REGS)
) regfile_u (
	.clk        (clk),

	.rd         (writeback_reg),
	.rd_q       (reg_rd_qr),
	.rd_wen     (writeback_wen),
	.rd_d       (writeback_data),

	.rs         (instr_rs),
	.rs_q       (reg_rs_qr),
	.rs_q_next  (reg_rs_qr_next),

	.rt         (instr_rt),
	.rt_q       (reg_rt_qr)
);

// ----------------------------------------------------------------------------
// Program counter

wire pc_dl;
wire pc_qr;

wire [15:0] pc_q_all;
wire pc_qr_next = pc_q_all[1];

whisk_shiftreg_right #(
	.W (16)
) pc_u (
	.clk   (clk),
	.dl    (pc_dl),
	.q_all (pc_q_all),
	.qr    (pc_qr)
);

wire pc_increment =
	state == S_FETCH ||
	state == S_EXEC && instr_has_imm_operand ||
	state == S_SKIP_IMM;

reg pc_ci;
wire pc_co, pc_sum;

assign {pc_co, pc_sum} = pc_qr + (~|bit_ctr[3:1] ? bit_ctr[0] && pc_increment : pc_ci);

always @ (posedge clk) begin
	pc_ci <= pc_co;
end

wire rd_is_pc = instr_rd == 3'd7;

assign pc_dl =
	state == S_EXEC    && rd_is_pc                     ? alu_result   :
	state == S_LS_DATA && rd_is_pc && !instr_op_st_nld ? mem_sdi_prev : pc_sum;

// ----------------------------------------------------------------------------
// ALU

wire alu_op_s =
	instr_rs == 3'd7 ? pc_qr        : reg_rs_qr;

wire alu_op_s_next =
	instr_rs == 3'd7 ? pc_qr_next   : reg_rs_qr_next;

wire alu_op_t =
	instr_rt == 3'd7 ? mem_sdi_prev : reg_rt_qr;

reg alu_ci;
wire [1:0] alu_add = alu_op_s +  alu_op_t + (~|bit_ctr ? 1'b0 : alu_ci);
wire [1:0] alu_sub = alu_op_s + !alu_op_t + (~|bit_ctr ? 1'b1 : alu_ci);

// Left shift uses the carry flop as a 1-cycle delay, counter to the
// register's rightward rotation. Right shift looks ahead to advance its
// rotation. The final carry flag is the bit shifted "out of" the register.

wire [1:0] alu_shift_l = {
	alu_op_s,
	|alu_ci && |bit_ctr
};

// Rotate uses the carry to remember prior LSB and insert it at MSB.
// (Convenient because prior LSB is already the carry flag.)
wire alu_shift_r_last_bit =
	instr_rt[1] ? alu_ci : alu_op_s && instr_rt[0];

wire [1:0] alu_shift_r = {
	|bit_ctr ? alu_ci                  : alu_op_s,
	&bit_ctr ? alu_shift_r_last_bit    : alu_op_s_next
};

// Carry is an all-ones flag for bitwise ops
wire alu_bitop_no_c =
	instr_op == OP_AND    ? alu_op_s &&  alu_op_t :
	instr_op == OP_ANDN   ? alu_op_s && !alu_op_t : alu_op_s ||  alu_op_t;

wire alu_bit_co = alu_bitop_no_c && (alu_ci || ~|bit_ctr);

wire [1:0] alu_bitop = {alu_bit_co, alu_bitop_no_c};

// Byte loads must be zero- or sign-extended. Use the carry to
// propagate the sign.
wire instr_op_ls_byte = !(instr_op_ls_sumr || instr_op_ls_suma);
wire instr_op_ls_sbyte = instr_rt[2];

wire [1:0] alu_load = {
	bit_ctr[3]                     ? alu_ci                      : mem_sdi_prev,
	bit_ctr[3] && instr_op_ls_byte ? alu_ci && instr_op_ls_sbyte : mem_sdi_prev
};

wire alu_co;
assign {alu_co, alu_result} =
	state == S_LS_DATA                   ? alu_load         :
	instr_op_ls                          ? alu_add          :
	instr_op == OP_ADD                   ? alu_add          :
	instr_op == OP_SUB                   ? alu_sub          :
	instr_op == OP_AND                   ? alu_bitop        :
	instr_op == OP_ANDN                  ? alu_bitop        :
	instr_op == OP_OR                    ? alu_bitop        :
	instr_op == OP_SHIFT &&  instr_rt[2] ? alu_shift_l      :
	instr_op == OP_SHIFT && !instr_rt[2] ? alu_shift_r      :
	instr_op == OP_INOUT                 ? ioport_sdi_prev  : alu_add;

always @ (posedge clk) begin
	alu_ci <= alu_co;
end

// ----------------------------------------------------------------------------
// Flags

reg flag_z;
reg flag_c;
reg flag_n;

wire update_flags = (state == S_EXEC || state == S_LS_DATA) && ~|instr_cond;

always @ (posedge clk) begin
	if (update_flags) begin
		flag_z <= (flag_z || ~|bit_ctr) && !alu_result;
		flag_n <= alu_result;
		flag_c <= alu_co;
	end
end

assign condition_vec8 = {
	!flag_z, flag_z,
	!flag_c, flag_c,
	!flag_n, flag_n,
	1'b1,    1'b1
};

// ----------------------------------------------------------------------------
// Address register

// Captures address calculations LSB-first and then replays them MSB-first.

wire        ar_l_nr;
wire        ar_dl;
wire        ar_dr;
wire        ar_ql;
wire        ar_qr;

// Need to look ahead by one bit to get correct timing for read addresses:
wire [15:0] ar_q_all;
wire        ar_ql_next = ar_q_all[14];

whisk_shiftreg_leftright #(
	.W (16)
) ar_u (
	.clk   (clk),
	.l_nr  (ar_l_nr),
	.dl    (ar_dl),
	.ql    (ar_ql),
	.dr    (ar_dr),
	.qr    (ar_qr),
	.q_all (ar_q_all)
);

// Shift left when replaying addresses. Also shift left in LS_ADDR0 to
// recirculate the address generated during EXEC for use in LS_ADDR1.
assign ar_l_nr =
	state == S_LS_ADDR1 ||
	state == S_PC_NONSEQ1 ||
	state == S_LS_ADDR0;

assign ar_dr = ar_ql;

assign ar_dl =
	state == S_PC_NONSEQ0 ? pc_qr   :
	instr_op_ls_suma      ? alu_add : reg_rs_qr;
// ----------------------------------------------------------------------------
// SPI controls

// Deassert CSn before issuing a nonsequential address.

// Note LS_ADDR0 state is skipped if we are able to issue from EXEC:
wire issue_ls_addr_ph0 =
	state == S_LS_ADDR0 ||
	state == S_EXEC && instr_op_ls && !instr_has_imm_operand && instr_cond_true;

wire [3:0] spi_cmd_start_cycle =
	state == S_PC_NONSEQ0 ? 4'h7 :
	instr_op_st_nld       ? 4'h8 : 4'h7;

assign mem_csn_next = bit_ctr < spi_cmd_start_cycle && (
	state == S_PC_NONSEQ0 || issue_ls_addr_ph0
);

// Pedal to the metal on SCK except when pulling CSn for a nonsequential
// access, or when executing an unskipped instruction without immediate or
// early address issue. (Also mask for second half of byte accesses.)

wire mem_sck_disable_on_imm =
	state == (&bit_ctr[3:1] ? S_FETCH : S_EXEC) && instr_cond_true &&
	!(instr_has_imm_operand || issue_ls_addr_ph0);

wire mem_sck_disable_on_byte_ls =
	state == S_LS_DATA && instr_op_ls_byte && bit_ctr[3];

assign mem_sck_en_next = !(
	mem_csn_next ||
	mem_sck_disable_on_imm ||
	mem_sck_disable_on_byte_ls
);

// Store address replays entirely in LS_ADDR1, but load/fetch extend one cycle
// into previous state, so carefully pick what delay to observe the address
// with. (Also mask address to zero for very first fetch at start of day.)
//
// Note in LS_ADDR0 that we are actually recirculating an address generated in
// EXEC, because the address issue was deferred due to an immediate read, so
// this case looks like load-LS_ADDR1 rather than like load-EXEC.

wire mem_spi_addr =
	!instr_cond_true                        ? 1'b0       :
	state == S_PC_NONSEQ1                   ? ar_ql_next :
	state == S_LS_ADDR1 &&  instr_op_st_nld ? ar_ql      :
	state == S_LS_ADDR1 && !instr_op_st_nld ? ar_ql_next :
	state == S_LS_ADDR0                     ? ar_ql_next : ar_dl;

// Note: SPI commands are MSB-first (the commands here are 03h and 02h).
localparam [15:0] SPI_INSTR_READ  = 16'hc000 >> 1;
localparam [15:0] SPI_INSTR_WRITE = 16'h4000;

wire mem_sdo_ls_addr_ph0 =
	instr_op_st_nld ? SPI_INSTR_WRITE[bit_ctr] :
	&bit_ctr        ? mem_spi_addr             : SPI_INSTR_READ[bit_ctr];

assign mem_sdo_next =
	state == S_PC_NONSEQ0 ? (&bit_ctr ? pc_qr : SPI_INSTR_READ[bit_ctr]) :
	state == S_PC_NONSEQ1 ? mem_spi_addr                                 :
	issue_ls_addr_ph0     ? mem_sdo_ls_addr_ph0                          :
	state == S_LS_ADDR1   ? mem_spi_addr                                 :
	state == S_LS_DATA    ? (instr_rd == 3'd7 ? pc_qr : reg_rd_qr)       : 1'b0;

// ----------------------------------------------------------------------------
// IO port

// Expected hardware is a 1x 8-bit PISO, and 2x 8-bit SIPO shift registers:
//
// - OUT: Clock out 16 bits from rt[15:0]/imm[15:0], then pulse latch_o high.
//
// - IN: Clock 8 bits into rd[15:8], with latch_i low for the first clock.
//
// The IN interface is still driven when executing an OUT, with more clocks.
// Abusable for 6 extra inputs if a second PISO register is chained.
//
// rt[13:6] is actually clocked out on an IN, there's just no latch_o pulse.
// Abusable to drive longer SIPO chains using multiple INs and a final OUT.

wire exec_io_instr = state == S_EXEC && instr_op == OP_INOUT;
wire io_instr_out = (instr_rs & (OP2_OUT | OP2_IN)) == OP2_OUT;

// The instruction is still valid on the first cycle of FETCH. This lets us
// latch outputs *after* the last clock pulse, without spending a flop.
assign ioport_latch_o_next = state == S_FETCH && ~|bit_ctr &&
	instr_op == OP_INOUT && io_instr_out && instr_cond_true;

assign ioport_latch_i_next = !(exec_io_instr && bit_ctr == 4'h6);

assign ioport_sdo_next = exec_io_instr && alu_op_t;

assign ioport_sck_en_next  = exec_io_instr && (
	(bit_ctr >= 4'h6 && bit_ctr < 4'he) ||
	io_instr_out
);

endmodule

// ============================================================================
// Module whisk_regfile: a register file of multiple shift registers, with 3
// read ports (rd/rs/rt) and one write port (rd).
// ============================================================================

// All registers rotate right by one bit every cycle. No enable, so do things
// in multiples of 16 cycles. Registers not written to are recirculated.
//
// q is the value of the rightmost flop in each register. The rs port also has
// a q_next value, which taps in one flop from the end, and is required for
// performing right-shift-by-one in 16 cycles.
//
// Out-of-range indices read as 0, and ignore writes.

module whisk_regfile #(
	parameter W = 16,
	parameter N = 6
) (
	input  wire                 clk,

	input  wire [$clog2(N)-1:0] rd,
	output wire                 rd_q,
	input  wire                 rd_wen,
	input  wire                 rd_d,

	input  wire [$clog2(N)-1:0] rs,
	output wire                 rs_q,
	output wire                 rs_q_next,

	input  wire [$clog2(N)-1:0] rt,
	output wire                 rt_q,
);

localparam N_PADDED = 1 << $clog2(N);

wire [N-1:0] d;
wire [N-1:0] d;
wire [W-1:0] q [N_PADDED-1:0];

assign rd_q      = q[rd][0];
assign rs_q      = q[rs][0];
assign rs_q_next = q[rs][1];
assign rt_q      = q[rt][0];

genvar g;
generate
for (g = 0; g < N_PADDED; g = g + 1) begin: loop_gprs
	if (g >= N) begin: gpr_tieoff

		assign q[g] = {W{1'b0}};

	end else begin: gpr_shifter

		// Recirculate unless register is addressed as rd.
		wire qr;
		assign d[g] = rd_wen && rd == g ? rd_d : qr;

		whisk_shiftreg_right #(
			.W (W)
		) reg_u (
			.clk   (clk),
			.dl    (d[g]),
			.qr    (qr),
			.q_all (q[g])
		);

	end
end
endgenerate

endmodule

// ============================================================================
// Module whisk_shiftreg_leftright: a shift register that always shifts left
// or right each cycle.
// ============================================================================

// Note there is no enable because the underlying scan flops do not have an
// enable (there is an enable version, but it's larger, and more routing
// required!). If you don't want to shift, just shift back and forth for an
// even number of cycles, or do a full loop :)
//
// dl and ql are the leftmost inputs and outputs. If l_nr is low (right), ql
// becomes dl on every posedge of clk. (Yes, it's confusing!)
//
// dr and qr are the rightmost inputs and outputs. If l_nr is high (left), qr
// becomes dr on every posedge of clk.

module whisk_shiftreg_leftright #(
	parameter W = 16
) (
	input  wire         clk,
	input  wire         l_nr,
	input  wire         dl,
	input  wire         dr,
	output wire         ql,
	output wire         qr,
	output wire [W-1:0] q_all
);

wire [W+1:0] chain_q;

assign chain_q[0    ] = dr;
assign chain_q[W + 1] = dl;

assign qr    = chain_q[1];
assign ql    = chain_q[W];
assign q_all = chain_q[W:1];

genvar g;
generate
for (g = 1; g < W + 1; g = g + 1) begin: shift_stage
	// Shift-to-left means select the input to your right, and vice versa.
	whisk_flop_scanmux flop_u (
		.clk (clk),
		.sel (l_nr),
		.d   ({chain_q[g - 1], chain_q[g + 1]}),
		.q   (chain_q[g])
	);
end
endgenerate

endmodule

// ============================================================================
// Module whisk_shiftreg_right: register that only shifts right, like Zoolander
// ============================================================================

// Cost per bit is lower than whisk_shiftreg_leftright

module whisk_shiftreg_right #(
	parameter W = 16
) (
	input  wire         clk,
	input  wire         dl,
	output wire         qr,
	output reg  [W-1:0] q_all
);

always @ (posedge clk) begin
	q_all <= {dl, q_all[W-1:1]};
end

assign qr = q_all[0];

endmodule

// ============================================================================
// Module whisk_flop_scanmux: a flop with a mux on its input. Usually reserved
// for DFT scan insertion, but we don't need that where we're going >:)
// ============================================================================

module whisk_flop_scanmux (
	input  wire       clk,
	input  wire       sel,
	input  wire [1:0] d,
	output wire       q
);

`ifdef WHISK_CELLS_SKY130

// (scanchain in TT2 uses sky130_fd_sc_hd__sdfxtp, a simple flop with scan
// mux. An enable version, sky130_fd_sc_hd__sedfxtp, is also available, but
// this is significantly larger. Instantiate the unit-drive version because
// we have a ridiculously long clock period; not sure whether the backend is
// allowed to change the drive.)

sky130_fd_sc_hd__sdfxtp_1 sdff_u (
	.CLK        (clk),
	.D          (d[0]),
	.SCD        (d[1]),
	.SCE        (sel),
	.Q          (q),
	.VPWR       (1'b1),
	.VGND       (1'b0)
);

`else

// Synthesisable model

reg q_r;
always @ (posedge clk) begin
	q_r <= d[sel];
end

assign q = q_r;

`endif

endmodule

// ============================================================================
// Module whisk_spi_serdes: handle the timing of the SPI interface, and
// provide a slightly abstracted interface to the Whisk core
// ============================================================================

// Note the assumption in the core is that if it asserts the last address bit
// by the end of cycle k then it can sample the first data bit at the end of
// cycle k + 2.
//
// - clk posedge k: outputs are registered and go straight into scan chain
// - clk negedge k: SCK rising edge for last address bit is launched into scan chain
// - clk posedge k + 1: SCK falling edge following last address bit is launched into scan chain
// - clk negedge k + 1: sample taken at falling SCK edge comes back through scan
// - clk posedge k + 2: sample taken at SCK rising edge comes back through scan
//
// Unfortunately the sample coming back is not meaningfully constrained with
// respect to clk, so we have some options to shmoo things around. The winner
// is probably to launch our outputs a half cycle earlier (on the negedge) so
// that the input is stable at the point the core samples it on its posedge.
// This creates a half cycle path in the core, but the clock period is long
// so we don't care. This is the default.
//
// Note without the scan problems the core's assumption about delay would be a
// reasonable one.

module whisk_spi_serdes(
	input  wire       clk,
	input  wire       rst_n,

	// Core
	input  wire       sdo,
	input  wire       sck_en,
	input  wire       csn,
	output wire       sdi,

	// IOs
	output wire       padout_sck,
	output wire       padout_csn,
	output wire       padout_sdo,
	input  wire       padin_sdi,

	input  wire       padin_retime_mem_out,
	input  wire [1:0] padin_retime_mem_in
);

// ----------------------------------------------------------------------------
// Output paths

// There are multiple through-paths from the clock input to SPI outputs
// (*mostly* via DFF CK-to-Q) and these should fully settle between the scan
// input latches going transparent, and the outputs being registered back out
// into the scan chain. We can't add IO constraints, but there are plenty of
// wait states in the scan chain driver around this point. Hopefully on TT3
// the scan chain stuff will go away and we can build a normal SPI
// interface.

reg sdo_pos_r;
reg sck_en_pos_r;
reg csn_pos_r;

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		sdo_pos_r <= 1'b0;
		sck_en_pos_r <= 1'b1;
		csn_pos_r <= 1'b0;
	end else begin
		sdo_pos_r <= sdo;
		sck_en_pos_r <= csn;
		csn_pos_r <= sck_en;
	end
end

// Through-path for clock input to SCK output. This *will* glitch, but gating
// cell not required for TT2, as this signal is sampled by the scan flops at
// the tile output.
wire padout_sck_p = sck_en_pos_r && !clk;

// Very dirty option to advance all outputs by a half cycle.

reg sdo_neg_r;
reg sck_en_neg_r;
reg csn_neg_r;

always @ (negedge clk or negedge rst_n) begin
	if (!rst_n) begin
		sdo_neg_r <= 1'b0;
		csn_neg_r <= 1'b1;
		sck_en_neg_r <= 1'b0;
	end else begin
		sdo_neg_r <= sdo;
		csn_neg_r <= csn;
		sck_en_neg_r <= sck_en;
	end
end

wire padout_sck_n = sck_en_neg_r && clk;

assign padout_sdo = padin_retime_mem_out ? sdo_pos_r : sdo_neg_r;
assign padout_csn = padin_retime_mem_out ? csn_pos_r : csn_neg_r;
// Literally a behavioural mux on a clock lmao
assign padout_sck = padin_retime_mem_out ? padout_sck_p : padout_sck_n;

// ----------------------------------------------------------------------------
// Input paths

// 4 options:
// - 0: Nothing
// - 1: Some delay buffers
// - 2: An active-high latch after delay buffers
// - 3: A negedge flop

wire padin_sdi_delay;
`ifdef WHISK_CELLS_SKY130
wire [2:0] padin_sdi_delay_int;
sky130_fd_sc_hd__dlymetal6s6s_1 delbuf[3:0] (
	.A    ({padin_sdi_delay_int, padin_sdi}),
	.X    ({padin_sdi_delay, padin_sdi_delay_int}),
	.VPWR (1'b1),
	.VGND (1'b0)
);
`else
assign padin_sdi_delay = padin_sdi;
`endif

reg sdi_latch;

always @ (*) begin
	if (clk) begin
		sdi_latch <= padin_sdi_delay;
	end
end

reg sdi_negedge;

always @ (negedge clk) begin
	sdi_negedge <= padin_sdi;
end

wire [3:0] sdi_retime_opt = {
	sdi_negedge,
	sdi_latch,
	padin_sdi_delay,
	padin_sdi
};

assign sdi = sdi_retime_opt[padin_retime_mem_in];

endmodule

// ============================================================================
// Module whisk_ioport_serdes: similar to whisk_spi_serdes, but for the
// shift-register-based IO port.
// ============================================================================

module whisk_ioport_serdes(
	input  wire clk,
	input  wire rst_n,

	// Core
	input  wire sdo,
	input  wire sck_en,
	input  wire latch_i,
	input  wire latch_o,
	output wire sdi,

	// IOs
	output wire padout_sdo,
	output wire padout_sck,
	output wire padout_latch_i,
	output wire padout_latch_o,
	input  wire padin_sdi,

	input  wire padin_retime_ioport_out
);

// ----------------------------------------------------------------------------
// Output paths

// Again, stupid cheesy half cycle retiming option that creates a half-cycle
// path from the core

reg sdo_pos;
reg sck_en_pos;
reg latch_i_pos;
reg latch_o_pos;

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		sdo_pos <= 1'b0;
		sck_en_pos <= 1'b0;
		latch_i_pos <= 1'b0;
		latch_o_pos <= 1'b0;
	end else begin
		sdo_pos <= sdo;
		sck_en_pos <= sck_en;
		latch_i_pos <= latch_i;
		latch_o_pos <= latch_o;
	end
end

reg sdo_neg;
reg sck_en_neg;
reg latch_i_neg;
reg latch_o_neg;

always @ (negedge clk or negedge rst_n) begin
	if (!rst_n) begin
		sdo_neg <= 1'b0;
		sck_en_neg <= 1'b0;
		latch_i_neg <= 1'b0;
		latch_o_neg <= 1'b0;
	end else begin
		sdo_neg <= sdo;
		sck_en_neg <= sck_en;
		latch_i_neg <= latch_i;
		latch_o_neg <= latch_o;
	end
end

assign padout_sdo     = padin_retime_ioport_out ? sdo_neg     : sdo_pos;
assign padout_latch_i = padin_retime_ioport_out ? latch_i_neg : latch_i_pos;
assign padout_latch_o = padin_retime_ioport_out ? latch_o_neg : latch_o_pos;

// Again, no clock gating cell for TT2, but must revisit in future. Also
// behavioural mux on clock lmao
assign padout_sck = padin_retime_ioport_out ? (sck_en_neg && clk) : (sck_en_pos && !clk);

// ----------------------------------------------------------------------------
// Input paths

assign sdi = padin_sdi;

endmodule

// ============================================================================
//
//           _     _     _
//          | |   (_)   | |
// __      _| |__  _ ___| | __
// \ \ /\ / / '_ \| / __| |/ /
//  \ V  V /| | | | \__ \   <
//   \_/\_/ |_| |_|_|___/_|\_\
//
//
// When I was 16 I designed a 7400-series breadboard processor called Fork,
// with a language called Spoon. Now I'm 26 and I'm designing a processor
// called Whisk. I wonder what I'll do when I grow up.
//
// Many mistakes were made in this ISA. What did you think? My aim with this
// version of Whisk is to run enough software to discover exactly why my
// instruction set is bad. Hopefully Tiny Tapeout 3 will bring faster IOs,
// with 2D muxing instead of a scan chain, and then I can try getting some
// serious software running on Whisk v2, at a few MHz instead of 12 kHz.
