`default_nettype none `timescale 1ns / 1ps
// coded by Hirosh Dabui 2012
// based on T-Bird tail-lights machine from digital design book
// table 9-20 in VHDL
/* verilator lint_off MULTITOP */
module thunderbird_taillight_ctrl #(
    parameter MAX_COUNT = 1000,
    parameter SYSTEM_FREQ = 6250,
    parameter HZ = 8
) (
    input  [7:0] io_in,
    output [7:0] io_out
);

  wire clk = io_in[0];
  wire reset = io_in[1];
  wire left = io_in[2];
  wire right = io_in[3];
  wire haz = io_in[4];

  wire [5:0] lights = state;
  assign io_out[7:0] = {2'b00, lights};

  wire div;
  divider #(
      .SYSTEM_FREQ(SYSTEM_FREQ),
      .HZ         (HZ)
  ) divider_i (
      .clk    (clk),
      .reset  (reset),
      .divider(div)
  );

  localparam IDLE = 6'b000_000;
  localparam L3 = 6'b111_000;
  localparam L2 = 6'b011_000;
  localparam L1 = 6'b001_000;
  localparam R3 = 6'b000_111;
  localparam R2 = 6'b000_110;
  localparam R1 = 6'b000_100;
  localparam LR3 = 6'b111_111;

  reg [5:0] state, next_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      if (div) begin
        state <= next_state;
      end
    end
  end

  always @(*) begin
    next_state = state;

    case (state)
      IDLE: begin
        case (1'b1)
          haz | (left & right): next_state = LR3;
          left: next_state = L1;
          right: next_state = R1;
          default: next_state = IDLE;
        endcase
      end

      L1: next_state = haz ? LR3 : L2;
      L2: next_state = haz ? LR3 : L3;
      L3: next_state = haz ? LR3 : IDLE;

      R1: next_state = haz ? LR3 : R2;
      R2: next_state = haz ? LR3 : R3;
      R3: next_state = haz ? LR3 : IDLE;

      LR3: next_state = IDLE;

      default: next_state = state;
    endcase
  end

endmodule

module divider #(
    parameter SYSTEM_FREQ = 6250,
    parameter HZ = 8
) (
    input  clk,
    input  reset,
    output divider
);
  localparam CYCLES = SYSTEM_FREQ / HZ;
  reg [$clog2(CYCLES) -1:0] cnt;
  always @(posedge clk) begin
    if (reset) begin
      cnt <= 0;
    end else begin
      cnt <= cnt + 1;
      /* verilator lint_off WIDTH */
      if (cnt >= (CYCLES - 1)) begin
        cnt <= 0;
      end
      /* verilator lint_on WIDTH */
    end
  end
  assign divider = cnt == 0;
endmodule
/* verilator lint_on MULTITOP */
