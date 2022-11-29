/* Automatically generated from https://wokwi.com/projects/348787952842703444 */

`default_nettype none

module user_module_348787952842703444(
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
  wire net14 = 1'b0;
  wire net15 = 1'b1;
  wire net16 = 1'b1;
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
  wire net34 = 1'b0;
  wire net35;
  wire net36;
  wire net37;
  wire net38;
  wire net39;
  wire net40;
  wire net41;
  wire net42;
  wire net43;
  wire net44;
  wire net45;
  wire net46;
  wire net47;
  wire net48;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[3] = net12;
  assign io_out[4] = net13;

  xor_cell gate3 (
    .a (net17),
    .b (net18),
    .out (net19)
  );
  nand_cell gate4 (
    .a (net1),
    .b (net6),
    .out (net17)
  );
  nand_cell gate1 (
    .a (net1),
    .b (net5),
    .out (net20)
  );
  nand_cell gate7 (
    .a (net2),
    .b (net5),
    .out (net18)
  );
  nand_cell gate8 (
    .a (net2),
    .b (net6),
    .out (net21)
  );
  nand_cell gate9 (
    .a (net17),
    .b (net18),
    .out (net22)
  );
  nand_cell gate10 (
    .a (net22),
    .b (net21),
    .out (net23)
  );
  xor_cell gate11 (
    .a (net22),
    .b (net21),
    .out (net24)
  );
  xor_cell gate2 (
    .a (net25),
    .b (net26),
    .out (net27)
  );
  nand_cell gate5 (
    .a (net3),
    .b (net8),
    .out (net25)
  );
  nand_cell gate6 (
    .a (net3),
    .b (net7),
    .out (net28)
  );
  nand_cell gate12 (
    .a (net4),
    .b (net7),
    .out (net26)
  );
  nand_cell gate13 (
    .a (net4),
    .b (net8),
    .out (net29)
  );
  nand_cell gate14 (
    .a (net25),
    .b (net26),
    .out (net30)
  );
  nand_cell gate15 (
    .a (net30),
    .b (net29),
    .out (net31)
  );
  xor_cell gate16 (
    .a (net30),
    .b (net29),
    .out (net32)
  );
  xor_cell xor1 (
    .a (net20),
    .b (net28),
    .out (net33)
  );
  xor_cell xor2 (
    .a (net33),
    .b (net34),
    .out (net9)
  );
  nand_cell gate17 (
    .a (net34),
    .b (net33),
    .out (net35)
  );
  nand_cell gate18 (
    .a (net28),
    .b (net20),
    .out (net36)
  );
  or_cell or1 (
    .a (net35),
    .b (net36),
    .out (net37)
  );
  xor_cell xor3 (
    .a (net19),
    .b (net27),
    .out (net38)
  );
  xor_cell xor4 (
    .a (net38),
    .b (net37),
    .out (net10)
  );
  nand_cell gate19 (
    .a (net37),
    .b (net38),
    .out (net39)
  );
  nand_cell gate20 (
    .a (net27),
    .b (net19),
    .out (net40)
  );
  or_cell or2 (
    .a (net39),
    .b (net40),
    .out (net41)
  );
  xor_cell xor5 (
    .a (net24),
    .b (net32),
    .out (net42)
  );
  xor_cell xor6 (
    .a (net42),
    .b (net41),
    .out (net11)
  );
  nand_cell gate21 (
    .a (net41),
    .b (net42),
    .out (net43)
  );
  nand_cell gate22 (
    .a (net32),
    .b (net24),
    .out (net44)
  );
  or_cell or3 (
    .a (net43),
    .b (net44),
    .out (net45)
  );
  xor_cell xor7 (
    .a (net23),
    .b (net31),
    .out (net46)
  );
  xor_cell xor8 (
    .a (net46),
    .b (net45),
    .out (net12)
  );
  nand_cell gate23 (
    .a (net45),
    .b (net46),
    .out (net47)
  );
  nand_cell gate24 (
    .a (net31),
    .b (net23),
    .out (net48)
  );
  or_cell or4 (
    .a (net47),
    .b (net48),
    .out (net13)
  );
endmodule
