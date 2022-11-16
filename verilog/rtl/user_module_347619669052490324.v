/* Automatically generated from https://wokwi.com/projects/347619669052490324 */

`default_nettype none

module user_module_347619669052490324(
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
  wire net10 = 1'b0;
  wire net11 = 1'b1;
  wire net12 = 1'b1;
  wire net13;
  wire net14;
  wire net15 = 1'b1;
  wire net16;
  wire net17;
  wire net18 = 1'b1;
  wire net19;
  wire net20;
  wire net21 = 1'b1;
  wire net22;
  wire net23;
  wire net24 = 1'b1;
  wire net25;
  wire net26;
  wire net27 = 1'b0;
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
  wire net40 = 1'b0;
  wire net41;
  wire net42;
  wire net43 = 1'b1;
  wire net44;
  wire net45;
  wire net46 = 1'b0;
  wire net47;
  wire net48;
  wire net49 = 1'b1;
  wire net50;
  wire net51;
  wire net52 = 1'b1;
  wire net53;
  wire net54;
  wire net55 = 1'b1;
  wire net56;
  wire net57;
  wire net58 = 1'b1;
  wire net59 = 1'b0;
  wire net60 = 1'b0;
  wire net61 = 1'b1;
  wire net62 = 1'b0;

  assign io_out[0] = net7;
  assign io_out[5] = net8;
  assign io_out[7] = net9;

  dff_cell flop1 (
    .d (net13),
    .clk (net1),
    .q (net14)
  );
  mux_cell mux1 (
    .a (net15),
    .b (net16),
    .sel (net7),
    .out (net13)
  );
  dff_cell flop3 (
    .d (net17),
    .clk (net1),
    .q (net16)
  );
  mux_cell mux3 (
    .a (net18),
    .b (net19),
    .sel (net7),
    .out (net17)
  );
  dff_cell flop4 (
    .d (net20),
    .clk (net1),
    .q (net19)
  );
  mux_cell mux4 (
    .a (net21),
    .b (net22),
    .sel (net7),
    .out (net20)
  );
  dff_cell flop5 (
    .d (net23),
    .clk (net1),
    .q (net22)
  );
  mux_cell mux5 (
    .a (net24),
    .b (net25),
    .sel (net7),
    .out (net23)
  );
  dff_cell flop6 (
    .d (net26),
    .clk (net1),
    .q (net25)
  );
  mux_cell mux6 (
    .a (net27),
    .b (net28),
    .sel (net7),
    .out (net26)
  );
  dff_cell flop7 (
    .d (net29),
    .clk (net1),
    .q (net28)
  );
  mux_cell mux7 (
    .a (net2),
    .b (net30),
    .sel (net7),
    .out (net29)
  );
  dff_cell flop8 (
    .d (net31),
    .clk (net1),
    .q (net30)
  );
  mux_cell mux8 (
    .a (net3),
    .b (net32),
    .sel (net7),
    .out (net31)
  );
  dff_cell flop9 (
    .d (net33),
    .clk (net1),
    .q (net32)
  );
  mux_cell mux9 (
    .a (net4),
    .b (net34),
    .sel (net7),
    .out (net33)
  );
  dff_cell flop10 (
    .d (net35),
    .clk (net1),
    .q (net34)
  );
  mux_cell mux10 (
    .a (net5),
    .b (net36),
    .sel (net7),
    .out (net35)
  );
  dff_cell flop11 (
    .d (net37),
    .clk (net1),
    .q (net36)
  );
  mux_cell mux11 (
    .a (net6),
    .b (net38),
    .sel (net7),
    .out (net37)
  );
  dff_cell flop12 (
    .d (net39),
    .clk (net1),
    .q (net38)
  );
  mux_cell mux12 (
    .a (net40),
    .b (net41),
    .sel (net7),
    .out (net39)
  );
  dff_cell flop13 (
    .d (net42),
    .clk (net1),
    .q (net41)
  );
  mux_cell mux13 (
    .a (net43),
    .b (net44),
    .sel (net7),
    .out (net42)
  );
  dff_cell flop14 (
    .d (net45),
    .clk (net1),
    .q (net44)
  );
  mux_cell mux14 (
    .a (net46),
    .b (net47),
    .sel (net7),
    .out (net45)
  );
  dff_cell flop15 (
    .d (net48),
    .clk (net1),
    .q (net47)
  );
  mux_cell mux15 (
    .a (net49),
    .b (net50),
    .sel (net7),
    .out (net48)
  );
  dff_cell flop16 (
    .d (net51),
    .clk (net1),
    .q (net50)
  );
  mux_cell mux16 (
    .a (net52),
    .b (net53),
    .sel (net7),
    .out (net51)
  );
  dff_cell flop17 (
    .d (net54),
    .clk (net1),
    .q (net53)
  );
  mux_cell mux17 (
    .a (net55),
    .b (net56),
    .sel (net7),
    .out (net54)
  );
  dff_cell flop18 (
    .d (net57),
    .clk (net1),
    .q (net56)
  );
  mux_cell mux18 (
    .a (net58),
    .b (net9),
    .sel (net7),
    .out (net57)
  );
  mux_cell mux2 (
    .a (net61),
    .b (net14),
    .sel (net8),
    .out (net9)
  );
endmodule
