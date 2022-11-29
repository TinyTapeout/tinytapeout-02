/* Automatically generated from https://wokwi.com/projects/349546262775726676 */

`default_nettype none

module user_module_349546262775726676(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[4];
  wire net6 = io_in[5];
  wire net7;
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15 = 1'b0;
  wire net16 = 1'b1;
  wire net17 = 1'b1;
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

  assign io_out[0] = net7;
  assign io_out[1] = net8;
  assign io_out[2] = net9;
  assign io_out[3] = net10;
  assign io_out[4] = net11;
  assign io_out[5] = net12;
  assign io_out[6] = net13;
  assign io_out[7] = net14;

  and_cell gate1 (

  );
  or_cell gate2 (

  );
  xor_cell gate3 (

  );
  nand_cell gate4 (

  );
  not_cell gate5 (

  );
  buffer_cell gate6 (

  );
  mux_cell mux1 (

  );
  dff_cell flipflop1 (

  );
  buffer_cell gate7 (
    .in (net4),
    .out (net18)
  );
  buffer_cell gate8 (
    .in (net3),
    .out (net19)
  );
  buffer_cell gate9 (
    .in (net2),
    .out (net20)
  );
  buffer_cell gate10 (
    .in (net1),
    .out (net21)
  );
  not_cell gate11 (
    .in (net4)
  );
  not_cell gate12 (
    .in (net3),
    .out (net22)
  );
  not_cell gate13 (
    .in (net2),
    .out (net23)
  );
  not_cell gate14 (
    .in (net1),
    .out (net24)
  );
  and_cell gate15 (
    .a (net19),
    .b (net21),
    .out (net25)
  );
  and_cell gate16 (
    .a (net22),
    .b (net24),
    .out (net26)
  );
  and_cell gate17 (
    .a (net20),
    .b (net21),
    .out (net27)
  );
  and_cell gate18 (
    .a (net23),
    .b (net24),
    .out (net28)
  );
  and_cell gate19 (
    .a (net20),
    .b (net24),
    .out (net29)
  );
  and_cell gate20 (
    .a (net22),
    .b (net20),
    .out (net30)
  );
  and_cell gate21 (
    .a (net21),
    .b (net31),
    .out (net32)
  );
  and_cell gate22 (
    .a (net19),
    .b (net23),
    .out (net31)
  );
  and_cell gate23 (
    .a (net19),
    .b (net24),
    .out (net33)
  );
  or_cell gate24 (
    .a (net25),
    .b (net26),
    .out (net34)
  );
  or_cell gate25 (
    .a (net18),
    .b (net20),
    .out (net35)
  );
  or_cell gate26 (
    .a (net34),
    .b (net35),
    .out (net36)
  );
  or_cell gate27 (
    .a (net27),
    .b (net28),
    .out (net37)
  );
  or_cell gate28 (
    .a (net37),
    .b (net22),
    .out (net38)
  );
  or_cell gate29 (
    .a (net19),
    .b (net23),
    .out (net39)
  );
  or_cell gate30 (
    .a (net39),
    .b (net21),
    .out (net40)
  );
  or_cell gate31 (
    .a (net18),
    .b (net26),
    .out (net41)
  );
  or_cell gate32 (
    .a (net29),
    .b (net30),
    .out (net42)
  );
  or_cell gate33 (
    .a (net41),
    .b (net42),
    .out (net43)
  );
  or_cell gate34 (
    .a (net43),
    .b (net32),
    .out (net44)
  );
  or_cell gate35 (
    .a (net26),
    .b (net29),
    .out (net45)
  );
  or_cell gate36 (
    .a (net31),
    .b (net33),
    .out (net46)
  );
  or_cell gate37 (
    .a (net28),
    .b (net18),
    .out (net47)
  );
  or_cell gate38 (
    .a (net46),
    .b (net47),
    .out (net48)
  );
  or_cell gate39 (
    .a (net29),
    .b (net30),
    .out (net49)
  );
  or_cell gate40 (
    .a (net31),
    .b (net18),
    .out (net50)
  );
  or_cell gate41 (
    .a (net49),
    .b (net50),
    .out (net51)
  );
  buffer_cell gate42 (
    .in (net5),
    .out (net52)
  );
  xor_cell gate45 (
    .a (net52),
    .b (net53),
    .out (net14)
  );
  xor_cell gate44 (
    .a (net36),
    .b (net53),
    .out (net7)
  );
  buffer_cell gate43 (
    .in (net6),
    .out (net53)
  );
  xor_cell gate46 (
    .a (net38),
    .b (net53),
    .out (net8)
  );
  xor_cell gate47 (
    .a (net40),
    .b (net53),
    .out (net9)
  );
  xor_cell gate48 (
    .a (net44),
    .b (net53),
    .out (net10)
  );
  xor_cell gate49 (
    .a (net45),
    .b (net53),
    .out (net11)
  );
  xor_cell gate50 (
    .a (net48),
    .b (net53),
    .out (net12)
  );
  xor_cell gate51 (
    .a (net51),
    .b (net53),
    .out (net13)
  );
endmodule
