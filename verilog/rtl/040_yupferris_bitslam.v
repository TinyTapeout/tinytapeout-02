`default_nettype none

module voice(
    input clk,
    input addr,
    input write_data,
    input [5:0] data,
    output out
);

    reg [5:0] max_clk_div_counter;

    always @(posedge clk) begin
        if (write_data & ~addr)
            max_clk_div_counter <= data;
    end

    reg [5:0] clk_div_counter;
    wire tick = clk_div_counter >= max_clk_div_counter;

    always @(posedge clk) begin
        if (tick) begin
            clk_div_counter <= 6'h00;
        end
        else begin
            clk_div_counter <= clk_div_counter + 6'h01;
        end
    end

    reg [3:0] lfsr_tap_mask;

    always @(posedge clk) begin
        if (write_data & addr)
            lfsr_tap_mask <= data[3:0];
    end

    reg [9:0] lfsr;
    wire tap1 = lfsr[1] & lfsr_tap_mask[0];
    wire tap4 = lfsr[4] & lfsr_tap_mask[1];
    wire tap6 = lfsr[6] & lfsr_tap_mask[2];
    wire tap9 = lfsr[9] & lfsr_tap_mask[3];

    always @(posedge clk) begin
        if (tick) begin
            if (lfsr == 10'h00) begin
                lfsr <= 10'h01;
            end
            else begin
                lfsr <= {lfsr[8:0], tap1 ^ tap4 ^ tap6 ^ tap9};
            end
        end
    end

    assign out = lfsr[0];

endmodule

module mixer(
    input clk,
    input write_data,
    input [5:0] data,
    input voice0_out,
    input voice1_out,
    output [3:0] out
);

    reg [5:0] voice_volumes;

    always @(posedge clk) begin
        if (write_data)
            voice_volumes <= data;
    end

    wire [2:0] voice0_volume = voice_volumes[2:0];
    wire [2:0] voice1_volume = voice_volumes[5:3];

    wire [2:0] scaled_voice0_out = voice0_out ? voice0_volume : 3'h00;
    wire [2:0] scaled_voice1_out = voice1_out ? voice1_volume : 3'h00;

    assign out = scaled_voice0_out + scaled_voice1_out;

endmodule

module yupferris_bitslam(
    input [7:0] io_in,
    output [7:0] io_out
);

    wire clk = io_in[0];

    wire addr_data_sel = io_in[1];
    wire write_addr = ~addr_data_sel;
    wire write_data = addr_data_sel;
    wire [5:0] addr_data = io_in[7:2];
    wire [5:0] data = addr_data;

    reg [2:0] addr;

    always @(posedge clk) begin
        if (write_addr)
            addr <= addr_data[2:0];
    end

    wire voice_select = addr[1];
    wire mixer_select = addr[2];

    wire voice0_select = ~voice_select & ~mixer_select;
    wire voice1_select = voice_select & ~mixer_select;

    wire voice0_out;
    voice voice0(
        .clk(clk),
        .addr(addr[0]),
        .write_data(write_data & voice0_select),
        .data(data),
        .out(voice0_out)
    );

    wire voice1_out;
    voice voice1(
        .clk(clk),
        .addr(addr[0]),
        .write_data(write_data & voice1_select),
        .data(data),
        .out(voice1_out)
    );

    wire [3:0] mixer_out;
    mixer mixer(
        .clk(clk),
        .write_data(write_data & mixer_select),
        .data(data),
        .voice0_out(voice0_out),
        .voice1_out(voice1_out),
        .out(mixer_out)
    );

    assign io_out = {4'h00, mixer_out};

endmodule
