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
	.io_clk            (io_clk),
	.io_rst_n          (io_rst_n),

	.io_mem_sdi        (io_mem_sdi),
	.io_mem_csn        (io_mem_csn),
	.io_mem_sck        (io_mem_sck),
	.io_mem_sdo        (io_mem_sdo),

	.io_ioport_sdi     (io_ioport_sdi),
	.io_ioport_sck     (io_ioport_sck),
	.io_ioport_sdo     (io_ioport_sdo),
	.io_ioport_latch_i (io_ioport_latch_i),
	.io_ioport_latch_o (io_ioport_latch_o)
);

endmodule

// ============================================================================
// Module whisk_top: instantiate the CPU core together with the SPI mem
// serdes and IO port serdes.
// ============================================================================

module whisk_top (
	input  wire io_clk,
	input  wire io_rst_n,

	input  wire io_mem_sdi,
	output wire io_mem_csn,
	output wire io_mem_sck,
	output wire io_mem_sdo,

	input  wire io_ioport_sdi,
	output wire io_ioport_sck,
	output wire io_ioport_sdo,
	output wire io_ioport_latch_i,
	output wire io_ioport_latch_o
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
	.clk        (clk),
	.rst_n      (rst_n),

	.sdo        (mem_sdo_next),
	.sck_en     (mem_sck_en_next),
	.csn        (mem_csn_next),
	.sdi        (mem_sdi_prev),

	.padout_sck (io_mem_sck),
	.padout_csn (io_mem_csn),
	.padout_sdo (io_mem_sdo),
	.padin_sdi  (io_mem_sdi)
);

