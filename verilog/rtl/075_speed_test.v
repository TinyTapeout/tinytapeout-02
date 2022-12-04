`timescale 1ns/10ps

//`define COCOTB_SIM

module rdffe(input clk,d,en,rst, output q);
  `ifdef COCOTB_SIM
    reg rq;
    assign #0.1 q = rq;
    always @(posedge clk or posedge rst)
      rq <= rst ? 1'b0 : ( en ? d : q);
  `else
    wire b;
    assign b = en ? d : q;
    sky130_fd_sc_hd__dfrtp_4 dfrtp(
        .D(b),
        .RESET_B(~rst),
        .CLK(clk),
        .Q(q)
    );
  `endif
endmodule

module sdffe(input clk,d,en,pre, output q);
  `ifdef COCOTB_SIM 
    reg rq;
    assign #0.1 q = rq;
    always @(posedge clk or posedge pre)
      rq <= pre ? 1'b1 : ( en ? d : q);
  `else
    wire b;
    assign b = en ? d : q;
    sky130_fd_sc_hd__dfstp_4 dfstp(
        .D(b),
        .SET_B(~pre),
        .CLK(clk),
        .Q(q)
    );
  `endif
endmodule

module inv_with_delay(input A,output Y);
  `ifdef COCOTB_SIM
  assign #0.02 Y = ~A; // pick a fairly quick delay from the tt_025C_1v80 liberty file
                       // the actualy delay per stage is going to be slower
  `else
  sky130_fd_sc_hd__inv_2 inv(.A(A),.Y(Y));
  `endif
endmodule

module nand2_with_delay(input A,input B,output Y);
  `ifdef COCOTB_SIM
  assign #0.05 Y = ~(A & B);
  `else
  sky130_fd_sc_hd__nand2_2 nand2(.A(A),.B(B),.Y(Y));
  `endif
endmodule

module ring_osc(input nrst,output osc);
  // We count for 1 scan_clk period which expected at 166uS (6KHz).
  // If the delay of one inverter is 20ps and the ring is 150 inverters long,
  // then the ring period is 6nS (2*150inv*20pS/inv)
  // This is 166MHz so expect a count of 166*166 nominally. 
  // For more time resolution make scan_clk slower but that requires more
  // counter depth. 
  // scan clk slowing can be done externally to the TT IC or with the clk div. 

  localparam NUM_INVERTERS = 150; //  must be an even number
  
  // setup loop of inverters
  // http://svn.clairexen.net/handicraft/2015/ringosc/ringosc.v
  wire [NUM_INVERTERS-1:0] delay_in, delay_out;
  wire osc_out;
  inv_with_delay idelay [NUM_INVERTERS-1:0] (
        .A(delay_in),
        .Y(delay_out)
    );
  assign delay_in = {delay_out[NUM_INVERTERS-2:0], osc_out};
  nand2_with_delay nand2_with_delay(.A(nrst),.B(delay_out[NUM_INVERTERS-1]),.Y(osc_out));
  assign osc = osc_out;
endmodule

