`default_nettype none

module chrisruk_matrix #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    wire clk = io_in[0];        // Input clock line
    wire reset = io_in[1];      // Input reset line

    reg [0:0] resetflag = 1;    // Reset flag, only used by FPGA
    reg [0:0] clock_1;
    reg [0:0] strip_1;
    
    assign io_out[0] = clock_1; // Clock output for LED matrix
    assign io_out[1] = strip_1; // Data output for LED matrix

    reg [0:48-1] fonts [0:2-1]; // Font array
    reg [11:0] counter1;        // Count where we are in bit pattern
    reg [2:0] shift;            // Amount to left shift letter
    reg [4:0] letteridx;        // Index of letter

    reg [3:0] rowno;            // Row number in 8x8 matrix
    reg [5:0] idx;              // Bit index within colour register
    reg [5:0] pidx;             // Bit index within letter, we apply processing on top of this
                                // value to create the bitidx value

    reg [5:0] bitidx;           // Index of bit we are within of letter
    reg [0:32-1] ledreg1;       // Colour 1
    reg [0:32-1] ledreg2;       // Colour 2
    reg [0:64-1] display;       // Display buffer

`ifdef FPGA
    // Generate 6kHz clock from input 12MHz clock
    reg [0:0] clk2 = 0;
    integer counter = 0;

    always @(posedge clk) begin
        if (counter == 2000) begin
            clk2 = ~clk2;
            counter = 0;
        end else begin
            counter <= counter + 1;
        end
    end

    always @(posedge clk2) begin
`else
    always @(posedge clk) begin
`endif
        if (reset || resetflag) begin
            // Setup variables
            shift = 0;
            letteridx = 0;
            counter1 = 0;
            rowno = 0;
            idx = 0;
            pidx = 0;
            strip_1 = 0;
            clock_1 = 0;
            resetflag = 0;
            bitidx = 0;
            ledreg1 = 32'hf00f0000;
            ledreg2 = 32'hf0000000;

            // Array of 8x8 font letters
            /*fonts[0] = 48'h60_6c_76_66_66_e6;  // h
            fonts[1] = 48'h00_78_cc_fc_c0_78;  // e
            fonts[2] = 48'h30_30_30_30_30_78;  // l
            fonts[3] = 48'h00_78_cc_cc_cc_78;  // o*/

            fonts[0] = 48'h30_30_30_30_30_78;  // l
            fonts[1] = 48'h00_78_cc_cc_cc_78;  // o

        end else begin
            clock_1 = ~clock_1 ;
            if (clock_1 == 1) begin
                if (counter1 < 32) begin
                    // Need zeros at start of pattern
                    strip_1 = 0;
                    display = {8'b0, fonts[letteridx][40:47] << shift, fonts[letteridx][32:39] << shift,
                                 fonts[letteridx][24:31] << shift, fonts[letteridx][16:23] << shift, fonts[letteridx][8:15] << shift, fonts[letteridx][0:7] << shift, 8'b0};
                    display = display | {8'b0, fonts[letteridx+1][40:47] >> 8 - shift, fonts[letteridx+1][32:39] >> 8 - shift,
                                 fonts[letteridx+1][24:31] >> 8 - shift, fonts[letteridx+1][16:23] >> 8 - shift, fonts[letteridx+1][8:15] >> 8 - shift, fonts[letteridx+1][0:7] >> 8 - shift, 8'b0};
                end else if (counter1 < 32 + (32 * (8*8))) begin
                    rowno = pidx / 8;
                    // flip bit order if even row, as matrix of LEDs
                    // is in a 'snake' like pattern
                    if(rowno % 2 == 0) begin
                        bitidx = ((rowno * 16) + 8) - 1 - pidx;
                    end else begin
                        bitidx = pidx;
                    end

                    // Extract bit from display buffer
                    if (display[bitidx] == 1) begin
                        strip_1 = ledreg1[idx];
                    end else begin
                        strip_1 = ledreg2[idx];
                    end

                    idx = idx + 1;
                    if (idx == 32) begin
                        idx = 0;
                        pidx = pidx + 1;
                    end

                    if (pidx == 64) begin
                        pidx = 0;
                    end
                end else if (counter1 < 32 + (32 * (8*8)) + 32 + 32) begin
                    // Need zeros at end of pattern
                    strip_1 = 0;
                end else begin
                    counter1 = 0;
                    strip_1 = 0;
                    pidx = 0;
                    idx = 0;

                    if (shift == 7) begin
                        letteridx = letteridx + 1;
                        if (letteridx == 4) begin
                            letteridx = 0;
                        end
                        shift = 0;
                    end else begin
                        // Need to wrap back to first letter
                        shift = shift + 1;
                    end
                end

                counter1 = counter1 + 1;
            end
        end
    end
endmodule

