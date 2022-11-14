`default_nettype none
module tt2_tholin_multiplier(
    input [7:0] io_in,
    output [7:0] io_out
);
   wire s_A0 = io_in[0];
   wire s_A1 = io_in[1];
   wire s_A2 = io_in[2];
   wire s_A3 = io_in[3];
   wire s_B0 = io_in[4];
   wire s_B1 = io_in[5];
   wire s_B2 = io_in[6];
   wire s_B3 = io_in[7];
   wire s_R0;
   wire s_R1;
   wire s_R2;
   wire s_R3;
   wire s_R4;
   wire s_R5;
   wire s_R6;
   wire s_R7;
   assign io_out[0] = s_R0;
   assign io_out[1] = s_R1;
   assign io_out[2] = s_R2;
   assign io_out[3] = s_R3;
   assign io_out[4] = s_R4;
   assign io_out[5] = s_R5;
   assign io_out[6] = s_R6;
   assign io_out[7] = s_R7;
   main   CIRCUIT_0 (.A0(s_A0),
                     .A1(s_A1),
                     .A2(s_A2),
                     .A3(s_A3),
                     .B0(s_B0),
                     .B1(s_B1),
                     .B2(s_B2),
                     .B3(s_B3),
                     .R0(s_R0),
                     .R1(s_R1),
                     .R2(s_R2),
                     .R3(s_R3),
                     .R4(s_R4),
                     .R5(s_R5),
                     .R6(s_R6),
                     .R7(s_R7));
endmodule