module  ring_with_counter #(parameter WIDTH=24) (input nrst, ring_en, count_en, output [WIDTH-1:0] count);

  wire [WIDTH:0] value;
  wire rst,count_en_s0,count_en_s1,osc,nosc_buf;
  genvar i;

  ring_osc ring_osc(.nrst(ring_en),.osc(osc));

  inv_with_delay inv_r(.A(nrst),.Y(rst));

  // logic in this module should minimize loading the ring, so buffer the ring output
  inv_with_delay inv_b(.A(osc),.Y(nosc_buf)); 

  // synchronize the counter enable time to the ring oscillator frequency 
  // so metastability doesnt corrupt the count.  note: we count on the ring frequency domain

  rdffe ds0(.clk(nosc_buf),.rst(rst),.en(1'b1), .d(count_en),    .q(count_en_s0));
  rdffe ds1(.clk(nosc_buf),.rst(rst),.en(1'b1), .d(count_en_s0), .q(count_en_s1));

  // Count down toward zero from (signed)-1

  assign value[0] = nosc_buf;

  generate
		for (i = 1; i < WIDTH; i = i + 1) 
          sdffe dcg(.clk(value[i-1]),.pre(rst),.en(count_en_s1),.d(~value[i]),.q(value[i]));
  endgenerate

  // value[WIDTH] is the overflow bit.  Make it sticky.  
  // This bit should never be cleared if the measurement is designed correctly.

  sdffe dcg(.clk(value[WIDTH-1]),.pre(rst),.en(count_en_s1),.d(1'b0),.q(value[WIDTH]));

  assign count[WIDTH-1:0] = value[WIDTH:1];
  
endmodule

module ericsmi_speed_test(
  input [7:0] io_in,
  output [7:0] io_out
);

parameter WIDTH=24;
localparam COUNTER_WIDTH = 23; // TinyTapeout is small, so find a value that fits by trial and error

wire force_trig, fired, count_en;
wire [2:0] sel;
wire [2:0] trig_q;
wire [1:0] ring_en;
wire [WIDTH-1:0] value0,value1;
wire [COUNTER_WIDTH-1:0] count0,count1;

wire clk  = io_in[0];
wire nrst = io_in[1];
wire trig = io_in[2];

assign sel[2:0]     = io_in[5:3];
assign ring_en[1:0] = io_in[7:6];

assign force_trig = &sel; // force the oscillators and counters to run to test their operation
                          // not really a controlled measurement.  Only for debug. 

inv_with_delay inv_r(.A(nrst),.Y(rst));

// Enable the counters for one clk period upon trig rising edge. 
// Asserting nrst arms the measurements.  Clear nrst before fire. 

rdffe dt0(.clk(clk),.rst(rst),.en(1'b1), .d(trig ),     .q(trig_q[0]));
rdffe dt1(.clk(clk),.rst(rst),.en(1'b1), .d(trig_q[0]), .q(trig_q[1]));

rdffe dt2(
    .clk(clk),
    .rst(rst),
    .en(1'b1),
    .d((trig_q[0] & ~trig_q[1])),
    .q(trig_q[2])
);

rdffe dt3(
    .clk(clk),
    .rst(rst),
    .en(1'b1),
    .d(trig_q[2] | fired),
    .q(fired)
);

assign count_en = force_trig | trig_q[2];

ring_with_counter #(.WIDTH(COUNTER_WIDTH)) ring0(
    .nrst(nrst),
    .ring_en(ring_en[0]),
    .count_en(count_en),
    .count(count0[COUNTER_WIDTH-1:0])
);

assign value0[WIDTH-1:0] = {{WIDTH-COUNTER_WIDTH{count0[COUNTER_WIDTH-1]}},count0[COUNTER_WIDTH-1:0]};

ring_with_counter #(.WIDTH(COUNTER_WIDTH)) ring1(
    .nrst(nrst),
    .ring_en(ring_en[1]),
    .count_en(count_en),
    .count(count1[COUNTER_WIDTH-1:0])
);

assign value1[WIDTH-1:0] = {{WIDTH-COUNTER_WIDTH{count1[COUNTER_WIDTH-1]}},count1[COUNTER_WIDTH-1:0]};

wire [7:0] status;

// when force_trigger is asserted put the status byte on the output, everything is free running. 
assign status[7:0] = {1'b1, 
                      fired, 
                      value1[COUNTER_WIDTH-1], // overflow
                      value0[COUNTER_WIDTH-1], // overflow
                      value1[COUNTER_WIDTH-2],
                      value0[COUNTER_WIDTH-2],
                      value1[16], // 16=Ceiling@Log2[166*166]+1
                      value0[16]};

assign io_out[7:0] = sel[2:0] == 3'b000 ? 8'd0 : 
                     sel[2:0] == 3'b001 ? {value0[7:0]} :
                     sel[2:0] == 3'b010 ? {value0[15:8]} :
                     sel[2:0] == 3'b011 ? {value0[23:16]} : 
                     sel[2:0] == 3'b100 ? {value1[7:0]} :
                     sel[2:0] == 3'b101 ? {value1[15:8]} :
                     sel[2:0] == 3'b110 ? {value1[23:16]} :
                                          status[7:0] ;

endmodule
