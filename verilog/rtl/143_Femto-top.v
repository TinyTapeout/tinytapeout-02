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
reg[1:0] mode;

reg change_state;
reg[1:0] next_mode;

always @(*) begin
    if(io_in[3:1]==0&&io_in[7:6]==2'b10) 
    begin
        change_state=1'b1;
        next_mode=io_in[5:4];
    end
    else begin
        change_state=0;
        next_mode=0;
    end 
        
end

always @(posedge clk) begin
    if(change_state==1) begin
        mode<=next_mode;
    end
end

//Mode:
//00: No action
//01: Run (Read instruction buffer)
//10: Fill (Write instruction buffer)
//11: N/A

wire wren=mode[1]&&(io_in[3:1]!=0&&io_in[7:6]!=2'b10); //Don't write when changing state
wire rden=mode[0];
wire[6:0] instr_in=io_in[7:1];
wire[6:0] instr_out;

ibuffer 
#(
    .ENTRIES(6)
)
ibuf
(
    .clk(clk), .wren(wren), .rden(rden),
    .instr_in(instr_in),
    .instr_out(instr_out)
);

//Decode (from interface)
// wire[OPSIZE-1:0]     op=io_in[1+:OPSIZE];                        //opcode wire
// wire  [NUMRF-1:0] reg_0=io_in[1+OPSIZE+:NUMRF];                  //register address 0 (Dest)
// wire  [NUMRF-1:0] reg_1=io_in[1+OPSIZE+NUMRF+:NUMRF];            //register address 1 (Src)
wire[OPSIZE-1:0]                     op=instr_out[2:0];                        //opcode wire
wire  [NUMRF-1:0]                 reg_0=instr_out[4:3];                  //register address 0 (Dest)
wire  [NUMRF-1:0]                 reg_1=instr_out[6:5];            //register address 1 (Src)


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
