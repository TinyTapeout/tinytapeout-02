`default_nettype none

module tt2_tholin_namebadge (
	input [7:0] io_in,
	output [7:0] io_out
);
	wire CLK = io_in[0];
	wire RST = io_in[1];
	wire RS;
	wire E;
	wire D4;
	wire D5;
	wire D6;
	wire D7;
	wire LED;
	assign io_out[0] = RS;
	assign io_out[1] = E;
	assign io_out[2] = D4;
	assign io_out[3] = D5;
	assign io_out[4] = D6;
	assign io_out[5] = D7;
	assign io_out[6] = LED;
	
	lcd lcd (
		.CLK(CLK),
		.RST(RST),
		.RS(RS),
		.E(E),
		.D4(D4),
		.D5(D5),
		.D6(D6),
		.D7(D7),
		.LED(LED));
endmodule
