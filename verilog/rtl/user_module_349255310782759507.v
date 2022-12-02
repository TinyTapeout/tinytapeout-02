/* Automatically generated from https://wokwi.com/projects/349255310782759507 */

`default_nettype none

module user_module_349255310782759507(
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
  wire net11 = 1'b0;
  wire net12 = 1'b1;
  wire net13 = 1'b1;
  wire net14;
  wire net15;
  wire net16;
  wire net17;
  wire net18;
  wire net19 = 1'b1;
  wire net20;
  wire net21;
  wire net22;
  wire net23;
  wire net24;
  wire net25;
  wire net26;

  assign io_out[0] = net9;
  assign io_out[3] = net10;

  mux_cell mux1 (
    .a (net14),
    .b (net15),
    .sel (net16),
    .out (net17)
  );
  mux_cell mux2 (
    .a (net18),
    .b (net19),
    .sel (net16),
    .out (net20)
  );
  mux_cell mux3 (
    .a (net17),
    .b (net20),
    .sel (net21),
    .out (net9)
  );
  buffer_cell gate1 (
    .in (net1),
    .out (net16)
  );
  buffer_cell gate2 (
    .in (net2),
    .out (net21)
  );
  buffer_cell gate3 (
    .in (net3),
    .out (net14)
  );
  mux_cell mux4 (
    .a (net22),
    .b (net23),
    .sel (net16),
    .out (net24)
  );
  mux_cell mux5 (
    .a (net25),
    .b (net19),
    .sel (net16),
    .out (net26)
  );
  mux_cell mux6 (
    .a (net24),
    .b (net26),
    .sel (net21),
    .out (net10)
  );
  buffer_cell gate4 (
    .in (net4),
    .out (net22)
  );
  buffer_cell gate5 (
    .in (net5),
    .out (net15)
  );
  buffer_cell gate6 (
    .in (net6),
    .out (net23)
  );
  buffer_cell gate7 (
    .in (net7),
    .out (net18)
  );
  buffer_cell gate8 (
    .in (net8),
    .out (net25)
  );
endmodule
