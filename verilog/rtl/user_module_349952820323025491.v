/* Automatically generated from https://wokwi.com/projects/349952820323025491 */

`default_nettype none

module user_module_349952820323025491(
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
  wire net17 = 1'b1;
  wire net18 = 1'b0;
  wire net19 = 1'b0;
  wire net20 = 1'b0;
  wire net21;
  wire net22 = 1'b0;
  wire net23;
  wire net24;
  wire net25;
  wire net26;
  wire net27;
  wire net28 = 1'b0;
  wire net29;
  wire net30;
  wire net31;
  wire net32;
  wire net33;
  wire net34 = 1'b0;
  wire net35;
  wire net36;
  wire net37;
  wire net38;
  wire net39;
  wire net40;
  wire net41 = 1'b0;
  wire net42;
  wire net43;
  wire net44;
  wire net45;
  wire net46;
  wire net47 = 1'b0;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[3] = net12;
  assign io_out[4] = net13;
  assign io_out[5] = net14;
  assign io_out[6] = net15;
  assign io_out[7] = net16;

  xor_cell gate43 (
    .a (net21),
    .b (net22),
    .out (net9)
  );
  and_cell gate44 (
    .a (net22),
    .b (net21),
    .out (net23)
  );
  or_cell gate45 (
    .a (net23),
    .b (net24),
    .out (net25)
  );
  and_cell gate46 (
    .a (net1),
    .b (net5),
    .out (net24)
  );
  xor_cell gate47 (
    .a (net1),
    .b (net5),
    .out (net21)
  );
  xor_cell gate48 (
    .a (net26),
    .b (net25),
    .out (net10)
  );
  xor_cell gate52 (
    .a (net2),
    .b (net6),
    .out (net26)
  );
  xor_cell gate7 (
    .a (net27),
    .b (net28),
    .out (net11)
  );
  and_cell gate8 (
    .a (net28),
    .b (net27),
    .out (net29)
  );
  or_cell gate9 (
    .a (net29),
    .b (net30),
    .out (net31)
  );
  and_cell gate10 (
    .a (net3),
    .b (net7),
    .out (net30)
  );
  xor_cell gate11 (
    .a (net3),
    .b (net7),
    .out (net27)
  );
  xor_cell gate12 (
    .a (net32),
    .b (net31),
    .out (net12)
  );
  xor_cell gate16 (
    .a (net4),
    .b (net8),
    .out (net32)
  );
  xor_cell gate17 (
    .a (net33),
    .b (net34),
    .out (net13)
  );
  and_cell gate18 (
    .a (net34),
    .b (net33),
    .out (net35)
  );
  or_cell gate19 (
    .a (net35),
    .b (net36),
    .out (net37)
  );
  and_cell gate20 (
    .a (net1),
    .b (net5),
    .out (net36)
  );
  xor_cell gate21 (
    .a (net1),
    .b (net5),
    .out (net33)
  );
  xor_cell gate22 (
    .a (net38),
    .b (net37),
    .out (net14)
  );
  xor_cell gate26 (
    .a (net2),
    .b (net39),
    .out (net38)
  );
  xor_cell gate27 (
    .a (net40),
    .b (net41),
    .out (net15)
  );
  and_cell gate28 (
    .a (net41),
    .b (net40),
    .out (net42)
  );
  or_cell gate29 (
    .a (net42),
    .b (net43),
    .out (net44)
  );
  and_cell gate30 (
    .a (net3),
    .b (net7),
    .out (net43)
  );
  xor_cell gate31 (
    .a (net3),
    .b (net7),
    .out (net40)
  );
  xor_cell gate32 (
    .a (net45),
    .b (net44),
    .out (net16)
  );
  xor_cell gate36 (
    .a (net4),
    .b (net46),
    .out (net45)
  );
  xor_cell gate37 (
    .a (net5),
    .b (net6),
    .out (net39)
  );
  xor_cell gate38 (
    .a (net7),
    .b (net8),
    .out (net46)
  );
endmodule
