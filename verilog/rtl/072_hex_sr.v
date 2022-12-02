// Hex shift register
// Copyright 2022 Eric Smith <spacewar@gmail.com>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module hex_sr #( parameter LENGTH = 40 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
   wire clk;
   wire recirc;
   wire [5:0] data_in;

   wire [5:0] data_out;

   assign clk = io_in[0];
   assign recirc = io_in[1];
   assign data_in = io_in[7:2];

   assign io_out[7:2] = data_out;
   assign io_out[1:0] = 2'b0;

   genvar i;
   generate
      for (i = 0; i < 6; i = i + 1)
	sr_recirc #(.LENGTH(LENGTH)) sr0(clk, recirc, data_in[i], data_out[i]);
   endgenerate

endmodule
