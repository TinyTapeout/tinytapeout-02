/* Automatically generated from https://wokwi.com/projects/347417602591556180 */

`default_nettype none

module user_module_347417602591556180(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[4];
  wire net6 = io_in[7];
  wire net7;
  wire net8;
  wire net9 = 1'b0;
  wire net10 = 1'b1;
  wire net11 = 1'b1;
  wire net12;
  wire net13;
  wire net14;
  wire net15 = 1'b0;
  wire net16 = 1'b0;
  wire net17 = 1'b0;
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

  assign io_out[1] = net7;
  assign io_out[2] = net7;
  assign io_out[3] = net8;
  assign io_out[4] = net8;
  assign io_out[5] = net8;

  dff_cell flipflop1 (
    .d (net12),
    .clk (net1),
    .q (net13)
  );
  dff_cell flipflop2 (
    .d (net14),
    .clk (net1),
    .q (net7)
  );
  or_cell gate1 (
    .a (net13),
    .b (net7),
    .out (net8)
  );
  and_cell gate2 (
    .a (net18),
    .b (net19),
    .out (net20)
  );
  and_cell gate3 (
    .a (net20),
    .b (net13),
    .out (net21)
  );
  or_cell gate4 (
    .a (net21),
    .b (net22),
    .out (net23)
  );
  or_cell gate5 (
    .a (net23),
    .b (net24),
    .out (net25)
  );
  and_cell gate6 (
    .a (net18),
    .b (net26),
    .out (net27)
  );
  and_cell gate7 (
    .a (net27),
    .b (net13),
    .out (net22)
  );
  and_cell gate8 (
    .a (net18),
    .b (net28),
    .out (net29)
  );
  and_cell gate9 (
    .a (net29),
    .b (net13),
    .out (net24)
  );
  not_cell not1 (
    .in (net30),
    .out (net18)
  );
  buffer_cell not2 (
    .in (net31),
    .out (net26)
  );
  buffer_cell not3 (
    .in (net32),
    .out (net28)
  );
  or_cell gate10 (
    .a (net30),
    .b (net25),
    .out (net12)
  );
  and_cell gate11 (
    .a (net13),
    .b (net18),
    .out (net33)
  );
  and_cell gate12 (
    .a (net33),
    .b (net34),
    .out (net35)
  );
  and_cell gate13 (
    .a (net35),
    .b (net36),
    .out (net37)
  );
  and_cell gate14 (
    .a (net18),
    .b (net7),
    .out (net38)
  );
  or_cell gate15 (
    .a (net39),
    .b (net38),
    .out (net14)
  );
  and_cell gate16 (
    .a (net37),
    .b (net40),
    .out (net39)
  );
  buffer_cell not4 (
    .in (net41),
    .out (net40)
  );
  buffer_cell gate17 (
    .in (net2),
    .out (net30)
  );
  buffer_cell gate21 (
    .in (net42),
    .out (net19)
  );
  buffer_cell gate22 (
    .in (net43),
    .out (net36)
  );
  buffer_cell gate23 (
    .in (net44),
    .out (net34)
  );
  not_cell gate27 (
    .in (net4),
    .out (net45)
  );
  buffer_cell not8 (
    .in (net4),
    .out (net46)
  );
  mux_cell mux7 (
    .a (net46),
    .b (net45),
    .sel (net47),
    .out (net31)
  );
  mux_cell mux8 (
    .a (net45),
    .b (net46),
    .sel (net47),
    .out (net44)
  );
  dff_cell flipflop4 (
    .d (net4),
    .clk (net6),
    .q (net47)
  );
  not_cell gate18 (
    .in (net3),
    .out (net48)
  );
  buffer_cell not9 (
    .in (net3),
    .out (net49)
  );
  mux_cell mux9 (
    .a (net49),
    .b (net48),
    .sel (net50),
    .out (net42)
  );
  mux_cell mux10 (
    .a (net48),
    .b (net49),
    .sel (net50),
    .out (net41)
  );
  dff_cell flipflop5 (
    .d (net3),
    .clk (net6),
    .q (net50)
  );
  not_cell gate28 (
    .in (net5),
    .out (net51)
  );
  buffer_cell not10 (
    .in (net5),
    .out (net52)
  );
  mux_cell mux11 (
    .a (net52),
    .b (net51),
    .sel (net53),
    .out (net32)
  );
  mux_cell mux12 (
    .a (net51),
    .b (net52),
    .sel (net53),
    .out (net43)
  );
  dff_cell flipflop6 (
    .d (net5),
    .clk (net6),
    .q (net53)
  );
endmodule
