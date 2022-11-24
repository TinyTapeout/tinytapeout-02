/* Automatically generated from https://wokwi.com/projects/349047610915422802 */

`default_nettype none

module user_module_349047610915422802(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[6];
  wire net6 = io_in[7];
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13 = 1'b0;
  wire net14 = 1'b1;
  wire net15 = 1'b1;
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
  wire net26;
  wire net27;
  wire net28;
  wire net29;
  wire net30;
  wire net31;
  wire net32;
  wire net33;
  wire net34;

  assign io_out[0] = net7;
  assign io_out[1] = net8;
  assign io_out[2] = net9;
  assign io_out[3] = net10;
  assign io_out[4] = net11;
  assign io_out[7] = net12;

  dff_cell flipflop2 (
    .d (net5),
    .clk (net6),
    .q (net16),
    .notq (net17)
  );
  dff_cell flipflop3 (
    .d (net17),
    .clk (net6),
    .q (net18),
    .notq (net19)
  );
  dff_cell flipflop4 (
    .d (net19),
    .clk (net6),
    .q (net20),
    .notq (net21)
  );
  dff_cell flipflop5 (
    .d (net21),
    .clk (net6),
    .q (net22),
    .notq (net12)
  );
  xor_cell gate7 (
    .a (net1),
    .b (net16),
    .out (net7)
  );
  xor_cell gate8 (
    .a (net2),
    .b (net18),
    .out (net23)
  );
  xor_cell gate9 (
    .a (net3),
    .b (net20),
    .out (net24)
  );
  xor_cell gate10 (
    .a (net4),
    .b (net22),
    .out (net25)
  );
  and_cell gate11 (
    .a (net23),
    .b (net26),
    .out (net27)
  );
  and_cell gate12 (
    .a (net2),
    .b (net18),
    .out (net28)
  );
  and_cell gate13 (
    .a (net3),
    .b (net20),
    .out (net29)
  );
  and_cell gate14 (
    .a (net4),
    .b (net22),
    .out (net30)
  );
  and_cell gate16 (
    .a (net1),
    .b (net16),
    .out (net26)
  );
  xor_cell gate17 (
    .a (net23),
    .b (net26),
    .out (net8)
  );
  and_cell gate18 (
    .a (net24),
    .b (net31),
    .out (net32)
  );
  xor_cell gate19 (
    .a (net25),
    .b (net33),
    .out (net10)
  );
  and_cell gate20 (
    .a (net25),
    .b (net33),
    .out (net34)
  );
  or_cell gate21 (
    .a (net34),
    .b (net30),
    .out (net11)
  );
  or_cell gate22 (
    .a (net32),
    .b (net29),
    .out (net33)
  );
  or_cell gate25 (
    .a (net27),
    .b (net28),
    .out (net31)
  );
  xor_cell gate26 (
    .a (net24),
    .b (net31),
    .out (net9)
  );
endmodule
