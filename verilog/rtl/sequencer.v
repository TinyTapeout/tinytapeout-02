`default_nettype none

module loxodes_sequencer (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire enable = io_in[2];
    wire [4:0] delay;
    assign delay = io_in[7:3];
    
    wire [7:0] channel;
    assign io_out[7:0] = channel;
    assign channel = channel_state;

    reg [4:0] counter;
    reg [7:0] channel_state;
    reg [3:0] channel_index;

    always @(posedge clk) begin
        // if reset, set counter to 0
        if (reset) begin
            counter <= 0;
            channel_state <= 0;
            channel_index <= 0;
        end else begin
            if (enable) begin
                if (counter == delay && channel_index < 8) begin
                    counter <= 0;
                    channel_index <= channel_index + 1'b1;
                    channel_state <= channel_state + (1'b1 << channel_index);
                end else begin
                    counter <= counter + 1'b1;
                end
            end else begin
                if (counter == delay && channel_index > 0) begin
                    counter <= 0;
                    channel_index <= channel_index - 1'b1;
                    channel_state <= (channel_state >> 1);
                end else begin
                    counter <= counter + 1'b1;
                end

            end
        end
    end
endmodule
