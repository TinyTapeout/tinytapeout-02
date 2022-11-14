/* Automatically generated from https://wokwi.com/projects/348242239268323922 */

`default_nettype none

module user_module_348242239268323922(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[7];
  wire net3;
  wire net4;
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11 = 1'b0;
  wire net12 = 1'b1;
  wire net13 = 1'b1;
  wire net14 = 1'b0;
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
  wire net26;
  wire net27;
  wire net28;
  wire net29;
  wire net30;
  wire net31;
  wire net32;
  wire net33;
  wire net34;
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
  wire net48 = 1'b0;
  wire net49 = 1'b0;
  wire net50 = 1'b0;
  wire net51 = 1'b0;
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
  wire net62;
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
  wire net79 = 1'b0;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84;
  wire net85;
  wire net86 = 1'b0;
  wire net87 = 1'b0;
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
  wire net106;
  wire net107;
  wire net108;
  wire net109;
  wire net110;
  wire net111;
  wire net112;
  wire net113;
  wire net114;
  wire net115;
  wire net116;
  wire net117;
  wire net118;
  wire net119;
  wire net120;
  wire net121;
  wire net122;

  assign io_out[0] = net3;
  assign io_out[1] = net4;
  assign io_out[2] = net5;
  assign io_out[3] = net6;
  assign io_out[4] = net7;
  assign io_out[5] = net8;
  assign io_out[6] = net9;
  assign io_out[7] = net10;

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
  dff_cell flipflop (

  );
  mux_cell mux1 (

  );
  dff_cell flipflop1 (
    .d (net15),
    .clk (net1),
    .q (net16),
    .notq (net15)
  );
  dff_cell flipflop2 (
    .d (net17),
    .clk (net16),
    .q (net18),
    .notq (net17)
  );
  dff_cell flipflop3 (
    .d (net19),
    .clk (net18),
    .q (net20),
    .notq (net19)
  );
  dff_cell flipflop4 (
    .d (net21),
    .clk (net20),
    .q (net22),
    .notq (net21)
  );
  dff_cell flipflop5 (
    .d (net23),
    .clk (net22),
    .q (net24),
    .notq (net23)
  );
  dff_cell flipflop6 (
    .d (net25),
    .clk (net24),
    .q (net26),
    .notq (net25)
  );
  dff_cell flipflop7 (
    .d (net27),
    .clk (net26),
    .q (net28),
    .notq (net27)
  );
  dff_cell flipflop8 (
    .d (net29),
    .clk (net28),
    .q (net30),
    .notq (net29)
  );
  dff_cell flipflop9 (
    .d (net31),
    .clk (net30),
    .q (net32),
    .notq (net31)
  );
  dff_cell flipflop10 (
    .d (net33),
    .clk (net32),
    .q (net34),
    .notq (net33)
  );
  dff_cell flipflop11 (
    .d (net35),
    .clk (net34),
    .q (net36),
    .notq (net35)
  );
  dff_cell flipflop12 (
    .d (net37),
    .clk (net36),
    .q (net38),
    .notq (net37)
  );
  dff_cell flipflop13 (
    .d (net39),
    .clk (net38),
    .q (net40),
    .notq (net39)
  );
  dff_cell flipflop14 (
    .d (net41),
    .clk (net40),
    .q (net42),
    .notq (net41)
  );
  dff_cell flipflop15 (
    .d (net43),
    .clk (net42),
    .q (net44),
    .notq (net43)
  );
  dff_cell flipflop16 (
    .d (net45),
    .clk (net44),
    .q (net46),
    .notq (net45)
  );
  mux_cell mux2 (
    .a (net24),
    .b (net26),
    .sel (net42),
    .out (net47)
  );
  mux_cell mux3 (
    .a (net24),
    .b (net22),
    .sel (net42),
    .out (net52)
  );
  mux_cell mux4 (
    .a (net52),
    .b (net47),
    .sel (net53),
    .out (net10)
  );
  not_cell gate7 (
    .in (net40),
    .out (net54)
  );
  not_cell gate8 (
    .in (net38),
    .out (net55)
  );
  dff_cell flipflop17 (
    .d (net56),
    .clk (net46),
    .q (net53),
    .notq (net56)
  );
  and_cell gate9 (
    .a (net54),
    .b (net55),
    .out (net57)
  );
  and_cell gate10 (
    .a (net54),
    .b (net38),
    .out (net58)
  );
  and_cell gate11 (
    .a (net40),
    .b (net55),
    .out (net59)
  );
  and_cell gate12 (
    .a (net40),
    .b (net38),
    .out (net60)
  );
  not_cell gate20 (
    .in (net1),
    .out (net61)
  );
  dff_cell flipflop18 (
    .d (net62),
    .clk (net61),
    .q (net3)
  );
  dff_cell flipflop19 (
    .d (net63),
    .clk (net61),
    .q (net4)
  );
  dff_cell flipflop20 (
    .d (net64),
    .clk (net61),
    .q (net5)
  );
  dff_cell flipflop21 (
    .d (net65),
    .clk (net61),
    .q (net6)
  );
  dff_cell flipflop22 (
    .d (net66),
    .clk (net61),
    .q (net7)
  );
  dff_cell flipflop23 (
    .d (net67),
    .clk (net61),
    .q (net8)
  );
  dff_cell flipflop24 (
    .d (net68),
    .clk (net61),
    .q (net9)
  );
  mux_cell mux7 (
    .a (net60),
    .b (net69),
    .sel (net2),
    .out (net62)
  );
  mux_cell mux8 (
    .a (net70),
    .b (net71),
    .sel (net2),
    .out (net63)
  );
  mux_cell mux9 (
    .a (net70),
    .b (net72),
    .sel (net2),
    .out (net64)
  );
  mux_cell mux10 (
    .a (net73),
    .b (net74),
    .sel (net2),
    .out (net65)
  );
  mux_cell mux11 (
    .a (net75),
    .b (net76),
    .sel (net2),
    .out (net66)
  );
  mux_cell mux12 (
    .a (net75),
    .b (net77),
    .sel (net2),
    .out (net67)
  );
  mux_cell mux13 (
    .a (net78),
    .b (net79),
    .sel (net2),
    .out (net68)
  );
  dff_cell flipflop26 (
    .d (net80),
    .clk (net53),
    .q (net81),
    .notq (net80)
  );
  dff_cell flipflop27 (
    .d (net82),
    .clk (net81),
    .q (net83),
    .notq (net82)
  );
  buffer_cell gate13 (
    .in (net81),
    .out (net84)
  );
  buffer_cell gate14 (
    .in (net83),
    .out (net85)
  );
  mux_cell mux15 (
    .a (net59),
    .b (net57),
    .sel (net84),
    .out (net70)
  );
  mux_cell mux5 (
    .a (net57),
    .b (net59),
    .sel (net84),
    .out (net75)
  );
  mux_cell mux6 (
    .a (net60),
    .b (net58),
    .sel (net85),
    .out (net73)
  );
  mux_cell mux14 (
    .a (net58),
    .b (net88),
    .sel (net85),
    .out (net78)
  );
  or_cell gate15 (
    .a (net60),
    .b (net58),
    .out (net88)
  );
  dff_cell flipflop25 (
    .d (net89),
    .clk (net1),
    .q (net90),
    .notq (net91)
  );
  dff_cell flipflop30 (
    .d (net36),
    .clk (net1),
    .notq (net92)
  );
  and_cell gate16 (
    .a (net36),
    .b (net92),
    .out (net93)
  );
  xor_cell gate17 (
    .a (net90),
    .b (net93),
    .out (net89)
  );
  and_cell gate18 (
    .a (net90),
    .b (net93),
    .out (net94)
  );
  dff_cell flipflop28 (
    .d (net95),
    .clk (net1),
    .q (net96),
    .notq (net97)
  );
  xor_cell gate19 (
    .a (net96),
    .b (net94),
    .out (net98)
  );
  and_cell gate21 (
    .a (net96),
    .b (net94),
    .out (net99)
  );
  dff_cell flipflop29 (
    .d (net100),
    .clk (net1),
    .q (net101),
    .notq (net102)
  );
  xor_cell gate22 (
    .a (net101),
    .b (net99),
    .out (net103)
  );
  and_cell gate24 (

  );
  and_cell gate23 (
    .a (net90),
    .b (net101),
    .out (net104)
  );
  nand_cell gate25 (
    .a (net93),
    .b (net104),
    .out (net105)
  );
  and_cell gate26 (
    .a (net98),
    .b (net105),
    .out (net95)
  );
  and_cell gate27 (
    .a (net103),
    .b (net105),
    .out (net100)
  );
  and_cell gate1 (
    .a (net91),
    .b (net97),
    .out (net106)
  );
  and_cell gate29 (
    .a (net90),
    .b (net97),
    .out (net107)
  );
  and_cell gate31 (
    .a (net91),
    .b (net96),
    .out (net108)
  );
  and_cell gate33 (
    .a (net90),
    .b (net96),
    .out (net109)
  );
  and_cell gate28 (
    .a (net106),
    .b (net102),
    .out (net110)
  );
  and_cell gate30 (
    .a (net102),
    .b (net107),
    .out (net111)
  );
  and_cell gate32 (
    .a (net107),
    .b (net101),
    .out (net112)
  );
  and_cell gate34 (
    .a (net106),
    .b (net101),
    .out (net113)
  );
  or_cell gate35 (
    .a (net110),
    .b (net109),
    .out (net114)
  );
  or_cell gate36 (
    .a (net111),
    .b (net113),
    .out (net115)
  );
  or_cell gate37 (
    .a (net108),
    .b (net112),
    .out (net116)
  );
  mux_cell mux16 (
    .a (net110),
    .b (net114),
    .sel (net85),
    .out (net69)
  );
  mux_cell mux17 (
    .a (net111),
    .b (net112),
    .sel (net84),
    .out (net117)
  );
  mux_cell mux18 (
    .a (net115),
    .b (net116),
    .sel (net84),
    .out (net118)
  );
  mux_cell mux19 (
    .a (net117),
    .b (net118),
    .sel (net85),
    .out (net71)
  );
  mux_cell mux20 (
    .a (net108),
    .b (net113),
    .sel (net84),
    .out (net119)
  );
  mux_cell mux21 (
    .a (net116),
    .b (net115),
    .sel (net84),
    .out (net120)
  );
  mux_cell mux22 (
    .a (net119),
    .b (net120),
    .sel (net85),
    .out (net72)
  );
  mux_cell mux23 (
    .a (net109),
    .b (net114),
    .sel (net85),
    .out (net74)
  );
  mux_cell mux24 (
    .a (net113),
    .b (net108),
    .sel (net84),
    .out (net121)
  );
  mux_cell mux25 (
    .a (net121),
    .b (net118),
    .sel (net85),
    .out (net76)
  );
  mux_cell mux26 (
    .a (net112),
    .b (net111),
    .sel (net84),
    .out (net122)
  );
  mux_cell mux27 (
    .a (net122),
    .b (net120),
    .sel (net85),
    .out (net77)
  );
endmodule
