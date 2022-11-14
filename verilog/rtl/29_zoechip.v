/*
      -- 1 --
     |       |
     6       2
     |       |
      -- 7 --
     |       |
     5       3
     |       |
      -- 4 --
      
      -- A --
     |       |
     B       C
     |       |
      --  D --
     |       |
     G       M
     |       |
      -- F --      
*/

module zoechip #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);

wire A,B,C,D,F,G,M;
assign io_out = { 1'b0, D,B,G,F,M,C,A };

wire Z = io_in[0];
wire O = io_in[1];
wire E = io_in[2];
wire f = io_in[3];

assign A = Z+O+E;
assign B =O+E+f;
assign C =Z+O+f;
assign D =Z+O+E+f; 
assign F = E+Z;
assign G =E+Z;
assign M = f;
      
endmodule
