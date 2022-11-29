/* Automatically generated from https://wokwi.com/projects/348381622440034899 */

`default_nettype none

module user_module_348381622440034899(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[4];
  wire net6;
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
  wire net135;
  wire net136;
  wire net137;
  wire net138;
  wire net139;
  wire net140;
  wire net141;
  wire net142;
  wire net143;
  wire net144;
  wire net145;
  wire net146;
  wire net147;
  wire net148;
  wire net149;
  wire net150;
  wire net151;
  wire net152;
  wire net153;
  wire net154;
  wire net155;

  assign io_out[0] = net6;
  assign io_out[1] = net7;
  assign io_out[2] = net8;
  assign io_out[3] = net9;
  assign io_out[4] = net10;
  assign io_out[5] = net11;
  assign io_out[6] = net12;

  dff_cell flipflop2 (
    .d (net16),
    .clk (net1),
    .q (net17),
    .notq (net16)
  );
  dff_cell flipflop3 (
    .d (net18),
    .clk (net1),
    .q (net19)
  );
  xor_cell gate7 (
    .a (net19),
    .b (net17),
    .out (net18)
  );
  and_cell gate8 (
    .a (net19),
    .b (net17),
    .out (net20)
  );
  dff_cell flipflop4 (
    .d (net21),
    .clk (net1),
    .q (net22)
  );
  and_cell gate9 (
    .a (net22),
    .b (net20),
    .out (net23)
  );
  xor_cell gate10 (
    .a (net22),
    .b (net20),
    .out (net21)
  );
  dff_cell flipflop5 (
    .d (net24),
    .clk (net1),
    .q (net25)
  );
  xor_cell gate11 (
    .a (net25),
    .b (net23),
    .out (net24)
  );
  dff_cell flipflop6 (
    .d (net26),
    .clk (net27),
    .q (net28)
  );
  dff_cell flipflop7 (
    .d (net29),
    .clk (net27),
    .q (net30)
  );
  dff_cell flipflop8 (
    .d (net30),
    .clk (net27),
    .q (net31)
  );
  or_cell gate12 (
    .a (net28),
    .b (net30),
    .out (net32)
  );
  or_cell gate13 (
    .a (net32),
    .b (net33),
    .out (net6)
  );
  dff_cell flipflop9 (
    .d (net34),
    .clk (net27),
    .q (net35)
  );
  dff_cell flipflop10 (
    .d (net36),
    .clk (net27),
    .q (net37)
  );
  dff_cell flipflop11 (
    .d (net37),
    .clk (net27),
    .q (net38)
  );
  or_cell gate14 (
    .a (net35),
    .b (net37),
    .out (net39)
  );
  or_cell gate15 (
    .a (net39),
    .b (net40),
    .out (net7)
  );
  dff_cell flipflop12 (
    .d (net41),
    .clk (net27),
    .q (net42)
  );
  dff_cell flipflop13 (
    .d (net43),
    .clk (net27),
    .q (net44)
  );
  dff_cell flipflop14 (
    .d (net44),
    .clk (net27),
    .q (net45)
  );
  or_cell gate16 (
    .a (net42),
    .b (net44),
    .out (net46)
  );
  or_cell gate17 (
    .a (net46),
    .b (net47),
    .out (net8)
  );
  dff_cell flipflop15 (
    .d (net48),
    .clk (net27),
    .q (net49)
  );
  dff_cell flipflop16 (
    .d (net50),
    .clk (net27),
    .q (net51)
  );
  dff_cell flipflop17 (
    .d (net51),
    .clk (net27),
    .q (net52)
  );
  or_cell gate18 (
    .a (net49),
    .b (net51),
    .out (net53)
  );
  or_cell gate19 (
    .a (net53),
    .b (net54),
    .out (net9)
  );
  dff_cell flipflop18 (
    .d (net55),
    .clk (net27),
    .q (net56)
  );
  dff_cell flipflop19 (
    .d (net57),
    .clk (net27),
    .q (net58)
  );
  dff_cell flipflop20 (
    .d (net58),
    .clk (net27),
    .q (net59)
  );
  or_cell gate20 (
    .a (net56),
    .b (net58),
    .out (net60)
  );
  or_cell gate21 (
    .a (net60),
    .b (net61),
    .out (net10)
  );
  dff_cell flipflop21 (
    .d (net62),
    .clk (net27),
    .q (net63)
  );
  dff_cell flipflop22 (
    .d (net64),
    .clk (net27),
    .q (net65)
  );
  dff_cell flipflop23 (
    .d (net65),
    .clk (net27),
    .q (net66)
  );
  or_cell gate22 (
    .a (net63),
    .b (net65),
    .out (net67)
  );
  or_cell gate23 (
    .a (net67),
    .b (net68),
    .out (net11)
  );
  dff_cell flipflop24 (
    .d (net69),
    .clk (net27),
    .q (net70)
  );
  dff_cell flipflop25 (
    .d (net71),
    .clk (net27),
    .q (net72)
  );
  dff_cell flipflop26 (
    .d (net72),
    .clk (net27),
    .q (net73)
  );
  or_cell gate24 (
    .a (net70),
    .b (net72),
    .out (net74)
  );
  or_cell gate25 (
    .a (net74),
    .b (net75),
    .out (net12)
  );
  dff_cell flipflop27 (
    .d (net76),
    .clk (net27),
    .q (net77)
  );
  dff_cell flipflop28 (
    .d (net78),
    .clk (net27),
    .q (net79)
  );
  dff_cell flipflop29 (
    .d (net79),
    .clk (net27),
    .q (net80)
  );
  dff_cell flipflop30 (
    .d (net81),
    .clk (net27),
    .q (net76),
    .notq (net82)
  );
  or_cell gate1 (
    .a (net83),
    .b (net84),
    .out (net26)
  );
  not_cell not1 (
    .in (net83),
    .out (net85)
  );
  and_cell gate2 (
    .a (net85),
    .b (net86),
    .out (net34)
  );
  and_cell gate3 (
    .a (net85),
    .b (net87),
    .out (net41)
  );
  and_cell gate4 (
    .a (net85),
    .b (net88),
    .out (net48)
  );
  and_cell gate5 (
    .a (net85),
    .b (net89),
    .out (net55)
  );
  and_cell gate6 (
    .a (net85),
    .b (net90),
    .out (net62)
  );
  and_cell gate26 (
    .a (net85),
    .b (net91),
    .out (net69)
  );
  or_cell gate28 (
    .a (net77),
    .b (net83),
    .out (net78)
  );
  xor_cell gate27 (
    .a (net76),
    .b (net80),
    .out (net81)
  );
  and_cell gate29 (
    .a (net28),
    .b (net85),
    .out (net29)
  );
  or_cell gate30 (
    .a (net83),
    .b (net35),
    .out (net36)
  );
  and_cell gate31 (
    .a (net42),
    .b (net85),
    .out (net43)
  );
  and_cell gate32 (
    .a (net49),
    .b (net85),
    .out (net50)
  );
  and_cell gate33 (
    .a (net56),
    .b (net85),
    .out (net57)
  );
  and_cell gate34 (
    .a (net63),
    .b (net85),
    .out (net64)
  );
  and_cell gate35 (
    .a (net70),
    .b (net85),
    .out (net71)
  );
  or_cell gate36 (
    .a (net92),
    .b (net93),
    .out (net84)
  );
  and_cell gate37 (
    .a (net35),
    .b (net94),
    .out (net92)
  );
  and_cell gate38 (
    .a (net63),
    .b (net95),
    .out (net93)
  );
  or_cell gate39 (
    .a (net44),
    .b (net72),
    .out (net94)
  );
  or_cell gate40 (
    .a (net58),
    .b (net72),
    .out (net95)
  );
  and_cell gate41 (
    .a (net96),
    .b (net76),
    .out (net91)
  );
  or_cell gate42 (
    .a (net97),
    .b (net98),
    .out (net99)
  );
  or_cell gate43 (
    .a (net100),
    .b (net101),
    .out (net102)
  );
  or_cell gate44 (
    .a (net99),
    .b (net102),
    .out (net96)
  );
  and_cell gate45 (
    .a (net30),
    .b (net35),
    .out (net97)
  );
  and_cell gate46 (
    .a (net51),
    .b (net42),
    .out (net98)
  );
  and_cell gate47 (
    .a (net51),
    .b (net56),
    .out (net100)
  );
  and_cell gate48 (
    .a (net30),
    .b (net63),
    .out (net101)
  );
  or_cell gate49 (
    .a (net103),
    .b (net104),
    .out (net88)
  );
  and_cell gate50 (
    .a (net42),
    .b (net105),
    .out (net103)
  );
  and_cell gate51 (
    .a (net56),
    .b (net106),
    .out (net104)
  );
  or_cell gate52 (
    .a (net37),
    .b (net72),
    .out (net105)
  );
  or_cell gate53 (
    .a (net65),
    .b (net72),
    .out (net106)
  );
  or_cell gate54 (
    .a (net107),
    .b (net108),
    .out (net86)
  );
  and_cell gate55 (
    .a (net109),
    .b (net82),
    .out (net108)
  );
  or_cell gate56 (
    .a (net110),
    .b (net111),
    .out (net109)
  );
  and_cell gate57 (
    .a (net112),
    .b (net70),
    .out (net110)
  );
  and_cell gate58 (
    .a (net51),
    .b (net42),
    .out (net111)
  );
  and_cell gate59 (
    .a (net28),
    .b (net65),
    .out (net107)
  );
  or_cell gate60 (
    .a (net65),
    .b (net58),
    .out (net112)
  );
  or_cell gate61 (
    .a (net113),
    .b (net114),
    .out (net89)
  );
  and_cell gate62 (
    .a (net115),
    .b (net82),
    .out (net114)
  );
  or_cell gate63 (
    .a (net116),
    .b (net117),
    .out (net115)
  );
  and_cell gate64 (
    .a (net118),
    .b (net70),
    .out (net116)
  );
  and_cell gate65 (
    .a (net30),
    .b (net63),
    .out (net117)
  );
  and_cell gate66 (
    .a (net49),
    .b (net44),
    .out (net113)
  );
  or_cell gate67 (
    .a (net44),
    .b (net37),
    .out (net118)
  );
  or_cell gate68 (
    .a (net119),
    .b (net120),
    .out (net87)
  );
  and_cell gate69 (
    .a (net58),
    .b (net49),
    .out (net119)
  );
  or_cell gate70 (
    .a (net121),
    .b (net122),
    .out (net120)
  );
  and_cell gate71 (
    .a (net123),
    .b (net82),
    .out (net121)
  );
  and_cell gate72 (
    .a (net35),
    .b (net30),
    .out (net123)
  );
  and_cell gate73 (
    .a (net124),
    .b (net76),
    .out (net122)
  );
  or_cell gate74 (
    .a (net65),
    .b (net58),
    .out (net125)
  );
  and_cell gate75 (
    .a (net70),
    .b (net125),
    .out (net124)
  );
  or_cell gate76 (
    .a (net126),
    .b (net127),
    .out (net90)
  );
  and_cell gate77 (
    .a (net28),
    .b (net37),
    .out (net126)
  );
  or_cell gate78 (
    .a (net128),
    .b (net129),
    .out (net127)
  );
  and_cell gate79 (
    .a (net130),
    .b (net82),
    .out (net128)
  );
  and_cell gate80 (
    .a (net131),
    .b (net76),
    .out (net129)
  );
  and_cell gate81 (
    .a (net56),
    .b (net51),
    .out (net130)
  );
  and_cell gate82 (
    .a (net118),
    .b (net70),
    .out (net131)
  );
  mux_cell mux1 (
    .a (net25),
    .b (net1),
    .sel (net4),
    .out (net27)
  );
  xor_cell gate83 (
    .a (net86),
    .b (net87),
    .out (net132)
  );
  xor_cell gate84 (
    .a (net88),
    .b (net89),
    .out (net133)
  );
  xor_cell gate85 (
    .a (net90),
    .b (net91),
    .out (net134)
  );
  and_cell gate86 (
    .a (net84),
    .b (net135),
    .out (net136)
  );
  and_cell gate87 (
    .a (net137),
    .b (net132),
    .out (net138)
  );
  and_cell gate88 (
    .a (net133),
    .b (net139),
    .out (net140)
  );
  and_cell gate89 (
    .a (net141),
    .b (net134),
    .out (net142)
  );
  not_cell gate90 (
    .in (net84),
    .out (net137)
  );
  or_cell gate91 (
    .a (net86),
    .b (net87),
    .out (net143)
  );
  not_cell gate92 (
    .in (net143),
    .out (net135)
  );
  or_cell gate93 (
    .a (net88),
    .b (net89),
    .out (net144)
  );
  not_cell gate94 (
    .in (net144),
    .out (net141)
  );
  or_cell gate95 (
    .a (net90),
    .b (net91),
    .out (net145)
  );
  not_cell gate96 (
    .in (net145),
    .out (net139)
  );
  and_cell gate97 (
    .a (net141),
    .b (net139),
    .out (net146)
  );
  and_cell gate98 (
    .a (net137),
    .b (net135),
    .out (net147)
  );
  and_cell gate99 (
    .a (net148),
    .b (net146),
    .out (net149)
  );
  and_cell gate100 (
    .a (net147),
    .b (net150),
    .out (net151)
  );
  or_cell gate101 (
    .a (net149),
    .b (net151),
    .out (net152)
  );
  or_cell gate102 (
    .a (net136),
    .b (net138),
    .out (net148)
  );
  or_cell gate103 (
    .a (net140),
    .b (net142),
    .out (net150)
  );
  not_cell gate104 (
    .in (net152),
    .out (net153)
  );
  or_cell gate105 (
    .a (net154),
    .b (net3),
    .out (net83)
  );
  and_cell gate106 (
    .a (net153),
    .b (net155),
    .out (net154)
  );
  not_cell not2 (
    .in (net2),
    .out (net155)
  );
  and_cell gate107 (
    .a (net31),
    .b (net5),
    .out (net33)
  );
  and_cell gate108 (
    .a (net38),
    .b (net5),
    .out (net40)
  );
  and_cell gate109 (
    .a (net45),
    .b (net5),
    .out (net47)
  );
  and_cell gate110 (
    .a (net52),
    .b (net5),
    .out (net54)
  );
  and_cell gate111 (
    .a (net59),
    .b (net5),
    .out (net61)
  );
  and_cell gate112 (
    .a (net66),
    .b (net5),
    .out (net68)
  );
  and_cell gate113 (
    .a (net73),
    .b (net5),
    .out (net75)
  );
endmodule
