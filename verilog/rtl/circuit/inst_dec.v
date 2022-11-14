/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : inst_dec                                                     **
 **                                                                          **
 *****************************************************************************/

module inst_dec( ARI,
                 CLK1,
                 D0,
                 D1,
                 D2,
                 D3,
                 I0,
                 I1,
                 I2,
                 I3,
                 JMP,
                 LD,
                 LDD,
                 LOG,
                 RST_C,
                 SEI,
                 SMH,
                 SML,
                 STR,
                 W_CAR );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input CLK1;
   input D0;
   input D1;
   input D2;
   input D3;
   input RST_C;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output ARI;
   output I0;
   output I1;
   output I2;
   output I3;
   output JMP;
   output LD;
   output LDD;
   output LOG;
   output SEI;
   output SMH;
   output SML;
   output STR;
   output W_CAR;

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
   assign s_logisimNet0  = RST_C;
   assign s_logisimNet20 = D0;
   assign s_logisimNet27 = D1;
   assign s_logisimNet31 = D2;
   assign s_logisimNet5  = D3;
   assign s_logisimNet6  = CLK1;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign ARI   = s_logisimNet7;
   assign I0    = s_logisimNet4;
   assign I1    = s_logisimNet2;
   assign I2    = s_logisimNet18;
   assign I3    = s_logisimNet9;
   assign JMP   = s_logisimNet23;
   assign LD    = s_logisimNet3;
   assign LDD   = s_logisimNet28;
   assign LOG   = s_logisimNet32;
   assign SEI   = s_logisimNet17;
   assign SMH   = s_logisimNet22;
   assign SML   = s_logisimNet30;
   assign STR   = s_logisimNet29;
   assign W_CAR = s_logisimNet19;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet16 = ~s_logisimNet10;

   // NOT Gate
   assign s_logisimNet13 = ~s_logisimNet8;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   AND_GATE #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet7),
               .input2(s_logisimNet2),
               .result(s_logisimNet19));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet4),
               .input2(s_logisimNet2),
               .result(s_logisimNet8));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet26),
               .input2(s_logisimNet16),
               .result(s_logisimNet23));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet10),
               .input2(s_logisimNet26),
               .result(s_logisimNet28));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet8),
               .input2(s_logisimNet15),
               .result(s_logisimNet32));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet18),
               .input2(s_logisimNet9),
               .result(s_logisimNet33));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimNet33),
               .input2(s_logisimNet3),
               .result(s_logisimNet15));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_8 (.input1(s_logisimNet13),
               .input2(s_logisimNet15),
               .result(s_logisimNet22));

   NOR_GATE #(.BubblesMask(2'b00))
      GATES_9 (.input1(s_logisimNet18),
               .input2(s_logisimNet9),
               .result(s_logisimNet1));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_10 (.input1(s_logisimNet21),
                .input2(s_logisimNet12),
                .result(s_logisimNet35));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_11 (.input1(s_logisimNet35),
                .input2(s_logisimNet1),
                .result(s_logisimNet3));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_12 (.input1(s_logisimNet4),
                .input2(s_logisimNet12),
                .result(s_logisimNet24));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_13 (.input1(s_logisimNet24),
                .input2(s_logisimNet1),
                .result(s_logisimNet29));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_14 (.input1(s_logisimNet21),
                .input2(s_logisimNet2),
                .result(s_logisimNet34));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_15 (.input1(s_logisimNet34),
                .input2(s_logisimNet1),
                .result(s_logisimNet17));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_16 (.input1(s_logisimNet4),
                .input2(s_logisimNet2),
                .result(s_logisimNet25));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_17 (.input1(s_logisimNet25),
                .input2(s_logisimNet1),
                .result(s_logisimNet30));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_18 (.input1(s_logisimNet4),
                .input2(s_logisimNet2),
                .result(s_logisimNet10));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_19 (.input1(s_logisimNet14),
                .input2(s_logisimNet18),
                .result(s_logisimNet26));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_20 (.input1(s_logisimNet11),
                .input2(s_logisimNet9),
                .result(s_logisimNet7));

   D_FLIPFLOP #(.invertClockEnable(0))
      MEMORY_21 (.clock(s_logisimNet6),
                 .d(s_logisimNet20),
                 .preset(1'b0),
                 .q(s_logisimNet4),
                 .qBar(s_logisimNet21),
                 .reset(s_logisimNet0),
                 .tick(1'b1));

   D_FLIPFLOP #(.invertClockEnable(0))
      MEMORY_22 (.clock(s_logisimNet6),
                 .d(s_logisimNet27),
                 .preset(1'b0),
                 .q(s_logisimNet2),
                 .qBar(s_logisimNet12),
                 .reset(s_logisimNet0),
                 .tick(1'b1));

   D_FLIPFLOP #(.invertClockEnable(0))
      MEMORY_23 (.clock(s_logisimNet6),
                 .d(s_logisimNet31),
                 .preset(1'b0),
                 .q(s_logisimNet18),
                 .qBar(s_logisimNet11),
                 .reset(s_logisimNet0),
                 .tick(1'b1));

   D_FLIPFLOP #(.invertClockEnable(0))
      MEMORY_24 (.clock(s_logisimNet6),
                 .d(s_logisimNet5),
                 .preset(1'b0),
                 .q(s_logisimNet9),
                 .qBar(s_logisimNet14),
                 .reset(s_logisimNet0),
                 .tick(1'b1));


endmodule
