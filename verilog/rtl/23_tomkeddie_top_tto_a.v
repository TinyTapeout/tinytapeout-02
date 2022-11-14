`default_nettype none

module tomkeddie_top_tto_a
  #(parameter CLOCK_RATE=1000)
  (
   input [7:0]  io_in,
   output [7:0] io_out
   );
  
  wire                      clk   = io_in[0];
  wire                      reset = io_in[1];
  wire                      uart_tx_pin0;
  wire                      uart_tx_pin1;
  wire                      uart_tx_pin2;

  assign io_out[0] = uart_tx_pin0;
  assign io_out[1] = uart_tx_pin1;
  assign io_out[2] = uart_tx_pin2;

  // instatiate lcd
  uart_tx uart_tx(.clk(clk), .reset(reset), .tx_pin0(uart_tx_pin0), .tx_pin1(uart_tx_pin1), .tx_pin2(uart_tx_pin2));
  
endmodule
