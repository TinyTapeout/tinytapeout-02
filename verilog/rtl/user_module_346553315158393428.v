/* Automatically generated from https://wokwi.com/projects/346553315158393428 */

`default_nettype none

module user_module_346553315158393428(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[4];
  wire net6;
  wire net7 = 1'b0;
  wire net8 = 1'b1;
  wire net9;
  wire net10;

  assign io_out[0] = net6;

  xor_cell gate3 (
    .a (net9),
    .b (net4),
    .out (net10)
  );
  mux_cell mux1 (
    .a (net1),
    .b (net2),
    .sel (net3),
    .out (net9)
  );
  xor_cell gate1 (
    .a (net10),
    .b (net5),
    .out (net6)
  );
endmodule
