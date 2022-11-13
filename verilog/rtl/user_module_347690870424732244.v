/* Automatically generated from https://wokwi.com/projects/347690870424732244 */

`default_nettype none

module user_module_347690870424732244(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
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
  wire net14;
  wire net15;
  wire net16;
  wire net17 = 1'b1;
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
  wire net37 = 1'b0;
  wire net38;
  wire net39 = 1'b0;
  wire net40;
  wire net41 = 1'b0;
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
  wire net79 = 1'b0;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84;
  wire net85;
  wire net86 = 1'b1;
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
  wire net100 = 1'b0;
  wire net101;
  wire net102 = 1'b0;
  wire net103 = 1'b0;
  wire net104 = 1'b0;
  wire net105;
  wire net106;
  wire net107;
  wire net108;
  wire net109;
  wire net110;
  wire net111;
  wire net112;
  wire net113;
  wire net114 = 1'b0;

  assign io_out[0] = net3;
  assign io_out[1] = net4;
  assign io_out[2] = net5;
  assign io_out[3] = net6;
  assign io_out[4] = net7;
  assign io_out[5] = net8;
  assign io_out[6] = net9;
  assign io_out[7] = net10;

  dff_cell flop1 (
    .d (net14),
    .clk (net1),
    .q (net15),
    .notq (net16)
  );
  xor_cell xor1 (
    .a (net15),
    .b (net17),
    .out (net18)
  );
  dff_cell flop2 (
    .d (net19),
    .clk (net1),
    .q (net20),
    .notq (net21)
  );
  xor_cell xor2 (
    .a (net20),
    .b (net22),
    .out (net23)
  );
  dff_cell flop3 (
    .d (net24),
    .clk (net1),
    .q (net25),
    .notq (net26)
  );
  xor_cell xor3 (
    .a (net25),
    .b (net27),
    .out (net28)
  );
  dff_cell flop4 (
    .d (net29),
    .clk (net1),
    .q (net30),
    .notq (net31)
  );
  xor_cell xor4 (
    .a (net30),
    .b (net32),
    .out (net33)
  );
  and_cell and1 (
    .a (net17),
    .b (net15),
    .out (net22)
  );
  and_cell and2 (
    .a (net22),
    .b (net20),
    .out (net27)
  );
  and_cell and3 (
    .a (net27),
    .b (net25),
    .out (net32)
  );
  mux_cell mux1 (
    .a (net34),
    .b (net35),
    .sel (net36),
    .out (net14)
  );
  mux_cell mux2 (
    .a (net37),
    .b (net38),
    .sel (net36),
    .out (net19)
  );
  mux_cell mux3 (
    .a (net39),
    .b (net40),
    .sel (net36),
    .out (net24)
  );
  mux_cell mux4 (
    .a (net41),
    .b (net42),
    .sel (net36),
    .out (net29)
  );
  or_cell or2 (
    .a (net43),
    .b (net44),
    .out (net45)
  );
  or_cell or3 (
    .a (net45),
    .b (net46),
    .out (net47)
  );
  and_cell and4 (
    .a (net26),
    .b (net21),
    .out (net43)
  );
  and_cell and5 (
    .a (net25),
    .b (net20),
    .out (net44)
  );
  and_cell and6 (
    .a (net25),
    .b (net15),
    .out (net46)
  );
  or_cell or5 (
    .a (net48),
    .b (net49),
    .out (net50)
  );
  and_cell and7 (
    .a (net31),
    .b (net26),
    .out (net51)
  );
  and_cell and8 (
    .a (net21),
    .b (net15),
    .out (net52)
  );
  and_cell and10 (
    .a (net51),
    .b (net52),
    .out (net48)
  );
  and_cell and11 (
    .a (net25),
    .b (net21),
    .out (net53)
  );
  and_cell and13 (
    .a (net53),
    .b (net16),
    .out (net49)
  );
  and_cell and9 (
    .a (net26),
    .b (net20),
    .out (net54)
  );
  and_cell and12 (
    .a (net26),
    .b (net20),
    .out (net55)
  );
  and_cell and14 (
    .a (net55),
    .b (net16),
    .out (net56)
  );
  or_cell or4 (
    .a (net57),
    .b (net58),
    .out (net59)
  );
  or_cell or6 (
    .a (net59),
    .b (net60),
    .out (net61)
  );
  and_cell and15 (
    .a (net31),
    .b (net16),
    .out (net57)
  );
  and_cell and16 (
    .a (net31),
    .b (net21),
    .out (net58)
  );
  and_cell and17 (
    .a (net31),
    .b (net26),
    .out (net60)
  );
  or_cell or7 (
    .a (net62),
    .b (net63),
    .out (net64)
  );
  and_cell and19 (
    .a (net25),
    .b (net20),
    .out (net65)
  );
  and_cell and20 (
    .a (net30),
    .b (net15),
    .out (net63)
  );
  and_cell and21 (
    .a (net65),
    .b (net16),
    .out (net62)
  );
  or_cell or8 (
    .a (net66),
    .b (net67),
    .out (net68)
  );
  and_cell and18 (
    .a (net25),
    .b (net20),
    .out (net69)
  );
  and_cell and22 (
    .a (net30),
    .b (net16),
    .out (net67)
  );
  and_cell and23 (
    .a (net69),
    .b (net15),
    .out (net66)
  );
  and_cell and25 (
    .a (net25),
    .b (net20),
    .out (net70)
  );
  and_cell and26 (
    .a (net70),
    .b (net15),
    .out (net71)
  );
  and_cell and24 (
    .a (net72),
    .b (net30),
    .out (net73)
  );
  or_cell or1 (
    .a (net74),
    .b (net2),
    .out (net75)
  );
  not_cell not1 (
    .in (net75),
    .out (net36)
  );
  and_cell and27 (
    .a (net68),
    .b (net71),
    .out (net76)
  );
  or_cell or11 (
    .a (net77),
    .b (net76),
    .out (net78)
  );
  and_cell and28 (
    .a (net54),
    .b (net56),
    .out (net77)
  );
  or_cell or9 (
    .a (net50),
    .b (net64),
    .out (net80)
  );
  and_cell and29 (
    .a (net81),
    .b (net82),
    .out (net83)
  );
  not_cell not2 (
    .in (net78),
    .out (net81)
  );
  not_cell not3 (
    .in (net80),
    .out (net82)
  );
  dff_cell flop5 (
    .d (net84),
    .clk (net1),
    .q (net85)
  );
  xor_cell xor5 (
    .a (net85),
    .b (net86),
    .out (net87)
  );
  dff_cell flop6 (
    .d (net88),
    .clk (net1),
    .q (net89)
  );
  xor_cell xor6 (
    .a (net89),
    .b (net90),
    .out (net91)
  );
  dff_cell flop7 (
    .d (net92),
    .clk (net1),
    .q (net93)
  );
  xor_cell xor7 (
    .a (net93),
    .b (net94),
    .out (net95)
  );
  dff_cell flop8 (
    .d (net96),
    .clk (net1),
    .q (net97)
  );
  xor_cell xor8 (
    .a (net97),
    .b (net98),
    .out (net99)
  );
  and_cell and30 (
    .a (net86),
    .b (net85),
    .out (net90)
  );
  and_cell and31 (
    .a (net90),
    .b (net89),
    .out (net94)
  );
  and_cell and32 (
    .a (net94),
    .b (net93),
    .out (net98)
  );
  mux_cell mux5 (
    .a (net100),
    .b (net87),
    .sel (net101),
    .out (net84)
  );
  mux_cell mux6 (
    .a (net102),
    .b (net91),
    .sel (net101),
    .out (net88)
  );
  mux_cell mux7 (
    .a (net103),
    .b (net95),
    .sel (net101),
    .out (net92)
  );
  mux_cell mux8 (
    .a (net104),
    .b (net99),
    .sel (net101),
    .out (net96)
  );
  or_cell or10 (
    .a (net105),
    .b (net106),
    .out (net107)
  );
  not_cell not4 (
    .in (net107),
    .out (net101)
  );
  or_cell or12 (
    .a (net108),
    .b (net2),
    .out (net106)
  );
  or_cell or13 (
    .a (net109),
    .b (net110),
    .out (net105)
  );
  and_cell and33 (
    .a (net97),
    .b (net78),
    .out (net108)
  );
  and_cell and34 (
    .a (net93),
    .b (net83),
    .out (net110)
  );
  and_cell and35 (
    .a (net85),
    .b (net80),
    .out (net109)
  );
  mux_cell mux9 (
    .a (net30),
    .b (net33),
    .sel (net107),
    .out (net42)
  );
  mux_cell mux10 (
    .a (net25),
    .b (net28),
    .sel (net107),
    .out (net40)
  );
  mux_cell mux11 (
    .a (net20),
    .b (net23),
    .sel (net107),
    .out (net38)
  );
  mux_cell mux12 (
    .a (net15),
    .b (net18),
    .sel (net107),
    .out (net35)
  );
  and_cell and39 (
    .a (net73),
    .b (net107),
    .out (net74)
  );
  or_cell or14 (
    .a (net15),
    .b (net20),
    .out (net111)
  );
  or_cell or15 (
    .a (net111),
    .b (net25),
    .out (net72)
  );
  dff_cell flop9 (
    .d (net112),
    .clk (net1),
    .q (net113),
    .notq (net112)
  );
  mux_cell mux13 (
    .a (net47),
    .b (net114),
    .sel (net2),
    .out (net3)
  );
  mux_cell mux14 (
    .a (net50),
    .b (net114),
    .sel (net2),
    .out (net4)
  );
  mux_cell mux15 (
    .a (net54),
    .b (net114),
    .sel (net2),
    .out (net5)
  );
  mux_cell mux16 (
    .a (net56),
    .b (net114),
    .sel (net2),
    .out (net6)
  );
  mux_cell mux17 (
    .a (net61),
    .b (net114),
    .sel (net2),
    .out (net7)
  );
  mux_cell mux18 (
    .a (net64),
    .b (net113),
    .sel (net2),
    .out (net8)
  );
  mux_cell mux19 (
    .a (net68),
    .b (net114),
    .sel (net2),
    .out (net9)
  );
  mux_cell mux20 (
    .a (net71),
    .b (net114),
    .sel (net2),
    .out (net10)
  );
endmodule
