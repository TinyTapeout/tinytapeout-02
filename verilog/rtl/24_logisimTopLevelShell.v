`default_nettype none
module tholin_avalonsemi_tbb1143(
   input [7:0] io_in,
   output [7:0] io_out
);
   wire s_A0 = io_in[6];
   wire s_CLK = io_in[0];
   wire s_D0 = io_in[2];
   wire s_D1 = io_in[3];
   wire s_D2 = io_in[4];
   wire s_D3 = io_in[5];
   wire s_RST = io_in[1];
   wire [1:0] s_SOUT;
   wire s_WR = io_in[7];

   assign io_out[1:0] = s_SOUT;

   reg [4:0] shifter;

   always @(posedge s_CLK)
   begin
      shifter[4:1] <= shifter[3:0];
      shifter[0]   <= ~s_RST;
   end

   wire c2_1, c2_2, c2_3, c2_4, c2_5;
   assign c2_1 = c2_5 & shifter[0];
   assign c2_2 = c2_1 & shifter[1];
   assign c2_3 = c2_2 & shifter[2];
   assign c2_4 = c2_3 & shifter[3];
   assign c2_5 = c2_4 & shifter[4];

   main   CIRCUIT_0 (.A0(s_A0),
                     .CLK(s_CLK),
                     .D0(s_D0),
                     .D1(s_D1),
                     .D2(s_D2),
                     .D3(s_D3),
                     .FCLK(c2_5),
                     .RST(s_RST),
                     .SOUT0(s_SOUT[0]),
                     .SOUT1(s_SOUT[1]),
                     .WR(s_WR));
endmodule
