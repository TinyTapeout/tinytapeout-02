/* Automatically generated from https://wokwi.com/projects/342981109408072274 */

`default_nettype none

module user_module_342981109408072274(
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
  wire net13;
  wire net14;
  wire net15;
  wire net16;
  wire net17;
  wire net18;
  wire net19 = 1'b0;
  wire net20 = 1'b1;
  wire net21 = 1'b1;
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
  wire net33 = 1'b0;
  wire net34;
  wire net35;
  wire net36;
  wire net37;
  wire net38;
  wire net39;
  wire net40;
  wire net41 = 1'b0;
  wire net42;
  wire net43 = 1'b0;
  wire net44 = 1'b0;
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

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[3] = net12;
  assign io_out[4] = net13;
  assign io_out[5] = net14;
  assign io_out[6] = net15;
  assign io_out[7] = net16;

  not_cell not3 (
    .in (net17),
    .out (net18)
  );
  and_cell gate1 (

  );
  or_cell gate2 (
    .a (net22),
    .b (net23),
    .out (net17)
  );
  xor_cell gate3 (

  );
  mux_cell mux1 (
    .a (net19),
    .b (net18),
    .sel (net3),
    .out (net24)
  );
  dff_cell flipflop1 (
    .d (net24),
    .clk (net25),
    .q (net22),
    .notq (net26)
  );
  xor_cell gate7 (

  );
  and_cell gate4 (

  );
  xor_cell gate5 (

  );
  dff_cell flipflop2 (
    .d (net22),
    .clk (net25),
    .q (net23)
  );
  dff_cell flipflop3 (
    .d (net23),
    .clk (net25),
    .q (net27)
  );
  dff_cell flipflop4 (
    .d (net27),
    .clk (net25),
    .q (net28)
  );
  dff_cell flipflop5 (
    .d (net28),
    .clk (net25),
    .q (net29)
  );
  dff_cell flipflop6 (
    .d (net29),
    .clk (net25),
    .q (net30)
  );
  dff_cell flipflop7 (
    .d (net30),
    .clk (net25),
    .q (net31)
  );
  dff_cell flipflop8 (
    .d (net31),
    .clk (net25),
    .q (net32)
  );
  mux_cell mux2 (
    .a (net33),
    .b (net26),
    .sel (net2),
    .out (net24)
  );
  or_cell gate8 (
    .a (net28),
    .b (net34),
    .out (net35)
  );
  or_cell gate9 (

  );
  or_cell gate10 (
    .a (net32),
    .b (net36),
    .out (net37)
  );
  or_cell gate11 (
    .a (net31),
    .b (net38),
    .out (net36)
  );
  or_cell gate13 (
    .a (net27),
    .b (net17),
    .out (net34)
  );
  or_cell gate14 (
    .a (net30),
    .b (net39),
    .out (net38)
  );
  or_cell gate15 (
    .a (net29),
    .b (net35),
    .out (net39)
  );
  not_cell not1 (
    .in (net37),
    .out (net40)
  );
  mux_cell mux3 (
    .a (net41),
    .b (net40),
    .sel (net5),
    .out (net24)
  );
  not_cell not2 (
    .in (net34),
    .out (net42)
  );
  mux_cell mux4 (
    .a (net43),
    .b (net42),
    .sel (net4),
    .out (net24)
  );
  mux_cell mux5 (
    .a (net22),
    .b (net32),
    .sel (net45),
    .out (net9)
  );
  mux_cell mux6 (
    .a (net32),
    .b (net22),
    .sel (net45),
    .out (net16)
  );
  mux_cell mux7 (
    .a (net23),
    .b (net31),
    .sel (net45),
    .out (net10)
  );
  mux_cell mux8 (
    .a (net27),
    .b (net30),
    .sel (net45),
    .out (net11)
  );
  mux_cell mux9 (
    .a (net28),
    .b (net29),
    .sel (net45),
    .out (net12)
  );
  mux_cell mux10 (
    .a (net29),
    .b (net28),
    .sel (net45),
    .out (net13)
  );
  mux_cell mux11 (
    .a (net30),
    .b (net27),
    .sel (net45),
    .out (net14)
  );
  mux_cell mux12 (
    .a (net31),
    .b (net23),
    .sel (net45),
    .out (net15)
  );
  dff_cell flipflop9 (
    .d (net46),
    .clk (net40),
    .q (net47),
    .notq (net46)
  );
  mux_cell mux13 (
    .a (net47),
    .b (net6),
    .sel (net7),
    .out (net45)
  );
  dff_cell flipflop10 (
    .d (net48),
    .clk (net1),
    .notq (net48)
  );
  dff_cell flipflop11 (
    .d (net49),
    .clk (net48),
    .notq (net49)
  );
  dff_cell flipflop12 (
    .d (net50),
    .clk (net49),
    .notq (net50)
  );
  dff_cell flipflop13 (
    .d (net51),
    .clk (net50),
    .notq (net51)
  );
  dff_cell flipflop14 (
    .d (net52),
    .clk (net51),
    .notq (net52)
  );
  dff_cell flipflop15 (
    .d (net53),
    .clk (net52),
    .notq (net53)
  );
  dff_cell flipflop16 (
    .d (net54),
    .clk (net53),
    .notq (net54)
  );
  dff_cell flipflop17 (
    .d (net55),
    .clk (net54),
    .notq (net55)
  );
  dff_cell flipflop18 (
    .d (net56),
    .clk (net55),
    .notq (net56)
  );
  dff_cell flipflop19 (
    .d (net57),
    .clk (net56),
    .notq (net57)
  );
  mux_cell mux14 (
    .a (net1),
    .b (net58),
    .sel (net8),
    .out (net25)
  );
  dff_cell flipflop20 (
    .d (net58),
    .clk (net57),
    .notq (net58)
  );
endmodule
