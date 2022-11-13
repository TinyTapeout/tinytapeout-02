/* Automatically generated from https://wokwi.com/projects/348121131386929746 */

`default_nettype none

module user_module_348121131386929746(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4;
  wire net5;
  wire net6;
  wire net7;
  wire net8;
  wire net9;
  wire net10 = 1'b0;
  wire net11 = 1'b1;
  wire net12 = 1'b1;
  wire net13 = 1'b0;
  wire net14;
  wire net15 = 1'b1;
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

  assign io_out[0] = net4;
  assign io_out[1] = net5;
  assign io_out[2] = net6;
  assign io_out[3] = net7;
  assign io_out[4] = net8;
  assign io_out[5] = net9;

  mux_cell mux1 (
    .a (net13),
    .b (net9),
    .sel (net2),
    .out (net14)
  );
  mux_cell mux2 (
    .a (net13),
    .b (net4),
    .sel (net2),
    .out (net16)
  );
  mux_cell mux3 (
    .a (net13),
    .b (net5),
    .sel (net2),
    .out (net17)
  );
  mux_cell mux4 (
    .a (net13),
    .b (net6),
    .sel (net2),
    .out (net18)
  );
  mux_cell mux5 (
    .a (net13),
    .b (net7),
    .sel (net2),
    .out (net19)
  );
  mux_cell mux6 (
    .a (net15),
    .b (net8),
    .sel (net2),
    .out (net20)
  );
  dff_cell flop3 (
    .d (net14),
    .clk (net21),
    .q (net4)
  );
  dff_cell flop4 (
    .d (net16),
    .clk (net21),
    .q (net5)
  );
  dff_cell flop5 (
    .d (net17),
    .clk (net21),
    .q (net6)
  );
  dff_cell flop6 (
    .d (net18),
    .clk (net21),
    .q (net7)
  );
  dff_cell flop7 (
    .d (net19),
    .clk (net21),
    .q (net8)
  );
  dff_cell flop8 (
    .d (net20),
    .clk (net21),
    .q (net9)
  );
  dff_cell flop2 (
    .d (net22),
    .clk (net23),
    .notq (net22)
  );
  dff_cell flop9 (
    .d (net24),
    .clk (net22),
    .notq (net24)
  );
  dff_cell flop10 (
    .d (net25),
    .clk (net24),
    .notq (net25)
  );
  dff_cell flop11 (
    .d (net26),
    .clk (net25),
    .notq (net26)
  );
  dff_cell flop12 (
    .d (net27),
    .clk (net26),
    .notq (net27)
  );
  dff_cell flop13 (
    .d (net28),
    .clk (net27),
    .notq (net28)
  );
  dff_cell flop14 (
    .d (net29),
    .clk (net28),
    .notq (net29)
  );
  dff_cell flop15 (
    .d (net30),
    .clk (net29),
    .notq (net30)
  );
  dff_cell flop16 (
    .d (net31),
    .clk (net30),
    .notq (net31)
  );
  dff_cell flop17 (
    .d (net32),
    .clk (net31),
    .q (net33),
    .notq (net32)
  );
  mux_cell mux7 (
    .a (net33),
    .b (net1),
    .sel (net3),
    .out (net21)
  );
  dff_cell flop18 (
    .d (net23),
    .clk (net1),
    .notq (net23)
  );
endmodule
