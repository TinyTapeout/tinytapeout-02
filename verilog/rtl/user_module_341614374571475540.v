/* Automatically generated from https://wokwi.com/projects/341614374571475540 */

`default_nettype none

module user_module_341614374571475540(
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
  wire net11 = 1'b0;
  wire net12 = 1'b1;
  wire net13 = 1'b1;
  wire net14;
  wire net15;
  wire net16;
  wire net17;
  wire net18;
  wire net19;
  wire net20;
  wire net21;
  wire net22;
  wire net23;
  wire net24;

  assign io_out[0] = net9;
  assign io_out[1] = net10;

  and_cell gate1 (

  );
  or_cell gate2 (

  );
  xor_cell gate3 (
    .a (net14),
    .b (net8),
    .out (net10)
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
    .d (net15),
    .clk (net1),
    .q (net16)
  );
  and_cell gate7 (
    .a (net6),
    .b (net7),
    .out (net17)
  );
  and_cell gate8 (
    .a (net4),
    .b (net18),
    .out (net19)
  );
  and_cell gate9 (
    .a (net3),
    .b (net6),
    .out (net20)
  );
  and_cell gate10 (
    .a (net3),
    .b (net4),
    .out (net21)
  );
  not_cell gate11 (
    .in (net7),
    .out (net18)
  );
  xor_cell gate12 (
    .a (net5),
    .b (net19),
    .out (net15)
  );
  xor_cell gate13 (
    .a (net20),
    .b (net5),
    .out (net22)
  );
  dff_cell flipflop2 (
    .d (net22),
    .clk (net1),
    .q (net23)
  );
  xor_cell gate14 (
    .a (net21),
    .b (net23),
    .out (net24)
  );
  xor_cell gate15 (
    .a (net16),
    .b (net17),
    .out (net14)
  );
  xor_cell gate16 (
    .a (net2),
    .b (net24),
    .out (net9)
  );
endmodule
