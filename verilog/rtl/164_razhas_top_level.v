module razhas_top_level 
  (
    input   [7:0] io_in, 
    output  [7:0] io_out
  );

  wire        w_clk = io_in[0];
  wire        w_rst = io_in[1];
  wire  [3:0] w_duty = io_in[5:2]; // selects pwm signal duty cycle: 0% to 100% in increments of 10%. Values of 11-15 treated as 100%.
  wire  [1:0] w_freq = io_in[7:6]; // selects pwm signal frequency: 156.25 Hz, 312.5 Hz, 625 Hz, or 1250 Hz.
  wire        w_pwm; // pwm signal

  assign io_out = {7'b0000000, w_pwm};

  pwm_gen   u0 (.i_clk(w_clk), .i_rst(w_rst), .i_duty(w_duty), .i_freq(w_freq), .o_pwm(w_pwm));

endmodule