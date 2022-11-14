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
  wire net10 = 1'b1;
  wire net11;
  wire net12;
  wire net13;
  wire net14 = 1'b0;
  wire net15;
  wire net16;
  wire net17;
  wire net18 = 1'b0;
  wire net19;
  wire net20;
  wire net21;
  wire net22;
  wire net23 = 1'b0;
  wire net24;
  wire net25;
  wire net26;
  wire net27;
  wire net28 = 1'b0;
  wire net29;
  wire net30;
  wire net31;
  wire net32;
  wire net33 = 1'b0;
  wire net34;
  wire net35;
  wire net36;
  wire net37;
  wire net38 = 1'b0;
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
  wire net76 = 1'b0;
  wire net77;
  wire net78;
  wire net79;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84 = 1'b0;

  assign io_out[0] = net9;

  and_cell gate1 (
    .a (net11),
    .b (net12),
    .out (net13)
  );
  mux_cell mux2 (
    .a (net12),
    .b (net14),
    .sel (net15),
    .out (net16)
  );
  dff_cell flipflop2 (
    .d (net16),
    .clk (net1),
    .q (net17),
    .notq (net12)
  );
  mux_cell mux3 (
    .a (net11),
    .b (net18),
    .sel (net15),
    .out (net19)
  );
  dff_cell flipflop3 (
    .d (net19),
    .clk (net20),
    .q (net21),
    .notq (net11)
  );
  mux_cell mux4 (
    .a (net22),
    .b (net23),
    .sel (net15),
    .out (net24)
  );
  dff_cell flipflop4 (
    .d (net24),
    .clk (net25),
    .q (net26),
    .notq (net22)
  );
  mux_cell mux5 (
    .a (net27),
    .b (net28),
    .sel (net15),
    .out (net29)
  );
  dff_cell flipflop5 (
    .d (net29),
    .clk (net30),
    .q (net31),
    .notq (net27)
  );
  mux_cell mux6 (
    .a (net32),
    .b (net33),
    .sel (net15),
    .out (net34)
  );
  dff_cell flipflop6 (
    .d (net34),
    .clk (net35),
    .q (net36),
    .notq (net32)
  );
  mux_cell mux7 (
    .a (net37),
    .b (net38),
    .sel (net15),
    .out (net39)
  );
  dff_cell flipflop7 (
    .d (net39),
    .clk (net40),
    .q (net41),
    .notq (net37)
  );
  mux_cell mux8 (
    .a (net32),
    .b (net1),
    .sel (net15),
    .out (net40)
  );
  mux_cell mux9 (
    .a (net27),
    .b (net1),
    .sel (net15),
    .out (net35)
  );
  mux_cell mux10 (
    .a (net22),
    .b (net1),
    .sel (net15),
    .out (net30)
  );
  mux_cell mux11 (
    .a (net11),
    .b (net1),
    .sel (net15),
    .out (net25)
  );
  mux_cell mux12 (
    .a (net12),
    .b (net1),
    .sel (net15),
    .out (net20)
  );
  and_cell gate7 (
    .a (net22),
    .b (net13),
    .out (net42)
  );
  and_cell gate8 (
    .a (net27),
    .b (net42),
    .out (net43)
  );
  and_cell gate9 (
    .a (net36),
    .b (net43),
    .out (net44)
  );
  and_cell gate10 (
    .a (net41),
    .b (net44),
    .out (net45)
  );
  and_cell gate11 (
    .a (net21),
    .b (net17),
    .out (net46)
  );
  and_cell gate12 (
    .a (net22),
    .b (net46),
    .out (net47)
  );
  and_cell gate13 (
    .a (net31),
    .b (net47),
    .out (net48)
  );
  and_cell gate14 (
    .a (net32),
    .b (net48),
    .out (net49)
  );
  and_cell gate15 (
    .a (net41),
    .b (net49),
    .out (net50)
  );
  and_cell gate16 (
    .a (net21),
    .b (net12),
    .out (net51)
  );
  and_cell gate17 (
    .a (net26),
    .b (net51),
    .out (net52)
  );
  and_cell gate18 (
    .a (net27),
    .b (net52),
    .out (net53)
  );
  and_cell gate19 (
    .a (net32),
    .b (net53),
    .out (net54)
  );
  and_cell gate20 (
    .a (net41),
    .b (net54),
    .out (net55)
  );
  and_cell gate21 (
    .a (net11),
    .b (net12),
    .out (net56)
  );
  and_cell gate22 (
    .a (net26),
    .b (net56),
    .out (net57)
  );
  and_cell gate23 (
    .a (net27),
    .b (net57),
    .out (net58)
  );
  and_cell gate24 (
    .a (net32),
    .b (net58),
    .out (net59)
  );
  and_cell gate25 (
    .a (net41),
    .b (net59),
    .out (net60)
  );
  and_cell gate26 (
    .a (net11),
    .b (net12),
    .out (net61)
  );
  and_cell gate27 (
    .a (net22),
    .b (net61),
    .out (net62)
  );
  and_cell gate28 (
    .a (net27),
    .b (net62),
    .out (net63)
  );
  and_cell gate29 (
    .a (net32),
    .b (net63),
    .out (net64)
  );
  and_cell gate30 (
    .a (net41),
    .b (net64),
    .out (net65)
  );
  and_cell gate31 (
    .a (net21),
    .b (net17),
    .out (net66)
  );
  and_cell gate32 (
    .a (net26),
    .b (net66),
    .out (net67)
  );
  and_cell gate33 (
    .a (net31),
    .b (net67),
    .out (net68)
  );
  and_cell gate34 (
    .a (net36),
    .b (net68),
    .out (net69)
  );
  and_cell gate35 (
    .a (net37),
    .b (net69),
    .out (net70)
  );
  and_cell gate36 (
    .a (net11),
    .b (net12),
    .out (net71)
  );
  and_cell gate37 (
    .a (net22),
    .b (net71),
    .out (net72)
  );
  and_cell gate38 (
    .a (net31),
    .b (net72),
    .out (net73)
  );
  and_cell gate39 (
    .a (net36),
    .b (net73),
    .out (net74)
  );
  and_cell gate40 (
    .a (net37),
    .b (net74),
    .out (net75)
  );
  mux_cell mux13 (
    .a (net76),
    .b (net45),
    .sel (net2),
    .out (net77)
  );
  mux_cell mux14 (
    .a (net77),
    .b (net50),
    .sel (net3),
    .out (net78)
  );
  mux_cell mux15 (
    .a (net78),
    .b (net55),
    .sel (net4),
    .out (net79)
  );
  mux_cell mux16 (
    .a (net79),
    .b (net60),
    .sel (net5),
    .out (net80)
  );
  mux_cell mux17 (
    .a (net80),
    .b (net65),
    .sel (net6),
    .out (net81)
  );
  mux_cell mux18 (
    .a (net81),
    .b (net70),
    .sel (net7),
    .out (net82)
  );
  mux_cell mux19 (
    .a (net82),
    .b (net75),
    .sel (net8),
    .out (net15)
  );
  dff_cell flipflop8 (
    .d (net83),
    .clk (net15),
    .q (net9),
    .notq (net83)
  );
endmodule
