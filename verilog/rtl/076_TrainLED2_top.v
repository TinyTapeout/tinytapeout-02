module cpldcpu_TrainLED2top(
  input [7:0] io_in,
  output [7:0] io_out
);

// Instance 1
TrainLED2 TrainLED2_top1 (
  .clk(io_in[0]),
  .rst(io_in[1]),
  .din(io_in[2]),
  .dout(io_out[0]),
  .led1(io_out[1]),
  .led2(io_out[2]),
  .led3(io_out[3])
  );



endmodule