module cpu_top (
	input [7:0] io_in,
	output [7:0] io_out
);
	
	cpu cpu(.INSTRUCTION(io_in[3:1]), .write_en(io_in[4]), .CLK(io_in[0]), 
					.RESET(io_in[5]), .RD(io_in[6]), .CS(io_in[7]), .PC(io_out[7:0])
				 );
	
endmodule
