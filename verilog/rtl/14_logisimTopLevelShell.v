`default_nettype none
module tholin_avalonsemi_5401(
   input [7:0] io_in,
   output [7:0] io_out
);

   wire s_CLK = io_in[0];
   wire s_RST = io_in[1];
   wire s_D0 = io_in[2];
   wire s_D1 = io_in[3];
   wire s_D2 = io_in[4];
   wire s_D3 = io_in[5];
   wire s_EF0 = io_in[6];
   wire s_EF1 = io_in[7];
   
   wire s_O_D0_RR0;
   wire s_O_D1_RR1;
   wire s_O_D2_RR2;
   wire s_O_D3_RR3;
   wire s_O_4_MAR;
   wire s_O_5_WRITE;
   wire s_O_6_JMP;
   wire s_O_7_I;
   assign io_out[0] = s_O_D0_RR0;
   assign io_out[1] = s_O_D1_RR1;
   assign io_out[2] = s_O_D2_RR2;
   assign io_out[3] = s_O_D3_RR3;
   assign io_out[4] = s_O_4_MAR;
   assign io_out[5] = s_O_5_WRITE;
   assign io_out[6] = s_O_6_JMP;
   assign io_out[7] = s_O_7_I;
   
   CPU   CIRCUIT_0 (.CLK(s_CLK),
                    .D0(s_D0),
                    .D1(s_D1),
                    .D2(s_D2),
                    .D3(s_D3),
                    .EF0(s_EF0),
                    .EF1(s_EF1),
                    .O_4_MAR(s_O_4_MAR),
                    .O_5_WRITE(s_O_5_WRITE),
                    .O_6_JMP(s_O_6_JMP),
                    .O_7_I(s_O_7_I),
                    .O_D0_RR0(s_O_D0_RR0),
                    .O_D1_RR1(s_O_D1_RR1),
                    .O_D2_RR2(s_O_D2_RR2),
                    .O_D3_RR3(s_O_D3_RR3),
                    .RST(s_RST));
endmodule
