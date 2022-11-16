module top(
  input wire [7:0] io_in,
  output wire [7:0] io_out
);
  user_module user_module0(io_in, io_out);
endmodule
