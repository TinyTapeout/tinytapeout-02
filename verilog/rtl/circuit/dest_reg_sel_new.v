/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : dest_reg_sel_new                                             **
 **                                                                          **
 *****************************************************************************/

module dest_reg_sel_new( CLK1,
                         LDD,
                         RST,
                         S0,
                         S1,
                         S2 );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input CLK1;
   input LDD;
   input RST;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output S0;
   output S1;
   output S2;

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
   wire s_logisimNet4;
   wire s_logisimNet5;
   wire s_logisimNet6;
   wire s_logisimNet7;
   wire s_logisimNet8;
   wire s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimNet19 = CLK1;
   assign s_logisimNet28 = LDD;
   assign s_logisimNet7  = RST;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign S0 = s_logisimNet33;
   assign S1 = s_logisimNet2;
   assign S2 = s_logisimNet17;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet27 = ~s_logisimNet19;

   // NOT Gate
   assign s_logisimNet13 = ~s_logisimNet0;

   // NOT Gate
   assign s_logisimNet4 = ~s_logisimNet2;

   // NOT Gate
   assign s_logisimNet15 = ~s_logisimNet12;

   // NOT Gate
   assign s_logisimNet23 = ~s_logisimNet7;

   // NOT Gate
   assign s_logisimNet1 = ~s_logisimNet5;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   AND_GATE #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet27),
               .input2(s_logisimNet28),
               .result(s_logisimNet0));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet12),
               .input2(s_logisimNet4),
               .result(s_logisimNet34));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet15),
               .input2(s_logisimNet1),
               .result(s_logisimNet35));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet1),
               .input2(s_logisimNet2),
               .result(s_logisimNet21));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet15),
               .input2(s_logisimNet1),
               .result(s_logisimNet36));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet2),
               .input2(s_logisimNet1),
               .result(s_logisimNet9));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimNet12),
               .input2(s_logisimNet4),
               .result(s_logisimNet10));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_8 (.input1(s_logisimNet5),
               .input2(s_logisimNet4),
               .result(s_logisimNet30));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_9 (.input1(s_logisimNet5),
               .input2(s_logisimNet12),
               .result(s_logisimNet11));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_10 (.input1(s_logisimNet35),
                .input2(s_logisimNet0),
                .result(s_logisimNet25));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_11 (.input1(s_logisimNet21),
                .input2(s_logisimNet13),
                .result(s_logisimNet20));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_12 (.input1(s_logisimNet36),
                .input2(s_logisimNet2),
                .result(s_logisimNet26));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_13 (.input1(s_logisimNet9),
                .input2(s_logisimNet13),
                .result(s_logisimNet6));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_14 (.input1(s_logisimNet1),
                .input2(s_logisimNet12),
                .result(s_logisimNet29));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_15 (.input1(s_logisimNet34),
                .input2(s_logisimNet13),
                .result(s_logisimNet22));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_16 (.input1(s_logisimNet10),
                .input2(s_logisimNet13),
                .result(s_logisimNet32));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_17 (.input1(s_logisimNet30),
                .input2(s_logisimNet0),
                .result(s_logisimNet8));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_18 (.input1(s_logisimNet11),
                .input2(s_logisimNet4),
                .result(s_logisimNet16));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_19 (.input1(s_logisimNet6),
                .input2(s_logisimNet29),
                .result(s_logisimNet14));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_20 (.input1(s_logisimNet25),
                .input2(s_logisimNet20),
                .result(s_logisimNet31));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_21 (.input1(s_logisimNet32),
                .input2(s_logisimNet8),
                .result(s_logisimNet37));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_22 (.input1(s_logisimNet14),
                .input2(s_logisimNet22),
                .result(s_logisimNet3));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_23 (.input1(s_logisimNet31),
                .input2(s_logisimNet26),
                .result(s_logisimNet24));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_24 (.input1(s_logisimNet37),
                .input2(s_logisimNet16),
                .result(s_logisimNet18));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_25 (.input1(s_logisimNet7),
                .input2(s_logisimNet3),
                .result(s_logisimNet12));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_26 (.input1(s_logisimNet7),
                .input2(s_logisimNet18),
                .result(s_logisimNet5));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_27 (.input1(s_logisimNet23),
                .input2(s_logisimNet24),
                .result(s_logisimNet2));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_28 (.input1(s_logisimNet4),
                .input2(s_logisimNet15),
                .result(s_logisimNet33));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_29 (.input1(s_logisimNet4),
                .input2(s_logisimNet12),
                .result(s_logisimNet17));


endmodule
