/* Automatically generated from https://wokwi.com/projects/347497504164545108 */

`default_nettype none

module user_module_347497504164545108(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[3];
  wire net4 = io_in[4];
  wire net5 = io_in[5];
  wire net6 = io_in[6];
  wire net7 = io_in[7];
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
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
  wire net32 = 1'b1;
  wire net33 = 1'b1;
  wire net34 = 1'b0;
  wire net35 = 1'b0;
  wire net36;
  wire net37;
  wire net38;
  wire net39 = 1'b0;
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
  wire net52 = 1'b0;
  wire net53;
  wire net54;
  wire net55;
  wire net56;
  wire net57;
  wire net58;
  wire net59;
  wire net60;
  wire net61 = 1'b0;
  wire net62;
  wire net63;
  wire net64;
  wire net65;
  wire net66;
  wire net67;
  wire net68;
  wire net69;
  wire net70;
  wire net71 = 1'b0;
  wire net72 = 1'b0;
  wire net73;
  wire net74;
  wire net75;
  wire net76;
  wire net77 = 1'b0;
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
  wire net99 = 1'b0;
  wire net100 = 1'b0;

  assign io_out[0] = net8;
  assign io_out[1] = net9;
  assign io_out[2] = net10;
  assign io_out[3] = net11;
  assign io_out[4] = net12;
  assign io_out[5] = net13;
  assign io_out[6] = net14;

  buffer_cell gate53 (
    .in (net15),
    .out (net16)
  );
  not_cell gate54 (
    .in (net15),
    .out (net17)
  );
  not_cell gate55 (
    .in (net18),
    .out (net19)
  );
  buffer_cell gate56 (
    .in (net18),
    .out (net20)
  );
  not_cell gate57 (
    .in (net21),
    .out (net22)
  );
  not_cell gate58 (
    .in (net23),
    .out (net24)
  );
  buffer_cell gate59 (
    .in (net21),
    .out (net25)
  );
  buffer_cell gate60 (
    .in (net23),
    .out (net26)
  );
  and_cell gate61 (
    .a (net17),
    .b (net20),
    .out (net27)
  );
  and_cell gate74 (
    .a (net27),
    .b (net25),
    .out (net28)
  );
  or_cell gate75 (
    .a (net28),
    .b (net29),
    .out (net8)
  );
  and_cell gate76 (
    .a (net16),
    .b (net19),
    .out (net30)
  );
  and_cell gate77 (
    .a (net30),
    .b (net22),
    .out (net31)
  );
  and_cell gate78 (
    .a (net31),
    .b (net24),
    .out (net29)
  );
  or_cell gate79 (
    .a (net28),
    .b (net36),
    .out (net37)
  );
  or_cell gate80 (
    .a (net37),
    .b (net29),
    .out (net9)
  );
  and_cell gate81 (
    .a (net17),
    .b (net25),
    .out (net38)
  );
  and_cell gate82 (
    .a (net38),
    .b (net26),
    .out (net36)
  );
  or_cell gate83 (
    .a (net41),
    .b (net42),
    .out (net43)
  );
  or_cell gate84 (
    .a (net43),
    .b (net44),
    .out (net45)
  );
  and_cell gate87 (
    .a (net17),
    .b (net19),
    .out (net46)
  );
  and_cell gate88 (
    .a (net46),
    .b (net25),
    .out (net41)
  );
  and_cell gate89 (
    .a (net19),
    .b (net25),
    .out (net47)
  );
  and_cell gate90 (
    .a (net47),
    .b (net24),
    .out (net42)
  );
  and_cell gate91 (
    .a (net24),
    .b (net25),
    .out (net48)
  );
  and_cell gate92 (
    .a (net48),
    .b (net17),
    .out (net44)
  );
  and_cell gate93 (
    .a (net16),
    .b (net49),
    .out (net50)
  );
  and_cell gate85 (
    .a (net19),
    .b (net51),
    .out (net49)
  );
  and_cell gate86 (
    .a (net22),
    .b (net26),
    .out (net51)
  );
  or_cell gate94 (
    .a (net45),
    .b (net50),
    .out (net10)
  );
  xor_cell gate95 (
    .a (net25),
    .b (net26),
    .out (net53)
  );
  and_cell gate96 (
    .a (net17),
    .b (net54),
    .out (net55)
  );
  and_cell gate97 (
    .a (net20),
    .b (net56),
    .out (net54)
  );
  and_cell gate98 (
    .a (net22),
    .b (net26),
    .out (net56)
  );
  and_cell gate99 (
    .a (net16),
    .b (net19),
    .out (net57)
  );
  and_cell gate100 (
    .a (net58),
    .b (net19),
    .out (net59)
  );
  not_cell gate101 (
    .in (net53),
    .out (net58)
  );
  or_cell gate102 (
    .a (net57),
    .b (net59),
    .out (net60)
  );
  or_cell gate103 (
    .a (net60),
    .b (net55),
    .out (net11)
  );
  and_cell gate104 (
    .a (net16),
    .b (net19),
    .out (net62)
  );
  and_cell gate105 (
    .a (net19),
    .b (net22),
    .out (net63)
  );
  and_cell gate106 (
    .a (net17),
    .b (net20),
    .out (net64)
  );
  or_cell gate107 (
    .a (net25),
    .b (net26),
    .out (net65)
  );
  and_cell gate108 (
    .a (net17),
    .b (net66),
    .out (net67)
  );
  and_cell gate109 (
    .a (net25),
    .b (net24),
    .out (net66)
  );
  or_cell gate110 (
    .a (net62),
    .b (net63),
    .out (net68)
  );
  or_cell gate111 (
    .a (net68),
    .b (net69),
    .out (net70)
  );
  or_cell gate112 (
    .a (net70),
    .b (net67),
    .out (net12)
  );
  and_cell gate113 (
    .a (net64),
    .b (net65),
    .out (net69)
  );
  or_cell gate114 (
    .a (net59),
    .b (net69),
    .out (net13)
  );
  or_cell gate115 (
    .a (net73),
    .b (net74),
    .out (net75)
  );
  or_cell gate116 (
    .a (net75),
    .b (net76),
    .out (net14)
  );
  and_cell gate118 (
    .a (net17),
    .b (net25),
    .out (net73)
  );
  and_cell gate119 (
    .a (net78),
    .b (net26),
    .out (net74)
  );
  xor_cell gate120 (
    .a (net16),
    .b (net20),
    .out (net78)
  );
  and_cell gate117 (
    .a (net19),
    .b (net79),
    .out (net76)
  );
  and_cell gate121 (
    .a (net22),
    .b (net24),
    .out (net79)
  );
  dff_cell flipflop4 (
    .d (net80),
    .clk (net1),
    .q (net81),
    .notq (net82)
  );
  or_cell gate2 (
    .a (net82),
    .b (net83),
    .out (net80)
  );
  dff_cell flipflop7 (
    .d (net84),
    .clk (net85),
    .q (net86),
    .notq (net87)
  );
  or_cell gate3 (
    .a (net87),
    .b (net83),
    .out (net84)
  );
  dff_cell flipflop8 (
    .d (net88),
    .clk (net89),
    .q (net90),
    .notq (net91)
  );
  or_cell gate4 (
    .a (net91),
    .b (net83),
    .out (net88)
  );
  dff_cell flipflop9 (
    .d (net92),
    .clk (net93),
    .notq (net94)
  );
  or_cell gate5 (
    .a (net94),
    .b (net83),
    .out (net92)
  );
  dff_cell flipflop10 (
    .d (net95),
    .clk (net1),
    .q (net83)
  );
  or_cell gate6 (
    .a (net96),
    .b (net2),
    .out (net95)
  );
  mux_cell mux1 (
    .a (net81),
    .b (net1),
    .sel (net83),
    .out (net85)
  );
  mux_cell mux5 (
    .a (net86),
    .b (net1),
    .sel (net83),
    .out (net89)
  );
  mux_cell mux6 (
    .a (net90),
    .b (net1),
    .sel (net83),
    .out (net93)
  );
  and_cell gate17 (
    .a (net90),
    .b (net94),
    .out (net97)
  );
  and_cell gate18 (
    .a (net87),
    .b (net97),
    .out (net98)
  );
  and_cell gate19 (
    .a (net81),
    .b (net98),
    .out (net96)
  );
  mux_cell mux2 (
    .a (net94),
    .b (net4),
    .sel (net3),
    .out (net15)
  );
  mux_cell mux3 (
    .a (net91),
    .b (net5),
    .sel (net3),
    .out (net18)
  );
  mux_cell mux4 (
    .a (net87),
    .b (net6),
    .sel (net3),
    .out (net21)
  );
  mux_cell mux7 (
    .a (net82),
    .b (net7),
    .sel (net3),
    .out (net23)
  );
endmodule
