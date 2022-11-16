module mbikovitsky_top #(
    parameter LFSR_BITS = 5,
    parameter CLOCK_FREQ = 1000
) (
    input [7:0] io_in,
    output [7:0] io_out
);

    localparam TICKS_IN_SECOND = CLOCK_FREQ;

    // Decompose the input wires
    wire clk = io_in[0];
    wire reset_lfsr = io_in[1];
    wire reset_taps = io_in[2];
    wire [4:0] data_in = io_in[3+LFSR_BITS-1:3];

    // Assign the output
    seven_segment seven_segment (
        .value(lfsr),
        .segments(io_out)
    );

    reg [LFSR_BITS-1:0] taps;
    reg [LFSR_BITS-1:0] lfsr;

    reg [$clog2(CLOCK_FREQ)+1:0] tick_count;

    always @(posedge clk) begin
        if (reset_taps) begin
            taps <= data_in;
        end

        if (reset_lfsr) begin
            tick_count <= 0;
            lfsr <= data_in;
        end else begin
            if (tick_count == TICKS_IN_SECOND) begin
                tick_count <= 0;

                // Advance the LFSR
                if (lfsr[0]) begin
                    lfsr <= (lfsr >> 1) ^ taps;
                end else begin
                    lfsr <= (lfsr >> 1);
                end
            end else begin
                tick_count <= tick_count + 1;
            end
        end
    end

endmodule
