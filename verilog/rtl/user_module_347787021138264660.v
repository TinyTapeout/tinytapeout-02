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
  wire net135;
  wire net136;
  wire net137;
  wire net138;
  wire net139;
  wire net140;
  wire net141;
  wire net142;
  wire net143;

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
  dff_cell flipflop2 (
    .d (net30),
    .clk (net37),
    .q (net38)
  );
  dff_cell flipflop3 (
    .d (net24),
    .clk (net39),
    .q (net40)
  );
  dff_cell flipflop4 (
    .d (net21),
    .clk (net41),
    .q (net42)
  );
  dff_cell flipflop5 (
    .d (net27),
    .clk (net43),
    .q (net44)
  );
  dff_cell flipflop6 (
    .d (net36),
    .clk (net45),
    .q (net46)
  );
  dff_cell flipflop7 (
    .d (net33),
    .clk (net47),
    .q (net48)
  );
  xor_cell gate5 (
    .a (net46),
    .b (net44),
    .out (net49)
  );
  and_cell gate7 (
    .a (net46),
    .b (net44),
    .out (net50)
  );
  xor_cell gate8 (
    .a (net42),
    .b (net40),
    .out (net51)
  );
  and_cell gate9 (
    .a (net42),
    .b (net40),
    .out (net52)
  );
  xor_cell gate10 (
    .a (net38),
    .b (net48),
    .out (net53)
  );
  and_cell gate11 (
    .a (net38),
    .b (net48),
    .out (net54)
  );
  xor_cell gate13 (
    .a (net49),
    .b (net51),
    .out (net55)
  );
  and_cell gate15 (
    .a (net49),
    .b (net51),
    .out (net56)
  );
  xor_cell gate16 (
    .a (net50),
    .b (net52),
    .out (net57)
  );
  xor_cell gate17 (
    .a (net57),
    .b (net56),
    .out (net58)
  );
  and_cell gate18 (
    .a (net56),
    .b (net57),
    .out (net59)
  );
  and_cell gate19 (
    .a (net52),
    .b (net50),
    .out (net60)
  );
  or_cell gate20 (
    .a (net59),
    .b (net60),
    .out (net61)
  );
  xor_cell gate22 (
    .a (net53),
    .b (net62),
    .out (net63)
  );
  and_cell gate24 (
    .a (net53),
    .b (net62),
    .out (net64)
  );
  xor_cell gate25 (
    .a (net54),
    .b (net62),
    .out (net65)
  );
  xor_cell gate26 (
    .a (net65),
    .b (net64),
    .out (net66)
  );
  and_cell gate27 (
    .a (net64),
    .b (net65),
    .out (net67)
  );
  and_cell gate28 (
    .a (net62),
    .b (net54),
    .out (net68)
  );
  or_cell gate29 (
    .a (net67),
    .b (net68),
    .out (net69)
  );
  xor_cell gate36 (
    .a (net55),
    .b (net63),
    .out (net70)
  );
  and_cell gate37 (
    .a (net55),
    .b (net63),
    .out (net71)
  );
  xor_cell gate38 (
    .a (net58),
    .b (net66),
    .out (net72)
  );
  xor_cell gate40 (
    .a (net72),
    .b (net71),
    .out (net73)
  );
  and_cell gate42 (
    .a (net71),
    .b (net72),
    .out (net74)
  );
  and_cell gate43 (
    .a (net66),
    .b (net58),
    .out (net75)
  );
  or_cell gate44 (
    .a (net74),
    .b (net75),
    .out (net76)
  );
  xor_cell gate31 (
    .a (net61),
    .b (net69),
    .out (net77)
  );
  xor_cell gate33 (
    .a (net77),
    .b (net76),
    .out (net78)
  );
  or_cell gate34 (
    .a (net79),
    .b (net73),
    .out (net80)
  );
  or_cell gate35 (
    .a (net80),
    .b (net81),
    .out (net9)
  );
  and_cell gate45 (
    .a (net70),
    .b (net78),
    .out (net81)
  );
  and_cell gate47 (
    .a (net82),
    .b (net83),
    .out (net79)
  );
  not_cell not1 (
    .in (net70),
    .out (net82)
  );
  not_cell not2 (
    .in (net78),
    .out (net83)
  );
  or_cell gate46 (
    .a (net84),
    .b (net85),
    .out (net86)
  );
  or_cell gate49 (
    .a (net86),
    .b (net83),
    .out (net10)
  );
  and_cell gate51 (
    .a (net73),
    .b (net70),
    .out (net84)
  );
  and_cell gate52 (
    .a (net82),
    .b (net87),
    .out (net85)
  );
  not_cell not3 (
    .in (net73),
    .out (net87)
  );
  or_cell gate53 (
    .a (net87),
    .b (net70),
    .out (net88)
  );
  or_cell gate54 (
    .a (net88),
    .b (net78),
    .out (net11)
  );
  or_cell gate55 (
    .a (net89),
    .b (net90),
    .out (net91)
  );
  or_cell gate56 (
    .a (net91),
    .b (net92),
    .out (net12)
  );
  or_cell gate58 (
    .a (net93),
    .b (net94),
    .out (net92)
  );
  and_cell gate60 (
    .a (net83),
    .b (net82),
    .out (net89)
  );
  and_cell gate61 (
    .a (net83),
    .b (net73),
    .out (net90)
  );
  and_cell gate62 (
    .a (net73),
    .b (net82),
    .out (net93)
  );
  and_cell gate63 (
    .a (net87),
    .b (net78),
    .out (net95)
  );
  and_cell gate64 (
    .a (net95),
    .b (net70),
    .out (net94)
  );
  or_cell gate65 (
    .a (net96),
    .b (net97),
    .out (net13)
  );
  and_cell gate67 (
    .a (net98),
    .b (net82),
    .out (net96)
  );
  and_cell gate69 (
    .a (net73),
    .b (net82),
    .out (net97)
  );
  not_cell not4 (
    .in (net78),
    .out (net98)
  );
  or_cell gate70 (
    .a (net99),
    .b (net100),
    .out (net101)
  );
  or_cell gate71 (
    .a (net101),
    .b (net102),
    .out (net14)
  );
  and_cell gate72 (
    .a (net82),
    .b (net103),
    .out (net99)
  );
  not_cell not5 (
    .in (net73),
    .out (net103)
  );
  and_cell gate73 (
    .a (net103),
    .b (net78),
    .out (net100)
  );
  and_cell gate74 (
    .a (net78),
    .b (net82),
    .out (net102)
  );
  or_cell gate75 (
    .a (net104),
    .b (net105),
    .out (net106)
  );
  or_cell gate76 (
    .a (net106),
    .b (net107),
    .out (net15)
  );
  and_cell gate77 (
    .a (net98),
    .b (net73),
    .out (net104)
  );
  and_cell gate78 (
    .a (net73),
    .b (net82),
    .out (net105)
  );
  and_cell gate79 (
    .a (net78),
    .b (net103),
    .out (net107)
  );
  xor_cell gate80 (
    .a (net108),
    .b (net8),
    .out (net109)
  );
  dff_cell flipflop9 (
    .d (net109),
    .clk (net1),
    .q (net108)
  );
  xor_cell gate82 (
    .a (net110),
    .b (net111),
    .out (net112)
  );
  dff_cell flipflop10 (
    .d (net112),
    .clk (net1),
    .q (net111)
  );
  xor_cell gate84 (
    .a (net113),
    .b (net114),
    .out (net115)
  );
  dff_cell flipflop11 (
    .d (net115),
    .clk (net1),
    .q (net114)
  );
  and_cell gate88 (
    .a (net108),
    .b (net8),
    .out (net110)
  );
  and_cell gate83 (
    .a (net111),
    .b (net110),
    .out (net113)
  );
  and_cell gate89 (
    .a (net114),
    .b (net113),
    .out (net116)
  );
  xor_cell gate85 (
    .a (net116),
    .b (net117),
    .out (net118)
  );
  dff_cell flipflop12 (
    .d (net118),
    .clk (net1),
    .q (net117)
  );
  xor_cell gate86 (
    .a (net119),
    .b (net120),
    .out (net121)
  );
  dff_cell flipflop13 (
    .d (net121),
    .clk (net1),
    .q (net120)
  );
  and_cell gate87 (
    .a (net117),
    .b (net116),
    .out (net119)
  );
  and_cell gate90 (
    .a (net120),
    .b (net119),
    .out (net122)
  );
  xor_cell gate81 (
    .a (net122),
    .b (net123),
    .out (net124)
  );
  dff_cell flipflop14 (
    .d (net124),
    .clk (net1),
    .q (net123)
  );
  and_cell gate91 (
    .a (net123),
    .b (net122),
    .out (net125)
  );
  xor_cell gate92 (
    .a (net125),
    .b (net126),
    .out (net127)
  );
  dff_cell flipflop15 (
    .d (net127),
    .clk (net1),
    .q (net126)
  );
  and_cell gate94 (
    .a (net126),
    .b (net125),
    .out (net128)
  );
  xor_cell gate95 (
    .a (net128),
    .b (net129),
    .out (net130)
  );
  dff_cell flipflop16 (
    .d (net130),
    .clk (net1),
    .q (net129)
  );
  xor_cell gate96 (
    .a (net131),
    .b (net132),
    .out (net133)
  );
  dff_cell flipflop17 (
    .d (net133),
    .clk (net1),
    .q (net132)
  );
  and_cell gate97 (
    .a (net129),
    .b (net128),
    .out (net131)
  );
  and_cell gate98 (
    .a (net132),
    .b (net131),
    .out (net134)
  );
  xor_cell gate99 (
    .a (net134),
    .b (net135),
    .out (net136)
  );
  dff_cell flipflop18 (
    .d (net136),
    .clk (net1),
    .q (net135)
  );
  and_cell gate100 (
    .a (net135),
    .b (net134),
    .out (net137)
  );
  xor_cell gate101 (
    .a (net137),
    .b (net138),
    .out (net139)
  );
  dff_cell flipflop19 (
    .d (net139),
    .clk (net1),
    .q (net138)
  );
  and_cell gate102 (
    .a (net138),
    .b (net137),
    .out (net140)
  );
  xor_cell gate103 (
    .a (net140),
    .b (net141),
    .out (net142)
  );
  dff_cell flipflop20 (
    .d (net142),
    .clk (net1),
    .q (net141)
  );
  and_cell gate104 (
    .a (net141),
    .b (net140),
    .out (net143)
  );
  mux_cell mux2 (
    .a (net1),
    .b (net143),
    .sel (net8),
    .out (net47)
  );
  mux_cell mux3 (
    .a (net1),
    .b (net143),
    .sel (net8),
    .out (net37)
  );
  mux_cell mux4 (
    .a (net1),
    .b (net143),
    .sel (net8),
    .out (net39)
  );
  mux_cell mux5 (
    .a (net1),
    .b (net143),
    .sel (net8),
    .out (net41)
  );
  mux_cell mux6 (
    .a (net1),
    .b (net143),
    .sel (net8),
    .out (net43)
  );
  mux_cell mux7 (
    .a (net1),
    .b (net143),
    .sel (net8),
    .out (net45)
  );
endmodule
