// 8 inputs
// 8 outputs

// 4 bit input value (switches)
// reset
// do arithmetic
// 2 bits for +, -, ^, <<
// I would have done & and | but doing those operations with 
//    an 8-bit number and 3-bit number wasn't that useful

// 2 7-segment displays

module sophialiCMU_math (
  input logic [7:0] io_in,
  output logic [7:0] io_out  
);
  
  logic clock, reset, en;
  logic [2:0] in;
  logic [1:0] arithOp;
  
  always_comb begin
    clock = io_in[0];
    reset = io_in[1];
    en = io_in[2];
    in = io_in[3:5];
    arithOp = io_in[6:7];
  end

  logic enable;
  enum logic {IDLE, GO} state, nextState;

  // ALU
  always_ff @(posedge clock, posedge reset) begin
    if (reset)
      io_out <= 0;
    else begin
      if (enable)
        unique case (arithOp)
          2'b00: io_out <= io_out + in;  // add
          2'b01: io_out <= io_out - in;  // subtract
          2'b10: io_out <= io_out ^ {5'b0, in};  // XOR per bit
          2'b11: io_out <= io_out << in;  // Left-shift per bit
        endcase
    end
  end

  // FF to ensure button for enable isn't continuously set
  always_ff @(posedge clock, posedge reset) begin
    if (reset)
      state <= IDLE;
    else begin
      state <= nextState; 
    end
  end

  assign enable = (state == IDLE && nextState == GO);
  always_comb begin
    if (state == IDLE) begin
      nextState = (en) ? GO : IDLE;
    end
    else
      nextState = (en) ? GO : IDLE;
  end

endmodule: sophialiCMU_math
