/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : output_logic                                                 **
 **                                                                          **
 *****************************************************************************/

module output_logic( DEST_0,
                     DEST_1,
                     DEST_10,
                     DEST_11,
                     DEST_2,
                     DEST_3,
                     DEST_4,
                     DEST_5,
                     DEST_6,
                     DEST_7,
                     DEST_8,
                     DEST_9,
                     DO_JMP,
                     F_I,
                     JMP,
                     MAR,
                     MAR_0,
                     MAR_1,
                     MAR_2,
                     MAR_3,
                     MAR_4,
                     MAR_5,
                     MAR_6,
                     MAR_7,
                     OUT_0,
                     OUT_1,
                     OUT_2,
                     OUT_3,
                     OUT_4,
                     OUT_5,
                     OUT_6,
                     OUT_7,
                     O_S,
                     RR_0,
                     RR_1,
                     RR_2,
                     RR_3,
                     WRITE );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input DEST_0;
   input DEST_1;
   input DEST_10;
   input DEST_11;
   input DEST_2;
   input DEST_3;
   input DEST_4;
   input DEST_5;
   input DEST_6;
   input DEST_7;
   input DEST_8;
   input DEST_9;
   input DO_JMP;
   input F_I;
   input JMP;
   input MAR;
   input MAR_0;
   input MAR_1;
   input MAR_2;
   input MAR_3;
   input MAR_4;
   input MAR_5;
   input MAR_6;
   input MAR_7;
   input O_S;
   input RR_0;
   input RR_1;
   input RR_2;
   input RR_3;
   input WRITE;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output OUT_0;
   output OUT_1;
   output OUT_2;
   output OUT_3;
   output OUT_4;
   output OUT_5;
   output OUT_6;
   output OUT_7;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_logisimNet0;
   wire s_logisimNet1;
   wire s_logisimNet10;
   wire s_logisimNet11;
   wire s_logisimNet12;
   wire s_logisimNet13;
   wire s_logisimNet14;
   wire s_logisimNet15;
   wire s_logisimNet16;
   wire s_logisimNet17;
   wire s_logisimNet18;
   wire s_logisimNet19;
   wire s_logisimNet2;
   wire s_logisimNet20;
   wire s_logisimNet21;
   wire s_logisimNet22;
   wire s_logisimNet23;
   wire s_logisimNet24;
   wire s_logisimNet25;
   wire s_logisimNet26;
   wire s_logisimNet27;
   wire s_logisimNet28;
   wire s_logisimNet29;
   wire s_logisimNet3;
   wire s_logisimNet30;
   wire s_logisimNet31;
   wire s_logisimNet32;
   wire s_logisimNet33;
   wire s_logisimNet34;
   wire s_logisimNet35;
   wire s_logisimNet36;
   wire s_logisimNet37;
   wire s_logisimNet38;
   wire s_logisimNet39;
   wire s_logisimNet4;
   wire s_logisimNet40;
   wire s_logisimNet41;
   wire s_logisimNet42;
   wire s_logisimNet43;
   wire s_logisimNet44;
   wire s_logisimNet45;
   wire s_logisimNet46;
   wire s_logisimNet47;
   wire s_logisimNet48;
   wire s_logisimNet49;
   wire s_logisimNet5;
   wire s_logisimNet50;
   wire s_logisimNet51;
   wire s_logisimNet52;
   wire s_logisimNet53;
   wire s_logisimNet54;
   wire s_logisimNet55;
   wire s_logisimNet56;
   wire s_logisimNet57;
   wire s_logisimNet58;
   wire s_logisimNet59;
   wire s_logisimNet6;
   wire s_logisimNet60;
   wire s_logisimNet61;
   wire s_logisimNet62;
   wire s_logisimNet63;
   wire s_logisimNet64;
   wire s_logisimNet65;
   wire s_logisimNet66;
   wire s_logisimNet67;
   wire s_logisimNet68;
   wire s_logisimNet69;
   wire s_logisimNet7;
   wire s_logisimNet70;
   wire s_logisimNet71;
   wire s_logisimNet72;
   wire s_logisimNet73;
   wire s_logisimNet74;
   wire s_logisimNet75;
   wire s_logisimNet76;
   wire s_logisimNet77;
   wire s_logisimNet78;
   wire s_logisimNet79;
   wire s_logisimNet8;
   wire s_logisimNet80;
   wire s_logisimNet81;
   wire s_logisimNet82;
   wire s_logisimNet83;
   wire s_logisimNet84;
   wire s_logisimNet85;
   wire s_logisimNet86;
   wire s_logisimNet87;
   wire s_logisimNet88;
   wire s_logisimNet89;
   wire s_logisimNet9;
   wire s_logisimNet90;
   wire s_logisimNet91;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimNet11 = DO_JMP;
   assign s_logisimNet13 = O_S;
   assign s_logisimNet17 = DEST_8;
   assign s_logisimNet18 = DEST_1;
   assign s_logisimNet19 = DEST_5;
   assign s_logisimNet34 = MAR_1;
   assign s_logisimNet35 = MAR_5;
   assign s_logisimNet36 = RR_1;
   assign s_logisimNet40 = F_I;
   assign s_logisimNet49 = DEST_0;
   assign s_logisimNet50 = DEST_11;
   assign s_logisimNet51 = DEST_4;
   assign s_logisimNet63 = MAR_0;
   assign s_logisimNet64 = MAR_4;
   assign s_logisimNet65 = RR_0;
   assign s_logisimNet69 = JMP;
   assign s_logisimNet71 = WRITE;
   assign s_logisimNet73 = DEST_7;
   assign s_logisimNet74 = DEST_10;
   assign s_logisimNet75 = DEST_3;
   assign s_logisimNet79 = MAR_3;
   assign s_logisimNet8  = MAR;
   assign s_logisimNet80 = MAR_7;
   assign s_logisimNet81 = RR_3;
   assign s_logisimNet84 = DEST_6;
   assign s_logisimNet85 = DEST_9;
   assign s_logisimNet86 = DEST_2;
   assign s_logisimNet89 = MAR_2;
   assign s_logisimNet90 = MAR_6;
   assign s_logisimNet91 = RR_2;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign OUT_0 = s_logisimNet77;
   assign OUT_1 = s_logisimNet59;
   assign OUT_2 = s_logisimNet28;
   assign OUT_3 = s_logisimNet88;
   assign OUT_4 = s_logisimNet78;
   assign OUT_5 = s_logisimNet57;
   assign OUT_6 = s_logisimNet27;
   assign OUT_7 = s_logisimNet87;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet12 = ~s_logisimNet13;

   // NOT Gate
   assign s_logisimNet14 = ~s_logisimNet11;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   OR_GATE #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet45),
               .input2(s_logisimNet16),
               .result(s_logisimNet42));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet70),
               .input2(s_logisimNet26),
               .result(s_logisimNet32));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet5),
               .input2(s_logisimNet25),
               .result(s_logisimNet54));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet56),
               .input2(s_logisimNet72),
               .result(s_logisimNet20));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet24),
               .input2(s_logisimNet53),
               .result(s_logisimNet37));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet55),
               .input2(s_logisimNet6),
               .result(s_logisimNet0));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimNet29),
               .input2(s_logisimNet48),
               .result(s_logisimNet82));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_8 (.input1(s_logisimNet83),
               .input2(s_logisimNet7),
               .result(s_logisimNet66));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_9 (.input1(s_logisimNet2),
               .input2(s_logisimNet31),
               .result(s_logisimNet38));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_10 (.input1(s_logisimNet10),
                .input2(s_logisimNet62),
                .result(s_logisimNet39));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_11 (.input1(s_logisimNet30),
                .input2(s_logisimNet21),
                .result(s_logisimNet1));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_12 (.input1(s_logisimNet76),
                .input2(s_logisimNet3),
                .result(s_logisimNet67));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_13 (.input1(s_logisimNet67),
                .input2(s_logisimNet12),
                .result(s_logisimNet52));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_14 (.input1(s_logisimNet37),
                .input2(s_logisimNet12),
                .result(s_logisimNet44));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_15 (.input1(s_logisimNet0),
                .input2(s_logisimNet12),
                .result(s_logisimNet68));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_16 (.input1(s_logisimNet82),
                .input2(s_logisimNet12),
                .result(s_logisimNet15));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_17 (.input1(s_logisimNet66),
                .input2(s_logisimNet12),
                .result(s_logisimNet43));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_18 (.input1(s_logisimNet38),
                .input2(s_logisimNet12),
                .result(s_logisimNet61));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_19 (.input1(s_logisimNet39),
                .input2(s_logisimNet12),
                .result(s_logisimNet9));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_20 (.input1(s_logisimNet1),
                .input2(s_logisimNet12),
                .result(s_logisimNet4));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_21 (.input1(s_logisimNet42),
                .input2(s_logisimNet13),
                .result(s_logisimNet22));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_22 (.input1(s_logisimNet32),
                .input2(s_logisimNet13),
                .result(s_logisimNet58));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_23 (.input1(s_logisimNet54),
                .input2(s_logisimNet13),
                .result(s_logisimNet23));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_24 (.input1(s_logisimNet20),
                .input2(s_logisimNet13),
                .result(s_logisimNet47));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_25 (.input1(s_logisimNet8),
                .input2(s_logisimNet13),
                .result(s_logisimNet41));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_26 (.input1(s_logisimNet71),
                .input2(s_logisimNet13),
                .result(s_logisimNet60));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_27 (.input1(s_logisimNet69),
                .input2(s_logisimNet13),
                .result(s_logisimNet46));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_28 (.input1(s_logisimNet40),
                .input2(s_logisimNet13),
                .result(s_logisimNet33));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_29 (.input1(s_logisimNet52),
                .input2(s_logisimNet22),
                .result(s_logisimNet77));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_30 (.input1(s_logisimNet44),
                .input2(s_logisimNet58),
                .result(s_logisimNet59));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_31 (.input1(s_logisimNet68),
                .input2(s_logisimNet23),
                .result(s_logisimNet28));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_32 (.input1(s_logisimNet15),
                .input2(s_logisimNet47),
                .result(s_logisimNet88));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_33 (.input1(s_logisimNet43),
                .input2(s_logisimNet41),
                .result(s_logisimNet78));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_34 (.input1(s_logisimNet61),
                .input2(s_logisimNet60),
                .result(s_logisimNet57));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_35 (.input1(s_logisimNet9),
                .input2(s_logisimNet46),
                .result(s_logisimNet27));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_36 (.input1(s_logisimNet4),
                .input2(s_logisimNet33),
                .result(s_logisimNet87));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_37 (.input1(s_logisimNet84),
                .input2(s_logisimNet11),
                .result(s_logisimNet10));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_38 (.input1(s_logisimNet73),
                .input2(s_logisimNet11),
                .result(s_logisimNet30));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_39 (.input1(s_logisimNet63),
                .input2(s_logisimNet14),
                .result(s_logisimNet3));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_40 (.input1(s_logisimNet34),
                .input2(s_logisimNet14),
                .result(s_logisimNet53));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_41 (.input1(s_logisimNet89),
                .input2(s_logisimNet14),
                .result(s_logisimNet6));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_42 (.input1(s_logisimNet79),
                .input2(s_logisimNet14),
                .result(s_logisimNet48));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_43 (.input1(s_logisimNet64),
                .input2(s_logisimNet14),
                .result(s_logisimNet7));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_44 (.input1(s_logisimNet35),
                .input2(s_logisimNet14),
                .result(s_logisimNet31));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_45 (.input1(s_logisimNet90),
                .input2(s_logisimNet14),
                .result(s_logisimNet62));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_46 (.input1(s_logisimNet80),
                .input2(s_logisimNet14),
                .result(s_logisimNet21));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_47 (.input1(s_logisimNet17),
                .input2(s_logisimNet11),
                .result(s_logisimNet45));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_48 (.input1(s_logisimNet85),
                .input2(s_logisimNet11),
                .result(s_logisimNet70));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_49 (.input1(s_logisimNet74),
                .input2(s_logisimNet11),
                .result(s_logisimNet5));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_50 (.input1(s_logisimNet50),
                .input2(s_logisimNet11),
                .result(s_logisimNet56));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_51 (.input1(s_logisimNet65),
                .input2(s_logisimNet14),
                .result(s_logisimNet16));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_52 (.input1(s_logisimNet36),
                .input2(s_logisimNet14),
                .result(s_logisimNet26));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_53 (.input1(s_logisimNet91),
                .input2(s_logisimNet14),
                .result(s_logisimNet25));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_54 (.input1(s_logisimNet81),
                .input2(s_logisimNet14),
                .result(s_logisimNet72));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_55 (.input1(s_logisimNet49),
                .input2(s_logisimNet11),
                .result(s_logisimNet76));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_56 (.input1(s_logisimNet18),
                .input2(s_logisimNet11),
                .result(s_logisimNet24));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_57 (.input1(s_logisimNet86),
                .input2(s_logisimNet11),
                .result(s_logisimNet55));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_58 (.input1(s_logisimNet75),
                .input2(s_logisimNet11),
                .result(s_logisimNet29));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_59 (.input1(s_logisimNet51),
                .input2(s_logisimNet11),
                .result(s_logisimNet83));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_60 (.input1(s_logisimNet19),
                .input2(s_logisimNet11),
                .result(s_logisimNet2));


endmodule
