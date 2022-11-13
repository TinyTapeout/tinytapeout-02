module chase_the_beat (
  input [7:0] io_in,
  output [7:0] io_out
);
    top top(.o(io_out), .clk(io_in[0]), .rst(io_in[1]), .tap(io_in[2]), .mode(io_in[3]));
endmodule