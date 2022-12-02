/* Automatically generated from https://wokwi.com/projects/349209305274122835 */

`default_nettype none

module user_module_349209305274122835(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[1];
  wire net2 = io_in[2];
  wire net3 = io_in[3];
  wire net4 = io_in[4];
  wire net5 = io_in[5];
  wire net6 = io_in[6];
  wire net7 = io_in[7];
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15 = 1'b0;
  wire net16 = 1'b1;
  wire net17 = 1'b1;

  assign io_out[0] = net1;
  assign io_out[1] = net8;
  assign io_out[2] = net9;
  assign io_out[3] = net10;
  assign io_out[4] = net11;
  assign io_out[5] = net12;
  assign io_out[6] = net13;
  assign io_out[7] = net14;

  and_cell gate1 (
    .a (net1),
    .b (net1),
    .out (net8)
  );
  or_cell gate2 (

  );
  xor_cell gate3 (

  );
  nand_cell gate4 (

  );
  buffer_cell gate6 (

  );
  mux_cell mux1 (

  );
  dff_cell flipflop1 (
    .d (net2),
    .clk (net8),
    .q (net9)
  );
  dff_cell flipflop2 (
    .d (net3),
    .clk (net8),
    .q (net10)
  );
  dff_cell flipflop3 (
    .d (net4),
    .clk (net8),
    .q (net11)
  );
  dff_cell flipflop4 (
    .d (net5),
    .clk (net8),
    .q (net12)
  );
  dff_cell flipflop5 (
    .d (net6),
    .clk (net8),
    .q (net13)
  );
  dff_cell flipflop6 (
    .d (net7),
    .clk (net8),
    .q (net14)
  );
endmodule
