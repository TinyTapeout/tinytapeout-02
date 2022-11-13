/* Automatically generated from https://wokwi.com/projects/348195845106041428 */

`default_nettype none

module user_module_348195845106041428(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4;
  wire net5;
  wire net6 = 1'b1;
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11 = 1'b0;
  wire net12 = 1'b0;
  wire net13;
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
  wire net25;

  assign io_out[0] = net4;
  assign io_out[1] = net5;

  or_cell gate2 (

  );
  nand_cell gate4 (
    .a (net7),
    .b (net1),
    .out (net8)
  );
  not_cell gate5 (
    .in (net7),
    .out (net4)
  );
  buffer_cell gate6 (
    .in (net9),
    .out (net10)
  );
  mux_cell mux1 (

  );
  dff_cell flipflop1 (

  );
  nand_cell nand1 (
    .a (net8),
    .b (net13),
    .out (net14)
  );
  nand_cell nand2 (
    .a (net14),
    .b (net10),
    .out (net13)
  );
  nand_cell nand3 (
    .a (net10),
    .b (net15),
    .out (net16)
  );
  nand_cell nand4 (
    .a (net16),
    .b (net17),
    .out (net15)
  );
  nand_cell nand5 (
    .a (net2),
    .b (net5),
    .out (net17)
  );
  and_cell and1 (
    .a (net8),
    .b (net14),
    .out (net18)
  );
  nand_cell nand6 (
    .a (net18),
    .b (net10),
    .out (net7)
  );
  nand_cell nand7 (
    .a (net14),
    .b (net8),
    .out (net19)
  );
  nand_cell nand8 (
    .a (net17),
    .b (net15),
    .out (net20)
  );
  nand_cell nand9 (
    .a (net19),
    .b (net19),
    .out (net21)
  );
  nand_cell nand10 (
    .a (net20),
    .b (net20),
    .out (net22)
  );
  nand_cell nand11 (
    .a (net21),
    .b (net22),
    .out (net23)
  );
  nand_cell nand12 (
    .a (net23),
    .b (net3),
    .out (net24)
  );
  not_cell not1 (
    .in (net24),
    .out (net9)
  );
  and_cell and2 (
    .a (net10),
    .b (net15),
    .out (net25)
  );
  nand_cell nand13 (
    .a (net25),
    .b (net17),
    .out (net5)
  );
endmodule
