module msaghir_top_level 
  (
    input   [7:0] io_in, 
    output  [7:0] io_out
  );

  wire      w_clk = io_in[0];
  wire      w_rst = io_in[1];
  wire      [3:0] w_sel = io_in[5:2];
  wire      w_blink = io_in[6];
  wire      w_fx = io_in[7];
  wire      [6:0] w_segment;
  wire      w_clk2Hz;
  wire      [6:0] w_bus0;
  wire      [6:0] w_bus1;

  assign io_out = {1'b0, w_segment};

  digit_gen b0 (.i_digit(w_sel), .i_blink(w_blink), .i_clk2Hz(w_clk2Hz), .o_segment(w_bus0));
  fx_gen    b1 (.i_clk(w_clk), .i_rst(w_rst), .i_sel(w_sel), .o_clk2Hz(w_clk2Hz), .o_segment(w_bus1));
  mux2      b2 (.i_in0(w_bus0), .i_in1(w_bus1), .i_sel(w_fx), .o_out(w_segment));

endmodule