`default_nettype none

//
// top level module
//

module rolfmobile99_alu_fsm_top(
  input [7:0] io_in,
  output [7:0] io_out
);

  wire clk = io_in[7];
  wire reset = io_in[6];
  wire ctl_in = io_in[5];
  wire notused = io_in[4];
  wire [3:0] databus = io_in[3:0];

  assign io_out[4] = aluCout;
  assign io_out[3:0] = aluOut[3:0];

  wire [2:0] state_out;
  wire enA, enB, enM, enC, selC;
  wire rst_out;

  wire [3:0] aluA, aluB;	// tmp: to alu A input
  wire aluCout;
  wire aluZ;				// notused
  wire [3:0] aluOut;
  wire [3:0] aluOp;			// bit0: add=0, sub=1  bit1: enCin  bit2,3: unused
  wire op0;					// bit0 of above

  assign op0 = aluOp[0];


  // connect modules

  alu_fsm alu_fsm(
    .ctl(ctl_in),
    .curstate(state_out),
    .rst_out(rst_out),
    .enA(enA),
    .enB(enB),
    .enM(enM),
    .enC(enC),
    .selC(selC),
    .reset(reset),
    .clk(clk) );	// clk with 'clk' signal

  flop_4 regA(
    .dd(databus),
    .qq(aluA),
    .qEn(1'b1),		// always enable output
    .reset(rst_out),// clear on reset state
    .cEn(enA),
    .clk(clk) );	// clk with 'clk' signal

  flop_4 regB(
    .dd(databus),
    .qq(aluB),
    .qEn(1'b1),		// always enable output
    .reset(rst_out),// clear on reset state
    .cEn(enB),
    .clk(clk) );	// clk with 'clk' signal

  flop_4 regM(
    .dd(databus),
    .qq(aluOp),		// note: regM drives aluOp lines
    .qEn(1'b1),		// always enable output
    .reset(rst_out),// clear on reset state
    .cEn(enM),
    .clk(clk) );	// clk with 'clk' signal

  alu_4 alu(
    .op(op0),	// controls add/sub
    .a(aluA),
    .b(aluB),
    .cin(1'b0),		// tmp: carryin=0
    .out(aluOut),
    .z(aluZ),		// alu zero (notused)
    .cout(aluCout),
    .outEn(1'b1) );	// always enable output

endmodule
