`timescale 1ns/1ns

module fraserbc_simon (
	io_in,
	io_out
);

	input  wire [7:0] io_in;
	output wire [7:0] io_out;

	assign io_out[7:4] = 4'b0;

	/* Instantiate main module */
	simon simon0 (
		.i_clk(io_in[0]),
		.i_shift(io_in[1]),
		.i_data(io_in[5:2]),
		.o_data(io_out[3:0])
	);

endmodule

module lfsr_z0(
	i_clk,
	i_rst,
	o_data
);

	input  wire i_clk;
	input  wire i_rst;
	output wire o_data;

	reg [4:0] r_lfsr;
	assign o_data = r_lfsr[0];

	always @(posedge i_clk)
		if(i_rst)
			r_lfsr <= 5'b00001;
		else begin
			r_lfsr[4] <= r_lfsr[3];
			r_lfsr[3] <= r_lfsr[2];
			r_lfsr[2] <= r_lfsr[4] ^ r_lfsr[1];
			r_lfsr[1] <= r_lfsr[0];
			r_lfsr[0] <= r_lfsr[4] ^ r_lfsr[0];
		end

endmodule

module simon (
	i_clk,
	i_shift,
	i_data,
	o_data
);

	input  wire       i_clk;
	input  wire       i_shift;
	input  wire [3:0] i_data;
	output wire [3:0] o_data;

	assign o_data = r_round[3:0];

	/* z0 Sequence */
	wire w_z0;
	lfsr_z0 lfsr0 (
		.i_clk(i_clk),
		.i_rst(i_shift),
		.o_data(w_z0)
	);

	/* Key Schedule */
	reg [63:0] r_key;
	wire [15:0] w_temp = r_key[31:16] ^ {r_key[50:48],r_key[63:51]};	// Right circular shift
	always @(posedge i_clk) begin
		if (i_shift)
			r_key <= {i_data, r_key[63:4]};
		else begin
			r_key[15:0] <= r_key[31:16];
			r_key[31:16] <= r_key[47:32];
			r_key[47:32] <= r_key[63:48];
			r_key[63:48] <= (2**16 - 4) ^ {{15{1'b0}}, w_z0} ^ w_temp ^ r_key[15:0] ^ {w_temp[0],w_temp[15:1]};
		end
	end

	/* Encrypt */
	reg [31:0] r_round;
	always @(posedge i_clk) begin
		if (i_shift)
			r_round <= {r_key[3:0], r_round[31:4]};
		else begin
			r_round[15:0] <= r_round[31:16];
			r_round[31:16] <= (({r_round[30:16],r_round[31]} & {r_round[23:16],r_round[31:24]})) ^ {r_round[29:16],r_round[31:30]} ^ r_key[15:0] ^ r_round[15:0];
		end
	end

endmodule