`default_nettype none

module poisonninja_top (
    input logic [7:0] io_in,
    output logic [7:0] io_out
);

    assign io_out[7:1] = 0;
    pwm_generator pwm(.clk(io_in[0]), .reset(io_in[1]), .duty(io_in[7:2]), .pwm_signal(io_out[0]));

endmodule