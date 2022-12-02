`default_nettype none

module prog_melody_gen (
  input [7:0] io_in,
  output [7:0] io_out
);
    reg [9:0] div_tmr = 0;
    reg tick;
    reg state;
    reg [7:0] curr_tone;

    reg [5:0] tone_seq;
    wire [3:0] rom_rdata;

    wire clock = io_in[0];
    wire reload = io_in[1];
    wire restart = io_in[2];

    wire pgm_data = io_in[3];
    wire pgm_strobe = io_in[4];

    assign io_out[7:1] = 1'b0;

    always @(posedge clock, posedge restart) begin
        if (restart) begin
            div_tmr <= 0;
            tone_seq <= 0;
            curr_tone <= 0;
            tick <= 1'b0;
            state <= 1'b0;
        end else begin
            {tick, div_tmr} <= div_tmr + 1'b1;
            if (tick) begin
                if (!state) begin
                    tone_seq <= tone_seq + 1'b1;
                    if (rom_rdata == 15)
                        curr_tone <= 0; // silence
                    else
                        curr_tone <= 12 + rom_rdata; // note
                end else begin
                    curr_tone <= 0; // gap between notes
                end
                state <= ~state;
            end
        end
    end

    reg [7:0] mel_gen = 0;
    reg mel_out;
    always @(posedge clock) begin
        if (mel_gen >= curr_tone)
            mel_gen <= 0;
        else 
            mel_gen <= mel_gen + 1'b1;
        mel_out <= mel_gen > (curr_tone / 2);
    end

    assign io_out[0] = mel_out;

    localparam C = 4'd11, CS = 4'd10, D = 4'd9, E = 4'd7, F = 4'd6, FS = 4'd5, G = 4'd4, GS = 4'd3, A = 4'd2, AS = 4'd1, B = 4'd0, S = 4'd15;
    localparam [4*64:0] JINGLE_BELS = {
        E, E, E, S, E, E, E, S,
        E, G, C, D, E, S, F, F,
        F, F, F, E, E, E, E, E,
        D, D, E, D, S, G, S, E,
        E, E, S, E, E, E, S, E,
        G, C, D, E, S, F, F, F,
        F, F, E, E, E, E, F, F,
        E, D, C, S, S, S, S, S
    };

    wire [3:0] tone_rom[0:63];

    // program shift register
    reg [10:0] write_sr;
    always @(posedge clock)
        write_sr <= {pgm_data, write_sr[10:1]};

    wire [5:0] pgm_word_sel = write_sr[10:5];
    wire [3:0] pgm_write_data = write_sr[3:0];

    // the tone RAM
    generate
        genvar ii;
        genvar jj;
        for (ii = 0; ii < 64; ii = ii + 1'b1) begin : words
            wire word_we;
            sky130_fd_sc_hd__and2_1 word_we_i ( // make sure this is really glitch free
                .A(pgm_word_sel == ii),
                .B(pgm_strobe),
                .X(word_we)
            );
            for (jj = 0; jj < 4; jj = jj + 1'b1) begin : bits
                localparam pgm_bit = JINGLE_BELS[(63 - ii) * 4 + jj];
                wire lat_o;
                sky130_fd_sc_hd__dlrtp_1 rfbit_i (
                    .GATE(word_we),
                    .RESET_B(reload),
                    .D(pgm_write_data[jj]),
                    .Q(lat_o)
                );
                assign tone_rom[ii][jj] = lat_o ^ pgm_bit;
            end
        end
    endgenerate

    assign rom_rdata = tone_rom[tone_seq];

endmodule

(* blackbox *)
module sky130_fd_sc_hd__dlrtp_1(input GATE, RESET_B, D, output reg Q);
    always @*
        if (~RESET_B)
            Q <= 0;
        else if (GATE)
            Q <= D;
endmodule
(* blackbox *)
module sky130_fd_sc_hd__and2_1(input A, B, output X);
    assign X = A & B;
endmodule
