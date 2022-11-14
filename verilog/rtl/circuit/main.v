/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : main                                                         **
 **                                                                          **
 *****************************************************************************/

module main( CAR_I,
             CAR_O,
             D_0,
             D_1,
             D_2,
             D_3,
             LOG_EN,
             LOG_SEL_0,
             LOG_SEL_1,
             OUT_0,
             OUT_1,
             OUT_2,
             OUT_3,
             RR_0,
             RR_1,
             RR_2,
             RR_3,
             SUB,
             W_C );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input CAR_I;
   input D_0;
   input D_1;
   input D_2;
   input D_3;
   input LOG_EN;
   input LOG_SEL_0;
   input LOG_SEL_1;
   input RR_0;
   input RR_1;
   input RR_2;
   input RR_3;
   input SUB;
   input W_C;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output CAR_O;
   output OUT_0;
   output OUT_1;
   output OUT_2;
   output OUT_3;

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
   wire s_logisimNet92;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimNet0  = LOG_SEL_1;
   assign s_logisimNet10 = D_3;
   assign s_logisimNet11 = RR_2;
   assign s_logisimNet12 = LOG_SEL_0;
   assign s_logisimNet16 = LOG_EN;
   assign s_logisimNet17 = D_2;
   assign s_logisimNet19 = RR_1;
   assign s_logisimNet2  = RR_0;
   assign s_logisimNet24 = D_0;
   assign s_logisimNet25 = RR_3;
   assign s_logisimNet3  = D_1;
   assign s_logisimNet46 = W_C;
   assign s_logisimNet48 = CAR_I;
   assign s_logisimNet6  = SUB;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign CAR_O = s_logisimNet23;
   assign OUT_0 = s_logisimNet87;
   assign OUT_1 = s_logisimNet61;
   assign OUT_2 = s_logisimNet88;
   assign OUT_3 = s_logisimNet15;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet57 = ~s_logisimNet46;

   // NOT Gate
   assign s_logisimNet7 = ~s_logisimNet16;

   // NOT Gate
   assign s_logisimNet69 = ~s_logisimNet12;

   // NOT Gate
   assign s_logisimNet38 = ~s_logisimNet0;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet24),
               .input2(s_logisimNet6),
               .result(s_logisimNet43));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet3),
               .input2(s_logisimNet6),
               .result(s_logisimNet31));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet17),
               .input2(s_logisimNet6),
               .result(s_logisimNet1));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet10),
               .input2(s_logisimNet6),
               .result(s_logisimNet29));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet6),
               .input2(s_logisimNet57),
               .result(s_logisimNet68));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet68),
               .input2(s_logisimNet30),
               .result(s_logisimNet26));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimNet46),
               .input2(s_logisimNet48),
               .result(s_logisimNet30));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_8 (.input1(s_logisimNet2),
               .input2(s_logisimNet43),
               .result(s_logisimNet27));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_9 (.input1(s_logisimNet19),
               .input2(s_logisimNet31),
               .result(s_logisimNet40));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_10 (.input1(s_logisimNet11),
                .input2(s_logisimNet1),
                .result(s_logisimNet14));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_11 (.input1(s_logisimNet25),
                .input2(s_logisimNet29),
                .result(s_logisimNet39));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_12 (.input1(s_logisimNet2),
                .input2(s_logisimNet24),
                .result(s_logisimNet79));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_13 (.input1(s_logisimNet19),
                .input2(s_logisimNet3),
                .result(s_logisimNet80));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_14 (.input1(s_logisimNet11),
                .input2(s_logisimNet17),
                .result(s_logisimNet81));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_15 (.input1(s_logisimNet25),
                .input2(s_logisimNet10),
                .result(s_logisimNet82));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_16 (.input1(s_logisimNet2),
                .input2(s_logisimNet24),
                .result(s_logisimNet89));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_17 (.input1(s_logisimNet19),
                .input2(s_logisimNet3),
                .result(s_logisimNet90));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_18 (.input1(s_logisimNet11),
                .input2(s_logisimNet17),
                .result(s_logisimNet91));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_19 (.input1(s_logisimNet25),
                .input2(s_logisimNet10),
                .result(s_logisimNet92));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_20 (.input1(s_logisimNet2),
                .input2(s_logisimNet24),
                .result(s_logisimNet70));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_21 (.input1(s_logisimNet19),
                .input2(s_logisimNet3),
                .result(s_logisimNet71));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_22 (.input1(s_logisimNet11),
                .input2(s_logisimNet17),
                .result(s_logisimNet72));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_23 (.input1(s_logisimNet25),
                .input2(s_logisimNet10),
                .result(s_logisimNet73));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_24 (.input1(s_logisimNet27),
                .input2(s_logisimNet26),
                .result(s_logisimNet55));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_25 (.input1(s_logisimNet2),
                .input2(s_logisimNet43),
                .result(s_logisimNet47));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_26 (.input1(s_logisimNet27),
                .input2(s_logisimNet26),
                .result(s_logisimNet60));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_27 (.input1(s_logisimNet40),
                .input2(s_logisimNet18),
                .result(s_logisimNet32));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_28 (.input1(s_logisimNet19),
                .input2(s_logisimNet31),
                .result(s_logisimNet64));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_29 (.input1(s_logisimNet40),
                .input2(s_logisimNet18),
                .result(s_logisimNet58));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_30 (.input1(s_logisimNet14),
                .input2(s_logisimNet20),
                .result(s_logisimNet5));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_31 (.input1(s_logisimNet11),
                .input2(s_logisimNet1),
                .result(s_logisimNet62));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_32 (.input1(s_logisimNet39),
                .input2(s_logisimNet13),
                .result(s_logisimNet33));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_33 (.input1(s_logisimNet25),
                .input2(s_logisimNet29),
                .result(s_logisimNet65));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_34 (.input1(s_logisimNet14),
                .input2(s_logisimNet20),
                .result(s_logisimNet22));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_35 (.input1(s_logisimNet39),
                .input2(s_logisimNet13),
                .result(s_logisimNet44));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_36 (.input1(s_logisimNet55),
                .input2(s_logisimNet47),
                .result(s_logisimNet18));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_37 (.input1(s_logisimNet32),
                .input2(s_logisimNet64),
                .result(s_logisimNet20));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_38 (.input1(s_logisimNet5),
                .input2(s_logisimNet62),
                .result(s_logisimNet13));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_39 (.input1(s_logisimNet33),
                .input2(s_logisimNet65),
                .result(s_logisimNet66));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_40 (.input1(s_logisimNet60),
                .input2(s_logisimNet7),
                .result(s_logisimNet74));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_41 (.input1(s_logisimNet58),
                .input2(s_logisimNet7),
                .result(s_logisimNet63));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_42 (.input1(s_logisimNet22),
                .input2(s_logisimNet7),
                .result(s_logisimNet36));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_43 (.input1(s_logisimNet44),
                .input2(s_logisimNet7),
                .result(s_logisimNet67));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_44 (.input1(s_logisimNet66),
                .input2(s_logisimNet7),
                .result(s_logisimNet23));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_45 (.input1(s_logisimNet79),
                .input2(s_logisimNet35),
                .result(s_logisimNet53));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_46 (.input1(s_logisimNet80),
                .input2(s_logisimNet35),
                .result(s_logisimNet54));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_47 (.input1(s_logisimNet81),
                .input2(s_logisimNet35),
                .result(s_logisimNet51));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_48 (.input1(s_logisimNet82),
                .input2(s_logisimNet35),
                .result(s_logisimNet52));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_49 (.input1(s_logisimNet89),
                .input2(s_logisimNet9),
                .result(s_logisimNet42));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_50 (.input1(s_logisimNet90),
                .input2(s_logisimNet9),
                .result(s_logisimNet34));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_51 (.input1(s_logisimNet91),
                .input2(s_logisimNet9),
                .result(s_logisimNet41));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_52 (.input1(s_logisimNet92),
                .input2(s_logisimNet9),
                .result(s_logisimNet21));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_53 (.input1(s_logisimNet70),
                .input2(s_logisimNet45),
                .result(s_logisimNet49));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_54 (.input1(s_logisimNet71),
                .input2(s_logisimNet45),
                .result(s_logisimNet8));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_55 (.input1(s_logisimNet72),
                .input2(s_logisimNet45),
                .result(s_logisimNet56));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_56 (.input1(s_logisimNet73),
                .input2(s_logisimNet45),
                .result(s_logisimNet28));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_57 (.input1(s_logisimNet0),
                .input2(s_logisimNet69),
                .result(s_logisimNet45));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_58 (.input1(s_logisimNet38),
                .input2(s_logisimNet69),
                .result(s_logisimNet9));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_59 (.input1(s_logisimNet53),
                .input2(s_logisimNet42),
                .result(s_logisimNet83));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_60 (.input1(s_logisimNet54),
                .input2(s_logisimNet34),
                .result(s_logisimNet84));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_61 (.input1(s_logisimNet51),
                .input2(s_logisimNet41),
                .result(s_logisimNet85));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_62 (.input1(s_logisimNet52),
                .input2(s_logisimNet21),
                .result(s_logisimNet86));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_63 (.input1(s_logisimNet38),
                .input2(s_logisimNet12),
                .result(s_logisimNet35));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_64 (.input1(s_logisimNet83),
                .input2(s_logisimNet49),
                .result(s_logisimNet75));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_65 (.input1(s_logisimNet84),
                .input2(s_logisimNet8),
                .result(s_logisimNet76));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_66 (.input1(s_logisimNet85),
                .input2(s_logisimNet56),
                .result(s_logisimNet77));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_67 (.input1(s_logisimNet86),
                .input2(s_logisimNet28),
                .result(s_logisimNet78));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_68 (.input1(s_logisimNet75),
                .input2(s_logisimNet16),
                .result(s_logisimNet4));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_69 (.input1(s_logisimNet76),
                .input2(s_logisimNet16),
                .result(s_logisimNet59));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_70 (.input1(s_logisimNet77),
                .input2(s_logisimNet16),
                .result(s_logisimNet37));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_71 (.input1(s_logisimNet78),
                .input2(s_logisimNet16),
                .result(s_logisimNet50));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_72 (.input1(s_logisimNet74),
                .input2(s_logisimNet4),
                .result(s_logisimNet87));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_73 (.input1(s_logisimNet63),
                .input2(s_logisimNet59),
                .result(s_logisimNet61));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_74 (.input1(s_logisimNet36),
                .input2(s_logisimNet37),
                .result(s_logisimNet88));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_75 (.input1(s_logisimNet67),
                .input2(s_logisimNet50),
                .result(s_logisimNet15));


endmodule
