module option22 (
    input wire [7:0] io_in,
    output wire [7:0] io_out
);
parameter WORD_COUNT = 22;

wire clk = io_in[0];
wire reset = io_in[1];
wire write = io_in[2];
wire din = io_in[3];

assign io_out = buffer[7:0];

reg [2:0] count;
reg [8 * WORD_COUNT - 1:0] buffer;

wire [7:0] bh = (write & din) | (!write & buffer[15]);

always@(posedge clk or posedge reset) begin

    if(reset) begin
        count <= 3'd0;
    end else begin
        if(count == 3'b111) begin
            buffer <= {buffer[7:0], buffer[WORD_COUNT * 8 - 1:16], bh, buffer[15:9]};
        end else begin
            buffer[15:8] <= {bh, buffer[15:9]};
        end
        count <= count + 3'd1;
    end
end
endmodule
