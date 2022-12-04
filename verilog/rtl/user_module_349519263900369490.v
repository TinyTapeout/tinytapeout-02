/* Automatically generated from https://wokwi.com/projects/349519263900369490 */

`default_nettype none

module user_module_349519263900369490(
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
  wire net8;
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13 = 1'b0;
  wire net14 = 1'b1;
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
  wire net54;
  wire net55;
  wire net56;
  wire net57;
  wire net58;
  wire net59;
  wire net60;
  wire net61;
  wire net62;
  wire net63;
  wire net64;
  wire net65;
  wire net66;
  wire net67;
  wire net68;
  wire net69;
  wire net70;
  wire net71;
  wire net72;
  wire net73;
  wire net74;
  wire net75;
  wire net76;
  wire net77;
  wire net78;
  wire net79;
  wire net80;
  wire net81;
  wire net82;
  wire net83;
  wire net84;
  wire net85;
  wire net86;

  assign io_out[0] = net5;
  assign io_out[1] = net6;
  assign io_out[2] = net7;
  assign io_out[3] = net8;
  assign io_out[4] = net9;
  assign io_out[5] = net10;
  assign io_out[6] = net11;
  assign io_out[7] = net12;

  not_cell gate7 (
    .in (net1),
    .out (net15)
  );
  not_cell gate8 (
    .in (net2),
    .out (net16)
  );
  not_cell gate9 (
    .in (net3),
    .out (net17)
  );
  not_cell gate10 (
    .in (net4),
    .out (net18)
  );
  and_cell gate11 (
    .a (net15),
    .b (net2),
    .out (net19)
  );
  and_cell gate14 (
    .a (net17),
    .b (net19),
    .out (net20)
  );
  and_cell gate12 (
    .a (net17),
    .b (net18),
    .out (net21)
  );
  and_cell gate15 (
    .a (net2),
    .b (net18),
    .out (net22)
  );
  and_cell gate16 (
    .a (net1),
    .b (net16),
    .out (net23)
  );
  and_cell gate17 (
    .a (net1),
    .b (net3),
    .out (net24)
  );
  or_cell gate18 (
    .a (net20),
    .b (net21),
    .out (net25)
  );
  or_cell gate19 (
    .a (net22),
    .b (net23),
    .out (net26)
  );
  or_cell gate20 (
    .a (net25),
    .b (net27),
    .out (net10)
  );
  or_cell gate21 (
    .a (net26),
    .b (net24),
    .out (net27)
  );
  and_cell gate22 (
    .a (net1),
    .b (net16),
    .out (net28)
  );
  and_cell gate23 (
    .a (net17),
    .b (net28),
    .out (net29)
  );
  and_cell gate24 (
    .a (net15),
    .b (net2),
    .out (net30)
  );
  and_cell gate25 (
    .a (net30),
    .b (net4),
    .out (net31)
  );
  and_cell gate26 (
    .a (net1),
    .b (net18),
    .out (net32)
  );
  and_cell gate27 (
    .a (net15),
    .b (net3),
    .out (net33)
  );
  and_cell gate28 (
    .a (net2),
    .b (net3),
    .out (net34)
  );
  and_cell gate29 (
    .a (net16),
    .b (net18),
    .out (net35)
  );
  or_cell gate30 (
    .a (net29),
    .b (net31),
    .out (net36)
  );
  or_cell gate31 (
    .a (net32),
    .b (net33),
    .out (net37)
  );
  or_cell gate32 (
    .a (net34),
    .b (net35),
    .out (net38)
  );
  or_cell gate33 (
    .a (net36),
    .b (net37),
    .out (net39)
  );
  or_cell gate34 (
    .a (net39),
    .b (net38),
    .out (net5)
  );
  and_cell gate13 (
    .a (net15),
    .b (net17),
    .out (net40)
  );
  and_cell gate35 (
    .a (net18),
    .b (net40),
    .out (net41)
  );
  and_cell gate36 (
    .a (net15),
    .b (net3),
    .out (net42)
  );
  and_cell gate37 (
    .a (net4),
    .b (net42),
    .out (net43)
  );
  and_cell gate38 (
    .a (net1),
    .b (net17),
    .out (net44)
  );
  and_cell gate39 (
    .a (net4),
    .b (net44),
    .out (net45)
  );
  and_cell gate40 (
    .a (net16),
    .b (net17),
    .out (net46)
  );
  and_cell gate41 (
    .a (net16),
    .b (net18),
    .out (net47)
  );
  or_cell gate42 (
    .a (net41),
    .b (net43),
    .out (net48)
  );
  or_cell gate43 (
    .a (net45),
    .b (net46),
    .out (net49)
  );
  or_cell gate44 (
    .a (net48),
    .b (net49),
    .out (net50)
  );
  or_cell gate45 (
    .a (net50),
    .b (net47),
    .out (net6)
  );
  and_cell gate46 (
    .a (net15),
    .b (net17),
    .out (net51)
  );
  and_cell gate47 (
    .a (net15),
    .b (net4),
    .out (net52)
  );
  and_cell gate48 (
    .a (net17),
    .b (net4),
    .out (net53)
  );
  and_cell gate49 (
    .a (net15),
    .b (net2),
    .out (net54)
  );
  and_cell gate50 (
    .a (net1),
    .b (net16),
    .out (net55)
  );
  or_cell gate51 (
    .a (net51),
    .b (net52),
    .out (net56)
  );
  or_cell gate52 (
    .a (net53),
    .b (net54),
    .out (net57)
  );
  or_cell gate53 (
    .a (net58),
    .b (net55),
    .out (net7)
  );
  or_cell gate54 (
    .a (net56),
    .b (net57),
    .out (net58)
  );
  and_cell gate55 (
    .a (net15),
    .b (net16),
    .out (net59)
  );
  and_cell gate56 (
    .a (net59),
    .b (net18),
    .out (net60)
  );
  and_cell gate57 (
    .a (net16),
    .b (net3),
    .out (net61)
  );
  and_cell gate58 (
    .a (net61),
    .b (net4),
    .out (net62)
  );
  and_cell gate59 (
    .a (net2),
    .b (net17),
    .out (net63)
  );
  and_cell gate60 (
    .a (net63),
    .b (net4),
    .out (net64)
  );
  and_cell gate61 (
    .a (net2),
    .b (net3),
    .out (net65)
  );
  and_cell gate62 (
    .a (net65),
    .b (net18),
    .out (net66)
  );
  and_cell gate63 (
    .a (net1),
    .b (net17),
    .out (net67)
  );
  or_cell gate64 (
    .a (net60),
    .b (net62),
    .out (net68)
  );
  or_cell gate65 (
    .a (net68),
    .b (net69),
    .out (net70)
  );
  or_cell gate66 (
    .a (net64),
    .b (net66),
    .out (net69)
  );
  or_cell gate68 (
    .a (net70),
    .b (net67),
    .out (net8)
  );
  and_cell gate67 (
    .a (net16),
    .b (net18),
    .out (net71)
  );
  and_cell gate69 (
    .a (net3),
    .b (net18),
    .out (net72)
  );
  and_cell gate70 (
    .a (net1),
    .b (net3),
    .out (net73)
  );
  and_cell gate71 (
    .a (net1),
    .b (net2),
    .out (net74)
  );
  or_cell gate72 (
    .a (net71),
    .b (net72),
    .out (net75)
  );
  or_cell gate73 (
    .a (net73),
    .b (net74),
    .out (net76)
  );
  or_cell gate74 (
    .a (net75),
    .b (net76),
    .out (net9)
  );
  and_cell gate75 (
    .a (net15),
    .b (net2),
    .out (net77)
  );
  and_cell gate76 (
    .a (net77),
    .b (net17),
    .out (net78)
  );
  and_cell gate77 (
    .a (net16),
    .b (net3),
    .out (net79)
  );
  and_cell gate78 (
    .a (net3),
    .b (net18),
    .out (net80)
  );
  and_cell gate79 (
    .a (net1),
    .b (net16),
    .out (net81)
  );
  and_cell gate80 (
    .a (net1),
    .b (net4),
    .out (net82)
  );
  or_cell gate81 (
    .a (net78),
    .b (net79),
    .out (net83)
  );
  or_cell gate82 (
    .a (net80),
    .b (net81),
    .out (net84)
  );
  or_cell gate83 (
    .a (net85),
    .b (net82),
    .out (net11)
  );
  or_cell gate84 (
    .a (net83),
    .b (net84),
    .out (net85)
  );
  and_cell gate85 (
    .a (net1),
    .b (net86),
    .out (net12)
  );
  nand_cell gate87 (
    .a (net17),
    .b (net16),
    .out (net86)
  );
endmodule
