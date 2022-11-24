`default_nettype none

/*
    Verilog code for playing a RTTL ringtone on a Piezo Speaker

    Copyright 2022 Milosch Meriac <milosch@meriac.com>
    Copyright 2022 Jiaxun Yang <jiaxun.yang@flygoat.com>

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:
    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
    3. Neither the name of the copyright holder nor the names of its
       contributors may be used to endorse or promote products derived
       from this software without specific prior written permission.
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
    HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

module flygoat_tt02_play_tune #( parameter MAX_COUNT = 100 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire [1:0] db_sel_in = io_in[3:2];

    wire [10:0] db_entry;

    wire [10:0] flygoat_db_entry;
    wire [10:0] bh5hso_db_entry;
    wire [10:0] gm3hso_db_entry;
    wire [10:0] planetes_db_entry;

    reg [6:0] note_address;
    reg [12:0] ticks;
    reg [6:0] freq, counter;
    reg [1:0] db_sel_r;
    reg speaker;

    reg [3:0] led_out;

    assign io_out[0] = speaker;
    assign io_out[1] = ~speaker;
    assign io_out[5:2] = led_out;
    assign io_out[7:6] = 2'bzz;

    always @(posedge clk) begin

        // if reset, set note_address to 0
        if (reset) begin
            note_address <= 0;
            ticks <= 0;
            freq <= 0;
            counter <= 0;
            speaker <= 0;
            db_sel_r <= db_sel_in;
        end else begin
            if (!ticks) begin
                if (note_address<MAX_COUNT) begin
                    note_address <= note_address + 1'b1;
                end else begin
                    note_address <= 0;
                end
            end

            // tone frequency divider
            if (counter>0) begin
                counter <= counter - 1'b1;
                speaker <= counter >= (freq/2);
            end else begin
                counter <= freq;
                speaker <= 1'b0;
            end

        end
    end

    always @(negedge clk) begin

        if (!reset) begin
            if (ticks>0) begin
                ticks <= ticks - 1'b1;
            end else begin
                // update per-note delay
                ticks[12:9] <= db_entry[3:0];
                ticks[8:0] <= 0;

                // reset tone generator
                counter <= db_entry[10:4];
                freq <= db_entry[10:4];
            end

        end

    end

    // instantiate tune database
    flygoat_tune_db flygoat_tune_db(.address(note_address), .db_entry(flygoat_db_entry));
    gm3hso_tune_db gm3hso_tune_db(.address(note_address), .db_entry(gm3hso_db_entry));
    bh5hso_tune_db bh5hso_tune_db(.address(note_address), .db_entry(bh5hso_db_entry));
    planetes_tune_db planetes_tune_db(.address(note_address), .db_entry(planetes_db_entry));

    genvar i;
    generate
        for (i=0; i < 11; i=i+1) begin
            mux4_cell tune_db_mux (
                .a(flygoat_db_entry[i]),
                .b(gm3hso_db_entry[i]),
                .c(bh5hso_db_entry[i]),
                .d(planetes_db_entry[i]),
                .sel(db_sel_r),
                .out(db_entry[i])
            );
        end
    endgenerate
 
    reg [24:0] cnt;
    always@(posedge clk) begin
        if(reset) begin
            cnt <= 25'd0;
        // 10 khz clk, 1s led peroid
        end else if(cnt>=(10000-1)) begin
            cnt <= 25'd0;
        end else begin
            cnt <= cnt + 25'd1;
        end
    end

    reg [1:0] led_cnt = 2'd0;
    always@(posedge clk) begin
        if(reset) begin
            led_cnt <= 2'd0;
        end else if(cnt==(10000-1)) begin
            if(led_cnt==2'd3) led_cnt <= 2'd0;
            else led_cnt <= led_cnt + 2'd1;
        end
    end

    always@(*) begin
        if (reset) begin
            led_out = 4'b0000;
        end else begin
	        case(led_cnt)
		        3'd0: led_out = 4'b1110;
		        3'd1: led_out = 4'b1101;
		        3'd2: led_out = 4'b1011;
		        3'd3: led_out = 4'b0111;
		    default: led_out = 4'b1111;
	        endcase
        end
    end

endmodule
