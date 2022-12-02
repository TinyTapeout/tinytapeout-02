`default_nettype none

module rglenn_hex_to_7_seg (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire latch = io_in[0];
    wire blank = io_in[1];
    wire [4:0] data = io_in[5:2];
    wire [6:0] led_out;
    assign io_out[6:0] = blank ? 7'b0000000 : led_out;
    assign io_out[7] = io_in[6]; // decimal point

    // external clock is 1000Hz, so need 10 bit counter
    reg [3:0] data_reg;

    always @(posedge latch) begin
        data_reg <= data;
    end

    // instantiate segment display
    hex2seg7 hex2seg7(.data(data_reg), .segments(led_out));

endmodule
