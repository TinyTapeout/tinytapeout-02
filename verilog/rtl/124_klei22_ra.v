`default_nettype none

module klei22_ra #(
    parameter RA_SIZE = 8,
    parameter BITS_PER_ELEM = 5
) (
    input  [7:0] io_in,
    output [7:0] io_out
);

  wire clk = io_in[0];
  wire rst = io_in[1];
  wire i_data_clk = io_in[2];
  wire start_calc;
  wire [4:0] i_value = io_in[7:3];

  wire [BITS_PER_ELEM - 1:0] ra_out;
  assign io_out[BITS_PER_ELEM-1:0] = {3'b000, ra_out[4:0]};


  parameter SRL_SIZE = RA_SIZE + 1;  // RA_SIZE valid inputs and one stale input
  parameter TOTAL_SRL_BITS = 5 * SRL_SIZE;
  wire [TOTAL_SRL_BITS - 1:0] taps;

  shift_register_line #(
      .TOTAL_TAPS(SRL_SIZE),
      .BITS_PER_ELEM(BITS_PER_ELEM),
      .TOTAL_BITS(TOTAL_SRL_BITS)
  ) srl_1 (
      .clk(clk),
      .rst(rst),
      .i_value(i_value[4:0]),
      .i_data_clk(i_data_clk),
      .o_start_calc(start_calc),
      .o_taps(taps[TOTAL_SRL_BITS-1:0])
  );

  // rolling sums RA_SIZE elements + 1 stale element
  parameter RA_NUM_ELEM = RA_SIZE;
  parameter MAX_BITS = 8;  // log_2(31 * 8) = 7.9 ~ 8; where 31 is largest valut for 5 bit elem
  rolling_average #(
      .BITS_PER_ELEM(BITS_PER_ELEM),
      .MAX_BITS(8)
  ) ra_1 (
      .clk(clk),
      .rst(rst),
      .i_new(taps[4:0]),
      .i_old(taps[(4 + 5 * 9):(0 + 5 * 8)]),
      .i_start_calc(start_calc),
      .o_ra(ra_out[BITS_PER_ELEM-1:0])
  );


endmodule
