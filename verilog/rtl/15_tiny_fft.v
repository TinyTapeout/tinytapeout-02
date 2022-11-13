`default_nettype none

module tiny_fft (
  input [7:0] io_in,
  output [7:0] io_out
);

    wire clk = io_in[0];
    wire reset = io_in[1];
    wire wrEn = io_in[2];

    wire [3:0] data_in = io_in[7:4];

    reg [1:0] wrIdx;
    reg [2:0] rdIdx;

    reg signed [3:0] input_reg[0:3];

    assign io_out[0] = (rdIdx == 0) ? 1'b1 : 1'b0;
    // Signal high when output value is real
    assign io_out[1] = ~rdIdx[0];

    always @(posedge clk) begin
        if (reset) begin
            wrIdx <= 0;
        end else if(wrEn) begin
            input_reg[wrIdx] <= data_in;
            wrIdx <= wrIdx + 1;
        end
    end

    wire [5:0] stage0_0 = input_reg[0] + input_reg[2];
    wire [5:0] stage0_1 = input_reg[0] + ((~input_reg[2]) + 1);
    wire [5:0] stage0_2 = input_reg[1] + input_reg[3];
    wire [5:0] stage0_3 = input_reg[1] + ((~input_reg[3]) + 1);

    wire [5:0] stage1[0:7];

    // Freq bin 0 real + complex
    assign stage1[0] = stage0_0 + stage0_2;
    assign stage1[1] = 0;
    // Freq bin 1 real + complex
    assign stage1[2] = stage0_1;
    assign stage1[3] = ((~stage0_3) + 1);
    // Freq bin 2 real + complex
    assign stage1[4] = ((~stage0_2) + 1) + stage0_0;
    assign stage1[5] = 0;
    // Freq bin 3 real + complex
    assign stage1[6] = stage0_1;
    assign stage1[7] = stage0_3;

    assign io_out[7:2] = stage1[rdIdx];

    always @(posedge clk) begin
        if (reset) begin
            rdIdx <= 0;
        end else begin
            rdIdx <= rdIdx + 1;
        end
    end

endmodule
