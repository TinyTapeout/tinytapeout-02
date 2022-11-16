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
  wire net10;
  wire net11 = 1'b0;
  wire net12 = 1'b1;
  wire net13 = 1'b1;
  wire net14 = 1'b0;
  wire net15;
  wire net16;
  wire net17;
  wire net18 = 1'b1;
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

  assign io_out[0] = net4;
  assign io_out[1] = net5;
  assign io_out[2] = net6;
  assign io_out[3] = net7;
  assign io_out[4] = net8;
  assign io_out[5] = net9;
  assign io_out[7] = net10;

  mux_cell mux1 (
    .a (net14),
    .b (net15),
    .sel (net16),
    .out (net17)
  );
  mux_cell mux2 (
    .a (net14),
    .b (net19),
    .sel (net16),
    .out (net20)
  );
  mux_cell mux3 (
    .a (net14),
    .b (net21),
    .sel (net16),
    .out (net22)
  );
  mux_cell mux4 (
    .a (net14),
    .b (net23),
    .sel (net16),
    .out (net24)
  );
  mux_cell mux5 (
    .a (net14),
    .b (net25),
    .sel (net16),
    .out (net26)
  );
  mux_cell mux6 (
    .a (net18),
    .b (net27),
    .sel (net16),
    .out (net28)
  );
  dff_cell flop3 (
    .d (net17),
    .clk (net29),
    .q (net19)
  );
  dff_cell flop4 (
    .d (net20),
    .clk (net29),
    .q (net21)
  );
  dff_cell flop5 (
    .d (net22),
    .clk (net29),
    .q (net23)
  );
  dff_cell flop6 (
    .d (net24),
    .clk (net29),
    .q (net25)
  );
  dff_cell flop7 (
    .d (net26),
    .clk (net29),
    .q (net27)
  );
  dff_cell flop8 (
    .d (net28),
    .clk (net29),
    .q (net15)
  );
  dff_cell flop2 (
    .d (net30),
    .clk (net31),
    .notq (net30)
  );
  dff_cell flop9 (
    .d (net32),
    .clk (net30),
    .notq (net32)
  );
  dff_cell flop10 (
    .d (net33),
    .clk (net32),
    .notq (net33)
  );
  dff_cell flop11 (
    .d (net34),
    .clk (net33),
    .notq (net34)
  );
  dff_cell flop12 (
    .d (net35),
    .clk (net34),
    .notq (net35)
  );
  dff_cell flop13 (
    .d (net36),
    .clk (net35),
    .notq (net36)
  );
  dff_cell flop14 (
    .d (net37),
    .clk (net36),
    .notq (net37)
  );
  dff_cell flop15 (
    .d (net38),
    .clk (net37),
    .notq (net38)
  );
  dff_cell flop16 (
    .d (net39),
    .clk (net38),
    .notq (net39)
  );
  dff_cell flop17 (
    .d (net40),
    .clk (net39),
    .q (net41),
    .notq (net40)
  );
  mux_cell mux7 (
    .a (net41),
    .b (net42),
    .sel (net43),
    .out (net44)
  );
  dff_cell flop18 (
    .d (net31),
    .clk (net42),
    .notq (net31)
  );
  buffer_cell gate1 (
    .in (net1),
    .out (net42)
  );
  buffer_cell gate2 (
    .in (net2),
    .out (net16)
  );
  buffer_cell gate3 (
    .in (net3),
    .out (net43)
  );
  buffer_cell gate4 (
    .in (net19),
    .out (net4)
  );
  buffer_cell gate5 (
    .in (net21),
    .out (net5)
  );
  buffer_cell gate6 (
    .in (net23),
    .out (net6)
  );
  buffer_cell gate7 (
    .in (net25),
    .out (net7)
  );
  buffer_cell gate8 (
    .in (net27),
    .out (net8)
  );
  buffer_cell gate9 (
    .in (net15),
    .out (net9)
  );
  buffer_cell gate10 (
    .in (net44),
    .out (net29)
  );
  buffer_cell gate11 (
    .in (net29),
    .out (net10)
  );
endmodule
