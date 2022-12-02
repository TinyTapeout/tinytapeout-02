`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2022 08:21:55
// Design Name: 
// Module Name: rotary_encoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module rotary_encoder (
  input wire [7:0] io_in,
  output wire [7:0] io_out
);

    wire clk = io_in[0];
    wire reset = io_in[1];
    wire encA = io_in[2];
    wire encB = io_in[3];
    wire [6:0] led_out;
    assign io_out[6:0] = led_out;
    assign io_out[7] = 0;
    
    reg [7:0] delay_counter;
    reg [3:0] digit;
    reg old_value;

    always @(posedge clk) begin
        // if reset, set counter to 0
        if (reset) begin
            digit <= 0;
            old_value <= encA;
            delay_counter <= 0;
        end else begin
            if (delay_counter != 0) begin
                delay_counter <= delay_counter - 1'b1;
            end
            if (encA == 1 && old_value == 0 && delay_counter == 0) begin
                delay_counter = 125; //IOrefreshrate = 12.5Khz => clock = 6.25KHz => delay 20ms = 125 cycles
                //rising edge on A
                if(encB == 0) begin
                    // increment digit
                    digit <= digit + 1'b1;
    
                    // only count from 0 to 9
                    if (digit == 9) begin
                        digit <= 0;
                    end
                end else begin
                    // decrement digit
                    if (digit == 0) begin
                        digit <= 9;
                    end else begin    
                        digit <= digit - 1'b1;
                    end 
                end             
            end
            old_value = encA;
        end
    end 

    // instantiate segment display
    seg7 seg7(.counter(digit), .segments(led_out));

endmodule
