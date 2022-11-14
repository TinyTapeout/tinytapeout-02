
`default_nettype none

module xyz_peppergray_Potato1_top(
  input [7:0] io_in,
  output [7:0] io_out
);

  localparam INSTR_WITH   = 4;
  localparam INSTR_NUM    = 9;
  localparam CNTRL_WITH   = 9;
  localparam CMD_WITH     = 8;
  localparam LOOPCTR_WITH = 16;

  localparam CTRL_X_INC  = 0;
  localparam CTRL_X_DEC  = 1;
  localparam CTRL_A_INC  = 2;
  localparam CTRL_A_DEC  = 3;
  localparam CTRL_PUT    = 4;
  localparam CTRL_GET    = 5;
  localparam CTRL_LOOP   = 6;
  localparam CTRL_DONE   = 7;
  localparam CTRL_HALT   = 8;

  localparam X_PC_INC  = 0;
  localparam X_PC_DEC  = 1;

  localparam CMD_OFFSET = 2;

  wire Clock   = io_in[0];
  wire Reset_n = io_in[1];

  reg ZeroFlag;
  reg IOWait;
  reg [INSTR_WITH-1:0] Instruction;

  /* Input */  
  always @(posedge Clock or negedge Reset_n) begin
    if(~Reset_n) begin
      Instruction <= 4'b1111; /* Halt */
      ZeroFlag    <= 0;
      IOWait      <= 0;
    end
    else begin
      Instruction <= io_in[7:4];
      ZeroFlag    <= io_in[3];
      IOWait      <= (IOActivity && io_in[2]);
    end
  end

  /* Instruction Decode */  
  reg [INSTR_NUM-1:0] MicroInstruction;
  
  always @ * begin
    case(Instruction)
      4'b0000: begin MicroInstruction <= (1 << CTRL_X_INC); end
      4'b0001: begin MicroInstruction <= (1 << CTRL_X_DEC); end
      4'b0010: begin MicroInstruction <= (1 << CTRL_A_INC); end
      4'b0011: begin MicroInstruction <= (1 << CTRL_A_DEC); end
      4'b0100: begin MicroInstruction <= (1 << CTRL_PUT);   end
      4'b0101: begin MicroInstruction <= (1 << CTRL_GET);   end
      4'b0110: begin MicroInstruction <= (1 << CTRL_LOOP);  end
      4'b0111: begin MicroInstruction <= (1 << CTRL_DONE);  end
      4'b1111: begin MicroInstruction <= (1 << CTRL_HALT);  end
      default: begin MicroInstruction <= 0; /* CTRL_NOP */  end
    endcase
  end

  /* Loop Control */
  reg reverse;
  reg skipCmd;  
  wire Reverse = setReverse | (reverse & ~clrReverse);
  wire SkipCmd = setSkipCmd | (skipCmd & ~clrSkipCmd);

  wire Loop = MicroInstruction[CTRL_LOOP];
  wire Done = MicroInstruction[CTRL_DONE];

  wire setSkipCmd_L =!reverse && !skipCmd & ZeroFlag;
  wire clrReverse_L = reverse && markMatch;
  wire clrSkipCmd_L = skipCmd && clrReverse;

  wire setReverse_D = !reverse && !skipCmd && !ZeroFlag;
  wire setSkipCmd_D = setReverse;
  wire clrSkipCmd_D = skipCmd && markMatch;

  wire setSkipCmd = Loop ? setSkipCmd_L : Done ? setSkipCmd_D : 0;
  wire clrSkipCmd = Loop ? clrSkipCmd_L : Done ? clrSkipCmd_D : 0;
  wire setReverse = Done ? setReverse_D : 0;
  wire clrReverse = Loop ? clrReverse_L : 0;

  wire Count = !((!reverse && setReverse) || (reverse && clrReverse));
  wire Up    = Count && (reverse ? Done : Loop);
  wire Down  = Count && (reverse ? Loop : Done);
  wire Store = setSkipCmd;
  
  reg [LOOPCTR_WITH-1:0] LoopCounter;
  reg [LOOPCTR_WITH-1:0] LoopJmpMark;
  wire markMatch     = (LoopJmpMark == LoopCounter);

  always @(negedge Clock or negedge Reset_n) begin
    if(~Reset_n) begin
      LoopCounter <= 0;
      LoopJmpMark <= 0;
      reverse     <= 0;
      skipCmd     <= 0;
    end
    else begin
      LoopCounter <= LoopCounter + (Count ? (Up ? 1 : Down ? -1 : 0) : 0);
      LoopJmpMark <= (Store ? LoopCounter + (Up ? 1 : Down ? -1 : 0) : LoopJmpMark);
      reverse     <= clrReverse ? 0 : setReverse ? 1 : reverse;
      skipCmd     <= clrSkipCmd ? 0 : setSkipCmd ? 1 : skipCmd;
    end
  end

  /* Execution Control */
  reg [CNTRL_WITH-1:0] Control;
  
  always @ * begin
    Control = IOWait ? Control : SkipCmd ? 0 : MicroInstruction;
  end

  /* ProgramCounter */
  wire [1:0] Control_PC;
    
  assign Control_PC[X_PC_INC] = ~Reverse & ~(Control[CTRL_HALT] | IOWait);
  assign Control_PC[X_PC_DEC] =  Reverse & ~(Control[CTRL_HALT] | IOWait);

  /* Output */
  reg [CMD_WITH-1:0] Command;
  assign io_out = Command;

  wire IOActivity = (Command[CMD_OFFSET + CTRL_GET] || Command[CMD_OFFSET + CTRL_PUT]);

  always @(negedge Clock or negedge Reset_n) begin
    if(~Reset_n) begin
      Command <= 0;
    end
    else begin
      Command <= { Control[5:0], Control_PC[1:0]};
    end
  end

endmodule
