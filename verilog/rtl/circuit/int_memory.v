/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : int_memory                                                   **
 **                                                                          **
 *****************************************************************************/

module int_memory( ADR0,
                   ADR1,
                   ADR2,
                   CLK,
                   DI0,
                   DI1,
                   DI2,
                   DI3,
                   DO0,
                   DO1,
                   DO2,
                   DO3,
                   EN,
                   WR );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input ADR0;
   input ADR1;
   input ADR2;
   input CLK;
   input DI0;
   input DI1;
   input DI2;
   input DI3;
   input EN;
   input WR;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output DO0;
   output DO1;
   output DO2;
   output DO3;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [3:0] s_logisimBus10;
   wire [3:0] s_logisimBus17;
   wire [3:0] s_logisimBus18;
   wire [3:0] s_logisimBus23;
   wire [3:0] s_logisimBus25;
   wire [3:0] s_logisimBus26;
   wire [3:0] s_logisimBus27;
   wire [2:0] s_logisimBus29;
   wire [3:0] s_logisimBus31;
   wire [3:0] s_logisimBus32;
   wire [3:0] s_logisimBus33;
   wire [3:0] s_logisimBus34;
   wire [3:0] s_logisimBus35;
   wire [3:0] s_logisimBus42;
   wire [3:0] s_logisimBus44;
   wire [3:0] s_logisimBus45;
   wire [3:0] s_logisimBus46;
   wire [3:0] s_logisimBus47;
   wire [3:0] s_logisimBus48;
   wire [3:0] s_logisimBus49;
   wire [3:0] s_logisimBus50;
   wire [3:0] s_logisimBus51;
   wire [3:0] s_logisimBus52;
   wire [3:0] s_logisimBus6;
   wire [3:0] s_logisimBus7;
   wire       s_logisimNet0;
   wire       s_logisimNet1;
   wire       s_logisimNet11;
   wire       s_logisimNet12;
   wire       s_logisimNet13;
   wire       s_logisimNet14;
   wire       s_logisimNet15;
   wire       s_logisimNet16;
   wire       s_logisimNet19;
   wire       s_logisimNet2;
   wire       s_logisimNet20;
   wire       s_logisimNet21;
   wire       s_logisimNet22;
   wire       s_logisimNet24;
   wire       s_logisimNet28;
   wire       s_logisimNet3;
   wire       s_logisimNet30;
   wire       s_logisimNet36;
   wire       s_logisimNet37;
   wire       s_logisimNet38;
   wire       s_logisimNet39;
   wire       s_logisimNet4;
   wire       s_logisimNet40;
   wire       s_logisimNet41;
   wire       s_logisimNet43;
   wire       s_logisimNet5;
   wire       s_logisimNet8;
   wire       s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all wiring is defined                                                 **
   *******************************************************************************/
   assign s_logisimBus31[0] = s_logisimNet12;
   assign s_logisimBus31[1] = s_logisimNet12;
   assign s_logisimBus31[2] = s_logisimNet12;
   assign s_logisimBus31[3] = s_logisimNet12;
   assign s_logisimBus47[0] = s_logisimNet1;
   assign s_logisimBus47[1] = s_logisimNet1;
   assign s_logisimBus47[2] = s_logisimNet1;
   assign s_logisimBus47[3] = s_logisimNet1;
   assign s_logisimBus48[0] = s_logisimNet0;
   assign s_logisimBus48[1] = s_logisimNet0;
   assign s_logisimBus48[2] = s_logisimNet0;
   assign s_logisimBus48[3] = s_logisimNet0;
   assign s_logisimBus49[0] = s_logisimNet2;
   assign s_logisimBus49[1] = s_logisimNet2;
   assign s_logisimBus49[2] = s_logisimNet2;
   assign s_logisimBus49[3] = s_logisimNet2;
   assign s_logisimBus50[0] = s_logisimNet3;
   assign s_logisimBus50[1] = s_logisimNet3;
   assign s_logisimBus50[2] = s_logisimNet3;
   assign s_logisimBus50[3] = s_logisimNet3;
   assign s_logisimBus51[0] = s_logisimNet4;
   assign s_logisimBus51[1] = s_logisimNet4;
   assign s_logisimBus51[2] = s_logisimNet4;
   assign s_logisimBus51[3] = s_logisimNet4;
   assign s_logisimBus52[0] = s_logisimNet11;
   assign s_logisimBus52[1] = s_logisimNet11;
   assign s_logisimBus52[2] = s_logisimNet11;
   assign s_logisimBus52[3] = s_logisimNet11;

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus26[0] = DI0;
   assign s_logisimBus26[1] = DI1;
   assign s_logisimBus26[2] = DI2;
   assign s_logisimBus26[3] = DI3;
   assign s_logisimBus29[0] = ADR0;
   assign s_logisimBus29[1] = ADR1;
   assign s_logisimBus29[2] = ADR2;
   assign s_logisimNet12    = EN;
   assign s_logisimNet43    = CLK;
   assign s_logisimNet9     = WR;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign DO0 = s_logisimBus35[0];
   assign DO1 = s_logisimBus35[1];
   assign DO2 = s_logisimBus35[2];
   assign DO3 = s_logisimBus35[3];

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // Constant
   assign  s_logisimNet16  =  1'b1;


   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   AND_GATE_BUS #(.BubblesMask(2'b00),
                  .NrOfBits(4))
      GATES_1 (.input1(s_logisimBus47[3:0]),
               .input2(s_logisimBus44[3:0]),
               .result(s_logisimBus17[3:0]));

   AND_GATE_BUS #(.BubblesMask(2'b00),
                  .NrOfBits(4))
      GATES_2 (.input1(s_logisimBus48[3:0]),
               .input2(s_logisimBus32[3:0]),
               .result(s_logisimBus7[3:0]));

   AND_GATE_BUS #(.BubblesMask(2'b00),
                  .NrOfBits(4))
      GATES_3 (.input1(s_logisimBus49[3:0]),
               .input2(s_logisimBus45[3:0]),
               .result(s_logisimBus18[3:0]));

   AND_GATE_BUS #(.BubblesMask(2'b00),
                  .NrOfBits(4))
      GATES_4 (.input1(s_logisimBus50[3:0]),
               .input2(s_logisimBus33[3:0]),
               .result(s_logisimBus10[3:0]));

   AND_GATE_BUS #(.BubblesMask(2'b00),
                  .NrOfBits(4))
      GATES_5 (.input1(s_logisimBus51[3:0]),
               .input2(s_logisimBus34[3:0]),
               .result(s_logisimBus27[3:0]));

   AND_GATE_BUS #(.BubblesMask(2'b00),
                  .NrOfBits(4))
      GATES_6 (.input1(s_logisimBus52[3:0]),
               .input2(s_logisimBus46[3:0]),
               .result(s_logisimBus25[3:0]));

   OR_GATE_BUS #(.BubblesMask(2'b00),
                 .NrOfBits(4))
      GATES_7 (.input1(s_logisimBus27[3:0]),
               .input2(s_logisimBus25[3:0]),
               .result(s_logisimBus6[3:0]));

   OR_GATE_BUS_4_INPUTS #(.BubblesMask(4'h0),
                          .NrOfBits(4))
      GATES_8 (.input1(s_logisimBus17[3:0]),
               .input2(s_logisimBus7[3:0]),
               .input3(s_logisimBus18[3:0]),
               .input4(s_logisimBus10[3:0]),
               .result(s_logisimBus42[3:0]));

   OR_GATE_BUS #(.BubblesMask(2'b00),
                 .NrOfBits(4))
      GATES_9 (.input1(s_logisimBus42[3:0]),
               .input2(s_logisimBus6[3:0]),
               .result(s_logisimBus23[3:0]));

   AND_GATE_BUS #(.BubblesMask(2'b00),
                  .NrOfBits(4))
      GATES_10 (.input1(s_logisimBus23[3:0]),
                .input2(s_logisimBus31[3:0]),
                .result(s_logisimBus35[3:0]));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_11 (.input1(s_logisimNet12),
                .input2(s_logisimNet43),
                .result(s_logisimNet15));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_12 (.input1(s_logisimNet15),
                .input2(s_logisimNet11),
                .result(s_logisimNet20));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_13 (.input1(s_logisimNet15),
                .input2(s_logisimNet1),
                .result(s_logisimNet21));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_14 (.input1(s_logisimNet15),
                .input2(s_logisimNet0),
                .result(s_logisimNet39));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_15 (.input1(s_logisimNet15),
                .input2(s_logisimNet2),
                .result(s_logisimNet22));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_16 (.input1(s_logisimNet15),
                .input2(s_logisimNet3),
                .result(s_logisimNet40));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_17 (.input1(s_logisimNet15),
                .input2(s_logisimNet4),
                .result(s_logisimNet41));

   Demultiplexer_8   PLEXERS_18 (.demuxIn(s_logisimNet16),
                                 .demuxOut_0(s_logisimNet1),
                                 .demuxOut_1(s_logisimNet0),
                                 .demuxOut_2(s_logisimNet2),
                                 .demuxOut_3(s_logisimNet3),
                                 .demuxOut_4(s_logisimNet4),
                                 .demuxOut_5(s_logisimNet11),
                                 .demuxOut_6(),
                                 .demuxOut_7(),
                                 .enable(1'b1),
                                 .sel(s_logisimBus29[2:0]));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(4))
      MEMORY_19 (.clock(s_logisimNet21),
                 .clockEnable(s_logisimNet9),
                 .d(s_logisimBus26[3:0]),
                 .q(s_logisimBus44[3:0]),
                 .reset(1'b0),
                 .tick(1'b1));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(4))
      MEMORY_20 (.clock(s_logisimNet39),
                 .clockEnable(s_logisimNet9),
                 .d(s_logisimBus26[3:0]),
                 .q(s_logisimBus32[3:0]),
                 .reset(1'b0),
                 .tick(1'b1));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(4))
      MEMORY_21 (.clock(s_logisimNet22),
                 .clockEnable(s_logisimNet9),
                 .d(s_logisimBus26[3:0]),
                 .q(s_logisimBus45[3:0]),
                 .reset(1'b0),
                 .tick(1'b1));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(4))
      MEMORY_22 (.clock(s_logisimNet40),
                 .clockEnable(s_logisimNet9),
                 .d(s_logisimBus26[3:0]),
                 .q(s_logisimBus33[3:0]),
                 .reset(1'b0),
                 .tick(1'b1));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(4))
      MEMORY_23 (.clock(s_logisimNet41),
                 .clockEnable(s_logisimNet9),
                 .d(s_logisimBus26[3:0]),
                 .q(s_logisimBus34[3:0]),
                 .reset(1'b0),
                 .tick(1'b1));

   REGISTER_FLIP_FLOP #(.invertClock(0),
                        .nrOfBits(4))
      MEMORY_24 (.clock(s_logisimNet20),
                 .clockEnable(s_logisimNet9),
                 .d(s_logisimBus26[3:0]),
                 .q(s_logisimBus46[3:0]),
                 .reset(1'b0),
                 .tick(1'b1));


endmodule
