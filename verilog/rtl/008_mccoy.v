/*
* Aidan Good
* mccoy.v
* top level module for the McCoy microprocessor
*/

`default_nettype none

module aidan_McCoy(
    input [7:0] io_in,
    output [7:0] io_out);

    // map i/o to proper labels
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire [5:0] instr = io_in[7:2];
    
    // decode signals
    wire bez;
    wire ja;
    //wire aluFun;
    wire op1Sel;
    wire op2Sel;
    wire writeReg;
    wire writex8;
    wire [1:0] x8Sel;
    
    // Other wires
    wire [7:0] pc;
    wire [7:0] pc1;
    wire [7:0] nextPC;
    wire pcSel;
    wire [7:0] aluOut;
    wire [7:0] x8;
    wire [7:0] newx8;
    wire [7:0] op1;
    wire [7:0] op2;
    wire [7:0] regOut;
    wire [7:0] imm;
    wire [7:0] notx8;

    /* Misc. blocks */ 
    
    decoder decoderBlock( .opcode(instr[2:0]), .bez(bez), .ja(ja), /*.aluFun(aluFun),*/ .op1(op1Sel), .op2(op2Sel),
                            .writeReg(writeReg), .writex8(writex8), .x8Sel(x8Sel));
                            
    iSign signBlock( .imm(instr[5:3]), .out(imm));
    
    /* PC related blocks */
    
    mux2 pcMux( .in0(aluOut), .in1(pc1), .sel(pcSel), .out(nextPC));
    
    pc pcBlock( .clk(clk), .reset(reset), .nextPC(nextPC), .PC(pc));
    
    add1 adder( .in(pc), .out(pc1));
    
    branch branchBlock( .x8(x8), .bez(bez), .ja(ja), .reset(reset), .pcSel(pcSel));
    
    /* ALU blocks */
    
    mux2 op1Mux( .in0(regOut), .in1(x8), .sel(op1Sel), .out(op1));
    
    mux2 op2Mux( .in0(regOut), .in1(pc), .sel(op2Sel), .out(op2));
    
    alu aluBlock( .op1(op1), .op2(op2), /*.aluFun(aluFun),*/ .aluOut(aluOut));
    
    /* x8 and other register blocks */
    
    register regBlock( .clk(clk), .reset(reset), .regAddr(instr[5:3]), .x8(x8), .writeReg(writeReg),
                        .out(regOut));
                        
    x8 x8Block( .clk(clk), .writex8(writex8), .newx8(newx8), .x8(x8));
    
    notx8 nx8( .x8(x8), .out(notx8));
    
    mux4 x8Mux( .in0(regOut), .in1(imm), .in2(aluOut), .in3(notx8), .sel(x8Sel), .out(newx8));
    
    
    assign io_out = clk ?  pc : x8;

    
endmodule
    
