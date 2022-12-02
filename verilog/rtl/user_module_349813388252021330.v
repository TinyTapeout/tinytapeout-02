/* Automatically generated from https://wokwi.com/projects/349813388252021330 */

`default_nettype none

module user_module_349813388252021330(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[6];
  wire net5 = io_in[7];
  wire net6;
  wire net7;
  wire net8;
  wire net9 = 1'b1;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15;
  wire net16;

  assign io_out[0] = net6;
  assign io_out[1] = net7;
  assign io_out[2] = net8;

  and_cell gate1 (
    .a (net10),
    .b (net3),
    .out (net11)
  );
  or_cell gate2 (
    .a (net11),
    .b (net12),
    .out (net6)
  );
  xor_cell gate3 (
    .a (net10),
    .b (net3),
    .out (net13)
  );
  xor_cell gate7 (
    .a (net1),
    .b (net2),
    .out (net10)
  );
  and_cell gate4 (
    .a (net1),
    .b (net3),
    .out (net12)
  );
  and_cell gate5 (
    .a (net14),
    .b (net5),
    .out (net15)
  );
  or_cell gate6 (
    .a (net15),
    .b (net16),
    .out (net7)
  );
  xor_cell gate8 (
    .a (net14),
    .b (net5),
    .out (net8)
  );
  xor_cell gate9 (
    .a (net13),
    .b (net4),
    .out (net14)
  );
  and_cell gate10 (
    .a (net13),
    .b (net5),
    .out (net16)
  );
endmodule
