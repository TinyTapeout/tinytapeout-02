module femto_top 
#(
    parameter OPSIZE = 3, //Number of opcodes, power of 2 (3 => 2**3 = 8 opcodes)
    parameter  NUMRF = 2,  //Number of registers in register file, power of 2 (2 => 2**2 = 4 registers)
    parameter   SIZE = 4 //Size of data in bits
)
(
    input  [7:0] io_in,
    output [7:0] io_out
);
wire clk=io_in[0];

//Decode
wire[OPSIZE-1:0]    op=io_in[1+:OPSIZE];                         //opcode wire
wire  [NUMRF-1:0] reg_0=io_in[1+OPSIZE+:NUMRF];                  //register address 0 (Dest)
wire  [NUMRF-1:0] reg_1=io_in[1+OPSIZE+NUMRF+:NUMRF];            //register address 1 (Src)
wire [(7-OPSIZE-2*NUMRF)-1:0] extra=io_in[7-:7-OPSIZE+2*NUMRF];  //Extra wires (if opcode and number of registers are small enough)
wire valid=(op=={(OPSIZE){1'b1}})?1:0;
wire rd=(op!=3'h6&&op!=3'h0&&op!=3'h1);
wire wr=(op==3'h6);
reg[3:0] value;

wire [SIZE-1:0] data_0,data_1,data_out;

reg_file #( .NUMRF(NUMRF),  .SIZE(SIZE))  rf (.clk(clk), .rd(rd), .wr(wr), .reg_out(reg_1),.reg_in(reg_0),.data_in(data_0),.data_out(data_1));

//Execute
alu_gen  #(.OPSIZE(OPSIZE), .SIZE(SIZE)) alu (.clk(clk), .op(op),.inp(data_1),.outp(data_out));

//Output

assign data_0=data_out;

always @(posedge clk) begin
    if(valid==1) begin
        value<=data_out;
    end
end

seg7 seg(.value(value),.segments(io_out[6:0]));
endmodule
