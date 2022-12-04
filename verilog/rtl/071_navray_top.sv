// Title:  Top-level wrapper in SystemVerilog
// File:   navray_top.sv
// Author: Wallace Everest
// Date:   23-NOV-2022
// URL:    https://github.com/navray/tt02-square-root
//
// Description:
//   The square-root of an unsigned 7-bit input is displayed on a 7-segment output.
//   The decimal point is unused.
//   Pipeline delay is 5 clocks.
// Implementation:
//   TinyTapeout-02 constraints identify io_in[0] as a clock tree.
//   FPGA synthesis reports 46 flip-flops
// Stye Guide:
//   https://github.com/lowRISC/style-guides/blob/master/VerilogCodingStyle.md

`default_nettype none

localparam K_WIDTH = 8;  // size must be even

module navray_top (
  input  wire [7:0] io_in,
  output wire [7:0] io_out
);
  logic                 clk;
  logic [K_WIDTH-1:0]   data_in;
  logic [K_WIDTH/2-1:0] sqrt_val;
  
  assign clk = io_in[0];
  assign data_in = {1'b0, io_in[7:1]};
  
  sqrt #(
    .G_WIDTH(K_WIDTH)
  ) sqrt_inst (
    .clk     (clk),
    .data_in (data_in),
    .data_out(sqrt_val)
  );

  seg7 seg7_inst (
    .clk     (clk),
    .data_in (sqrt_val),
    .segments(io_out)
  );
endmodule
