`default_nettype none

module jglim_7seg(  
    input [7:0] io_in,
    output [7:0] io_out
);

hex7seg seg7(
    .counter(io_in[3:0]), 
    .dot(io_in[4]), 
    .inv(io_in[5]), 
    .segments(io_out[7:0])
);

endmodule