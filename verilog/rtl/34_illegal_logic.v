module jar_illegal_logic
(
	input  [7:0] io_in,
	output [7:0] io_out
);
	wire clk   = io_in[0];
	wire reset = io_in[1];
	wire oe    = io_in[2];
	wire [6:0] led_out;
	assign io_out[6:0] = (oe) ? led_out : 7'b0;

	reg [4:0] index;
	wire [3:0] hex;

	wire v0 = index[4];
	wire v1 = index[3];
	wire v2 = index[2];
	wire v3 = index[1];
	wire v4 = index[0];

	wire n4 = !v4;
	wire n3 = !v3;
	wire n2 = !v2;
	wire n1 = !v1;
	wire n0 = !v0;

	always @(posedge clk) begin
		if (reset) begin
			index <= 0;
		end else begin
			hex[3] <= (n0&n1&n2&v3)|(n0&v1&v2&v3&v4)|(v0&n1&n2&n3)|(v0&v1&v2&n3)|(n0&v1&v2&n3&n4)|(v0&v2&v3&n4)|(n0&n1&n2&v4)|(n0&v1&n2&n3);
			hex[2] <= (n0&v1&n2&v4)|(v0&v1&n2&n3&n4)|(v0&n1&v2&v4)|(n0&v1&v2&n3&n4)|(v0&v2&v3&n4)|(v0&n1&n3&n4)|(n0&v1&v3&n4)|(n2&v3&n4)|(v1&n2&v3);
			hex[1] <= (v0&n1&v2&n3&v4)|(v0&v1&n2&n3&n4)|(n0&v2&v3&v4)|(v0&v1&n2&v4)|(n0&v1&v2&n3&n4)|(n0&n2&v3&n4)|(n0&v1&v2&v4);
			hex[0] <= (v0&n1&v3&v4)|(n0&n1&v2&n3)|(v1&n2&v3&n4)|(v1&n2&n3&v4)|(v0&n1&n3&n4)|(n0&n1&n2&v4)|(n0&n2&v3&n4)|(n0&v1&v2&v4)|(n0&v1&v3&n4)|(n0&v1&n2&n3);
			index <= index + 1;
		end
	end

	seg7hex seg7hex(.hex(hex), .segments(led_out));

endmodule
