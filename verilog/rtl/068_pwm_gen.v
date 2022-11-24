`default_nettype none

module pwm_gen (
  input [7:0] io_in,
  output [7:0] io_out
);
  
wire clk = io_in[0];
wire reset = io_in[1];
reg counter_state;
reg [5:0] pwm_counter;
reg [6:0] duty;
reg pwm;
assign io_out = {duty, pwm};

  //upcounter which determines pwm period 
always @(posedge clk) begin
    if (reset)
        pwm_counter <= 0;
    else
        pwm_counter <= pwm_counter + 1;
end
  //duty state machine to determine countup or countdown
always @(posedge clk) begin
    if (reset) begin
        counter_state = 0;
    end else begin
            case (counter_state)
                0:
                    if (duty == 8'b111110)
                        counter_state = 1;
                    else
                        counter_state = 0;
                1:
                    if (duty == 8'b000001)
                        counter_state = 0;
                    else
                        counter_state = 1;
            endcase
    end
end
  //generate duty
always @(posedge clk) begin
    if (reset) begin
        duty <= 0;
    end else begin
        if (pwm_counter == 6'b000000) begin
            if (counter_state == 0) begin
                duty <= duty + 1;
            end else if(counter_state == 1) begin
                duty <= duty - 1;
            end
        end
    end
end
  //generate pwm where duty determines it's duty cycle
always @(posedge clk) begin
    if(reset) begin
        pwm <= 0;
    end else begin
        if (pwm_counter == 6'b000000) begin
            pwm <= 1;
        end else if (pwm_counter == duty[6:0]) begin
            pwm <= 0;
        end
    end
end

endmodule
