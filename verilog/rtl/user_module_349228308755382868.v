/* Automatically generated from https://wokwi.com/projects/349228308755382868 */

`default_nettype none

module user_module_349228308755382868(
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
  wire net23;
  wire net24;
  wire net25;
  wire net26;
  wire net27;
  wire net28 = 1'b0;
  wire net29;
  wire net30;
  wire net31;
  wire net32 = 1'b1;
  wire net33 = 1'b0;
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
  wire net123;
  wire net124;
  wire net125;
  wire net126;
  wire net127;
  wire net128;
  wire net129;
  wire net130;
  wire net131;
  wire net132;
  wire net133;
  wire net134;
  wire net135 = 1'b0;
  wire net136 = 1'b0;
  wire net137 = 1'b0;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[3] = net12;
  assign io_out[4] = net13;
  assign io_out[5] = net14;
  assign io_out[6] = net15;
  assign io_out[7] = net16;

  and_cell gate1 (
    .a (net20),
    .b (net21),
    .out (net22)
  );
  xor_cell gate3 (
    .a (net23),
    .b (net24),
    .out (net25)
  );
  not_cell gate5 (
    .in (net1),
    .out (net26)
  );
  buffer_cell gate6 (
    .in (net1),
    .out (net27)
  );
  mux_cell mux1 (
    .a (net28),
    .b (net29),
    .sel (net21),
    .out (net30)
  );
  dff_cell flipflop1 (
    .d (net2),
    .clk (net27),
    .notq (net31)
  );
  dff_cell flop1 (
    .d (net34),
    .clk (net27),
    .q (net35)
  );
  dff_cell flop2 (
    .d (net36),
    .clk (net27),
    .q (net37)
  );
  dff_cell flop3 (
    .d (net38),
    .clk (net27),
    .q (net23),
    .notq (net39)
  );
  dff_cell flop4 (
    .d (net40),
    .clk (net27),
    .q (net41),
    .notq (net42)
  );
  dff_cell flop5 (
    .d (net43),
    .clk (net27),
    .q (net44),
    .notq (net45)
  );
  dff_cell flop6 (
    .d (net22),
    .clk (net27),
    .q (net24),
    .notq (net20)
  );
  and_cell gate7 (
    .a (net25),
    .b (net21),
    .out (net38)
  );
  xor_cell gate8 (
    .a (net41),
    .b (net46),
    .out (net47)
  );
  and_cell gate9 (
    .a (net47),
    .b (net21),
    .out (net40)
  );
  and_cell gate10 (
    .a (net24),
    .b (net23),
    .out (net46)
  );
  xor_cell gate11 (
    .a (net44),
    .b (net48),
    .out (net49)
  );
  and_cell gate12 (
    .a (net49),
    .b (net21),
    .out (net43)
  );
  and_cell gate13 (
    .a (net46),
    .b (net41),
    .out (net48)
  );
  xor_cell gate14 (
    .a (net37),
    .b (net50),
    .out (net51)
  );
  and_cell gate15 (
    .a (net51),
    .b (net21),
    .out (net36)
  );
  and_cell gate16 (
    .a (net48),
    .b (net44),
    .out (net50)
  );
  xor_cell gate17 (
    .a (net35),
    .b (net52),
    .out (net53)
  );
  and_cell gate18 (
    .a (net53),
    .b (net21),
    .out (net34)
  );
  and_cell gate19 (
    .a (net50),
    .b (net37),
    .out (net52)
  );
  and_cell gate20 (
    .a (net20),
    .b (net39),
    .out (net54)
  );
  and_cell gate21 (
    .a (net54),
    .b (net42),
    .out (net55)
  );
  and_cell gate22 (
    .a (net45),
    .b (net56),
    .out (net57)
  );
  and_cell gate23 (
    .a (net37),
    .b (net35),
    .out (net56)
  );
  and_cell and1 (
    .a (net31),
    .b (net58),
    .out (net21)
  );
  nand_cell nand1 (
    .a (net55),
    .b (net57),
    .out (net58)
  );
  dff_cell flop7 (
    .d (net59),
    .clk (net26),
    .q (net10)
  );
  dff_cell flop8 (
    .d (net60),
    .clk (net26),
    .q (net11)
  );
  dff_cell flop10 (
    .d (net21),
    .clk (net26),
    .notq (net9)
  );
  dff_cell flop15 (
    .d (net61),
    .clk (net27),
    .q (net62)
  );
  dff_cell flop16 (
    .d (net63),
    .clk (net27),
    .q (net64)
  );
  dff_cell flop17 (
    .d (net65),
    .clk (net27),
    .q (net66)
  );
  dff_cell flop18 (
    .d (net30),
    .clk (net27),
    .q (net67)
  );
  mux_cell mux2 (
    .a (net28),
    .b (net67),
    .sel (net21),
    .out (net61)
  );
  mux_cell mux3 (
    .a (net28),
    .b (net62),
    .sel (net21),
    .out (net63)
  );
  mux_cell mux4 (
    .a (net28),
    .b (net64),
    .sel (net21),
    .out (net65)
  );
  mux_cell mux5 (
    .a (net28),
    .b (net66),
    .sel (net21),
    .out (net68)
  );
  dff_cell flop19 (
    .d (net69),
    .clk (net27),
    .q (net70)
  );
  dff_cell flop20 (
    .d (net71),
    .clk (net27),
    .q (net72)
  );
  dff_cell flop21 (
    .d (net73),
    .clk (net27),
    .q (net74)
  );
  dff_cell flop22 (
    .d (net68),
    .clk (net27),
    .q (net75)
  );
  mux_cell mux6 (
    .a (net28),
    .b (net75),
    .sel (net21),
    .out (net69)
  );
  mux_cell mux7 (
    .a (net28),
    .b (net70),
    .sel (net21),
    .out (net71)
  );
  mux_cell mux8 (
    .a (net28),
    .b (net72),
    .sel (net21),
    .out (net73)
  );
  mux_cell mux9 (
    .a (net32),
    .b (net74),
    .sel (net21),
    .out (net76)
  );
  dff_cell flop23 (
    .d (net77),
    .clk (net27),
    .q (net78)
  );
  dff_cell flop24 (
    .d (net79),
    .clk (net27),
    .q (net80)
  );
  dff_cell flop25 (
    .d (net81),
    .clk (net27),
    .q (net82)
  );
  dff_cell flop26 (
    .d (net76),
    .clk (net27),
    .q (net83)
  );
  mux_cell mux10 (
    .a (net32),
    .b (net83),
    .sel (net21),
    .out (net77)
  );
  mux_cell mux11 (
    .a (net28),
    .b (net78),
    .sel (net21),
    .out (net79)
  );
  mux_cell mux12 (
    .a (net28),
    .b (net80),
    .sel (net21),
    .out (net81)
  );
  mux_cell mux13 (
    .a (net28),
    .b (net82),
    .sel (net21),
    .out (net84)
  );
  dff_cell flop27 (
    .d (net85),
    .clk (net27),
    .q (net86)
  );
  dff_cell flop28 (
    .d (net87),
    .clk (net27),
    .q (net88)
  );
  dff_cell flop29 (
    .d (net89),
    .clk (net27),
    .q (net59)
  );
  dff_cell flop30 (
    .d (net84),
    .clk (net27),
    .q (net90)
  );
  mux_cell mux14 (
    .a (net28),
    .b (net90),
    .sel (net21),
    .out (net85)
  );
  mux_cell mux15 (
    .a (net28),
    .b (net86),
    .sel (net21),
    .out (net87)
  );
  mux_cell mux16 (
    .a (net28),
    .b (net88),
    .sel (net21),
    .out (net89)
  );
  mux_cell mux33 (
    .a (net91),
    .b (net11),
    .sel (net21),
    .out (net60)
  );
  dff_cell flop9 (
    .d (net92),
    .clk (net26),
    .q (net12)
  );
  mux_cell mux34 (
    .a (net93),
    .b (net12),
    .sel (net21),
    .out (net92)
  );
  dff_cell flop11 (
    .d (net94),
    .clk (net26),
    .q (net13)
  );
  mux_cell mux35 (
    .a (net95),
    .b (net13),
    .sel (net21),
    .out (net94)
  );
  dff_cell flop12 (
    .d (net96),
    .clk (net26),
    .q (net14)
  );
  mux_cell mux36 (
    .a (net97),
    .b (net14),
    .sel (net21),
    .out (net96)
  );
  dff_cell flop13 (
    .d (net98),
    .clk (net26),
    .q (net15)
  );
  mux_cell mux37 (
    .a (net99),
    .b (net15),
    .sel (net21),
    .out (net98)
  );
  dff_cell flop14 (
    .d (net100),
    .clk (net26),
    .q (net16)
  );
  mux_cell mux38 (
    .a (net101),
    .b (net16),
    .sel (net21),
    .out (net100)
  );
  and_cell gate2 (
    .a (net3),
    .b (net31),
    .out (net102)
  );
  dff_cell flop31 (
    .d (net102),
    .clk (net27),
    .q (net91)
  );
  and_cell gate24 (
    .a (net103),
    .b (net31),
    .out (net104)
  );
  dff_cell flop32 (
    .d (net104),
    .clk (net27),
    .q (net93)
  );
  and_cell gate25 (
    .a (net105),
    .b (net31),
    .out (net106)
  );
  dff_cell flop33 (
    .d (net106),
    .clk (net27),
    .q (net95)
  );
  and_cell gate26 (
    .a (net107),
    .b (net31),
    .out (net108)
  );
  dff_cell flop34 (
    .d (net108),
    .clk (net27),
    .q (net97)
  );
  and_cell gate27 (
    .a (net109),
    .b (net31),
    .out (net110)
  );
  dff_cell flop35 (
    .d (net110),
    .clk (net27),
    .q (net99)
  );
  and_cell gate28 (
    .a (net111),
    .b (net31),
    .out (net112)
  );
  dff_cell flop36 (
    .d (net112),
    .clk (net27),
    .q (net101)
  );
  and_cell gate29 (
    .a (net113),
    .b (net31),
    .out (net114)
  );
  dff_cell flop37 (
    .d (net114),
    .clk (net27),
    .q (net115)
  );
  and_cell gate30 (
    .a (net115),
    .b (net31),
    .out (net116)
  );
  dff_cell flop38 (
    .d (net116),
    .clk (net27),
    .q (net117)
  );
  and_cell gate31 (
    .a (net117),
    .b (net31),
    .out (net118)
  );
  dff_cell flop39 (
    .d (net118),
    .clk (net27),
    .q (net119)
  );
  and_cell gate32 (
    .a (net119),
    .b (net31),
    .out (net120)
  );
  dff_cell flop40 (
    .d (net120),
    .clk (net27),
    .q (net121)
  );
  and_cell gate33 (
    .a (net121),
    .b (net31),
    .out (net122)
  );
  dff_cell flop41 (
    .d (net122),
    .clk (net27),
    .q (net123)
  );
  and_cell gate34 (
    .a (net123),
    .b (net31),
    .out (net124)
  );
  dff_cell flop42 (
    .d (net124),
    .clk (net27),
    .q (net125)
  );
  and_cell gate35 (
    .a (net125),
    .b (net31),
    .out (net126)
  );
  dff_cell flop43 (
    .d (net126),
    .clk (net27),
    .q (net127)
  );
  and_cell gate36 (
    .a (net127),
    .b (net31),
    .out (net128)
  );
  dff_cell flop44 (
    .d (net128),
    .clk (net27),
    .q (net129)
  );
  and_cell gate37 (
    .a (net129),
    .b (net31),
    .out (net130)
  );
  dff_cell flop45 (
    .d (net130),
    .clk (net27),
    .q (net131)
  );
  and_cell gate38 (
    .a (net131),
    .b (net31),
    .out (net132)
  );
  dff_cell flop46 (
    .d (net132),
    .clk (net27),
    .q (net133)
  );
  and_cell gate39 (
    .a (net133),
    .b (net31),
    .out (net134)
  );
  dff_cell flop47 (
    .d (net134),
    .clk (net27),
    .q (net29)
  );
  mux_cell mux17 (
    .a (net135),
    .b (net91),
    .sel (net21),
    .out (net103)
  );
  mux_cell mux18 (
    .a (net4),
    .b (net93),
    .sel (net21),
    .out (net105)
  );
  mux_cell mux19 (
    .a (net5),
    .b (net95),
    .sel (net21),
    .out (net107)
  );
  mux_cell mux20 (
    .a (net6),
    .b (net97),
    .sel (net21),
    .out (net109)
  );
  mux_cell mux21 (
    .a (net7),
    .b (net99),
    .sel (net21),
    .out (net111)
  );
  mux_cell mux22 (
    .a (net8),
    .b (net101),
    .sel (net21),
    .out (net113)
  );
endmodule
