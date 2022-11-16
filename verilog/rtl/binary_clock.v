module azdle_binary_clock(
  input [7:0] io_in,
  output [7:0] io_out
);
  wire rst;
  wire clk;
  wire pps; // Pulse per second input
  wire [4:0] hours_init; // value for hours to load when coming out of reset
  wire [7:0] opins;

  assign clk = io_in[0];
  assign rst = io_in[1];
  assign pps = io_in[2];
  assign hours_init = io_in[7:3];
  assign io_out = opins;

  wire state;

  wire d_roll; // rolls once per day
  wire [4:0] hours;
  wire h_roll; // rolls once per hour
  wire [5:0] minutes;
  wire m_roll; // rolls once per minute
  wire [5:0] seconds;
  wire s_roll; // rolls once per second
  wire [6:0] centiseconds;

  wire [11:0] pixels;

  wire [6:0] disp_pins;

  clock c(.rst, .clk, .pps, .hours_init,
	  .d_roll, .h_roll, .m_roll, .s_roll,
                   .hours, .minutes, .seconds, .centiseconds);
  display disp(.rst, .clk, .pins(disp_pins), .pixels);

  assign pixels = { hours, minutes, seconds[0] };
  assign opins = rst ? 0 : {1'b0, disp_pins};
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
  input [11:0] pixels, // [row][column]
  output [6:0] pins
);

  wire [1:0] col;
  wire [2:0] rows;
  wire [3:0] cols;

  rotor state_cycle(.rst(rst), .clk(clk), .val(rows));

  assign pins = { rows, cols };

  assign cols = rst ? 0 :
    rows == 3'b110 ? { p(pixels[0+3]), p(pixels[0+2]), p(pixels[0+1]), p(pixels[0+0]) } :
    rows == 3'b101 ? { p(pixels[4+3]), p(pixels[4+2]), p(pixels[4+1]), p(pixels[4+0]) } :
    rows == 3'b011 ? { p(pixels[8+3]), p(pixels[8+2]), p(pixels[8+1]), p(pixels[8+0]) } :
    0;
endmodule

module rotor #(parameter bits = 3, parameter pattern = 6) (
  input rst,
  input clk,
  output reg [bits-1:0] val
);

  always @(posedge clk)
    if (rst)
      val <= pattern;
    else
      val <= { val[bits-2:0], val[bits-1] };
endmodule

module clock(
  input rst,
  input clk,
  input pps,
  input [4:0] hours_init,
  output d_roll, // rolls once per day
  output [4:0] hours,
  output h_roll, // rolls once per hour
  output [5:0] minutes,
  output m_roll, // rolls once per minute
  output [5:0] seconds,
  output s_roll, // rolls once per second
  output [6:0] centiseconds
);

  reg pps_latch;
  wire sec_source;
  wire hclk;

  always @*
    if (rst)
      pps_latch = pps;
    else if (pps)
      pps_latch = 1;


  assign sec_source = pps_latch ? pps : s_roll;

  overflow_counter #(.bits(5))
    h_cnt(.rst(rst), .clk, .tick(h_roll), .cmp(5'd24), .cnt(hours), .roll(d_roll), .init(hours_init));
  overflow_counter #(.bits(6))
    m_cnt(.rst(rst), .clk, .tick(m_roll), .cmp(6'd60), .cnt(minutes), .roll(h_roll), .init(6'b0));
  overflow_counter #(.bits(6))
    s_cnt(.rst(rst), .clk, .tick(sec_source), .cmp(6'd60), .cnt(seconds), .roll(m_roll), .init(6'b0));
  overflow_counter #(.bits(7))
    ms_cnt(.rst(rst), .clk, .tick(hclk), .cmp(7'd100), .cnt(centiseconds), .roll(s_roll), .init(7'b0));
  halfclock cd(.clk, .hclk);
endmodule

module halfclock (
  input clk,
  output reg hclk
);

  always @(posedge clk)
    if (hclk)
      hclk <= 0;
    else
      hclk <= 1;
endmodule

module counter #(parameter bits = 8) (
  input rst,
  input clk,
  output reg [bits-1:0] cnt
);

  always @(posedge clk)
    if (rst)
      cnt <= 0;
    else
      cnt <= cnt + 1;
endmodule

module overflow_counter #(parameter bits = 8) (
  input rst,                 // reset
  input clk,                 // the raw system clock, for rst only
  input tick,                // the counted input tick
  input [bits-1:0] init,     // value to start at coming out of reset, still wraps to 0
  input [bits-1:0] cmp,      // even numbers only, rolls over instead of reaching this number
  output reg [bits-1:0] cnt, // the value of the counter
  output reg roll            // the output tick on overflow
);

  reg newtick; // tick is much less frequent than clk, only do things (other than reset) once for each tick

  always @(posedge clk)
    if (rst) begin
      cnt <= init;
      roll <= 1;
      newtick <= 0;
    end else if (tick == 0) begin
      newtick <= 1;
    end else if (tick == 1 && newtick == 1) begin
      newtick <= 0;
      // wrap to zero instead of reaching cmp
      if(cnt == cmp-1) begin
        cnt <= 0;
        roll <= 1;
      end
      else begin
        cnt <= cnt + 1;

        // unset roll halfway through, odd values for cmp result in unbalanced roll segments
        if (cnt == (cmp/2)-1)
          roll <= 0;
      end
    end
endmodule
