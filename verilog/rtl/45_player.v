`default_nettype none

/*
    Verilog code for playing a RTTL ringtone on a Piezo Speaker

    Copyright 2022 Milosch Meriac <milosch@meriac.com>
    Location: https://github.com/meriac/tt02-play-tune/

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

module meriac_tt02_play_tune #( parameter MAX_COUNT = 100 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire [10:0] db_entry;

    reg [6:0] note_address;
    reg [10:0] ticks;
    reg [6:0] freq, counter;
    reg speaker;

    assign io_out[0] = speaker;
    assign io_out[1] = ~speaker;

    always @(posedge clk) begin

        // if reset, set note_address to 0
        if (reset) begin
            note_address <= 0;
            ticks <= 0;
            freq <= 0;
            counter <= 0;
            speaker <= 0;
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
                ticks[10:7] <= db_entry[3:0];
                ticks[6:0] <= 0;

                // reset tone generator
                counter <= db_entry[10:4];
                freq <= db_entry[10:4];
            end

        end

    end

    // instantiate tune database
    meriac_tune_db meriac_tune_db(.address(note_address), .db_entry(db_entry));

endmodule
