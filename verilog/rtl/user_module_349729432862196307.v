/* Automatically generated from https://wokwi.com/projects/349729432862196307 */

`default_nettype none

module user_module_349729432862196307(
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
  wire net11 = 1'b0;
  wire net12 = 1'b1;
  wire net13 = 1'b1;
  wire net14;
  wire net15 = 1'b0;
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
  wire net29 = 1'b0;
  wire net30 = 1'b0;
  wire net31 = 1'b0;
  wire net32 = 1'b0;
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
  wire net51 = 1'b0;
  wire net52 = 1'b0;
  wire net53 = 1'b0;
  wire net54;
  wire net55;
  wire net56;
  wire net57;
  wire net58;
  wire net59;
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
  wire net73;
  wire net74 = 1'b0;
  wire net75 = 1'b0;
  wire net76;
  wire net77;
  wire net78;
  wire net79 = 1'b0;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net10;
  assign io_out[3] = net9;
  assign io_out[4] = net9;
  assign io_out[5] = net9;
  assign io_out[7] = net1;

  or_cell gate2 (
    .a (net14),
    .b (net15),
    .out (net9)
  );
  xor_cell gate3 (

  );
  nand_cell gate4 (

  );
  buffer_cell gate6 (

  );
  dff_cell flipflop1 (
    .d (net16),
    .clk (net1),
    .q (net17),
    .notq (net18)
  );
  dff_cell flipflop2 (
    .d (net8),
    .clk (net19),
    .q (net20)
  );
  mux_cell mux3 (
    .a (net20),
    .b (net7),
    .sel (net2),
    .out (net21)
  );
  dff_cell flipflop3 (
    .d (net21),
    .clk (net19),
    .q (net22)
  );
  mux_cell mux4 (
    .a (net22),
    .b (net6),
    .sel (net2),
    .out (net23)
  );
  dff_cell flipflop4 (
    .d (net23),
    .clk (net19),
    .q (net24)
  );
  mux_cell mux5 (
    .a (net24),
    .b (net5),
    .sel (net2),
    .out (net25)
  );
  dff_cell flipflop5 (
    .d (net25),
    .clk (net19),
    .q (net26)
  );
  mux_cell mux6 (
    .a (net26),
    .b (net4),
    .sel (net2),
    .out (net27)
  );
  dff_cell flipflop6 (
    .d (net27),
    .clk (net19),
    .q (net28)
  );
  dff_cell flipflop8 (
    .d (net34),
    .clk (net19),
    .q (net35)
  );
  dff_cell flipflop9 (
    .d (net36),
    .clk (net19),
    .q (net37)
  );
  dff_cell flipflop10 (
    .d (net38),
    .clk (net19),
    .q (net39)
  );
  dff_cell flipflop11 (
    .d (net40),
    .clk (net19),
    .q (net41)
  );
  dff_cell flipflop12 (
    .d (net42),
    .clk (net19),
    .q (net43)
  );
  dff_cell flipflop13 (
    .d (net44),
    .clk (net19),
    .q (net45)
  );
  not_cell not1 (
    .in (net46),
    .out (net47)
  );
  mux_cell mux1 (
    .a (net48),
    .b (net47),
    .sel (net49),
    .out (net50)
  );
  not_cell not3 (
    .in (net50),
    .out (net14)
  );
  xor_cell gate15 (
    .a (net34),
    .b (net35),
    .out (net54)
  );
  xor_cell gate19 (
    .a (net54),
    .b (net37),
    .out (net55)
  );
  xor_cell gate20 (
    .a (net55),
    .b (net39),
    .out (net56)
  );
  xor_cell gate21 (
    .a (net56),
    .b (net45),
    .out (net48)
  );
  xor_cell gate22 (
    .a (net37),
    .b (net34),
    .out (net57)
  );
  xor_cell gate23 (
    .a (net39),
    .b (net57),
    .out (net58)
  );
  xor_cell gate24 (
    .a (net43),
    .b (net58),
    .out (net59)
  );
  xor_cell gate25 (
    .a (net45),
    .b (net59),
    .out (net46)
  );
  mux_cell mux8 (
    .a (net35),
    .b (net65),
    .sel (net2),
    .out (net36)
  );
  mux_cell mux9 (
    .a (net37),
    .b (net66),
    .sel (net2),
    .out (net38)
  );
  mux_cell mux10 (
    .a (net39),
    .b (net67),
    .sel (net2),
    .out (net40)
  );
  mux_cell mux11 (
    .a (net41),
    .b (net68),
    .sel (net2),
    .out (net42)
  );
  mux_cell mux12 (
    .a (net43),
    .b (net69),
    .sel (net2),
    .out (net44)
  );
  mux_cell mux7 (
    .a (net73),
    .b (net71),
    .sel (net2),
    .out (net34)
  );
  mux_cell mux14 (
    .a (net17),
    .b (net1),
    .sel (net2),
    .out (net19)
  );
  mux_cell mux2 (
    .a (net18),
    .b (net75),
    .sel (net2),
    .out (net16)
  );
  not_cell not2 (
    .in (net19),
    .out (net49)
  );
  mux_cell mux15 (
    .a (net28),
    .b (net3),
    .sel (net2),
    .out (net76)
  );
  dff_cell flipflop7 (
    .d (net76),
    .clk (net19),
    .q (net77)
  );
  dff_cell flipflop14 (
    .d (net78),
    .clk (net19),
    .q (net73)
  );
  mux_cell mux16 (
    .a (net77),
    .b (net79),
    .sel (net2),
    .out (net78)
  );
endmodule
