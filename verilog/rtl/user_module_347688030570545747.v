/* Automatically generated from https://wokwi.com/projects/347688030570545747 */

`default_nettype none

module user_module_347688030570545747(
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
  wire net87;
  wire net88;
  wire net89;
  wire net90;
  wire net91;
  wire net92;
  wire net93;
  wire net94;
  wire net95;
  wire net96;
  wire net97;
  wire net98;
  wire net99;
  wire net100;
  wire net101;
  wire net102;
  wire net103;
  wire net104;
  wire net105;
  wire net106;
  wire net107 = 1'b1;
  wire net108 = 1'b1;
  wire net109 = 1'b0;

  assign io_out[0] = net5;
  assign io_out[1] = net6;
  assign io_out[2] = net7;
  assign io_out[3] = net8;
  assign io_out[4] = net9;
  assign io_out[5] = net10;
  assign io_out[6] = net11;

  buffer_cell input_w (
    .in (net1),
    .out (net12)
  );
  not_cell input_not_w (
    .in (net1),
    .out (net13)
  );
  buffer_cell input_x (
    .in (net2),
    .out (net14)
  );
  not_cell input_not_x (
    .in (net2),
    .out (net15)
  );
  buffer_cell input_y (
    .in (net3),
    .out (net16)
  );
  not_cell input_not_y (
    .in (net3),
    .out (net17)
  );
  buffer_cell input_z (
    .in (net4),
    .out (net18)
  );
  not_cell input_not_z (
    .in (net4),
    .out (net19)
  );
  and_cell gate_and_0 (
    .a (net13),
    .b (net15),
    .out (net20)
  );
  and_cell gate_and_1 (
    .a (net16),
    .b (net16),
    .out (net21)
  );
  and_cell gate_and_2 (
    .a (net12),
    .b (net15),
    .out (net22)
  );
  and_cell gate_and_3 (
    .a (net17),
    .b (net17),
    .out (net23)
  );
  and_cell gate_and_4 (
    .a (net13),
    .b (net14),
    .out (net24)
  );
  and_cell gate_and_5 (
    .a (net18),
    .b (net18),
    .out (net25)
  );
  and_cell gate_and_6 (
    .a (net15),
    .b (net17),
    .out (net26)
  );
  and_cell gate_and_7 (
    .a (net19),
    .b (net19),
    .out (net27)
  );
  and_cell gate_and_8 (
    .a (net13),
    .b (net17),
    .out (net28)
  );
  and_cell gate_and_9 (
    .a (net19),
    .b (net19),
    .out (net29)
  );
  and_cell gate_and_10 (
    .a (net15),
    .b (net17),
    .out (net30)
  );
  and_cell gate_and_11 (
    .a (net13),
    .b (net15),
    .out (net31)
  );
  and_cell gate_and_12 (
    .a (net13),
    .b (net16),
    .out (net32)
  );
  and_cell gate_and_13 (
    .a (net18),
    .b (net18),
    .out (net33)
  );
  and_cell gate_and_14 (
    .a (net13),
    .b (net14),
    .out (net34)
  );
  and_cell gate_and_15 (
    .a (net13),
    .b (net17),
    .out (net35)
  );
  and_cell gate_and_16 (
    .a (net15),
    .b (net17),
    .out (net36)
  );
  and_cell gate_and_17 (
    .a (net18),
    .b (net18),
    .out (net37)
  );
  and_cell gate_and_18 (
    .a (net13),
    .b (net18),
    .out (net38)
  );
  and_cell gate_and_19 (
    .a (net13),
    .b (net15),
    .out (net39)
  );
  and_cell gate_and_20 (
    .a (net16),
    .b (net16),
    .out (net40)
  );
  and_cell gate_and_21 (
    .a (net15),
    .b (net17),
    .out (net41)
  );
  and_cell gate_and_22 (
    .a (net19),
    .b (net19),
    .out (net42)
  );
  and_cell gate_and_23 (
    .a (net13),
    .b (net14),
    .out (net43)
  );
  and_cell gate_and_24 (
    .a (net17),
    .b (net18),
    .out (net44)
  );
  and_cell gate_and_25 (
    .a (net13),
    .b (net16),
    .out (net45)
  );
  and_cell gate_and_26 (
    .a (net19),
    .b (net19),
    .out (net46)
  );
  and_cell gate_and_27 (
    .a (net15),
    .b (net17),
    .out (net47)
  );
  and_cell gate_and_28 (
    .a (net19),
    .b (net19),
    .out (net48)
  );
  and_cell gate_and_29 (
    .a (net13),
    .b (net16),
    .out (net49)
  );
  and_cell gate_and_30 (
    .a (net19),
    .b (net19),
    .out (net50)
  );
  and_cell gate_and_31 (
    .a (net15),
    .b (net17),
    .out (net51)
  );
  and_cell gate_and_32 (
    .a (net19),
    .b (net19),
    .out (net52)
  );
  and_cell gate_and_33 (
    .a (net12),
    .b (net15),
    .out (net53)
  );
  and_cell gate_and_34 (
    .a (net17),
    .b (net17),
    .out (net54)
  );
  and_cell gate_and_35 (
    .a (net13),
    .b (net14),
    .out (net55)
  );
  and_cell gate_and_36 (
    .a (net17),
    .b (net17),
    .out (net56)
  );
  and_cell gate_and_37 (
    .a (net13),
    .b (net14),
    .out (net57)
  );
  and_cell gate_and_38 (
    .a (net19),
    .b (net19),
    .out (net58)
  );
  and_cell gate_and_39 (
    .a (net13),
    .b (net15),
    .out (net59)
  );
  and_cell gate_and_40 (
    .a (net16),
    .b (net16),
    .out (net60)
  );
  and_cell gate_and_41 (
    .a (net12),
    .b (net15),
    .out (net61)
  );
  and_cell gate_and_42 (
    .a (net17),
    .b (net17),
    .out (net62)
  );
  and_cell gate_and_43 (
    .a (net13),
    .b (net14),
    .out (net63)
  );
  and_cell gate_and_44 (
    .a (net17),
    .b (net17),
    .out (net64)
  );
  and_cell gate_and_45 (
    .a (net13),
    .b (net14),
    .out (net65)
  );
  and_cell gate_and_46 (
    .a (net19),
    .b (net19),
    .out (net66)
  );
  and_cell gate_and_47 (
    .a (net20),
    .b (net21),
    .out (net67)
  );
  and_cell gate_and_48 (
    .a (net22),
    .b (net23),
    .out (net68)
  );
  and_cell gate_and_49 (
    .a (net24),
    .b (net25),
    .out (net69)
  );
  and_cell gate_and_50 (
    .a (net26),
    .b (net27),
    .out (net70)
  );
  and_cell gate_and_51 (
    .a (net28),
    .b (net29),
    .out (net71)
  );
  and_cell gate_and_52 (
    .a (net32),
    .b (net33),
    .out (net72)
  );
  and_cell gate_and_53 (
    .a (net36),
    .b (net37),
    .out (net73)
  );
  and_cell gate_and_54 (
    .a (net39),
    .b (net40),
    .out (net74)
  );
  and_cell gate_and_55 (
    .a (net41),
    .b (net42),
    .out (net75)
  );
  and_cell gate_and_56 (
    .a (net44),
    .b (net43),
    .out (net76)
  );
  and_cell gate_and_57 (
    .a (net45),
    .b (net46),
    .out (net77)
  );
  and_cell gate_and_58 (
    .a (net47),
    .b (net48),
    .out (net78)
  );
  and_cell gate_and_59 (
    .a (net49),
    .b (net50),
    .out (net79)
  );
  and_cell gate_and_60 (
    .a (net52),
    .b (net51),
    .out (net80)
  );
  and_cell gate_and_61 (
    .a (net53),
    .b (net54),
    .out (net81)
  );
  and_cell gate_and_62 (
    .a (net55),
    .b (net56),
    .out (net82)
  );
  and_cell gate_and_63 (
    .a (net57),
    .b (net58),
    .out (net83)
  );
  and_cell gate_and_64 (
    .a (net60),
    .b (net59),
    .out (net84)
  );
  and_cell gate_and_65 (
    .a (net61),
    .b (net62),
    .out (net85)
  );
  and_cell gate_and_66 (
    .a (net63),
    .b (net64),
    .out (net86)
  );
  and_cell gate_and_67 (
    .a (net65),
    .b (net66),
    .out (net87)
  );
  or_cell gate_or_0 (
    .a (net67),
    .b (net68),
    .out (net88)
  );
  or_cell gate_or_1 (
    .a (net69),
    .b (net70),
    .out (net89)
  );
  or_cell gate_or_2 (
    .a (net71),
    .b (net30),
    .out (net90)
  );
  or_cell gate_or_3 (
    .a (net31),
    .b (net72),
    .out (net91)
  );
  or_cell gate_or_4 (
    .a (net34),
    .b (net35),
    .out (net92)
  );
  or_cell gate_or_5 (
    .a (net73),
    .b (net38),
    .out (net93)
  );
  or_cell gate_or_6 (
    .a (net74),
    .b (net75),
    .out (net94)
  );
  or_cell gate_or_7 (
    .a (net76),
    .b (net77),
    .out (net95)
  );
  or_cell gate_or_8 (
    .a (net78),
    .b (net79),
    .out (net96)
  );
  or_cell gate_or_9 (
    .a (net80),
    .b (net81),
    .out (net97)
  );
  or_cell gate_or_10 (
    .a (net82),
    .b (net83),
    .out (net98)
  );
  or_cell gate_or_11 (
    .a (net84),
    .b (net85),
    .out (net99)
  );
  or_cell gate_or_12 (
    .a (net86),
    .b (net87),
    .out (net100)
  );
  or_cell gate_or_13 (
    .a (net88),
    .b (net89),
    .out (net101)
  );
  or_cell gate_or_14 (
    .a (net90),
    .b (net91),
    .out (net102)
  );
  or_cell gate_or_15 (
    .a (net92),
    .b (net93),
    .out (net103)
  );
  or_cell gate_or_16 (
    .a (net94),
    .b (net95),
    .out (net104)
  );
  or_cell gate_or_17 (
    .a (net97),
    .b (net98),
    .out (net105)
  );
  or_cell gate_or_18 (
    .a (net99),
    .b (net100),
    .out (net106)
  );
  buffer_cell output_A (
    .in (net101),
    .out (net5)
  );
  buffer_cell output_B (
    .in (net102),
    .out (net6)
  );
  buffer_cell output_C (
    .in (net103),
    .out (net7)
  );
  buffer_cell output_D (
    .in (net104),
    .out (net8)
  );
  buffer_cell output_E (
    .in (net96),
    .out (net9)
  );
  buffer_cell output_F (
    .in (net105),
    .out (net10)
  );
  buffer_cell output_G (
    .in (net106),
    .out (net11)
  );
endmodule
