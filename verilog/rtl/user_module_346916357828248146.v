/* Automatically generated from https://wokwi.com/projects/346916357828248146 */

`default_nettype none

module user_module_346916357828248146(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[4];
  wire net6 = io_in[5];
  wire net7 = io_in[6];
  wire net8 = io_in[7];
  wire net9;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15 = 1'b0;
  wire net16 = 1'b1;
  wire net17 = 1'b1;

  assign io_out[0] = net9;
  assign io_out[1] = net10;
  assign io_out[2] = net11;
  assign io_out[4] = net12;
  assign io_out[5] = net13;
  assign io_out[6] = net14;

  xor_cell gate3 (
    .a (net9),
    .b (net4),
    .out (net10)
  );
  nand_cell gate4 (
    .a (net10),
    .b (net14),
    .out (net11)
  );
  mux_cell mux1 (
    .a (net1),
    .b (net2),
    .sel (net3),
    .out (net9)
  );
  nand_cell nand1 (
    .a (net13),
    .b (net11),
    .out (net14)
  );
  mux_cell mux2 (
    .a (net5),
    .b (net6),
    .sel (net7),
    .out (net12)
  );
  xor_cell xor1 (
    .a (net12),
    .b (net8),
    .out (net13)
  );
endmodule
