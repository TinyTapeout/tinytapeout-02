/* Automatically generated from https://wokwi.com/projects/348540666182107731 */

`default_nettype none

module user_module_348540666182107731(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[4];
  wire net6 = io_in[5];
  wire net7 = io_in[6];
  wire net8 = io_in[7];
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15;
  wire net16;
  wire net17 = 1'b0;
  wire net18 = 1'b1;
  wire net19 = 1'b1;
  wire net20;
  wire net21;
  wire net22;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[3] = net12;
  assign io_out[4] = net13;
  assign io_out[5] = net14;
  assign io_out[6] = net15;
  assign io_out[7] = net16;

  and_cell gate1 (

  );
  or_cell gate2 (

  );
  xor_cell gate3 (

  );
  nand_cell gate4 (
    .a (net6),
    .b (net14),
    .out (net13)
  );
  not_cell gate5 (

  );
  buffer_cell gate6 (

  );
  mux_cell mux1 (

  );
  dff_cell flipflop1 (
    .d (net2),
    .clk (net1),
    .q (net9),
    .notq (net10)
  );
  dff_cell flop1 (

  );
  dffsr_cell flipflop2 (
    .d (net2),
    .clk (net3),
    .s (net4),
    .r (net5),
    .q (net11),
    .notq (net12)
  );
  nand_cell gate7 (
    .a (net13),
    .b (net7),
    .out (net14)
  );
  and_cell gate8 (
    .a (net2),
    .b (net8),
    .out (net20)
  );
  or_cell gate9 (
    .a (net2),
    .b (net8),
    .out (net21)
  );
  and_cell gate10 (
    .a (net21),
    .b (net15),
    .out (net22)
  );
  or_cell gate11 (
    .a (net20),
    .b (net22),
    .out (net15)
  );
  not_cell gate12 (
    .in (net1),
    .out (net16)
  );
endmodule
