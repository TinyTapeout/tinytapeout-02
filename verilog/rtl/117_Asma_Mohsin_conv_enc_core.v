module Asma_Mohsin_conv_enc_core(// Inputs
 input [7:0]io_in,
// Output
 output [7:0]io_out
);
parameter [4:0] POLY_1 = 5'b10111 ;
parameter [4:0] POLY_2 = 5'b11001 ;
// Inputs
wire clk ;
wire rst_n ;
wire data_valid ;
wire d_in ;

assign clk = io_in[0];
assign rst_n=io_in[1];
assign data_valid=io_in[2];
assign d_in=io_in[3];

// Output

//output [1:0] enc_dout ;
reg [4:0] shift_reg ;
reg [1:0] codeword ;
wire [1:0] enc_dout ;
// Shift Input Data in 5 bits lenght register
always @(posedge clk or negedge rst_n)
begin
if(~rst_n)
shift_reg <= 5'd0 ;
else if(data_valid)
shift_reg <= {d_in, shift_reg[4:1]} ;
else
shift_reg <= 5'd0 ;
end
always @(shift_reg)
begin
codeword[0] = ^(POLY_2 & shift_reg) ;
codeword[1] = ^(POLY_1 & shift_reg) ;
end
assign io_out = codeword ;
endmodule

