`default_nettype none

module luthor2k_top_tto
  #(parameter CLOCK_RATE=9600)
  (
   input [7:0]  io_in,
   output [7:0] io_out
   );
  
  // INPUTS
  wire                      clk_ascii   = io_in[0];
  wire                      clk_baudot = io_in[1];
  wire                      baudot_input = io_in[2];
  
  // OUTPUTS
  wire                      ascii_serial_output;
  wire                      baudot_ready_out;
  wire               [4:0]  baudot_byte_out;

  assign io_out[0] = ascii_serial_output;
  assign io_out[1] = baudot_ready_out;  
  //assign io_out[2] = 
  assign io_out[3] = baudot_byte_out[0];
  assign io_out[4] = baudot_byte_out[1];
  assign io_out[5] = baudot_byte_out[2];
  assign io_out[6] = baudot_byte_out[3];
  assign io_out[7] = baudot_byte_out[4];

  // instatiate converter  .function_pin(top_pin)
  main main(.v65b531(clk_ascii), .v3c4a34(clk_baudot), .vcb44a7(baudot_input), .v7c2fea(ascii_serial_output), .v40cda4(baudot_ready_out), .v4d3fdd(baudot_byte_out));
  
endmodule
