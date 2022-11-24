`default_nettype none

module tt2_tholin_namebadge (
	input [7:0] io_in,
	output [7:0] io_out
);
	wire CLK = io_in[0];
	wire RST = io_in[1];
	wire EF0 = io_in[2];
	wire EF1 = io_in[3];
	wire EF2 = io_in[4];
	wire RS;
	wire E;
	wire D4;
	wire D5;
	wire D6;
	wire D7;
	wire LED0;
	wire LED1;
	assign io_out[0] = RS;
	assign io_out[1] = E;
	assign io_out[2] = D4;
	assign io_out[3] = D5;
	assign io_out[4] = D6;
	assign io_out[5] = D7;
	assign io_out[6] = LED0;
	assign io_out[7] = LED1;
	
	lcd lcd (
		.CLK(CLK),
		.RST(RST),
		.EF0(EF0),
		.EF1(EF1),
		.EF2(EF2),
		.RS(RS),
		.E(E),
		.D4(D4),
		.D5(D5),
		.D6(D6),
		.D7(D7),
		.LED0(LED0),
		.LED1(LED1)
		);
endmodule