whisk_ioport_serdes io_serdes_u (
	.clk             (clk),
	.rst_n           (rst_n),

	.sdo             (ioport_sdo_next),
	.sck_en          (ioport_sck_en_next),
	.latch_i         (ioport_latch_i_next),
	.latch_o         (ioport_latch_o_next),
	.sdi             (ioport_sdi_prev),

	.padout_sdo      (io_ioport_sdo),
	.padout_sck      (io_ioport_sck),
	.padout_latch_i  (io_ioport_latch_i),
	.padout_latch_o  (io_ioport_latch_o),
	.padin_sdi       (io_ioport_sdi)
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
localparam [3:0] OP_ADD         = 4'h0; // rd = rs + rt
localparam [3:0] OP_SUB         = 4'h1; // rd = rs - rt
localparam [3:0] OP_AND         = 4'h2; // rd = rs & rt
localparam [3:0] OP_ANDN        = 4'h3; // rd = rs & ~rt
localparam [3:0] OP_OR          = 4'h4; // rd = rs | rt
localparam [3:0] OP_SHIFT       = 4'h5; // Minor opcode in rt
localparam [3:0] OP_INOUT       = 4'h6; // Minor opcode in rs

localparam [3:0] OP_LDR         = 4'h8; //           rd = mem[rs];
localparam [3:0] OP_LDR_IB      = 4'h9; // rs += rt; rd = mem[rs];
localparam [3:0] OP_LDR_DA      = 4'ha; //           rd = mem[rs]; rs -= rt
localparam [3:0] OP_LDR_IB_DA   = 4'hb; // rs += rt; rd = mem[rs]; rs -= rt

localparam [3:0] OP_STR         = 4'hc; //           mem[rs] = rd;
localparam [3:0] OP_STR_IB      = 4'hd; // rs += rt; mem[rs] = rd;
localparam [3:0] OP_STR_DA      = 4'he; //           mem[rs] = rd; rs -= rt
localparam [3:0] OP_STR_IB_DA   = 4'hf; // rs += rt; mem[rs] = rd; rs -= rt

// Minor opcodes (rt)
localparam [2:0] OP2_SRL        = 3'h0;
localparam [2:0] OP2_SRA        = 3'h1;
localparam [2:0] OP2_SLL        = 3'h4;

// Minor opcodes (rs)
localparam [2:0] OP2_IN         = 3'h0;
localparam [2:0] OP2_OUT        = 3'h4;

// ----------------------------------------------------------------------------
// Main control state machine

wire [W_INSTR-1:0] instr;

wire [INSTR_OP_MSB  -INSTR_OP_LSB  :0] instr_op;
wire [INSTR_COND_MSB-INSTR_COND_LSB:0] instr_cond;
wire [INSTR_RT_MSB  -INSTR_RT_LSB  :0] instr_rt;
wire [INSTR_RS_MSB  -INSTR_RS_LSB  :0] instr_rs;
wire [INSTR_RD_MSB  -INSTR_RD_LSB  :0] instr_rd;

assign {instr_rd, instr_rs, instr_rt, instr_cond, instr_op} = instr;

wire instr_op_ls     = instr_op[3]; // Whether an instruction is a load/store
wire instr_op_st_nld = instr_op[2]; // Whether a load/store is a load or store
wire instr_op_ls_da  = instr_op[1]; // Whether a load/store has decrement-after
wire instr_op_ls_ib  = instr_op[0]; // Whether a load/store has increment-before

reg [3:0] bit_ctr;
reg [2:0] state;
reg       instr_cond_true;
reg       instr_has_imm_operand;

// Note there is a 2 cycle delay from issuing a bit on SDO to getting a bit
// back on SDI. This is handled with a 2-cycle stall after issuing a read
// address, so that e.g. S_FETCH always has the first instruction bit
// available on the first cycle.

localparam [2:0] S_FETCH      = 3'd0; // Sample 16 instr bits, increment PC
localparam [2:0] S_EXEC       = 3'd1; // Loop all GPRs, write one GPR
localparam [2:0] S_PC_NONSEQ0 = 3'd2; // Issue cmd, then issue 2 PC bits
localparam [2:0] S_PC_NONSEQ1 = 3'd3; // Issue rest of PC bits, stall 2 cycles
localparam [2:0] S_LS_ADDR0   = 3'd4; // Issue cmd; if load, issue 2 addr bits
localparam [2:0] S_LS_ADDR1   = 3'd5; // Issue addr; if load, stall 2 cycles
localparam [2:0] S_LS_DATA    = 3'd6; // Issue store data, or sample load data
localparam [2:0] S_LS_IMMPD   = 3'd7; // Re-read imm for imm post-decrement

reg [3:0] bit_ctr_nxt_wrap;
reg [3:0] bit_ctr_nxt;
reg [2:0] state_nxt_wrap;
reg [2:0] state_nxt;

always @ (*) begin
	state_nxt_wrap = state;
	bit_ctr_nxt_wrap = bit_ctr + 4'h1;
	case (state)
		S_FETCH: begin
			if (!instr_cond_true) begin
				if (instr_has_imm_operand) begin
					// Need to dump 16 more bits, and if we stay in this
					// state then instr_cond_true will lose its value, so take a detour
					state_nxt_wrap = S_LS_IMMPD;
				end else begin
					state_nxt_wrap = S_FETCH;
				end
			end else if (instr[4] && !instr[1]) begin
				// Load/store with no preincrement, go straight to address
				// state (note instruction is left-shifted by 1 at this point)
				state_nxt_wrap = S_LS_ADDR0;
				bit_ctr_nxt_wrap = instr[3] ? 4'h8 : 4'h6; // FIXME no chip select deassert on store!
			end else begin
				state_nxt_wrap = S_EXEC;
			end
		end
		S_EXEC: begin
			if (instr_op_ls) begin
				state_nxt_wrap = S_LS_ADDR0;
				bit_ctr_nxt_wrap = instr[3] ? 4'h8 : 4'h6;
			end else if (instr_rd == 3'd7) begin
				state_nxt_wrap = S_PC_NONSEQ0;
				bit_ctr_nxt_wrap = 4'h6;
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
			end else if (instr_has_imm_operand && instr_op_ls && instr_op_ls_da) begin
				state_nxt_wrap = S_LS_IMMPD;
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
			bit_ctr_nxt_wrap = 4'h6;
		end
		S_LS_IMMPD: begin
			if (instr_cond_true) begin
				state_nxt_wrap = S_PC_NONSEQ0;
				bit_ctr_nxt_wrap = 4'h6;
			end else begin
				// Borrowed to dump the second half of a false-predicate instruction
				state_nxt_wrap = S_FETCH;
			end
		end
	endcase
	state_nxt   = &bit_ctr ? state_nxt_wrap   : state;
	bit_ctr_nxt = &bit_ctr ? bit_ctr_nxt_wrap : bit_ctr + 4'h1;
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
//
// - You may then want to clear all the GPRs, though it's not necessary as
//   they will always be written before first read.

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		state <= S_PC_NONSEQ0;
		bit_ctr <= 4'h6;
	end else begin
		state <= state_nxt;
		bit_ctr <= bit_ctr_nxt;
	end
end

// ----------------------------------------------------------------------------
// Instruction shifter and early decode

// Manually instantiate DFFEs, as otherwise we get mux + DFF which is larger

wire shift_instr_reg = state == S_FETCH;

whisk_flop_en instr_flop_u[15:0] (
	.clk (clk),
	.d   ({mem_sdi_prev, instr[15:1]}),
	.e   (shift_instr_reg),
	.q   (instr)
);

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
			instr_has_imm_operand_nxt = instr[W_INSTR-1 -: 3] == 3'd6;
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

wire regfile_shift_l_nr;

wire reg_rd_ql, reg_rd_qr;
wire reg_rs_ql, reg_rs_qr;
wire reg_rt_ql, reg_rt_qr;

wire alu_result;

wire ls_early_postdec = state == S_PC_NONSEQ1 && instr_op_ls &&
	instr_op_ls_da && !instr_has_imm_operand;

wire writeback_wen =
	state == S_EXEC ||
	state == S_LS_DATA && !instr_op_st_nld ||
	state == S_PC_NONSEQ1 && ls_early_postdec ||
	state == S_LS_IMMPD && instr_cond_true;

wire writeback_data = state == S_LS_DATA ? mem_sdi_prev : alu_result;

wire [INSTR_RD_MSB-INSTR_RD_LSB:0] writeback_reg =
	instr_op_ls && state != S_LS_DATA ? instr_rs : instr_rd;

whisk_regfile #(
	.W (W_DATA),
	.N (N_REGS)
) regfile_u (
	.clk    (clk),
	.l_nr   (regfile_shift_l_nr),

	.rd     (writeback_reg),
	.rd_ql  (reg_rd_ql),
	.rd_qr  (reg_rd_qr),
	.rd_wen (writeback_wen),
	.rd_d   (writeback_data),

	.rs     (instr_rs),
	.rs_ql  (reg_rs_ql),
	.rs_qr  (reg_rs_qr),

	.rt     (instr_rt),
	.rt_ql  (reg_rt_ql),
	.rt_qr  (reg_rt_qr)
);

// On every cycle, the GPRs are shifted or rotated either to the left or the
// right. There is no shift enable, because enables cost money.
//
// - Normally we shift to right, and qr (rightmost flop in each register
//   chain) is the output. This lets us propagate carries serially.
//   Exceptions are: EXEC (instr: SRL/SRA only), LS_ADDR0 and LS_ADDR1.
//
// - For EXEC of SRL/SRA we reverse the GPR rotation to get the opposite shift
//   direction from a SLL. (See signal: alu_shift)
//
// - Total shift amount through LS_ADDR0/LS_ADDR1 must be a multiple of 16, to
//   avoid permanently rotating a register!
//
// - Total shift amount at cycle n, mod 2, is always n mod 2. (The total shift
//   amount always increments or decrements.) Get around this by using qr/ql
//   outputs of regfile.
//
// - Loads: Read address MSB-first (shift to left). MSB must be available on
//   final cycle of LS_ADDR0. LSB must be available on penultimate cycle of
//   LS_ADDR1, so that load data is available first cycle of LS_DATA. Shift
//   to left for last 2 cycles of ADDR0 and first 14 cycles of ADDR1, output
//   is qr. Jiggle back and forth for remaining cycles to keep 2-cycle shift
//   sum at 0.
//
// - Stores: Read address MSB-first (shift to left). LSB of address must be
//   available on final cycle of LS_ADDR1, store data follows immmediately in
//   LS_DATA. Rotate left for entirety of LS_ADDR1, output is ql.
//
// - Need to jiggle the register file during PC_NSEQ0 as this is not 16 cycles
//   long and we don't want to permanently rotate the register file

wire instr_is_right_shift = instr_op == OP_SHIFT && !instr_rt[2];

assign regfile_shift_l_nr =
	state == S_PC_NONSEQ0                   ? bit_ctr[0]                          :
	state == S_EXEC && instr_is_right_shift ? 1'b1                                :
	state == S_LS_ADDR0 && !instr_op_st_nld ? (&bit_ctr[3:1] ? 1'b1 : bit_ctr[0]) :
	state == S_LS_ADDR1 && !instr_op_st_nld ? (&bit_ctr[3:1] ? bit_ctr[0] : 1'b1) :
	state == S_LS_ADDR1 &&  instr_op_st_nld ? 1'b1                                : 1'b0;

// ----------------------------------------------------------------------------
// Program counter

wire pc_l_nr;
wire pc_dl;
wire pc_qr;
wire pc_dr;
wire pc_ql;

whisk_shiftreg_leftright #(
	.W (16)
) pc_u (
	.clk  (clk),
	.l_nr (pc_l_nr),
	.dl   (pc_dl),
	.dr   (pc_dr),
	.ql   (pc_ql),
	.qr   (pc_qr)
);

// We increment PC at the following times, noting that at the beginning of
// S_FETCH we do not know whether the instruction has an immediate, or
// whether its condition is true:
//
// - S_FETCH: +2 (Note: if there is an immediate, and cond is false, we go
//   through S_LS_IMMPD to dump the immediate, so +4 total).
//
// - S_EXEC: +2 if there is an immediate, UNLESS instruction is a load/store
//   with post-decrement.
//
// - S_LS_IMMPD: +2 (only reachable for load/store with immediate
//   post-decrement, or for dumping second half of disabled instruction).
//   Note: these instructions need special handling because they fetch the
//   immediate twice, so PC needs to point to the immediate after S_EXEC.

wire pc_increment =
	state == S_FETCH ||
	state == S_EXEC && instr_has_imm_operand && !(instr_op_ls && instr_op_ls_da) ||
	state == S_LS_IMMPD;

reg pc_ci;
wire pc_co, pc_sum;

assign {pc_co, pc_sum} = pc_qr + (~|bit_ctr[3:1] ? bit_ctr[0] && pc_increment : pc_ci);

always @ (posedge clk) begin
	pc_ci <= pc_co;
end

// Similar shift rules to register file shift rules for loads. LSB of addr is
// available on q_r on the penultimate cycle of PC_NONSEQ1. Also jiggle the
// PC during LS_ADDR0, as this state is not 16 cycles long, and we don't want
// to permanently rotate the PC.

wire pc_l_nr =
	state == S_PC_NONSEQ0 ? (&bit_ctr[3:1] ? 1'b1 : bit_ctr[0]) :
	state == S_PC_NONSEQ1 ? (&bit_ctr[3:1] ? bit_ctr[0] : 1'b1) :
	state == S_LS_ADDR0   ? bit_ctr[0]                          : 1'b0;

assign pc_dr = pc_ql;

assign pc_dl =
	state == S_FETCH                                           ? pc_sum       :
	state == S_EXEC    && instr_rd != 3'd7                     ? pc_sum       :
	state == S_EXEC    && instr_rd == 3'd7                     ? alu_result   :
	state == S_LS_DATA && instr_rd == 3'd7 && !instr_op_st_nld ? mem_sdi_prev :
	state == S_LS_IMMPD                                        ? pc_sum       : pc_qr;

// ----------------------------------------------------------------------------
// ALU

wire alu_op_s =
	instr_rs == 3'd7 ? pc_qr        : reg_rs_qr;

wire alu_op_t =
	instr_rt == 3'd7 ? pc_qr        :
	instr_rt == 3'd6 ? mem_sdi_prev : reg_rt_qr;

reg alu_ci;
wire [1:0] alu_add = alu_op_s +  alu_op_t + (~|bit_ctr ? 1'b0 : alu_ci);
wire [1:0] alu_sub = alu_op_s + !alu_op_t + (~|bit_ctr ? 1'b1 : alu_ci);

// Shift uses the ALU carry flop as a 1-cycle delay. SRL/SRA rotate the
// regfile to the left, SLL rotates the regfile to the right, and the delay
// produces a shift opposite to the regfile's rotation.

wire [1:0] alu_shift = {
	instr_is_right_shift ? reg_rs_ql : reg_rs_qr,
	|bit_ctr ? alu_ci : reg_rs_qr && instr_rt[0]
};

wire alu_co;
assign {alu_co, alu_result} =
	state == S_LS_IMMPD           ? alu_sub               :
	ls_early_postdec              ? alu_sub               :
	// state == S_EXEC:
	instr_op_ls && instr_op_ls_ib ? alu_add               :
	instr_op == OP_ADD            ? alu_add               :
	instr_op == OP_SUB            ? alu_sub               :
	instr_op == OP_AND            ? alu_op_s &&  alu_op_t :
	instr_op == OP_ANDN           ? alu_op_s && !alu_op_t :
	instr_op == OP_OR             ? alu_op_s ||  alu_op_t :
	instr_op == OP_SHIFT          ? alu_shift             :
	instr_op == OP_INOUT          ? ioport_sdi_prev       : reg_rd_qr;

always @ (posedge clk) begin
	alu_ci <= alu_co;
end

// ----------------------------------------------------------------------------
// Flags

reg flag_z;
reg flag_c;
reg flag_n;

wire update_flags = (state == S_EXEC || state == S_LS_DATA) && ~|instr_cond;

// TODO sensible flags for load/store
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
// Memory SPI controls

// Deassert CSn before issuing a nonsequential address, only.
assign mem_csn_next = bit_ctr == 4'h6 && (
	state == S_PC_NONSEQ0 ||
	state == S_LS_ADDR0
);

// Pedal to the metal on SCK except when pulling CSn for a nonsequential
// access, or when executing an instruction with no immediate.
assign mem_sck_en_next = !(
	mem_csn_next ||
	state == (&bit_ctr[3:1] ? S_FETCH : S_EXEC) && !instr_has_imm_operand && instr_cond_true
);

// ldr issues addresses one cycle earlier than str, due to in->out delay.
// Note: SPI commands are MSB-first (the commands here are 03h and 02h).
localparam [15:0] SPI_INSTR_READ  = 16'hc000 >> 1;
localparam [15:0] SPI_INSTR_WRITE = 16'h8000;

// See notes on shift direction in register file section. We are shifting to
// left to get MSB-first addr, but since load addresses are a cycle early,
// they end up using the qr output to get even register lag on an odd cycle.
wire ls_addr = instr_op_st_nld ? reg_rs_ql : reg_rs_qr;

wire mem_sdo_ls_addr0 =
	instr_op_st_nld ? SPI_INSTR_WRITE[bit_ctr] :
	&bit_ctr        ? ls_addr                  : SPI_INSTR_READ[bit_ctr];

assign mem_sdo_next =
	state == S_PC_NONSEQ0 ? (&bit_ctr ? pc_qr : SPI_INSTR_READ[bit_ctr]) :
	state == S_PC_NONSEQ1 ? pc_qr && instr_cond_true                     :
	state == S_LS_ADDR0   ? mem_sdo_ls_addr0                             :
	state == S_LS_ADDR1   ? ls_addr                                      :
	state == S_LS_DATA    ? reg_rd_qr                                    : 1'b0;

// ----------------------------------------------------------------------------
// IO port

// Expected hardware is a 1x 8-bit PISO, and 2x 8-bit SIPO shift registers:
//
// - OUT: Clock out 16 bits from rt[15:0]/imm[15:0], then pulse latch_o high.
//
// - IN: Clock 8 bits into rd[15:8], with latch_i high for the first clock.
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

assign ioport_latch_i_next = exec_io_instr && bit_ctr == 4'h6;

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

// No enable, so try to do things in multiples of 16 cycles. Registers not
// being written to are recirculated.
//
// qr is the value of the rightmost flop in a shift register (usually what you
// want when shifting out to right) and ql is the value of the leftmost flop
// in a shift register (usually what you want when shifting out to left).
//
// Out-of-range indices read as 0, and ignore writes.

module whisk_regfile #(
	parameter W = 16,
	parameter N = 6
) (
	input  wire                 clk,
	input  wire                 l_nr,

	input  wire [$clog2(N)-1:0] rd,
	output wire                 rd_ql,
	output wire                 rd_qr,
	input  wire                 rd_wen,
	input  wire                 rd_d,

	input  wire [$clog2(N)-1:0] rs,
	output wire                 rs_ql,
	output wire                 rs_qr,

	input  wire [$clog2(N)-1:0] rt,
	output wire                 rt_ql,
	output wire                 rt_qr
);

localparam N_PADDED = 1 << $clog2(N);

wire [N-1:0]        dl;
wire [N-1:0]        dr;
wire [N_PADDED-1:0] ql;
wire [N_PADDED-1:0] qr;

assign rd_ql = ql[rd];
assign rs_ql = ql[rs];
assign rt_ql = ql[rt];

assign rd_qr = qr[rd];
assign rs_qr = qr[rs];
assign rt_qr = qr[rt];

genvar g;
generate
for (g = 0; g < N_PADDED; g = g + 1) begin: loop_gprs
	if (g >= N) begin: gpr_tieoff

		assign ql[g] = 1'b0;
		assign qr[g] = 1'b0;

	end else begin: gpr_shifter

		// Recirculate unless this register is addressed as rd.
		assign dl[g] = rd_wen && rd == g ? rd_d : qr[g];
		assign dr[g] = rd_wen && rd == g ? rd_d : ql[g];

		whisk_shiftreg_leftright #(
			.W (W)
		) reg_u (
			.clk  (clk),
			.l_nr (l_nr),
			.dl   (dl[g]),
			.ql   (ql[g]),
			.dr   (dr[g]),
			.qr   (qr[g])
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
// even number of cycles, or do a full loop :) Shifting by an odd number of
// bits in an even number of cycles requires a delay flop to be patched in.
//
// dl and ql are the leftmost inputs and outputs. If l_nr is low (right), ql
// becomes dl on every posedge of clk. (Yes, it's confusing!)
//
// dr and qr are the rightmost inputs and outputs. If l_nr is high (left), qr
// becomes dr on every posedge of clk.

module whisk_shiftreg_leftright #(
	parameter W = 16
) (
	input  wire clk,
	input  wire l_nr,
	input  wire dl,
	input  wire dr,
	output wire ql,
	output wire qr
);

wire [W+1:0] chain_q;

assign chain_q[0    ] = dr;
assign chain_q[W + 1] = dl;

assign qr = chain_q[1];
assign ql = chain_q[W];

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
// Module whisk_flop_en: a flop with an input enable (DFFE). For some reason
// these are not mapped automatically, so we get a DFF, a mux and two  buffers
// ============================================================================

module whisk_flop_en (
	input  wire clk,
	input  wire d,
	input  wire e,
	output wire q
);

`ifdef WHISK_CELLS_SKY130

sky130_fd_sc_hd__edfxtp_1 dffe_u (
	.CLK        (clk),
	.D          (d),
	.DE         (e),
	.Q          (q),
	.VPWR       (1'b1),
	.VGND       (1'b0)
);

`else

// Synthesisable model

reg q_r;
always @ (posedge clk) begin
	if (e) begin
		q_r <= d;
	end
end

assign q = q_r;

`endif

endmodule
// ============================================================================
// Module whisk_spi_serdes: handle the timing of the SPI interface, and
// provide a slightly abstracted interface to the whisk core, with all
// signals on posedge of clk.
// ============================================================================

module whisk_spi_serdes(
	input  wire clk,
	input  wire rst_n,

	// Core
	input  wire sdo,
	input  wire sck_en,
	input  wire csn,
	output wire sdi,

	// IOs
	output wire padout_sck,
	output wire padout_csn,
	output wire padout_sdo,
	input  wire padin_sdi
);

// ----------------------------------------------------------------------------
// Output paths

reg sdo_r;
reg sck_en_r;
reg csn_r;

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		sdo_r <= 1'b0;
		csn_r <= 1'b1;
		sck_en_r <= 1'b0;
	end else begin
		sdo_r <= sdo;
		csn_r <= csn;
		sck_en_r <= sck_en;
	end
end

assign padout_sdo = sdo_r;
assign padout_csn = csn_r;

// Through-path for clock input to SCK output. TODO clock gating cell
// required? This is sampled by the scan flops at the tile output.
assign padout_sck = sck_en_r && !clk;

// ----------------------------------------------------------------------------
// Input paths

`ifdef WHISK_CELLS_SKY130

// ASIC version

// TODO find a suitable delay buffer cell for hold buffering, and decide how to
// dimension it against i[7:0] skew

// TODO find a suitable latch cell (possibly sky130_fd_sc_hd__dlxtp)

wire padin_sdi_delay = padin_sdi;

reg sdi_latch;

always @ (*) begin
	if (clk) begin
		sdi_latch <= padin_sdi_delay;
	end
end

assign sdi = sdi_latch;

`else

// Dodgy sim-only version

reg padin_sdi_reg;
always @ (negedge clk) begin
	padin_sdi_reg <= padin_sdi;
end

// FIXME there is something I don't understand here with the CXXRTL delta cycles
// assign sdi = padin_sdi_reg;
assign sdi = padin_sdi;

`endif

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
	input  wire padin_sdi
);

// ----------------------------------------------------------------------------
// Output paths

reg sdo_r;
reg sck_en_r;
reg latch_i_r;
reg latch_o_r;

always @ (posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		sdo_r <= 1'b0;
		sck_en_r <= 1'b0;
		latch_i_r <= 1'b0;
		latch_o_r <= 1'b0;
	end else begin
		sdo_r <= sdo;
		sck_en_r <= sck_en;
		latch_i_r <= latch_i;
		latch_o_r <= latch_o;
	end
end

assign padout_sdo = sdo_r;
assign padout_latch_i = latch_i_r;
assign padout_latch_o = latch_o_r;

// TODO clock gating cell?
assign padout_sck = sck_en_r && !clk;

// ----------------------------------------------------------------------------
// Input paths

// FIXME this is actually different from SPI, right? Probably transitions on
// posedge? Need to find some actual datasheets for candidate shift
// registers.

`ifdef WHISK_CELLS_SKY130

// ASIC version

// TODO find a suitable delay buffer cell for hold buffering, and decide how to
// dimension it against i[7:0] skew

// TODO find a suitable latch cell (possibly sky130_fd_sc_hd__dlxtp)

wire padin_sdi_delay = padin_sdi;

reg sdi_latch;

always @ (*) begin
	if (clk) begin
		sdi_latch <= padin_sdi_delay;
	end
end

assign sdi = sdi_latch;

`else

// Dodgy sim-only version

reg padin_sdi_reg;
always @ (negedge clk) begin
	padin_sdi_reg <= padin_sdi;
end

assign sdi = padin_sdi_reg;

`endif

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
