`default_nettype none

module xor_shift32_evango #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire [6:0] led_out;
    assign io_out[6:0] = led_out;
    wire [5:0] seed_input = io_in[7:2];

    // external clock is 1000Hz, so need 10 bit counter
    reg [9:0] second_counter;
    reg [3:0] digit;
    reg unsigned [31:0] inital_state;

    always @(posedge clk) begin
        // Seed Setting
        if (reset) begin
            inital_state <= {26'b00000000000000000000000000, seed_input};
            second_counter <= 0;
            digit <= 0;
        end else begin
            // if up to 16e6
            if (second_counter == MAX_COUNT) begin
                // reset
                second_counter <= 0;
                
                inital_state = inital_state ^ (inital_state << 13);
                inital_state = inital_state ^ (inital_state >> 17);
                inital_state = inital_state ^ (inital_state << 5);

                // increment digit
                digit <= {1'b0, inital_state[2:0]};
            end else 
                // increment counter
                second_counter <= second_counter + 1'b1;
        end
    end

    // instantiate segment display
    seg7 seg7(.counter(digit), .segments(led_out));

endmodule
