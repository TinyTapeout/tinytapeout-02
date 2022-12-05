module c_tt2_mrcs_test (
  input [7:0] io_in,
  output [7:0] io_out  
);

wire net_0 = io_in[0];
wire net_1 = net_0;
wire net_2 = net_0;
wire net_3 = net_0;
wire net_4 = net_0;
wire net_5 = io_in[1];
wire net_6 = net_5;
wire net_7 = net_5;
wire net_8 = net_5;

wire net_9;
wire net_10;
wire net_11;
wire net_12;
wire net_13;
wire net_14;
wire net_15;
wire net_16;
wire net_17;
wire net_18;

assign io_out[0] = net_9;
assign io_out[1] = net_10;
assign io_out[2] = net_11;
assign io_out[3] = net_12;
assign io_out[4] = net_13;
assign io_out[5] = net_14;
assign io_out[6] = net_15;
assign io_out[7] = net_16;

c_BIN_DFF SavedGate_0 (
.in_0(net_1),
.in_1(net_6),
.out_0(net_10),
.out_1(net_11),
.out_2(net_17),
.out_3(net_18)
);

c_BIN_ZOOK_DLATCH SavedGate_1 (
.in_0(net_0),
.in_1(net_5),
.out_0(net_9)
);

c_BIN_NAND_DLATCH SavedGate_2 (
.in_1(net_2),
.in_0(net_7),
.out_0(net_12),
.out_1(net_13)
);

c_BIN_EDGE_DETECTOR SavedGate_3 (
.in_0(net_4),
.out_0(net_16)
);

c_BIN_NAND_SR_LATCH SavedGate_4 (
.in_0(net_3),
.in_1(net_8),
.out_0(net_14),
.out_1(net_15)
);

endmodule

module c_BIN_DFF (
     input [0:0] in_0,
     input [0:0] in_1,
     output [0:0] out_0,
     output [0:0] out_1,
     output [0:0] out_2,
     output [0:0] out_3
);

wire net_0 = in_0;
wire net_1 = net_0;
wire net_2 = in_1;

wire net_3;
wire net_4;
wire net_5;
wire net_6 = net_4;
wire net_7;
wire net_8;

assign out_0 = net_5;
assign out_1 = net_6;
assign out_2 = net_7;
assign out_3 = net_8;

f_2 LogicGate_0 (
.in_0(net_0),
.out_0(net_3)
);

c_BIN_NAND_DLATCH SavedGate_0 (
.in_0(net_2),
.in_1(net_3),
.out_0(net_4),
.out_1(net_8)
);

c_BIN_NAND_DLATCH SavedGate_1 (
.in_1(net_1),
.in_0(net_4),
.out_0(net_5),
.out_1(net_7)
);

endmodule

module c_BIN_EDGE_DETECTOR (
     input [0:0] in_0,
     output [0:0] out_0
);

wire net_0 = in_0;
wire net_1 = net_0;

wire net_2;
wire net_3;
wire net_4;
wire net_5;

assign out_0 = net_5;

f_K00 LogicGate_0 (
.in_1(net_0),
.in_0(net_4),
.out_0(net_5)
);

f_2 LogicGate_1 (
.in_0(net_1),
.out_0(net_2)
);

f_2 LogicGate_2 (
.in_0(net_2),
.out_0(net_3)
);

f_2 LogicGate_3 (
.in_0(net_3),
.out_0(net_4)
);

endmodule

module c_BIN_NAND_DLATCH (
     input [0:0] in_0,
     input [0:0] in_1,
     output [0:0] out_0,
     output [0:0] out_1
);

wire net_0 = in_0;
wire net_1 = net_0;
wire net_2 = in_1;
wire net_3 = net_2;

wire net_4;
wire net_5;
wire net_6;
wire net_7;
wire net_8;

assign out_0 = net_7;
assign out_1 = net_8;

f_22Z LogicGate_0 (
.in_1(net_0),
.in_0(net_2),
.out_0(net_4)
);

f_22Z LogicGate_1 (
.in_1(net_3),
.in_0(net_6),
.out_0(net_5)
);

f_2 LogicGate_2 (
.in_0(net_1),
.out_0(net_6)
);

c_BIN_NAND_SR_LATCH SavedGate_0 (
.in_0(net_4),
.in_1(net_5),
.out_0(net_7),
.out_1(net_8)
);

endmodule

module c_BIN_NAND_SR_LATCH (
     input [0:0] in_0,
     input [0:0] in_1,
     output [0:0] out_0,
     output [0:0] out_1
);

wire net_0 = in_0;
wire net_1 = in_1;

wire net_2;
wire net_3;
wire net_4 = net_2;
wire net_5 = net_3;

assign out_0 = net_4;
assign out_1 = net_5;

f_22Z LogicGate_0 (
.in_1(net_0),
.in_0(net_3),
.out_0(net_2)
);

f_22Z LogicGate_1 (
.in_1(net_2),
.in_0(net_1),
.out_0(net_3)
);

endmodule

module c_BIN_ZOOK_DLATCH (
     input [0:0] in_0,
     input [0:0] in_1,
     output [0:0] out_0
);

wire net_0 = in_0;
wire net_1 = in_1;

wire net_2;
wire net_3 = net_2;

assign out_0 = net_3;

f_Z00K00KKK LogicGate_0 (
.in_2(net_0),
.in_0(net_2),
.in_1(net_1),
.out_0(net_2)
);

endmodule

module f_2 (
     input wire in_0,
     output wire out_0
     );

     assign out_0 = (in_0 == 0);
endmodule

module f_22Z (
     input wire in_0,
     input wire in_1,
     output wire out_0
     );

     assign out_0 = (in_0 == 0 & in_1 == 0) | (in_0 == 0 & in_1 == 1) | (in_0 == 1 & in_1 == 0);
endmodule

module f_K00 (
     input wire in_0,
     input wire in_1,
     output wire out_0
     );

     assign out_0 = (in_0 == 1 & in_1 == 1);
endmodule

module f_Z00K00KKK (
     input wire in_0,
     input wire in_1,
     input wire in_2,
     output wire out_0
     );

     assign out_0 = (in_0 == 0 & in_1 == 1 & in_2 == 0) | (in_0 == 1 & in_1 == 1 & in_2 == 0) | (in_0 == 1 & in_1 == 0 & in_2 == 1) | (in_0 == 1 & in_1 == 1 & in_2 == 1);
endmodule

