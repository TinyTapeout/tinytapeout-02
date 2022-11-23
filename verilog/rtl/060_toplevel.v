`default_nettype none

module tt2_tholin_diceroll(
	input [7:0] io_in,
	output [7:0] io_out
);
	wire CLK = io_in[0];
	wire RST = io_in[1];
	wire ROLL = io_in[2];
	wire [7:0] LEDS;
	assign io_out[7:0] = LEDS;
	
	dice dice (
		.CLK(CLK),
		.RST(RST),
		.ROLL(ROLL),
		.LEDS(LEDS)
	);

endmodule
