/* Automatically generated from https://wokwi.com/projects/347787021138264660 */

`default_nettype none

module user_module_347787021138264660(
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
  wire net16 = 1'b0;
  wire net17 = 1'b1;
  wire net18 = 1'b1;
  wire net19 = 1'b0;
  wire net20;
  wire net21;
  wire net22 = 1'b0;
  wire net23;
  wire net24;
  wire net25 = 1'b0;
  wire net26;
  wire net27;
  wire net28 = 1'b0;
  wire net29;
  wire net30;
  wire net31 = 1'b0;
  wire net32;
  wire net33;
  wire net34 = 1'b0;
  wire net35;
  wire net36;
  wire net37 = 1'b0;
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
  wire net49;
  wire net50;
  wire net51;
  wire net52;
  wire net53;
  wire net54;
  wire net55;
  wire net56;
  wire net57;
  wire net58;
  wire net59;
  wire net60;
  wire net61;
  wire net62 = 1'b0;
  wire net63;
  wire net64;
  wire net65;
  wire net66;
  wire net67;
  wire net68;
  wire net69;
  wire net70;
  wire net71;
  wire net72;
  wire net73;
  wire net74;
  wire net75;
  wire net76;
  wire net77;
  wire net78;
  wire net79;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84;
  wire net85;
  wire net86;
  wire net87;
  wire net88;
  wire net89;
  wire net90;
  wire net91;
  wire net92;
  wire net93;
  wire net94;
  wire net95;
  wire net96;
  wire net97;
  wire net98;
  wire net99;
  wire net100;
  wire net101;
  wire net102;
  wire net103;
  wire net104;
  wire net105;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[3] = net12;
  assign io_out[4] = net13;
  assign io_out[5] = net14;
  assign io_out[6] = net15;

  and_cell gate1 (

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

  );
  not_cell gate12 (
    .in (net19),
    .out (net20)
  );
  and_cell gate14 (
    .a (net4),
    .b (net20),
    .out (net21)
  );
  not_cell gate21 (
    .in (net22),
    .out (net23)
  );
  and_cell gate23 (
    .a (net5),
    .b (net23),
    .out (net24)
  );
  not_cell gate30 (
    .in (net25),
    .out (net26)
  );
  and_cell gate32 (
    .a (net3),
    .b (net26),
    .out (net27)
  );
  not_cell gate39 (
    .in (net28),
    .out (net29)
  );
  and_cell gate41 (
    .a (net6),
    .b (net29),
    .out (net30)
  );
  not_cell gate48 (
    .in (net31),
    .out (net32)
  );
  and_cell gate50 (
    .a (net7),
    .b (net32),
    .out (net33)
  );
  not_cell gate57 (
    .in (net34),
    .out (net35)
  );
  and_cell gate59 (
    .a (net2),
    .b (net35),
    .out (net36)
  );
  not_cell gate66 (
    .in (net37),
    .out (net38)
  );
  and_cell gate68 (
    .a (net8),
    .b (net38),
    .out (net39)
  );
  dff_cell flipflop2 (
    .d (net30),
    .clk (net1),
    .q (net40)
  );
  dff_cell flipflop3 (
    .d (net24),
    .clk (net1),
    .q (net41)
  );
  dff_cell flipflop4 (
    .d (net21),
    .clk (net1),
    .q (net42)
  );
  dff_cell flipflop5 (
    .d (net27),
    .clk (net1),
    .q (net43)
  );
  dff_cell flipflop6 (
    .d (net36),
    .clk (net1),
    .q (net44)
  );
  dff_cell flipflop7 (
    .d (net33),
    .clk (net1),
    .q (net45)
  );
  dff_cell flipflop8 (
    .d (net39),
    .clk (net1),
    .q (net46)
  );
  xor_cell gate5 (
    .a (net44),
    .b (net43),
    .out (net47)
  );
  and_cell gate7 (
    .a (net44),
    .b (net43),
    .out (net48)
  );
  xor_cell gate8 (
    .a (net42),
    .b (net41),
    .out (net49)
  );
  and_cell gate9 (
    .a (net42),
    .b (net41),
    .out (net50)
  );
  xor_cell gate10 (
    .a (net40),
    .b (net45),
    .out (net51)
  );
  and_cell gate11 (
    .a (net40),
    .b (net45),
    .out (net52)
  );
  xor_cell gate13 (
    .a (net47),
    .b (net49),
    .out (net53)
  );
  and_cell gate15 (
    .a (net47),
    .b (net49),
    .out (net54)
  );
  xor_cell gate16 (
    .a (net48),
    .b (net50),
    .out (net55)
  );
  xor_cell gate17 (
    .a (net55),
    .b (net54),
    .out (net56)
  );
  and_cell gate18 (
    .a (net54),
    .b (net55),
    .out (net57)
  );
  and_cell gate19 (
    .a (net50),
    .b (net48),
    .out (net58)
  );
  or_cell gate20 (
    .a (net57),
    .b (net58),
    .out (net59)
  );
  xor_cell gate22 (
    .a (net51),
    .b (net46),
    .out (net60)
  );
  and_cell gate24 (
    .a (net51),
    .b (net46),
    .out (net61)
  );
  xor_cell gate25 (
    .a (net52),
    .b (net62),
    .out (net63)
  );
  xor_cell gate26 (
    .a (net63),
    .b (net61),
    .out (net64)
  );
  and_cell gate27 (
    .a (net61),
    .b (net63),
    .out (net65)
  );
  and_cell gate28 (
    .a (net62),
    .b (net52),
    .out (net66)
  );
  or_cell gate29 (
    .a (net65),
    .b (net66),
    .out (net67)
  );
  xor_cell gate36 (
    .a (net53),
    .b (net60),
    .out (net68)
  );
  and_cell gate37 (
    .a (net53),
    .b (net60),
    .out (net69)
  );
  xor_cell gate38 (
    .a (net56),
    .b (net64),
    .out (net70)
  );
  xor_cell gate40 (
    .a (net70),
    .b (net69),
    .out (net71)
  );
  and_cell gate42 (
    .a (net69),
    .b (net70),
    .out (net72)
  );
  and_cell gate43 (
    .a (net64),
    .b (net56),
    .out (net73)
  );
  or_cell gate44 (
    .a (net72),
    .b (net73),
    .out (net74)
  );
  xor_cell gate31 (
    .a (net59),
    .b (net67),
    .out (net75)
  );
  xor_cell gate33 (
    .a (net75),
    .b (net74),
    .out (net76)
  );
  or_cell gate34 (
    .a (net77),
    .b (net71),
    .out (net78)
  );
  or_cell gate35 (
    .a (net78),
    .b (net79),
    .out (net9)
  );
  and_cell gate45 (
    .a (net68),
    .b (net76),
    .out (net79)
  );
  and_cell gate47 (
    .a (net80),
    .b (net81),
    .out (net77)
  );
  not_cell not1 (
    .in (net68),
    .out (net80)
  );
  not_cell not2 (
    .in (net76),
    .out (net81)
  );
  or_cell gate46 (
    .a (net82),
    .b (net83),
    .out (net84)
  );
  or_cell gate49 (
    .a (net84),
    .b (net81),
    .out (net10)
  );
  and_cell gate51 (
    .a (net71),
    .b (net68),
    .out (net82)
  );
  and_cell gate52 (
    .a (net80),
    .b (net85),
    .out (net83)
  );
  not_cell not3 (
    .in (net71),
    .out (net85)
  );
  or_cell gate53 (
    .a (net85),
    .b (net68),
    .out (net86)
  );
  or_cell gate54 (
    .a (net86),
    .b (net76),
    .out (net11)
  );
  or_cell gate55 (
    .a (net87),
    .b (net88),
    .out (net89)
  );
  or_cell gate56 (
    .a (net89),
    .b (net90),
    .out (net12)
  );
  or_cell gate58 (
    .a (net91),
    .b (net92),
    .out (net90)
  );
  and_cell gate60 (
    .a (net81),
    .b (net80),
    .out (net87)
  );
  and_cell gate61 (
    .a (net81),
    .b (net71),
    .out (net88)
  );
  and_cell gate62 (
    .a (net71),
    .b (net80),
    .out (net91)
  );
  and_cell gate63 (
    .a (net85),
    .b (net76),
    .out (net93)
  );
  and_cell gate64 (
    .a (net93),
    .b (net68),
    .out (net92)
  );
  or_cell gate65 (
    .a (net94),
    .b (net95),
    .out (net13)
  );
  and_cell gate67 (
    .a (net96),
    .b (net80),
    .out (net94)
  );
  and_cell gate69 (
    .a (net71),
    .b (net80),
    .out (net95)
  );
  not_cell not4 (
    .in (net76),
    .out (net96)
  );
  or_cell gate70 (
    .a (net97),
    .b (net98),
    .out (net99)
  );
  or_cell gate71 (
    .a (net99),
    .b (net100),
    .out (net14)
  );
  and_cell gate72 (
    .a (net80),
    .b (net101),
    .out (net97)
  );
  not_cell not5 (
    .in (net71),
    .out (net101)
  );
  and_cell gate73 (
    .a (net101),
    .b (net76),
    .out (net98)
  );
  and_cell gate74 (
    .a (net76),
    .b (net80),
    .out (net100)
  );
  or_cell gate75 (
    .a (net102),
    .b (net103),
    .out (net104)
  );
  or_cell gate76 (
    .a (net104),
    .b (net105),
    .out (net15)
  );
  and_cell gate77 (
    .a (net96),
    .b (net71),
    .out (net102)
  );
  and_cell gate78 (
    .a (net71),
    .b (net80),
    .out (net103)
  );
  and_cell gate79 (
    .a (net76),
    .b (net101),
    .out (net105)
  );
endmodule
