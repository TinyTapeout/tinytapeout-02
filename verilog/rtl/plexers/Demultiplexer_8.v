/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : Demultiplexer_8                                              **
 **                                                                          **
 *****************************************************************************/

module Demultiplexer_8( demuxIn,
                        demuxOut_0,
                        demuxOut_1,
                        demuxOut_2,
                        demuxOut_3,
                        demuxOut_4,
                        demuxOut_5,
                        demuxOut_6,
                        demuxOut_7,
                        enable,
                        sel );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input       demuxIn;
   input       enable;
   input [2:0] sel;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output demuxOut_0;
   output demuxOut_1;
   output demuxOut_2;
   output demuxOut_3;
   output demuxOut_4;
   output demuxOut_5;
   output demuxOut_6;
   output demuxOut_7;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/
   assign demuxOut_0   = (enable&(sel == 3'b000 )) ? demuxIn : 0;
   assign demuxOut_1   = (enable&(sel == 3'b001 )) ? demuxIn : 0;
   assign demuxOut_2   = (enable&(sel == 3'b010 )) ? demuxIn : 0;
   assign demuxOut_3   = (enable&(sel == 3'b011 )) ? demuxIn : 0;
   assign demuxOut_4   = (enable&(sel == 3'b100 )) ? demuxIn : 0;
   assign demuxOut_5   = (enable&(sel == 3'b101 )) ? demuxIn : 0;
   assign demuxOut_6   = (enable&(sel == 3'b110 )) ? demuxIn : 0;
   assign demuxOut_7   = (enable&(sel == 3'b111 )) ? demuxIn : 0;
endmodule
