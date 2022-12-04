`default_nettype none

// Keep I/O fixed for TinyTapeout
module gregdavill_clock_top(
  input [7:0] io_in, 
  output [7:0] io_out
);

clock clock_top (
    .i_clk(io_in[0]),
    .i_rst(io_in[1]),
    .i_min_up(io_in[2]),
    .i_hour_up(io_in[3]),
    .o_clk(io_out[0]),
    .o_latch(io_out[1]),
    .o_bit(io_out[2])
);

endmodule