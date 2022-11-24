module github_com_proppy_tt02_xls_counter(
  input wire [7:0] io_in,
  output wire [7:0] io_out
);
  wire 	    rdy = 1;
  wire 	    vld;
  user_module counter0(io_in[0], io_in[1], rdy, io_out, vld);
endmodule
