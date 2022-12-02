module msaghir_top_level (io_in, io_out);
  input     [7:0] io_in;
  output    [7:0] io_out;

  wire      w_clk = io_in[0];
  wire      w_rst = io_in[1];
  wire      [1:0] w_sel = io_in[3:2];
  wire      w_clk_2hz;
  wire      [2:0] w_count;
  wire      [6:0] w_segment;
  wire      [6:0] w_bus0;
  wire      [6:0] w_bus1;
  wire      [6:0] w_bus2;
  wire      [6:0] w_bus3;

  assign io_out[6:0] = w_segment;

  clk_div           u0 (.i_clk(w_clk), .i_rst(w_rst), .o_clk(w_clk_2hz));
  mod8_counter      u1 (.i_clk(w_clk_2hz), .i_rst(w_rst), .o_count(w_count));
  rand_pattern      u2 (.i_count(w_count), .o_segment(w_bus0));
  cw8_pattern       u3 (.i_count(w_count), .o_segment(w_bus1));
  scan_pattern      u4 (.i_count(w_count[1:0]), .o_segment(w_bus2));
  warning_pattern   u5 (.i_count(w_count[0]), .o_segment(w_bus3));
  mux4              u6 (.i_in0(w_bus0), .i_in1(w_bus1), .i_in2(w_bus2), .i_in3(w_bus3), .i_sel(w_sel), .o_out(w_segment));
endmodule