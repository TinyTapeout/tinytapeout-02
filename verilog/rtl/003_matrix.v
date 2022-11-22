`default_nettype none

module chrisruk_matrix #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    wire clk = io_in[0];        // Input clock line
    wire reset = io_in[1];      // Input reset line
    wire digit1 = io_in[2];     // Digit to display

    reg [0:0] digit1_cache;     // Cache of first digit
    reg [0:0] digit2_cache;     // Cache of second digit

    reg [0:0] clock_1;          // Clock output
    reg [0:0] strip_1;          // Data output
    reg [0:0] first;            // Whether this is first digit displayed, if so display 'blank' character

    assign io_out[0] = clock_1; // Clock output for LED matrix
    assign io_out[1] = strip_1; // Data output for LED matrix

    reg [0:40-1] fonts [0:2-1]; // Font array
    reg [11:0] counter1;        // Count where we are in bit pattern
    reg [2:0] shift;            // Amount to left shift character

    reg [3-1:0] rowno;          // Row number in 8x8 matrix
    reg [6-1:0] idx;            // Bit index within colour register
    reg [6-1:0] pidx;           // Bit index within character, we apply processing on top of this
                                // value to create the bitidx value

    reg [6-1:0] bitidx;         // Index of bit we are within of character
    reg [0:32-1] ledreg1;       // Colour 1
    reg [0:32-1] ledreg2;       // Colour 2
    reg [0:64-1] display;       // Display buffer

`ifdef FPGA
    // Generate 6kHz clock from input 12MHz clock
    reg [0:0] clk2;
    integer counter;
    reg [0:0] resetflag;

    initial begin
        first <= 1;              // For FPGA for some reason need to have this here too, otherwise we get duplicate first value
        clk2 <= 0;
        counter <= 0;
        resetflag  <= 1;         // Reset flag, only used by FPGA
    end

    always @(posedge clk) begin
        if (counter == 2000) begin // Create 6kHz clock
            clk2 <= ~clk2;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

    always @(posedge clk2) begin
        if (reset || resetflag) begin
            resetflag <= 0;
`else
    always @(posedge clk) begin
        if (reset) begin
`endif
            // Setup variables
            shift <= 0;
            counter1 <= 0;
            idx <= 0;
            bitidx <= 0;
            pidx <= 0;
            strip_1 <= 0;
            clock_1 <= 0;
            ledreg1 <= 32'hf0000f00;        // Number colour
            ledreg2 <= 32'hf0070000;        // Background colour
            fonts[0] <= 40'h18_24_24_24_18; // 0
            fonts[1] <= 40'h18_28_08_08_3e; // 1
            digit1_cache <= 0;
            digit2_cache <= digit1;
            first <= 1;
        end else begin
            clock_1 <= ~clock_1 ;
            if (clock_1 == 1) begin
                if (counter1 < 32) begin
                    strip_1 <= 0;
                    if(counter1 == 1) begin
                        // Provided we're not displaying first digit in scrolling marquee pattern, display digit
                        // and shift each time
                        if(!first) begin
                            display <= {16'b0,
                                    fonts[digit1_cache][32:39] << shift,
                                    fonts[digit1_cache][24:31] << shift,
                                    fonts[digit1_cache][16:23] << shift,
                                    fonts[digit1_cache][8:15]  << shift,
                                    fonts[digit1_cache][0:7]   << shift,
                                    8'b0};
                        end else begin
                            display <= 0;
                        end
                    end else if(counter1 == 2) begin
                        // Display part of next digit too
                        display <= display | {16'b0,
                                            fonts[digit2_cache][32:39] >> 8 - shift,
                                            fonts[digit2_cache][24:31] >> 8 - shift,
                                            fonts[digit2_cache][16:23] >> 8 - shift,
                                            fonts[digit2_cache][8:15]  >> 8 - shift,
                                            fonts[digit2_cache][0:7]   >> 8 - shift,
                                            8'b0};
                    end

                    counter1 <= counter1 + 1;
                end else if (counter1 < 32 + (32 * (8*8))) begin
                    rowno = pidx / 8;
                    // Flip bit order if even row, as matrix of LEDs
                    // is in a 'snake' like pattern
                    if(rowno % 2 == 0) begin
                        bitidx = ((rowno * 16) + 8) - 1 - pidx;
                    end else begin
                        bitidx = pidx;
                    end

                    // Extract bit from display buffer
                    if (display[bitidx] == 1) begin
                        strip_1 <= ledreg1[idx];
                    end else begin
                        strip_1 <= ledreg2[idx];
                    end

                    if (idx == 31) begin
                        idx <= 0;
                        pidx <= pidx + 1;
                    end else begin
                        idx <= idx + 1;
                    end
                    counter1 <= counter1 + 1;
                end else if (counter1 < 32 + (32 * (8*8)) + 32 + 32) begin
                    // Need zeros at end of pattern
                    strip_1 <= 0;
                    counter1 <= counter1 + 1;
                end else begin
                    counter1 <= 0;
                    pidx <= 0;
                    idx <= 0;
                    if (shift == 7) begin
                        digit1_cache <= digit2_cache;
                        digit2_cache <= digit1;       // Grab next digit to be displayed from input pin
                        shift <= 0;
                        first <= 0;
                    end else begin
                        // Need to wrap back to first letter
                        shift <= shift + 1;
                    end
                end
            end
        end
    end
endmodule

