/* Automatically generated from https://wokwi.com/projects/349803790984020562 */

`default_nettype none

module user_module_349803790984020562(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire net1 = io_in[0];
  wire net2 = io_in[1];
  wire net3 = io_in[2];
  wire net4 = io_in[3];
  wire net5 = io_in[4];
  wire net6 = io_in[5];
  wire net7 = 1'b1;
  wire net8;
  wire net9 = 1'b0;
  wire net10;
  wire net11;
  wire net12;
  wire net13;
  wire net14;
  wire net15;
  wire net16;
  wire net17;
  wire net18;
  wire net19;
  wire net20;
  wire net21 = 1'b0;

  xor_cell gate11 (
    .a (net2),
    .b (net5),
    .out (net8)
  );
  xor_cell gate7 (
    .a (net8),
    .b (net10),
    .out (net11)
  );
  and_cell gate8 (
    .a (net8),
    .b (net10),
    .out (net12)
  );
  and_cell gate9 (
    .a (net2),
    .b (net5),
    .out (net13)
  );
  or_cell gate10 (
    .a (net12),
    .b (net13),
    .out (net14)
  );
  xor_cell gate1 (
    .a (net3),
    .b (net6),
    .out (net15)
  );
  xor_cell gate2 (
    .a (net15),
    .b (net14),
    .out (net16)
  );
  and_cell gate3 (
    .a (net15),
    .b (net14),
    .out (net17)
  );
  and_cell gate4 (
    .a (net3),
    .b (net6),
    .out (net18)
  );
  or_cell gate5 (
    .a (net17),
    .b (net18),
    .out (net19)
  );
  and_cell gate6 (
    .a (net1),
    .b (net4),
    .out (net10)
  );
  xor_cell gate12 (
    .a (net1),
    .b (net4),
    .out (net20)
  );
endmodule
