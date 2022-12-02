
`default_nettype none

module davidsiaw_stackcalc (
  input wire [7:0] io_in,
  output wire [7:0] io_out
);
  stack_cpu cpu(.io_in(io_in), .io_out(io_out));
endmodule
