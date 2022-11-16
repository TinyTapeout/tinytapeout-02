`default_nettype none

module rc5_top (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire ir = io_in[2];
    wire [6:0] led_out;
    assign io_out[6:0] = led_out;

    wire valid;
    wire [5:0] command;
    wire control;
    reg control_d;
    localparam [5:0] RC5_INCR_VOLUME=16;
    localparam [5:0] RC5_DECR_VOLUME=17;

    rc5 rc5(
        .i_clk(clk),
        .i_rst(reset),

        .i_rc5(ir),

        .o_valid(valid),
        .o_command(command),
        .o_control(control)
    );

    reg [3:0] counter;
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            control_d <= 1'b0;
        end else begin
            if (valid) begin
                control_d <= control;

                if (control != control_d) begin
                    if (command == RC5_INCR_VOLUME) begin
                        counter <= counter+1;
                    end else if (command == RC5_DECR_VOLUME) begin
                        counter <= counter-1;
                    end
                end
            end
        end
    end

    // instantiate segment display
    seg7 seg7(.counter(counter), .segments(led_out));

endmodule
