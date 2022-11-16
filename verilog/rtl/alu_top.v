module alu_top (
	input [7:0] io_in,
	output [7:0] io_out
);
	
	alu alu(.A(io_in[7:6]), .B(io_in[5:4]), .ALU_Sel(io_in[3:0]), 
		.ALU_Out(io_out[6:0]), .CarryOut(io_out[7])
  );
	
endmodule
