//-------------------------------------------------------------------
// Title       : asic_multiplier_wrapper.v
// Author      : Fernando Dominguez Pousa
// Created     : 12/11/2022
// Description : Wrapper to fulfill TT02 interface requirements
//-------------------------------------------------------------------

`default_nettype none

module asic_multiplier_wrapper (
    input  [7:0] io_in ,
    output [7:0] io_out
);

    // Instantiate the multiplier
    asic_multiplier asic_multiplier_top (
        .clk        (io_in[0]   ),
        .reset      (io_in[1]   ),
        .i_factor_a (io_in[4:2] ),
        .i_factor_b (io_in[7:5] ),
        .o_segments (io_out[6:0]),
        .o_lsb_digit(io_out[7]  )
    );

endmodule