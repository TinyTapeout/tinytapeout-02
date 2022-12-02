`default_nettype none

module aramsey118_freq_counter #(
    parameter DEPTH = 200
) (
  input wire [7:0] io_in,
  output wire [7:0] io_out
);

    // Precalculate the boundaries
    localparam integer freq_0 = $ceil(DEPTH * 0.0); // not used, here for completeness
    localparam integer freq_1 = $ceil(DEPTH * 0.1);
    localparam integer freq_2 = $ceil(DEPTH * 0.2);
    localparam integer freq_3 = $ceil(DEPTH * 0.3);
    localparam integer freq_4 = $ceil(DEPTH * 0.4);
    localparam integer freq_5 = $ceil(DEPTH * 0.5);
    localparam integer freq_6 = $ceil(DEPTH * 0.6);
    localparam integer freq_7 = $ceil(DEPTH * 0.7);
    localparam integer freq_8 = $ceil(DEPTH * 0.8);
    localparam integer freq_9 = $ceil(DEPTH * 0.9);

    wire clk = io_in[0];
    wire reset = io_in[1];
    wire sig = io_in[2];
    wire [6:0] led_out;
    assign io_out[6:0] = led_out;
    assign io_out[7] = sig;

    wire [$clog2(DEPTH)-1:0] avg;
    reg sig_d1;
    reg diff;
    reg [3:0] digit;


    always @(posedge clk) begin
        // if reset, set counter to 0
        if (reset) begin
            sig_d1 <= 0;
            diff <= 0;
            digit <= 0;
        end else begin
            sig_d1 <= sig;
            diff <= (sig ^ sig_d1);
            if ((avg <= $unsigned(freq_1))) begin
                digit <= 0;
            end else if ((avg > $unsigned(freq_1)) && (avg <= $unsigned(freq_2))) begin
                digit <= 1;
            end else if ((avg > $unsigned(freq_2)) && (avg <= $unsigned(freq_3))) begin
                digit <= 2;
            end else if ((avg > $unsigned(freq_3)) && (avg <= $unsigned(freq_4))) begin
                digit <= 3;
            end else if ((avg > $unsigned(freq_4)) && (avg <= $unsigned(freq_5))) begin
                digit <= 4;
            end else if ((avg > $unsigned(freq_5)) && (avg <= $unsigned(freq_6))) begin
                digit <= 5;
            end else if ((avg > $unsigned(freq_6)) && (avg <= $unsigned(freq_7))) begin
                digit <= 6;
            end else if ((avg > $unsigned(freq_7)) && (avg <= $unsigned(freq_8))) begin
                digit <= 7;
            end else if ((avg > $unsigned(freq_8)) && (avg <= $unsigned(freq_9))) begin
                digit <= 8;
            end else begin
                digit <= 9;
            end
        end
    end

    // instantiate segment display
    seg7 seg7(.counter(digit), .segments(led_out));

    // instantiate moving average
    moving_avg #(.DEPTH(DEPTH)) moving_avg(.data_i(diff), .reset, .clk, .avg_o(avg));
endmodule
