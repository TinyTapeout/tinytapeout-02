module azdle_binary_clock(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire rst;
  wire clk;
  // TODO: input pps, // Pulse per second input
  // TODO: input [4:0] start_hours, // value for hours to load when coming out of reset
  wire [7:0] opins;

  assign rst = io_in[0];
  assign clk = io_in[1];
  assign io_out = opins;

  wire state;

  wire d_tick; // ticks once per day
  wire [4:0] hours;
  wire h_tick; // ticks once per hour
  wire [5:0] minutes;
  wire m_tick; // ticks once per minute
  wire [5:0] seconds;
  wire s_tick; // ticks once per second
  wire [6:0] centiseconds;

  wire [15:0] pixels;

  wire [7:0] disp_pins;

  clock c(.rst, .clk, .d_tick, .h_tick, .m_tick, .s_tick,
                               .hours, .minutes, .seconds, .centiseconds);
  display disp(.rst, .clk, .pins(disp_pins), .pixels);

  assign pixels = { 5'b0, hours, minutes };
  assign opins = rst ? 0 : {disp_pins};
endmodule

// pass (convenience to match `i` (invert))
function p;
  input pixel;

  p = pixel;
endfunction

// invert
function i;
  input pixel;

  i = ~pixel;
endfunction

module display (
  input rst,
  input clk,
  input [15:0] pixels, // [row][column]
  output [7:0] pins
);

  wire [1:0] row;
  wire [1:0] col;
  wire [3:0] rows;
  wire [3:0] cols;

  counter #(.bits(2)) state_cycle(.rst(rst), .clk(clk), .cnt(row));

  assign pins = { rows, cols };

  assign rows = rst ? 0 :
    row == 0 ? { 1'b1, 1'b1, 1'b1, 1'b0 } :
    row == 1 ? { 1'b1, 1'b1, 1'b0, 1'b1 } :
    row == 2 ? { 1'b1, 1'b0, 1'b1, 1'b1 } :
    row == 3 ? { 1'b0, 1'b1, 1'b1, 1'b1 } :
    0;
  assign cols = rst ? 0 :
    row == 0 ? { p(pixels[0+3]), p(pixels[0+2]), p(pixels[0+1]), p(pixels[0+0]) } :
    row == 1 ? { p(pixels[4+3]), p(pixels[4+2]), p(pixels[4+1]), p(pixels[4+0]) } :
    row == 2 ? { p(pixels[8+3]), p(pixels[8+2]), p(pixels[8+1]), p(pixels[8+0]) } :
    row == 3 ? { p(pixels[12+3]), p(pixels[12+2]), p(pixels[12+1]), p(pixels[12+0]) } :
    0;
endmodule

module clock(
  input rst,
  input clk,
  output d_tick, // ticks once per day
  output [4:0] hours,
  output h_tick, // ticks once per hour
  output [5:0] minutes,
  output m_tick, // ticks once per minute
  output [5:0] seconds,
  output s_tick, // ticks once per second
  output [6:0] centiseconds
);

  overflow_counter #(.bits(5))
    h_cnt(.rst(rst), .clk(h_tick), .cmp(5'd24), .cnt(hours), .tick(d_tick));
  overflow_counter #(.bits(6))
    m_cnt(.rst(rst), .clk(m_tick), .cmp(6'd60), .cnt(minutes), .tick(h_tick));
  overflow_counter #(.bits(6))
    s_cnt(.rst(rst), .clk(s_tick), .cmp(6'd60), .cnt(seconds), .tick(m_tick));
  overflow_counter #(.bits(7))
    ms_cnt(.rst(rst), .clk(clk), .cmp(7'd100), .cnt(centiseconds), .tick(s_tick));
endmodule

module counter #(parameter bits = 8) (
  input rst,
  input clk,
  output reg [bits-1:0] cnt
);

  always @(posedge clk or posedge rst)
    if (rst)
      cnt <= 0;
    else
      cnt <= cnt + 1;
endmodule

module overflow_counter #(parameter bits = 8) (
  input rst,
  input clk,
  input [bits-1:0] cmp, // even numbers only, rolls over instead of reaching this number
  output reg [bits-1:0] cnt,
  output reg tick
);

  always @(posedge clk or posedge rst)
    begin
      if (rst) begin
        cnt <= 0;
        tick <= 1;
      end else
        // wrap to zero instead of reaching cmp
        if (cnt == cmp-1) begin
          cnt <= 0;
          tick <= 1;
        end
        else begin
          cnt <= cnt + 1;

          // unset tick halfway through, odd values for cmp result in unbalanced tick segments
          if (cnt == (cmp/2)-1)
            tick <= 0;
        end
    end
endmodule
