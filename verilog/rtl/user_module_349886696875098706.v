/* Automatically generated from https://wokwi.com/projects/349886696875098706 */

`default_nettype none

module user_module_349886696875098706(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2;
  wire net3;
  wire net4;
  wire net5;
  wire net6 = 1'b1;
  wire net7;
  wire net8 = 1'b0;
  wire net9 = 1'b0;
  wire net10 = 1'b1;
  wire net11 = 1'b1;
  wire net12;
  wire net13;
  wire net14;
  wire net15 = 1'b0;
  wire net16 = 1'b0;

  assign io_out[0] = net2;
  assign io_out[1] = net3;
  assign io_out[2] = net3;
  assign io_out[3] = net4;
  assign io_out[4] = net5;
  assign io_out[5] = net6;
  assign io_out[6] = net7;
  assign io_out[7] = net8;

  and_cell gate1 (

  );
  or_cell gate2 (

  );
  xor_cell gate3 (

  );
  nand_cell gate4 (

  );
  not_cell gate5 (

  );
  buffer_cell gate6 (

  );
  mux_cell mux1 (

  );
  dff_cell flipflop1 (

  );
  dff_cell flipflop2 (
    .d (net12),
    .clk (net1),
    .q (net3),
    .notq (net13)
  );
  dff_cell flipflop3 (
    .d (net13),
    .clk (net1),
    .q (net12),
    .notq (net14)
  );
  nand_cell gate7 (
    .a (net13),
    .b (net12),
    .out (net2)
  );
  nand_cell gate8 (
    .a (net3),
    .b (net12),
    .out (net4)
  );
  nand_cell gate9 (
    .a (net3),
    .b (net14),
    .out (net5)
  );
  nand_cell gate10 (
    .a (net13),
    .b (net14),
    .out (net7)
  );
endmodule
