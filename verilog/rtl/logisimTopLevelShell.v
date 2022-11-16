`default_nettype none
module tt2_tholin_multiplexed_counter(
   input [7:0] io_in,
   output [7:0] io_out
);
   wire s_A;
   wire s_B;
   wire s_C;
   wire s_CLK = io_in[0];
   wire s_D;
   wire s_E;
   wire s_F;
   wire s_G;
   wire s_RST = io_in[1];
   wire s_SEL;

   assign io_out[0] = s_A;
   assign io_out[1] = s_B;
   assign io_out[2] = s_C;
   assign io_out[3] = s_D;
   assign io_out[4] = s_E;
   assign io_out[5] = s_F;
   assign io_out[6] = s_G;
   assign io_out[7] = s_SEL;

   main   CIRCUIT_0 (.A(s_A),
                     .B(s_B),
                     .C(s_C),
                     .CLK(s_CLK),
                     .D(s_D),
                     .E(s_E),
                     .F(s_F),
                     .G(s_G),
                     .RST(s_RST),
                     .SEL(s_SEL));
endmodule
