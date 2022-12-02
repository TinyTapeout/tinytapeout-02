/* Automatically generated from https://wokwi.com/projects/349833797657690706 */

`default_nettype none

module user_module_349833797657690706(
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
  wire net13 = 1'b1;
  wire net14 = 1'b1;
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
  wire net59 = 1'b0;
  wire net60 = 1'b0;
  wire net61 = 1'b0;
  wire net62 = 1'b0;
  wire net63 = 1'b0;
  wire net64 = 1'b0;
  wire net65 = 1'b0;
  wire net66 = 1'b0;
  wire net67 = 1'b0;
  wire net68 = 1'b0;
  wire net69 = 1'b0;
  wire net70 = 1'b0;
  wire net71 = 1'b0;
  wire net72 = 1'b0;
  wire net73 = 1'b0;
  wire net74 = 1'b0;
  wire net75 = 1'b0;
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
  wire net120 = 1'b0;
  wire net121 = 1'b0;
  wire net122 = 1'b0;
  wire net123 = 1'b0;
  wire net124 = 1'b0;
  wire net125 = 1'b0;
  wire net126 = 1'b0;
  wire net127 = 1'b0;
  wire net128 = 1'b0;
  wire net129 = 1'b0;
  wire net130 = 1'b0;
  wire net131 = 1'b0;
  wire net132 = 1'b0;
  wire net133 = 1'b0;
  wire net134 = 1'b0;
  wire net135 = 1'b0;
  wire net136;
  wire net137;
  wire net138;
  wire net139;
  wire net140;
  wire net141;
  wire net142;
  wire net143;
  wire net144;
  wire net145 = 1'b0;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[4] = net11;
  assign io_out[5] = net12;

  and_cell gate1 (

  );
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
  mux_cell mux1 (

  );
  dff_cell flipflop1 (

  );
  dff_cell flipflop2 (
    .d (net15),
    .clk (net3),
    .q (net16)
  );
  nand_cell gate7 (
    .a (net17),
    .b (net18),
    .out (net19)
  );
  nand_cell gate8 (
    .a (net18),
    .b (net2),
    .out (net20)
  );
  dff_cell flipflop3 (
    .d (net21),
    .clk (net3),
    .q (net22)
  );
  nand_cell gate9 (
    .a (net19),
    .b (net20),
    .out (net23)
  );
  nand_cell gate10 (
    .a (net17),
    .b (net2),
    .out (net18)
  );
  and_cell gate11 (
    .a (net1),
    .b (net22),
    .out (net15)
  );
  dff_cell flipflop4 (
    .d (net24),
    .clk (net3),
    .q (net25)
  );
  and_cell gate12 (
    .a (net1),
    .b (net16),
    .out (net24)
  );
  dff_cell flipflop5 (
    .d (net26),
    .clk (net3),
    .q (net27)
  );
  and_cell gate13 (
    .a (net1),
    .b (net25),
    .out (net26)
  );
  dff_cell flipflop6 (
    .d (net28),
    .clk (net3),
    .q (net29)
  );
  and_cell gate14 (
    .a (net1),
    .b (net27),
    .out (net28)
  );
  dff_cell flipflop7 (
    .d (net30),
    .clk (net3),
    .q (net31)
  );
  and_cell gate15 (
    .a (net1),
    .b (net32),
    .out (net30)
  );
  dff_cell flipflop8 (
    .d (net33),
    .clk (net3),
    .q (net34)
  );
  and_cell gate16 (
    .a (net1),
    .b (net31),
    .out (net33)
  );
  dff_cell flipflop9 (
    .d (net35),
    .clk (net3),
    .q (net36)
  );
  and_cell gate17 (
    .a (net1),
    .b (net34),
    .out (net35)
  );
  dff_cell flipflop10 (
    .d (net37),
    .clk (net3),
    .q (net38)
  );
  and_cell gate18 (
    .a (net1),
    .b (net36),
    .out (net37)
  );
  and_cell gate19 (
    .a (net1),
    .b (net23),
    .out (net21)
  );
  dff_cell flipflop11 (
    .d (net39),
    .clk (net3),
    .q (net40)
  );
  and_cell gate20 (
    .a (net1),
    .b (net38),
    .out (net39)
  );
  dff_cell flipflop12 (
    .d (net41),
    .clk (net3),
    .q (net42)
  );
  and_cell gate21 (
    .a (net1),
    .b (net40),
    .out (net41)
  );
  dff_cell flipflop13 (
    .d (net43),
    .clk (net3),
    .q (net44)
  );
  and_cell gate22 (
    .a (net1),
    .b (net42),
    .out (net43)
  );
  dff_cell flipflop14 (
    .d (net45),
    .clk (net3),
    .q (net46)
  );
  and_cell gate23 (
    .a (net1),
    .b (net47),
    .out (net45)
  );
  dff_cell flipflop15 (
    .d (net48),
    .clk (net3),
    .q (net49)
  );
  and_cell gate24 (
    .a (net1),
    .b (net46),
    .out (net48)
  );
  dff_cell flipflop16 (
    .d (net50),
    .clk (net3),
    .q (net51)
  );
  and_cell gate25 (
    .a (net1),
    .b (net49),
    .out (net50)
  );
  dff_cell flipflop17 (
    .d (net52),
    .clk (net3),
    .q (net9)
  );
  and_cell gate26 (
    .a (net1),
    .b (net51),
    .out (net52)
  );
  nand_cell gate31 (
    .a (net17),
    .b (net53),
    .out (net54)
  );
  nand_cell gate32 (
    .a (net53),
    .b (net29),
    .out (net55)
  );
  nand_cell gate33 (
    .a (net54),
    .b (net55),
    .out (net32)
  );
  nand_cell gate34 (
    .a (net17),
    .b (net29),
    .out (net53)
  );
  nand_cell gate35 (
    .a (net17),
    .b (net56),
    .out (net57)
  );
  nand_cell gate36 (
    .a (net56),
    .b (net44),
    .out (net58)
  );
  nand_cell gate37 (
    .a (net57),
    .b (net58),
    .out (net47)
  );
  nand_cell gate38 (
    .a (net17),
    .b (net44),
    .out (net56)
  );
  and_cell gate39 (
    .a (net9),
    .b (net4),
    .out (net17)
  );
  dff_cell flipflop18 (
    .d (net76),
    .clk (net7),
    .q (net77)
  );
  nand_cell gate40 (
    .a (net78),
    .b (net79),
    .out (net80)
  );
  nand_cell gate41 (
    .a (net79),
    .b (net6),
    .out (net81)
  );
  dff_cell flipflop19 (
    .d (net82),
    .clk (net7),
    .q (net83)
  );
  nand_cell gate42 (
    .a (net80),
    .b (net81),
    .out (net84)
  );
  nand_cell gate43 (
    .a (net78),
    .b (net6),
    .out (net79)
  );
  and_cell gate44 (
    .a (net5),
    .b (net83),
    .out (net76)
  );
  dff_cell flipflop20 (
    .d (net85),
    .clk (net7),
    .q (net86)
  );
  and_cell gate45 (
    .a (net5),
    .b (net77),
    .out (net85)
  );
  dff_cell flipflop21 (
    .d (net87),
    .clk (net7),
    .q (net88)
  );
  and_cell gate46 (
    .a (net5),
    .b (net86),
    .out (net87)
  );
  dff_cell flipflop22 (
    .d (net89),
    .clk (net7),
    .q (net90)
  );
  and_cell gate47 (
    .a (net5),
    .b (net88),
    .out (net89)
  );
  dff_cell flipflop23 (
    .d (net91),
    .clk (net7),
    .q (net92)
  );
  and_cell gate48 (
    .a (net5),
    .b (net93),
    .out (net91)
  );
  dff_cell flipflop24 (
    .d (net94),
    .clk (net7),
    .q (net95)
  );
  and_cell gate49 (
    .a (net5),
    .b (net92),
    .out (net94)
  );
  dff_cell flipflop25 (
    .d (net96),
    .clk (net7),
    .q (net97)
  );
  and_cell gate50 (
    .a (net5),
    .b (net95),
    .out (net96)
  );
  dff_cell flipflop26 (
    .d (net98),
    .clk (net7),
    .q (net99)
  );
  and_cell gate51 (
    .a (net5),
    .b (net97),
    .out (net98)
  );
  and_cell gate52 (
    .a (net5),
    .b (net84),
    .out (net82)
  );
  dff_cell flipflop27 (
    .d (net100),
    .clk (net7),
    .q (net101)
  );
  and_cell gate53 (
    .a (net5),
    .b (net99),
    .out (net100)
  );
  dff_cell flipflop28 (
    .d (net102),
    .clk (net7),
    .q (net103)
  );
  and_cell gate54 (
    .a (net5),
    .b (net101),
    .out (net102)
  );
  dff_cell flipflop29 (
    .d (net104),
    .clk (net7),
    .q (net105)
  );
  and_cell gate55 (
    .a (net5),
    .b (net103),
    .out (net104)
  );
  dff_cell flipflop30 (
    .d (net106),
    .clk (net7),
    .q (net107)
  );
  and_cell gate56 (
    .a (net5),
    .b (net108),
    .out (net106)
  );
  dff_cell flipflop31 (
    .d (net109),
    .clk (net7),
    .q (net110)
  );
  and_cell gate57 (
    .a (net5),
    .b (net107),
    .out (net109)
  );
  dff_cell flipflop32 (
    .d (net111),
    .clk (net7),
    .q (net112)
  );
  and_cell gate58 (
    .a (net5),
    .b (net110),
    .out (net111)
  );
  dff_cell flipflop33 (
    .d (net113),
    .clk (net7),
    .q (net11)
  );
  and_cell gate59 (
    .a (net5),
    .b (net112),
    .out (net113)
  );
  nand_cell gate60 (
    .a (net78),
    .b (net114),
    .out (net115)
  );
  nand_cell gate61 (
    .a (net114),
    .b (net90),
    .out (net116)
  );
  nand_cell gate62 (
    .a (net115),
    .b (net116),
    .out (net93)
  );
  nand_cell gate63 (
    .a (net78),
    .b (net90),
    .out (net114)
  );
  nand_cell gate64 (
    .a (net78),
    .b (net117),
    .out (net118)
  );
  nand_cell gate65 (
    .a (net117),
    .b (net105),
    .out (net119)
  );
  nand_cell gate66 (
    .a (net118),
    .b (net119),
    .out (net108)
  );
  nand_cell gate67 (
    .a (net78),
    .b (net105),
    .out (net117)
  );
  and_cell gate68 (
    .a (net11),
    .b (net8),
    .out (net78)
  );
  nand_cell gate27 (
    .a (net10),
    .b (net136),
    .out (net137)
  );
  nand_cell gate28 (
    .a (net136),
    .b (net2),
    .out (net138)
  );
  nand_cell gate29 (
    .a (net137),
    .b (net138),
    .out (net139)
  );
  nand_cell gate30 (
    .a (net10),
    .b (net2),
    .out (net136)
  );
  dff_cell flipflop34 (
    .d (net140),
    .clk (net3),
    .q (net10)
  );
  nand_cell gate69 (
    .a (net12),
    .b (net141),
    .out (net142)
  );
  nand_cell gate70 (
    .a (net141),
    .b (net6),
    .out (net143)
  );
  nand_cell gate71 (
    .a (net142),
    .b (net143),
    .out (net144)
  );
  nand_cell gate72 (
    .a (net12),
    .b (net6),
    .out (net141)
  );
  dff_cell flipflop35 (
    .d (net144),
    .clk (net7),
    .q (net12)
  );
  and_cell gate73 (
    .a (net1),
    .b (net139),
    .out (net140)
  );
endmodule
