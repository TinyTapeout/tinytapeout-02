/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : REGISTER_FLIP_FLOP                                           **
 **                                                                          **
 *****************************************************************************/

module REGISTER_FLIP_FLOP( clock,
                           clockEnable,
                           d,
                           q,
                           reset,
                           tick );

   /*******************************************************************************
   ** Here all module parameters are defined with a dummy value                  **
   *******************************************************************************/
   parameter invertClock = 1;
   parameter nrOfBits = 1;

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input                clock;
   input                clockEnable;
   input [nrOfBits-1:0] d;
   input                reset;
   input                tick;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [nrOfBits-1:0] q;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_clock;

   /*******************************************************************************
   ** The registers are defined here                                             **
   *******************************************************************************/
   reg [nrOfBits-1:0] s_currentState;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   assign q = s_currentState;
   assign s_clock = invertClock == 0 ? clock : ~clock;

   always @(posedge s_clock or posedge reset)
   begin
      if (reset) s_currentState <= 0;
      else if (clockEnable&tick) s_currentState <= d;
   end

endmodule
