`timescale 1ns / 1ps

/* ALU Arithmetic and Logic Operations
----------------------------------------------------------------------
|opcode |   ALU Operation
----------------------------------------------------------------------
| 0000  |   ALU_Out = A + B;
----------------------------------------------------------------------
| 0001  |   ALU_Out = A - B;
----------------------------------------------------------------------
| 0010  |   ALU_Out = A * B;
----------------------------------------------------------------------
| 0011  |   ALU_Out = A / B;
----------------------------------------------------------------------
| 0100  |   ALU_Out = A << 1;
----------------------------------------------------------------------
| 0101  |   ALU_Out = A >> 1;
----------------------------------------------------------------------
| 0110  |   ALU_Out = A << B;
----------------------------------------------------------------------
| 0111  |   ALU_Out = A >> B;
----------------------------------------------------------------------
| 1000  |   ALU_Out = A and B;
----------------------------------------------------------------------
| 1001  |   ALU_Out = A or B;
----------------------------------------------------------------------
| 1010  |   ALU_Out = A xor B;
----------------------------------------------------------------------
| 1011  |   ALU_Out = A nor B;
----------------------------------------------------------------------
| 1100  |   ALU_Out = A nand B;
----------------------------------------------------------------------
| 1101  |   ALU_Out = A xnor B;
----------------------------------------------------------------------
| 1110  |   ALU_Out = 1 if A>B else 0;
----------------------------------------------------------------------
| 1111  |   ALU_Out = 1 if A=B else 0;
----------------------------------------------------------------------*/

module shan1293_2bitalu(
           input [7:0] io_in,                  
           output [7:0] io_out 
    );
         alu alu(
            .A(io_in[7:6]), 
            .B(io_in[5:4]), 
            .opcode(io_in[3:0]), 
            .ALU_Out(io_out[7:0])
            );
endmodule

module alu(
	input [1:0] A,
	input [1:0] B,
	input [3:0] opcode,
	output [7:0] ALU_Out
);

    reg [7:0] ALU_Result;
    assign ALU_Out = ALU_Result; // ALU out
    always @(*)
    begin
        case(opcode)
        4'b0000: // Addition
           ALU_Result = A + B ; 
        4'b0001: // Subtraction
           ALU_Result = A - B ;
        4'b0010: // Multiplication
           ALU_Result = A * B;
        4'b0011: // Division
           ALU_Result = A/B;
        4'b0100: // Logical shift left one time
           ALU_Result = A<<1;
         4'b0101: // Logical shift right one time
           ALU_Result = A>>1;
         4'b0110: // Logical shift left B times
           ALU_Result = A<<B;
         4'b0111: // Logical shift right B times
           ALU_Result = A>>B;
          4'b1000: //  Logical and 
           ALU_Result = A & B;
          4'b1001: //  Logical or
           ALU_Result = A | B;
          4'b1010: //  Logical xor 
           ALU_Result = A ^ B;
          4'b1011: //  Logical nor
           ALU_Result = ~(A | B);
          4'b1100: // Logical nand 
           ALU_Result = ~(A & B);
          4'b1101: // Logical xnor
           ALU_Result = ~(A ^ B);
          4'b1110: // Greater comparison
           ALU_Result = (A>B)?4'd1:4'd0 ;
          4'b1111: // Equal comparison   
            ALU_Result = (A==B)?4'd1:4'd0 ;
          default: ALU_Result = A + B ; 
        endcase
    end
 endmodule