`timescale 100fs/100fs
`define default_netname none

// a small shim to get names lined up correctly.
// - tinytapeout expects all named "io_{in,out}"; this is possible in clash but annoying for grabbing clock and reset
// - tinytapeout expects unique name, here just prefixing with my github username
// this is written with the constraint as to be doing basically nothing.

module jleightcap_top( input wire  [7:0] io_in
                     , output wire [7:0] io_out
                     );

    top _top( .clk(io_in[0])
            , .rst(io_in[1])
            , .instr(io_in[7:2])
            , .io_out(io_out)
            );

endmodule
