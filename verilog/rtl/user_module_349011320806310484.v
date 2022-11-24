/* Automatically generated from https://wokwi.com/projects/349011320806310484 */

`default_nettype none

module user_module_349011320806310484(
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
  wire net12 = 1'b0;
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
  wire net69 = 1'b0;
  wire net70;
  wire net71 = 1'b1;
  wire net72;
  wire net73;
  wire net74;
  wire net75;
  wire net76;
  wire net77;
  wire net78;
  wire net79;
  wire net80 = 1'b0;
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

  assign io_out[0] = net9;
  assign io_out[1] = net9;
  assign io_out[3] = net10;
  assign io_out[5] = net9;
  assign io_out[6] = net9;
  assign io_out[7] = net11;

  dff_cell flipflop1 (
    .d (net15),
    .clk (net16),
    .q (net17)
  );
  not_cell gate7 (
    .in (net1),
    .out (net11)
  );
  not_cell gate8 (
    .in (net2),
    .out (net18)
  );
  and_cell gate9 (
    .a (net18),
    .b (net4),
    .out (net15)
  );
  not_cell gate10 (
    .in (net3),
    .out (net19)
  );
  and_cell gate11 (
    .a (net20),
    .b (net1),
    .out (net16)
  );
  dff_cell flop2 (
    .d (net15),
    .clk (net21),
    .q (net22)
  );
  and_cell gate12 (
    .a (net23),
    .b (net1),
    .out (net21)
  );
  or_cell gate13 (
    .a (net19),
    .b (net2),
    .out (net20)
  );
  or_cell gate14 (
    .a (net3),
    .b (net2),
    .out (net23)
  );
  dff_cell flipflop3 (
    .d (net24),
    .clk (net25),
    .q (net26)
  );
  not_cell gate15 (
    .in (net2),
    .out (net27)
  );
  and_cell gate16 (
    .a (net27),
    .b (net5),
    .out (net24)
  );
  not_cell gate17 (
    .in (net3),
    .out (net28)
  );
  and_cell gate18 (
    .a (net29),
    .b (net1),
    .out (net25)
  );
  dff_cell flop3 (
    .d (net24),
    .clk (net30),
    .q (net31)
  );
  and_cell gate19 (
    .a (net32),
    .b (net1),
    .out (net30)
  );
  or_cell gate20 (
    .a (net28),
    .b (net2),
    .out (net29)
  );
  or_cell gate21 (
    .a (net3),
    .b (net2),
    .out (net32)
  );
  dff_cell flipflop4 (
    .d (net33),
    .clk (net34),
    .q (net35)
  );
  not_cell gate22 (
    .in (net2),
    .out (net36)
  );
  and_cell gate23 (
    .a (net36),
    .b (net6),
    .out (net33)
  );
  not_cell gate24 (
    .in (net3),
    .out (net37)
  );
  and_cell gate25 (
    .a (net38),
    .b (net1),
    .out (net34)
  );
  dff_cell flop4 (
    .d (net33),
    .clk (net39),
    .q (net40)
  );
  and_cell gate26 (
    .a (net41),
    .b (net1),
    .out (net39)
  );
  or_cell gate27 (
    .a (net37),
    .b (net2),
    .out (net38)
  );
  or_cell gate28 (
    .a (net3),
    .b (net2),
    .out (net41)
  );
  dff_cell flipflop5 (
    .d (net42),
    .clk (net43),
    .q (net44)
  );
  not_cell gate29 (
    .in (net2),
    .out (net45)
  );
  and_cell gate30 (
    .a (net45),
    .b (net7),
    .out (net42)
  );
  not_cell gate31 (
    .in (net3),
    .out (net46)
  );
  and_cell gate32 (
    .a (net47),
    .b (net1),
    .out (net43)
  );
  dff_cell flop5 (
    .d (net42),
    .clk (net48),
    .q (net49)
  );
  and_cell gate33 (
    .a (net50),
    .b (net1),
    .out (net48)
  );
  or_cell gate34 (
    .a (net46),
    .b (net2),
    .out (net47)
  );
  or_cell gate35 (
    .a (net3),
    .b (net2),
    .out (net50)
  );
  dff_cell flipflop6 (
    .d (net51),
    .clk (net52),
    .q (net53)
  );
  not_cell gate36 (
    .in (net2),
    .out (net54)
  );
  and_cell gate37 (
    .a (net54),
    .b (net8),
    .out (net51)
  );
  not_cell gate38 (
    .in (net3),
    .out (net55)
  );
  and_cell gate39 (
    .a (net56),
    .b (net1),
    .out (net52)
  );
  dff_cell flop6 (
    .d (net51),
    .clk (net57),
    .q (net58)
  );
  and_cell gate40 (
    .a (net59),
    .b (net1),
    .out (net57)
  );
  or_cell gate41 (
    .a (net55),
    .b (net2),
    .out (net56)
  );
  or_cell gate42 (
    .a (net3),
    .b (net2),
    .out (net59)
  );
  buffer_cell gate43 (
    .in (net17),
    .out (net60)
  );
  buffer_cell gate44 (
    .in (net26),
    .out (net61)
  );
  buffer_cell gate45 (
    .in (net35),
    .out (net62)
  );
  buffer_cell gate46 (
    .in (net44),
    .out (net63)
  );
  buffer_cell gate47 (
    .in (net53),
    .out (net64)
  );
  buffer_cell gate48 (
    .in (net22),
    .out (net65)
  );
  buffer_cell gate49 (
    .in (net31),
    .out (net66)
  );
  buffer_cell gate50 (
    .in (net40),
    .out (net67)
  );
  buffer_cell gate51 (
    .in (net49),
    .out (net68)
  );
  buffer_cell gate52 (
    .in (net58),
    .out (net10)
  );
  mux_cell mux1 (
    .a (net69),
    .b (net64),
    .sel (net60),
    .out (net70)
  );
  mux_cell mux4 (
    .a (net64),
    .b (net71),
    .sel (net60),
    .out (net72)
  );
  not_cell not1 (
    .in (net60),
    .out (net73)
  );
  mux_cell mux5 (
    .a (net74),
    .b (net75),
    .sel (net66),
    .out (net76)
  );
  mux_cell mux6 (
    .a (net69),
    .b (net70),
    .sel (net61),
    .out (net77)
  );
  mux_cell mux7 (
    .a (net70),
    .b (net72),
    .sel (net61),
    .out (net78)
  );
  mux_cell mux8 (
    .a (net72),
    .b (net73),
    .sel (net61),
    .out (net79)
  );
  mux_cell mux9 (
    .a (net73),
    .b (net80),
    .sel (net61),
    .out (net81)
  );
  mux_cell mux10 (
    .a (net77),
    .b (net78),
    .sel (net62),
    .out (net82)
  );
  mux_cell mux11 (
    .a (net78),
    .b (net79),
    .sel (net62),
    .out (net83)
  );
  mux_cell mux12 (
    .a (net79),
    .b (net81),
    .sel (net62),
    .out (net84)
  );
  mux_cell mux13 (
    .a (net81),
    .b (net80),
    .sel (net62),
    .out (net85)
  );
  mux_cell mux14 (
    .a (net82),
    .b (net83),
    .sel (net63),
    .out (net86)
  );
  mux_cell mux15 (
    .a (net83),
    .b (net84),
    .sel (net63),
    .out (net87)
  );
  mux_cell mux16 (
    .a (net84),
    .b (net85),
    .sel (net63),
    .out (net88)
  );
  mux_cell mux17 (
    .a (net85),
    .b (net80),
    .sel (net63),
    .out (net89)
  );
  mux_cell mux18 (
    .a (net86),
    .b (net87),
    .sel (net65),
    .out (net74)
  );
  mux_cell mux19 (
    .a (net87),
    .b (net88),
    .sel (net65),
    .out (net75)
  );
  mux_cell mux20 (
    .a (net88),
    .b (net89),
    .sel (net65),
    .out (net90)
  );
  mux_cell mux21 (
    .a (net89),
    .b (net80),
    .sel (net65),
    .out (net91)
  );
  mux_cell mux2 (
    .a (net75),
    .b (net90),
    .sel (net66),
    .out (net92)
  );
  mux_cell mux3 (
    .a (net90),
    .b (net91),
    .sel (net66),
    .out (net93)
  );
  mux_cell mux22 (
    .a (net76),
    .b (net92),
    .sel (net67),
    .out (net94)
  );
  mux_cell mux23 (
    .a (net92),
    .b (net93),
    .sel (net67),
    .out (net95)
  );
  mux_cell mux24 (
    .a (net94),
    .b (net95),
    .sel (net68),
    .out (net9)
  );
endmodule
