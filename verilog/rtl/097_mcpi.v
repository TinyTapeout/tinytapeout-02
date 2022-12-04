`default_nettype none

//  Top level io for this module should stay the same to fit into the scan_wrapper.
//  The pin connections within the user_module are up to you,
//  although (if one is present) it is recommended to place a clock on io_in[0].
//  This allows use of the internal clock divider if you wish.
//
//  so, just somehow calculate x^2+y^2 with random
//  0<x, y<1, and compare it with 1
//  using 8-bit fixed point, [7:0]x means x/2**8
//  0.0039 resolution is really coarse...
module regymm_mcpi(
	input [7:0] io_in, 
	output reg [7:0] io_out
);
	wire clk = io_in[0];
	wire rst = io_in[1];
	wire [5:0]sw1 = io_in[7:2];

	always @ (*) begin
		io_out = 0;
		case(sw1[1:0])
			0: io_out = cnt[7:0];
			1: io_out = cnt_in[7:0];
			2: io_out = {6'b0, cnt[0], cnt_in[0]};
		endcase
	end

	reg [8:0]breg;
	reg [7:0]breg2; // shouldn't exceed 7:0 because x^2<1 when 0<x<1
	reg [7:0]x;

	reg [3:0]mulin1;
	reg [3:0]mulin2;
	wire [7:0]mulout;
	mul4_341521390605697619 mul_inst(
		.a(mulin1),
		.b(mulin2),
		.c(mulout)
	);

	reg [7:0]addin1;
	reg [7:0]addin2;
	wire [8:0]addout;
	assign addout = addin1 + addin2;

	// not very random actually, should somehow 
	// receive seed from outside
	reg [7:0]random = 8'h01;
	always @ (posedge clk) begin
		random <= {random[6:0], (random[7] ^ random[5] ^ random[4] ^ random[3])};
	end

	reg [3:0]sts;
	reg [7:0]cnt;
	reg [7:0]cnt_in;
	always @ (posedge clk) begin
		if (rst) begin
			sts <= 0;
			cnt <= 0;
			cnt_in <= 0;
			//x <= 0;
		end else begin
			if (sw1[5] == 0) begin
				case (sts)
					0: begin
						breg <= 0;
						x <= random;
					end
					4: begin
						x <= random;
						breg2 <= breg_in;
					end
					9: begin
						cnt <= cnt + 1;
						if (addout[8]) cnt_in <= cnt_in + 1;
					end
				endcase
				sts <= sts == 10 ? 0 : sts + 1;
				breg <= breg_in;
			end
		end
	end

	reg [8:0]breg_in;
	always @ (*) begin
		mulin1 = 0;
		mulin2 = 0;
		addin1 = 0;
		addin2 = 0;
		breg_in = 0;
		if (sts == 9) begin
			addin1 = breg;
			addin2 = breg2;
		end else begin
			case(sts[1:0])
				2'b01: begin
					mulin1 = x[3:0];
					mulin2 = x[3:0];
					breg_in = {1'b0, mulout};
				end
				2'b10: begin
					mulin1 = x[7:4];
					mulin2 = x[3:0];
					addin1 = {4'b0, breg[7:4]};
					addin2 = mulout;
					breg_in = addout;
				end
				2'b11: begin
					mulin1 = x[3:0];
					mulin2 = x[7:4];
					addin1 = breg[7:0];
					addin2 = mulout;
					breg_in = addout;
				end
				2'b00: begin
					mulin1 = x[7:4];
					mulin2 = x[7:4];
					addin1 = {3'b0, breg[8:4]};
					addin2 = mulout;
					breg_in = addout;
				end
			endcase
		end
	end
endmodule

module add_341521390605697619
#(parameter WIDTH = 8)
(
	input [WIDTH-1:0]a,
	input [WIDTH-1:0]b,
	output [WIDTH:0]c
);
assign c = a + b;
endmodule

module mul4_341521390605697619
(
	input [3:0] a,
	input [3:0] b,
	output [7:0] c
);
wire [3:0]x = b[0] ? a : 0;
wire [3:0]y = b[1] ? a : 0;
wire [3:0]z = b[2] ? a : 0;
wire [3:0]t = b[3] ? a : 0;

assign c = {
	add3,
	add2[0],
	add1[0],
	x[0]
	};
wire [4:0]add1;
add_341521390605697619 #(.WIDTH(4)) add_1(
	.a({1'b0, x[3:1]}),
	.b(y),
	.c(add1)
);

wire [4:0]add2;
add_341521390605697619 #(.WIDTH(4)) add_2(
	.a(add1[4:1]),
	.b(z),
	.c(add2)
);

wire [4:0]add3;
add_341521390605697619 #(.WIDTH(4)) add_3(
	.a(add2[4:1]),
	.b(t),
	.c(add3)
);
endmodule
