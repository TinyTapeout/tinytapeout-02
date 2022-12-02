`default_nettype none

module vaishnavachath_rotary_toplevel (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire clk_in = io_in[0];
    wire reset = io_in[1];
    wire rt_a;
    wire rt_b;
    wire tm_enable = io_in[4];
    wire [6:0] led_out;
    assign io_out[6:0] = led_out;
    reg [3:0] enc_byte = 0;
    reg [3:0] counter = 0;
    reg rt_a_delayed, rt_b_delayed, clk_msb_delayed;
    assign rt_a = tm_enable ? counter[3] : io_in[2];
    assign rt_b = tm_enable ? clk_msb_delayed : io_in[3];
    wire count_enable = rt_a ^ rt_a_delayed ^ rt_b ^ rt_b_delayed;
    wire count_direction = rt_a ^ rt_b_delayed;

    always @(posedge clk_in) rt_a_delayed <= rt_a;
    always @(posedge clk_in) rt_b_delayed <= rt_b;
    always @(posedge clk_in) clk_msb_delayed <= counter[3];

    always @(posedge clk_in) begin
         if(count_enable) begin
            if(count_direction) enc_byte<=enc_byte+1; else enc_byte<=enc_byte-1;
        end
    end


    always @(posedge clk_in) begin
        if (reset) begin
            counter <= 0;
        end else begin
            counter <= counter + 1'b1;
        end
    end

    seg7 seg7(.counter(enc_byte), .segments(led_out));

endmodule
