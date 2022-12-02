/* Automatically generated from https://wokwi.com/projects/349934460979905106 */

`default_nettype none

module user_module_349934460979905106(
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
  wire net16 = 1'b0;
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
  wire net46 = 1'b1;
  wire net47;
  wire net48 = 1'b1;
  wire net49;
  wire net50;
  wire net51;
  wire net52 = 1'b0;
  wire net53;
  wire net54;
  wire net55 = 1'b1;
  wire net56;
  wire net57;
  wire net58 = 1'b1;
  wire net59;
  wire net60;
  wire net61 = 1'b1;
  wire net62;
  wire net63;
  wire net64 = 1'b1;
  wire net65;
  wire net66;
  wire net67 = 1'b0;
  wire net68;
  wire net69;
  wire net70 = 1'b0;
  wire net71;
  wire net72;
  wire net73 = 1'b0;
  wire net74;
  wire net75;
  wire net76 = 1'b0;
  wire net77;
  wire net78;
  wire net79 = 1'b1;
  wire net80;
  wire net81;
  wire net82 = 1'b1;
  wire net83;
  wire net84;
  wire net85;
  wire net86 = 1'b0;
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
  wire net107 = 1'b1;
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
  wire net144 = 1'b1;
  wire net145;
  wire net146;
  wire net147 = 1'b1;
  wire net148;
  wire net149;
  wire net150 = 1'b1;
  wire net151;
  wire net152;
  wire net153 = 1'b1;
  wire net154;
  wire net155;
  wire net156 = 1'b1;
  wire net157;
  wire net158;
  wire net159 = 1'b1;
  wire net160;
  wire net161;
  wire net162 = 1'b1;
  wire net163;
  wire net164;
  wire net165 = 1'b1;
  wire net166;
  wire net167;
  wire net168 = 1'b1;
  wire net169;
  wire net170;
  wire net171 = 1'b1;
  wire net172;
  wire net173;
  wire net174 = 1'b1;
  wire net175;
  wire net176;
  wire net177 = 1'b1;
  wire net178 = 1'b1;
  wire net179;
  wire net180 = 1'b1;
  wire net181;
  wire net182 = 1'b1;
  wire net183;
  wire net184 = 1'b1;
  wire net185;
  wire net186;
  wire net187;
  wire net188;
  wire net189;
  wire net190;
  wire net191;
  wire net192;
  wire net193 = 1'b0;
  wire net194 = 1'b0;
  wire net195 = 1'b0;
  wire net196 = 1'b0;

  assign io_out[6] = net9;
  assign io_out[7] = net10;

  dff_cell flop6 (
    .d (net14),
    .clk (net1),
    .q (net15)
  );
  mux_cell mux6 (
    .a (net16),
    .b (net17),
    .sel (net8),
    .out (net14)
  );
  dff_cell flop7 (
    .d (net18),
    .clk (net1),
    .q (net17)
  );
  mux_cell mux7 (
    .a (net19),
    .b (net20),
    .sel (net8),
    .out (net18)
  );
  dff_cell flop8 (
    .d (net21),
    .clk (net1),
    .q (net20)
  );
  mux_cell mux8 (
    .a (net22),
    .b (net23),
    .sel (net8),
    .out (net21)
  );
  dff_cell flop9 (
    .d (net24),
    .clk (net1),
    .q (net23)
  );
  mux_cell mux9 (
    .a (net25),
    .b (net26),
    .sel (net8),
    .out (net24)
  );
  dff_cell flop10 (
    .d (net27),
    .clk (net1),
    .q (net26)
  );
  mux_cell mux10 (
    .a (net28),
    .b (net29),
    .sel (net8),
    .out (net27)
  );
  dff_cell flop11 (
    .d (net30),
    .clk (net1),
    .q (net29)
  );
  mux_cell mux11 (
    .a (net31),
    .b (net32),
    .sel (net8),
    .out (net30)
  );
  dff_cell flop12 (
    .d (net33),
    .clk (net1),
    .q (net32)
  );
  mux_cell mux12 (
    .a (net34),
    .b (net35),
    .sel (net8),
    .out (net33)
  );
  dff_cell flop13 (
    .d (net36),
    .clk (net1),
    .q (net35)
  );
  mux_cell mux13 (
    .a (net37),
    .b (net38),
    .sel (net8),
    .out (net36)
  );
  dff_cell flop14 (
    .d (net39),
    .clk (net1),
    .q (net38)
  );
  mux_cell mux14 (
    .a (net40),
    .b (net41),
    .sel (net8),
    .out (net39)
  );
  dff_cell flop15 (
    .d (net42),
    .clk (net1),
    .q (net41)
  );
  mux_cell mux15 (
    .a (net43),
    .b (net44),
    .sel (net8),
    .out (net42)
  );
  dff_cell flop16 (
    .d (net45),
    .clk (net1),
    .q (net44)
  );
  mux_cell mux16 (
    .a (net46),
    .b (net47),
    .sel (net8),
    .out (net45)
  );
  mux_cell mux2 (
    .a (net48),
    .b (net49),
    .sel (net8),
    .out (net10)
  );
  dff_cell flop1 (
    .d (net50),
    .clk (net1),
    .q (net51)
  );
  mux_cell mux1 (
    .a (net52),
    .b (net53),
    .sel (net8),
    .out (net50)
  );
  dff_cell flop2 (
    .d (net54),
    .clk (net1),
    .q (net53)
  );
  mux_cell mux3 (
    .a (net55),
    .b (net56),
    .sel (net8),
    .out (net54)
  );
  dff_cell flop3 (
    .d (net57),
    .clk (net1),
    .q (net56)
  );
  mux_cell mux4 (
    .a (net58),
    .b (net59),
    .sel (net8),
    .out (net57)
  );
  dff_cell flop4 (
    .d (net60),
    .clk (net1),
    .q (net59)
  );
  mux_cell mux5 (
    .a (net61),
    .b (net62),
    .sel (net8),
    .out (net60)
  );
  dff_cell flop5 (
    .d (net63),
    .clk (net1),
    .q (net62)
  );
  mux_cell mux17 (
    .a (net64),
    .b (net65),
    .sel (net8),
    .out (net63)
  );
  dff_cell flop17 (
    .d (net66),
    .clk (net1),
    .q (net65)
  );
  mux_cell mux18 (
    .a (net67),
    .b (net68),
    .sel (net8),
    .out (net66)
  );
  dff_cell flop18 (
    .d (net69),
    .clk (net1),
    .q (net68)
  );
  mux_cell mux19 (
    .a (net70),
    .b (net71),
    .sel (net8),
    .out (net69)
  );
  dff_cell flop19 (
    .d (net72),
    .clk (net1),
    .q (net71)
  );
  mux_cell mux20 (
    .a (net73),
    .b (net74),
    .sel (net8),
    .out (net72)
  );
  dff_cell flop20 (
    .d (net75),
    .clk (net1),
    .q (net74)
  );
  mux_cell mux21 (
    .a (net76),
    .b (net77),
    .sel (net8),
    .out (net75)
  );
  dff_cell flop21 (
    .d (net78),
    .clk (net1),
    .q (net77)
  );
  mux_cell mux22 (
    .a (net79),
    .b (net80),
    .sel (net8),
    .out (net78)
  );
  dff_cell flop22 (
    .d (net81),
    .clk (net1),
    .q (net80)
  );
  mux_cell mux23 (
    .a (net82),
    .b (net83),
    .sel (net8),
    .out (net81)
  );
  dff_cell flop23 (
    .d (net84),
    .clk (net1),
    .q (net85)
  );
  mux_cell mux24 (
    .a (net86),
    .b (net87),
    .sel (net8),
    .out (net84)
  );
  dff_cell flop24 (
    .d (net88),
    .clk (net1),
    .q (net87)
  );
  mux_cell mux25 (
    .a (net19),
    .b (net89),
    .sel (net8),
    .out (net88)
  );
  dff_cell flop25 (
    .d (net90),
    .clk (net1),
    .q (net89)
  );
  mux_cell mux26 (
    .a (net22),
    .b (net91),
    .sel (net8),
    .out (net90)
  );
  dff_cell flop26 (
    .d (net92),
    .clk (net1),
    .q (net91)
  );
  mux_cell mux27 (
    .a (net25),
    .b (net93),
    .sel (net8),
    .out (net92)
  );
  dff_cell flop27 (
    .d (net94),
    .clk (net1),
    .q (net93)
  );
  mux_cell mux28 (
    .a (net28),
    .b (net95),
    .sel (net8),
    .out (net94)
  );
  dff_cell flop28 (
    .d (net96),
    .clk (net1),
    .q (net95)
  );
  mux_cell mux29 (
    .a (net31),
    .b (net97),
    .sel (net8),
    .out (net96)
  );
  dff_cell flop29 (
    .d (net98),
    .clk (net1),
    .q (net97)
  );
  mux_cell mux30 (
    .a (net34),
    .b (net99),
    .sel (net8),
    .out (net98)
  );
  dff_cell flop30 (
    .d (net100),
    .clk (net1),
    .q (net99)
  );
  mux_cell mux31 (
    .a (net37),
    .b (net101),
    .sel (net8),
    .out (net100)
  );
  dff_cell flop31 (
    .d (net102),
    .clk (net1),
    .q (net101)
  );
  mux_cell mux32 (
    .a (net40),
    .b (net103),
    .sel (net8),
    .out (net102)
  );
  dff_cell flop32 (
    .d (net104),
    .clk (net1),
    .q (net103)
  );
  mux_cell mux33 (
    .a (net43),
    .b (net105),
    .sel (net8),
    .out (net104)
  );
  dff_cell flop33 (
    .d (net106),
    .clk (net1),
    .q (net105)
  );
  mux_cell mux34 (
    .a (net107),
    .b (net108),
    .sel (net8),
    .out (net106)
  );
  xor_cell xor1 (
    .a (net109),
    .b (net110),
    .out (net111)
  );
  xor_cell xor2 (
    .a (net19),
    .b (net22),
    .out (net109)
  );
  xor_cell xor3 (
    .a (net25),
    .b (net28),
    .out (net110)
  );
  xor_cell xor4 (
    .a (net31),
    .b (net34),
    .out (net112)
  );
  xor_cell xor5 (
    .a (net37),
    .b (net40),
    .out (net113)
  );
  xor_cell xor6 (
    .a (net112),
    .b (net113),
    .out (net114)
  );
  xor_cell xor7 (
    .a (net111),
    .b (net114),
    .out (net43)
  );
  dff_cell flop34 (
    .d (net115),
    .clk (net1),
    .q (net116),
    .notq (net117)
  );
  dff_cell flop35 (
    .d (net118),
    .clk (net1),
    .q (net119),
    .notq (net120)
  );
  dff_cell flop36 (
    .d (net121),
    .clk (net1),
    .q (net122),
    .notq (net123)
  );
  dff_cell flop37 (
    .d (net124),
    .clk (net1),
    .q (net125),
    .notq (net126)
  );
  and_cell and17 (
    .a (net122),
    .b (net117),
    .out (net127)
  );
  and_cell and18 (
    .a (net128),
    .b (net129),
    .out (net130)
  );
  and_cell and19 (
    .a (net116),
    .b (net125),
    .out (net129)
  );
  and_cell and20 (
    .a (net119),
    .b (net123),
    .out (net131)
  );
  and_cell and21 (
    .a (net119),
    .b (net117),
    .out (net132)
  );
  and_cell and22 (
    .a (net120),
    .b (net122),
    .out (net128)
  );
  and_cell and23 (
    .a (net119),
    .b (net126),
    .out (net133)
  );
  xor_cell xor8 (
    .a (net125),
    .b (net116),
    .out (net134)
  );
  or_cell or8 (
    .a (net135),
    .b (net136),
    .out (net137)
  );
  or_cell or11 (
    .a (net127),
    .b (net138),
    .out (net135)
  );
  or_cell or12 (
    .a (net139),
    .b (net140),
    .out (net141)
  );
  or_cell or13 (
    .a (net133),
    .b (net130),
    .out (net140)
  );
  or_cell or14 (
    .a (net131),
    .b (net132),
    .out (net139)
  );
  and_cell and24 (
    .a (net122),
    .b (net126),
    .out (net138)
  );
  and_cell and25 (
    .a (net123),
    .b (net125),
    .out (net142)
  );
  and_cell and26 (
    .a (net142),
    .b (net116),
    .out (net136)
  );
  dff_cell flop38 (
    .d (net143),
    .clk (net1),
    .q (net47)
  );
  mux_cell mux35 (
    .a (net144),
    .b (net145),
    .sel (net8),
    .out (net143)
  );
  dff_cell flop39 (
    .d (net146),
    .clk (net1),
    .q (net145)
  );
  mux_cell mux36 (
    .a (net147),
    .b (net148),
    .sel (net8),
    .out (net146)
  );
  dff_cell flop40 (
    .d (net149),
    .clk (net1),
    .q (net148)
  );
  mux_cell mux37 (
    .a (net150),
    .b (net151),
    .sel (net8),
    .out (net149)
  );
  dff_cell flop41 (
    .d (net152),
    .clk (net1),
    .q (net151)
  );
  mux_cell mux38 (
    .a (net153),
    .b (net154),
    .sel (net8),
    .out (net152)
  );
  dff_cell flop42 (
    .d (net155),
    .clk (net1),
    .q (net83)
  );
  mux_cell mux39 (
    .a (net156),
    .b (net157),
    .sel (net8),
    .out (net155)
  );
  dff_cell flop43 (
    .d (net158),
    .clk (net1),
    .q (net157)
  );
  mux_cell mux40 (
    .a (net159),
    .b (net160),
    .sel (net8),
    .out (net158)
  );
  dff_cell flop44 (
    .d (net161),
    .clk (net1),
    .q (net160)
  );
  mux_cell mux41 (
    .a (net162),
    .b (net163),
    .sel (net8),
    .out (net161)
  );
  dff_cell flop45 (
    .d (net164),
    .clk (net1),
    .q (net163)
  );
  mux_cell mux42 (
    .a (net165),
    .b (net166),
    .sel (net8),
    .out (net164)
  );
  dff_cell flop46 (
    .d (net167),
    .clk (net1),
    .q (net108)
  );
  mux_cell mux43 (
    .a (net168),
    .b (net169),
    .sel (net8),
    .out (net167)
  );
  dff_cell flop47 (
    .d (net170),
    .clk (net1),
    .q (net169)
  );
  mux_cell mux44 (
    .a (net171),
    .b (net172),
    .sel (net8),
    .out (net170)
  );
  dff_cell flop48 (
    .d (net173),
    .clk (net1),
    .q (net172)
  );
  mux_cell mux45 (
    .a (net174),
    .b (net175),
    .sel (net8),
    .out (net173)
  );
  dff_cell flop49 (
    .d (net176),
    .clk (net1),
    .q (net175)
  );
  mux_cell mux46 (
    .a (net177),
    .b (net178),
    .sel (net8),
    .out (net176)
  );
  dff_cell flop58 (
    .d (net179),
    .clk (net1),
    .q (net49)
  );
  mux_cell mux47 (
    .a (net180),
    .b (net15),
    .sel (net8),
    .out (net179)
  );
  dff_cell flop59 (
    .d (net181),
    .clk (net1),
    .q (net154)
  );
  mux_cell mux48 (
    .a (net182),
    .b (net51),
    .sel (net8),
    .out (net181)
  );
  dff_cell flop60 (
    .d (net183),
    .clk (net1),
    .q (net166)
  );
  mux_cell mux49 (
    .a (net184),
    .b (net85),
    .sel (net8),
    .out (net183)
  );
  dff_cell flop50 (
    .d (net2),
    .clk (net6),
    .q (net19)
  );
  dff_cell flop51 (
    .d (net5),
    .clk (net6),
    .q (net28)
  );
  dff_cell flop52 (
    .d (net4),
    .clk (net6),
    .q (net25)
  );
  dff_cell flop53 (
    .d (net3),
    .clk (net6),
    .q (net22)
  );
  dff_cell flop54 (
    .d (net2),
    .clk (net7),
    .q (net31)
  );
  dff_cell flop55 (
    .d (net3),
    .clk (net7),
    .q (net34)
  );
  dff_cell flop56 (
    .d (net4),
    .clk (net7),
    .q (net37)
  );
  dff_cell flop57 (
    .d (net5),
    .clk (net7),
    .q (net40)
  );
  or_cell or17 (
    .a (net116),
    .b (net125),
    .out (net185)
  );
  or_cell or18 (
    .a (net122),
    .b (net119),
    .out (net186)
  );
  or_cell or19 (
    .a (net185),
    .b (net186),
    .out (net187)
  );
  not_cell not7 (
    .in (net187),
    .out (net188)
  );
  or_cell or20 (
    .a (net188),
    .b (net187),
    .out (net189)
  );
  and_cell and31 (
    .a (net189),
    .b (net190),
    .out (net191)
  );
  or_cell or15 (
    .a (net191),
    .b (net192),
    .out (net9)
  );
  and_cell and28 (
    .a (net122),
    .b (net119),
    .out (net190)
  );
  mux_cell mux50 (
    .a (net193),
    .b (net117),
    .sel (net8),
    .out (net115)
  );
  mux_cell mux51 (
    .a (net194),
    .b (net134),
    .sel (net8),
    .out (net124)
  );
  mux_cell mux52 (
    .a (net195),
    .b (net137),
    .sel (net8),
    .out (net121)
  );
  mux_cell mux53 (
    .a (net196),
    .b (net141),
    .sel (net8),
    .out (net118)
  );
  and_cell and1 (
    .a (net1),
    .b (net8),
    .out (net192)
  );
endmodule
