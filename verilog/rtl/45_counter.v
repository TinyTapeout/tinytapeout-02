`default_nettype none

module phasenoisepon_seven_segment_seconds #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    // setup registers
    reg [3:0] nibble_low;
    reg [3:0] nibble_high;
    reg [7:0] output_reg;

    // declare wires
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire [1:0] ctl = io_in[3:2];
    wire [3:0] data_in = io_in[7:4];
    assign io_out[7:0] = output_reg;

    // define useful FSM states
    localparam CTL_LOW_NIBBLE  = 2'b00;
    localparam CTL_HIGH_NIBBLE = 2'b01;

    always @(posedge clk) begin
        // if reset, then reset all reg's to 0
        if (reset) begin
            nibble_low <= 0;
            nibble_high <= 0;
            output_reg <= 0;
        end else begin
            // read control lines
            if (ctl == CTL_LOW_NIBBLE) begin
                output_reg <= 8'h0F;
                nibble_low <= data_in;
            end else if (ctl == CTL_HIGH_NIBBLE) begin
                output_reg <= 8'hF0;
                nibble_high <= data_in;
            end else if (ctl[1] == 1'b1) begin
                //output_reg <= 8'hFF; // stub
                case ({nibble_high,nibble_low})
                    8'h00: output_reg <= 8'h00; //rot13(0x00)=0x00, '\x00'->'\x00'
                    8'h01: output_reg <= 8'h01; //rot13(0x01)=0x01, '\x01'->'\x01'
                    8'h02: output_reg <= 8'h02; //rot13(0x02)=0x02, '\x02'->'\x02'
                    8'h03: output_reg <= 8'h03; //rot13(0x03)=0x03, '\x03'->'\x03'
                    8'h04: output_reg <= 8'h04; //rot13(0x04)=0x04, '\x04'->'\x04'
                    8'h05: output_reg <= 8'h05; //rot13(0x05)=0x05, '\x05'->'\x05'
                    8'h06: output_reg <= 8'h06; //rot13(0x06)=0x06, '\x06'->'\x06'
                    8'h07: output_reg <= 8'h07; //rot13(0x07)=0x07, '\x07'->'\x07'
                    8'h08: output_reg <= 8'h08; //rot13(0x08)=0x08, '\x08'->'\x08'
                    8'h09: output_reg <= 8'h09; //rot13(0x09)=0x09, '\t'->'\t'
                    8'h0a: output_reg <= 8'h0a; //rot13(0x0a)=0x0a, '\n'->'\n'
                    8'h0b: output_reg <= 8'h0b; //rot13(0x0b)=0x0b, '\x0b'->'\x0b'
                    8'h0c: output_reg <= 8'h0c; //rot13(0x0c)=0x0c, '\x0c'->'\x0c'
                    8'h0d: output_reg <= 8'h0d; //rot13(0x0d)=0x0d, '\r'->'\r'
                    8'h0e: output_reg <= 8'h0e; //rot13(0x0e)=0x0e, '\x0e'->'\x0e'
                    8'h0f: output_reg <= 8'h0f; //rot13(0x0f)=0x0f, '\x0f'->'\x0f'
                    8'h10: output_reg <= 8'h10; //rot13(0x10)=0x10, '\x10'->'\x10'
                    8'h11: output_reg <= 8'h11; //rot13(0x11)=0x11, '\x11'->'\x11'
                    8'h12: output_reg <= 8'h12; //rot13(0x12)=0x12, '\x12'->'\x12'
                    8'h13: output_reg <= 8'h13; //rot13(0x13)=0x13, '\x13'->'\x13'
                    8'h14: output_reg <= 8'h14; //rot13(0x14)=0x14, '\x14'->'\x14'
                    8'h15: output_reg <= 8'h15; //rot13(0x15)=0x15, '\x15'->'\x15'
                    8'h16: output_reg <= 8'h16; //rot13(0x16)=0x16, '\x16'->'\x16'
                    8'h17: output_reg <= 8'h17; //rot13(0x17)=0x17, '\x17'->'\x17'
                    8'h18: output_reg <= 8'h18; //rot13(0x18)=0x18, '\x18'->'\x18'
                    8'h19: output_reg <= 8'h19; //rot13(0x19)=0x19, '\x19'->'\x19'
                    8'h1a: output_reg <= 8'h1a; //rot13(0x1a)=0x1a, '\x1a'->'\x1a'
                    8'h1b: output_reg <= 8'h1b; //rot13(0x1b)=0x1b, '\x1b'->'\x1b'
                    8'h1c: output_reg <= 8'h1c; //rot13(0x1c)=0x1c, '\x1c'->'\x1c'
                    8'h1d: output_reg <= 8'h1d; //rot13(0x1d)=0x1d, '\x1d'->'\x1d'
                    8'h1e: output_reg <= 8'h1e; //rot13(0x1e)=0x1e, '\x1e'->'\x1e'
                    8'h1f: output_reg <= 8'h1f; //rot13(0x1f)=0x1f, '\x1f'->'\x1f'
                    8'h20: output_reg <= 8'h20; //rot13(0x20)=0x20, ' '->' '
                    8'h21: output_reg <= 8'h21; //rot13(0x21)=0x21, '!'->'!'
                    8'h22: output_reg <= 8'h22; //rot13(0x22)=0x22, '"'->'"'
                    8'h23: output_reg <= 8'h23; //rot13(0x23)=0x23, '#'->'#'
                    8'h24: output_reg <= 8'h24; //rot13(0x24)=0x24, '$'->'$'
                    8'h25: output_reg <= 8'h25; //rot13(0x25)=0x25, '%'->'%'
                    8'h26: output_reg <= 8'h26; //rot13(0x26)=0x26, '&'->'&'
                    8'h27: output_reg <= 8'h27; //rot13(0x27)=0x27, "'"->"'"
                    8'h28: output_reg <= 8'h28; //rot13(0x28)=0x28, '('->'('
                    8'h29: output_reg <= 8'h29; //rot13(0x29)=0x29, ')'->')'
                    8'h2a: output_reg <= 8'h2a; //rot13(0x2a)=0x2a, '*'->'*'
                    8'h2b: output_reg <= 8'h2b; //rot13(0x2b)=0x2b, '+'->'+'
                    8'h2c: output_reg <= 8'h2c; //rot13(0x2c)=0x2c, ','->','
                    8'h2d: output_reg <= 8'h2d; //rot13(0x2d)=0x2d, '-'->'-'
                    8'h2e: output_reg <= 8'h2e; //rot13(0x2e)=0x2e, '.'->'.'
                    8'h2f: output_reg <= 8'h2f; //rot13(0x2f)=0x2f, '/'->'/'
                    8'h30: output_reg <= 8'h30; //rot13(0x30)=0x30, '0'->'0'
                    8'h31: output_reg <= 8'h31; //rot13(0x31)=0x31, '1'->'1'
                    8'h32: output_reg <= 8'h32; //rot13(0x32)=0x32, '2'->'2'
                    8'h33: output_reg <= 8'h33; //rot13(0x33)=0x33, '3'->'3'
                    8'h34: output_reg <= 8'h34; //rot13(0x34)=0x34, '4'->'4'
                    8'h35: output_reg <= 8'h35; //rot13(0x35)=0x35, '5'->'5'
                    8'h36: output_reg <= 8'h36; //rot13(0x36)=0x36, '6'->'6'
                    8'h37: output_reg <= 8'h37; //rot13(0x37)=0x37, '7'->'7'
                    8'h38: output_reg <= 8'h38; //rot13(0x38)=0x38, '8'->'8'
                    8'h39: output_reg <= 8'h39; //rot13(0x39)=0x39, '9'->'9'
                    8'h3a: output_reg <= 8'h3a; //rot13(0x3a)=0x3a, ':'->':'
                    8'h3b: output_reg <= 8'h3b; //rot13(0x3b)=0x3b, ';'->';'
                    8'h3c: output_reg <= 8'h3c; //rot13(0x3c)=0x3c, '<'->'<'
                    8'h3d: output_reg <= 8'h3d; //rot13(0x3d)=0x3d, '='->'='
                    8'h3e: output_reg <= 8'h3e; //rot13(0x3e)=0x3e, '>'->'>'
                    8'h3f: output_reg <= 8'h3f; //rot13(0x3f)=0x3f, '?'->'?'
                    8'h40: output_reg <= 8'h40; //rot13(0x40)=0x40, '@'->'@'
                    8'h41: output_reg <= 8'h4e; //rot13(0x41)=0x4e, 'A'->'N'
                    8'h42: output_reg <= 8'h4f; //rot13(0x42)=0x4f, 'B'->'O'
                    8'h43: output_reg <= 8'h50; //rot13(0x43)=0x50, 'C'->'P'
                    8'h44: output_reg <= 8'h51; //rot13(0x44)=0x51, 'D'->'Q'
                    8'h45: output_reg <= 8'h52; //rot13(0x45)=0x52, 'E'->'R'
                    8'h46: output_reg <= 8'h53; //rot13(0x46)=0x53, 'F'->'S'
                    8'h47: output_reg <= 8'h54; //rot13(0x47)=0x54, 'G'->'T'
                    8'h48: output_reg <= 8'h55; //rot13(0x48)=0x55, 'H'->'U'
                    8'h49: output_reg <= 8'h56; //rot13(0x49)=0x56, 'I'->'V'
                    8'h4a: output_reg <= 8'h57; //rot13(0x4a)=0x57, 'J'->'W'
                    8'h4b: output_reg <= 8'h58; //rot13(0x4b)=0x58, 'K'->'X'
                    8'h4c: output_reg <= 8'h59; //rot13(0x4c)=0x59, 'L'->'Y'
                    8'h4d: output_reg <= 8'h5a; //rot13(0x4d)=0x5a, 'M'->'Z'
                    8'h4e: output_reg <= 8'h41; //rot13(0x4e)=0x41, 'N'->'A'
                    8'h4f: output_reg <= 8'h42; //rot13(0x4f)=0x42, 'O'->'B'
                    8'h50: output_reg <= 8'h43; //rot13(0x50)=0x43, 'P'->'C'
                    8'h51: output_reg <= 8'h44; //rot13(0x51)=0x44, 'Q'->'D'
                    8'h52: output_reg <= 8'h45; //rot13(0x52)=0x45, 'R'->'E'
                    8'h53: output_reg <= 8'h46; //rot13(0x53)=0x46, 'S'->'F'
                    8'h54: output_reg <= 8'h47; //rot13(0x54)=0x47, 'T'->'G'
                    8'h55: output_reg <= 8'h48; //rot13(0x55)=0x48, 'U'->'H'
                    8'h56: output_reg <= 8'h49; //rot13(0x56)=0x49, 'V'->'I'
                    8'h57: output_reg <= 8'h4a; //rot13(0x57)=0x4a, 'W'->'J'
                    8'h58: output_reg <= 8'h4b; //rot13(0x58)=0x4b, 'X'->'K'
                    8'h59: output_reg <= 8'h4c; //rot13(0x59)=0x4c, 'Y'->'L'
                    8'h5a: output_reg <= 8'h4d; //rot13(0x5a)=0x4d, 'Z'->'M'
                    8'h5b: output_reg <= 8'h5b; //rot13(0x5b)=0x5b, '['->'['
                    8'h5c: output_reg <= 8'h5c; //rot13(0x5c)=0x5c, '\\'->'\\'
                    8'h5d: output_reg <= 8'h5d; //rot13(0x5d)=0x5d, ']'->']'
                    8'h5e: output_reg <= 8'h5e; //rot13(0x5e)=0x5e, '^'->'^'
                    8'h5f: output_reg <= 8'h5f; //rot13(0x5f)=0x5f, '_'->'_'
                    8'h60: output_reg <= 8'h60; //rot13(0x60)=0x60, '`'->'`'
                    8'h61: output_reg <= 8'h6e; //rot13(0x61)=0x6e, 'a'->'n'
                    8'h62: output_reg <= 8'h6f; //rot13(0x62)=0x6f, 'b'->'o'
                    8'h63: output_reg <= 8'h70; //rot13(0x63)=0x70, 'c'->'p'
                    8'h64: output_reg <= 8'h71; //rot13(0x64)=0x71, 'd'->'q'
                    8'h65: output_reg <= 8'h72; //rot13(0x65)=0x72, 'e'->'r'
                    8'h66: output_reg <= 8'h73; //rot13(0x66)=0x73, 'f'->'s'
                    8'h67: output_reg <= 8'h74; //rot13(0x67)=0x74, 'g'->'t'
                    8'h68: output_reg <= 8'h75; //rot13(0x68)=0x75, 'h'->'u'
                    8'h69: output_reg <= 8'h76; //rot13(0x69)=0x76, 'i'->'v'
                    8'h6a: output_reg <= 8'h77; //rot13(0x6a)=0x77, 'j'->'w'
                    8'h6b: output_reg <= 8'h78; //rot13(0x6b)=0x78, 'k'->'x'
                    8'h6c: output_reg <= 8'h79; //rot13(0x6c)=0x79, 'l'->'y'
                    8'h6d: output_reg <= 8'h7a; //rot13(0x6d)=0x7a, 'm'->'z'
                    8'h6e: output_reg <= 8'h61; //rot13(0x6e)=0x61, 'n'->'a'
                    8'h6f: output_reg <= 8'h62; //rot13(0x6f)=0x62, 'o'->'b'
                    8'h70: output_reg <= 8'h63; //rot13(0x70)=0x63, 'p'->'c'
                    8'h71: output_reg <= 8'h64; //rot13(0x71)=0x64, 'q'->'d'
                    8'h72: output_reg <= 8'h65; //rot13(0x72)=0x65, 'r'->'e'
                    8'h73: output_reg <= 8'h66; //rot13(0x73)=0x66, 's'->'f'
                    8'h74: output_reg <= 8'h67; //rot13(0x74)=0x67, 't'->'g'
                    8'h75: output_reg <= 8'h68; //rot13(0x75)=0x68, 'u'->'h'
                    8'h76: output_reg <= 8'h69; //rot13(0x76)=0x69, 'v'->'i'
                    8'h77: output_reg <= 8'h6a; //rot13(0x77)=0x6a, 'w'->'j'
                    8'h78: output_reg <= 8'h6b; //rot13(0x78)=0x6b, 'x'->'k'
                    8'h79: output_reg <= 8'h6c; //rot13(0x79)=0x6c, 'y'->'l'
                    8'h7a: output_reg <= 8'h6d; //rot13(0x7a)=0x6d, 'z'->'m'
                    8'h7b: output_reg <= 8'h7b; //rot13(0x7b)=0x7b, '{'->'{'
                    8'h7c: output_reg <= 8'h7c; //rot13(0x7c)=0x7c, '|'->'|'
                    8'h7d: output_reg <= 8'h7d; //rot13(0x7d)=0x7d, '}'->'}'
                    8'h7e: output_reg <= 8'h7e; //rot13(0x7e)=0x7e, '~'->'~'
                    8'h7f: output_reg <= 8'h7f; //rot13(0x7f)=0x7f, '\x7f'->'\x7f'
                    default: output_reg <= 0; //should cause a noticeable error in the TB
                endcase
            end
        end
    end

endmodule
