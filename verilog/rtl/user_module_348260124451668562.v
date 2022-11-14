/* Automatically generated from https://wokwi.com/projects/348260124451668562 */

`default_nettype none

module user_module_348260124451668562(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5;
  wire net6;
  wire net7;
  wire net8 = 1'b1;
  wire net9 = 1'b0;
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
  wire net26 = 1'b1;
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
  wire net45 = 1'b1;
  wire net46;
  wire net47 = 1'b1;

  assign io_out[0] = net1;
  assign io_out[1] = net5;
  assign io_out[2] = net6;
  assign io_out[3] = net7;

  dff_cell flop1 (
    .d (net10),
    .clk (net1),
    .q (net11)
  );
  dff_cell flop2 (
    .d (net11),
    .clk (net1),
    .q (net12)
  );
  dff_cell flop3 (
    .d (net12),
    .clk (net1),
    .q (net13)
  );
  dff_cell flop4 (
    .d (net13),
    .clk (net1),
    .q (net14)
  );
  dff_cell flop5 (
    .d (net14),
    .clk (net1),
    .q (net15)
  );
  dff_cell flop6 (
    .d (net15),
    .clk (net1),
    .q (net16)
  );
  dff_cell flop7 (
    .d (net16),
    .clk (net1),
    .q (net17)
  );
  dff_cell flop8 (
    .d (net17),
    .clk (net1),
    .q (net18)
  );
  dff_cell flop9 (
    .d (net18),
    .clk (net1),
    .q (net19)
  );
  dff_cell flop10 (
    .d (net19),
    .clk (net1),
    .q (net20)
  );
  dff_cell flop11 (
    .d (net20),
    .clk (net1),
    .q (net21)
  );
  dff_cell flop12 (
    .d (net21),
    .clk (net1),
    .q (net22)
  );
  dff_cell flop13 (
    .d (net22),
    .clk (net1),
    .q (net23)
  );
  dff_cell flop14 (
    .d (net23),
    .clk (net1),
    .q (net24)
  );
  dff_cell flop15 (
    .d (net24),
    .clk (net1),
    .q (net5)
  );
  xor_cell xor1 (
    .a (net5),
    .b (net24),
    .out (net25)
  );
  xor_cell xor2 (
    .a (net25),
    .b (net26),
    .out (net27)
  );
  mux_cell mux1 (
    .a (net2),
    .b (net27),
    .sel (net3),
    .out (net10)
  );
  dff_cell flop16 (
    .d (net28),
    .clk (net1),
    .q (net29)
  );
  dff_cell flop17 (
    .d (net29),
    .clk (net1),
    .q (net30)
  );
  dff_cell flop18 (
    .d (net30),
    .clk (net1),
    .q (net31)
  );
  dff_cell flop19 (
    .d (net31),
    .clk (net1),
    .q (net32)
  );
  dff_cell flop20 (
    .d (net32),
    .clk (net1),
    .q (net33)
  );
  dff_cell flop21 (
    .d (net33),
    .clk (net1),
    .q (net34)
  );
  dff_cell flop22 (
    .d (net34),
    .clk (net1),
    .q (net35)
  );
  dff_cell flop23 (
    .d (net35),
    .clk (net1),
    .q (net36)
  );
  dff_cell flop24 (
    .d (net36),
    .clk (net1),
    .q (net37)
  );
  dff_cell flop25 (
    .d (net37),
    .clk (net1),
    .q (net38)
  );
  dff_cell flop26 (
    .d (net38),
    .clk (net1),
    .q (net39)
  );
  dff_cell flop27 (
    .d (net39),
    .clk (net1),
    .q (net40)
  );
  dff_cell flop28 (
    .d (net40),
    .clk (net1),
    .q (net41)
  );
  dff_cell flop29 (
    .d (net41),
    .clk (net1),
    .q (net42)
  );
  dff_cell flop30 (
    .d (net42),
    .clk (net1),
    .q (net43)
  );
  xor_cell xor3 (
    .a (net43),
    .b (net42),
    .out (net44)
  );
  xor_cell xor4 (
    .a (net44),
    .b (net45),
    .out (net7)
  );
  not_cell not1 (
    .in (net4),
    .out (net28)
  );
  xor_cell xor5 (
    .a (net7),
    .b (net28),
    .out (net46)
  );
  xor_cell xor6 (
    .a (net46),
    .b (net47),
    .out (net6)
  );
endmodule
