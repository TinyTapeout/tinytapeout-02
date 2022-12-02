/* Automatically generated from https://wokwi.com/projects/348255968419643987 */

`default_nettype none

module user_module_348255968419643987(
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
  wire net14;
  wire net15;
  wire net16;
  wire net17 = 1'b0;
  wire net18;
  wire net19;
  wire net20 = 1'b0;
  wire net21;
  wire net22;
  wire net23;
  wire net24;
  wire net25 = 1'b0;
  wire net26;
  wire net27;
  wire net28;
  wire net29;
  wire net30 = 1'b0;
  wire net31;
  wire net32;
  wire net33;
  wire net34;
  wire net35 = 1'b0;
  wire net36;
  wire net37;
  wire net38;
  wire net39;
  wire net40 = 1'b0;
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
  wire net78 = 1'b0;
  wire net79;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84;
  wire net85;
  wire net86 = 1'b0;
  wire net87;
  wire net88;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[3] = net12;

  and_cell gate1 (
    .a (net14),
    .b (net15),
    .out (net16)
  );
  mux_cell mux2 (
    .a (net15),
    .b (net17),
    .sel (net9),
    .out (net18)
  );
  dff_cell flipflop2 (
    .d (net18),
    .clk (net1),
    .q (net19),
    .notq (net15)
  );
  mux_cell mux3 (
    .a (net14),
    .b (net20),
    .sel (net9),
    .out (net21)
  );
  dff_cell flipflop3 (
    .d (net21),
    .clk (net22),
    .q (net23),
    .notq (net14)
  );
  mux_cell mux4 (
    .a (net24),
    .b (net25),
    .sel (net9),
    .out (net26)
  );
  dff_cell flipflop4 (
    .d (net26),
    .clk (net27),
    .q (net28),
    .notq (net24)
  );
  mux_cell mux5 (
    .a (net29),
    .b (net30),
    .sel (net9),
    .out (net31)
  );
  dff_cell flipflop5 (
    .d (net31),
    .clk (net32),
    .q (net33),
    .notq (net29)
  );
  mux_cell mux6 (
    .a (net34),
    .b (net35),
    .sel (net9),
    .out (net36)
  );
  dff_cell flipflop6 (
    .d (net36),
    .clk (net37),
    .q (net38),
    .notq (net34)
  );
  mux_cell mux7 (
    .a (net39),
    .b (net40),
    .sel (net9),
    .out (net41)
  );
  dff_cell flipflop7 (
    .d (net41),
    .clk (net42),
    .q (net43),
    .notq (net39)
  );
  mux_cell mux8 (
    .a (net34),
    .b (net1),
    .sel (net9),
    .out (net42)
  );
  mux_cell mux9 (
    .a (net29),
    .b (net1),
    .sel (net9),
    .out (net37)
  );
  mux_cell mux10 (
    .a (net24),
    .b (net1),
    .sel (net9),
    .out (net32)
  );
  mux_cell mux11 (
    .a (net14),
    .b (net1),
    .sel (net9),
    .out (net27)
  );
  mux_cell mux12 (
    .a (net15),
    .b (net1),
    .sel (net9),
    .out (net22)
  );
  and_cell gate7 (
    .a (net24),
    .b (net16),
    .out (net44)
  );
  and_cell gate8 (
    .a (net29),
    .b (net44),
    .out (net45)
  );
  and_cell gate9 (
    .a (net38),
    .b (net45),
    .out (net46)
  );
  and_cell gate10 (
    .a (net43),
    .b (net46),
    .out (net47)
  );
  and_cell gate11 (
    .a (net23),
    .b (net19),
    .out (net48)
  );
  and_cell gate12 (
    .a (net24),
    .b (net48),
    .out (net49)
  );
  and_cell gate13 (
    .a (net33),
    .b (net49),
    .out (net50)
  );
  and_cell gate14 (
    .a (net34),
    .b (net50),
    .out (net51)
  );
  and_cell gate15 (
    .a (net43),
    .b (net51),
    .out (net52)
  );
  and_cell gate16 (
    .a (net23),
    .b (net15),
    .out (net53)
  );
  and_cell gate17 (
    .a (net28),
    .b (net53),
    .out (net54)
  );
  and_cell gate18 (
    .a (net29),
    .b (net54),
    .out (net55)
  );
  and_cell gate19 (
    .a (net34),
    .b (net55),
    .out (net56)
  );
  and_cell gate20 (
    .a (net43),
    .b (net56),
    .out (net57)
  );
  and_cell gate21 (
    .a (net14),
    .b (net15),
    .out (net58)
  );
  and_cell gate22 (
    .a (net28),
    .b (net58),
    .out (net59)
  );
  and_cell gate23 (
    .a (net29),
    .b (net59),
    .out (net60)
  );
  and_cell gate24 (
    .a (net34),
    .b (net60),
    .out (net61)
  );
  and_cell gate25 (
    .a (net43),
    .b (net61),
    .out (net62)
  );
  and_cell gate26 (
    .a (net14),
    .b (net15),
    .out (net63)
  );
  and_cell gate27 (
    .a (net24),
    .b (net63),
    .out (net64)
  );
  and_cell gate28 (
    .a (net29),
    .b (net64),
    .out (net65)
  );
  and_cell gate29 (
    .a (net34),
    .b (net65),
    .out (net66)
  );
  and_cell gate30 (
    .a (net43),
    .b (net66),
    .out (net67)
  );
  and_cell gate31 (
    .a (net23),
    .b (net19),
    .out (net68)
  );
  and_cell gate32 (
    .a (net28),
    .b (net68),
    .out (net69)
  );
  and_cell gate33 (
    .a (net33),
    .b (net69),
    .out (net70)
  );
  and_cell gate34 (
    .a (net38),
    .b (net70),
    .out (net71)
  );
  and_cell gate35 (
    .a (net39),
    .b (net71),
    .out (net72)
  );
  and_cell gate36 (
    .a (net14),
    .b (net15),
    .out (net73)
  );
  and_cell gate37 (
    .a (net24),
    .b (net73),
    .out (net74)
  );
  and_cell gate38 (
    .a (net33),
    .b (net74),
    .out (net75)
  );
  and_cell gate39 (
    .a (net38),
    .b (net75),
    .out (net76)
  );
  and_cell gate40 (
    .a (net39),
    .b (net76),
    .out (net77)
  );
  mux_cell mux13 (
    .a (net78),
    .b (net47),
    .sel (net2),
    .out (net79)
  );
  mux_cell mux14 (
    .a (net79),
    .b (net52),
    .sel (net3),
    .out (net80)
  );
  mux_cell mux15 (
    .a (net80),
    .b (net57),
    .sel (net4),
    .out (net81)
  );
  mux_cell mux16 (
    .a (net81),
    .b (net62),
    .sel (net5),
    .out (net82)
  );
  mux_cell mux17 (
    .a (net82),
    .b (net67),
    .sel (net6),
    .out (net83)
  );
  mux_cell mux18 (
    .a (net83),
    .b (net72),
    .sel (net7),
    .out (net84)
  );
  mux_cell mux19 (
    .a (net84),
    .b (net77),
    .sel (net8),
    .out (net9)
  );
  dff_cell flipflop8 (
    .d (net85),
    .clk (net9),
    .q (net10),
    .notq (net85)
  );
  dff_cell flipflop1 (
    .d (net87),
    .clk (net10),
    .q (net11),
    .notq (net87)
  );
  dff_cell flipflop9 (
    .d (net88),
    .clk (net11),
    .q (net12),
    .notq (net88)
  );
endmodule
