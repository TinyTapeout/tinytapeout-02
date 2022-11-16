module thezoq2_yafpga (
    input [7:0] io_in,
    output [7:0] io_out
    );

    wire[3:0] dummy;

    e_main main
        ( .clk_i(io_in[0])
        , .cfg_value_i(io_in[1])
        , .cfg_clk_i(io_in[2])
        , .inputs_unsync_i(io_in[7:3])
        , .output__({dummy, io_out[3:0]})
        );
endmodule
