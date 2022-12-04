`default_nettype none

// Keep I/O fixed for TinyTapeout
module gregdavill_serv_top(
    input [7:0] io_in,
    output [7:0] io_out
  );

  wire clk =   io_in[0];
  wire reset = io_in[7];

  wire data =         io_in[4];
  wire scan_select =  io_in[5];
  wire latch_enable = io_in[6];
  wire serv_clk =     io_in[7];

  wire timer_irq;

  parameter reset_strategy = "MINI";
  parameter sim = 0;
  parameter with_csr = 0;
  parameter [0:0] compress = 0;
  parameter [0:0] align = 0;

  wire [4+with_csr:0] wreg0;
  wire [4+with_csr:0] wreg1;
  wire [4+with_csr:0] rreg0;
  wire [4+with_csr:0] rreg1;
  wire 	      rf_wreq;
  wire 	      rf_rreq;
  wire 	      wen0;
  wire 	      wen1;
  wire 	      wdata0;
  wire 	      wdata1;
  wire 	      rf_ready;
  wire 	      rdata0;
  wire 	      rdata1;

  wire [31:0] 	wb_ibus_adr;
  wire [31:0] 	wb_ibus_rdt;
  wire 	wb_ibus_cyc;
  wire 	wb_ibus_ack;

  wire [31:0] 	wb_dbus_adr;
  wire [31:0] 	wb_dbus_dat;
  wire [3:0] 	wb_dbus_sel;
  wire [31:0] 	wb_dbus_rdt;
  wire 	wb_dbus_we;
  wire 	wb_dbus_cyc;
  wire 	wb_dbus_ack;

  wire [31:0] 	wb_dmem_adr;
  wire [31:0] 	wb_dmem_dat;
  wire [3:0] 	wb_dmem_sel;
  wire [31:0] 	wb_dmem_rdt;
  wire 	wb_dmem_we;
  wire 	wb_dmem_cyc;
  wire 	wb_dmem_ack;

  wire [31:0] 	wb_mem_adr;
  wire [31:0] 	wb_mem_dat;
  wire [3:0] 	wb_mem_sel;
  wire [31:0] 	wb_mem_rdt;
  wire 	wb_mem_we;
  wire 	wb_mem_cyc;
  wire 	wb_mem_ack;

  wire 	wb_gpio_dat;
  wire 	wb_gpio_we;
  wire 	wb_gpio_cyc;
  wire 	wb_gpio_rdt;


  servant_arbiter u_arbiter (
    .i_wb_cpu_dbus_adr (wb_dbus_adr),
    .i_wb_cpu_dbus_dat (wb_dbus_dat),
    .i_wb_cpu_dbus_sel (wb_dbus_sel),
    .i_wb_cpu_dbus_we  (wb_dbus_we ),
    .i_wb_cpu_dbus_cyc (wb_dbus_cyc),
    .o_wb_cpu_dbus_rdt (wb_dbus_rdt),
    .o_wb_cpu_dbus_ack (wb_dbus_ack),

    .i_wb_cpu_ibus_adr (wb_ibus_adr),
    .i_wb_cpu_ibus_cyc (wb_ibus_cyc),
    .o_wb_cpu_ibus_rdt (wb_ibus_rdt),
    .o_wb_cpu_ibus_ack (wb_ibus_ack),

    .o_wb_cpu_adr (wb_mem_adr),
    .o_wb_cpu_dat (wb_mem_dat),
    .o_wb_cpu_sel (wb_mem_sel),
    .o_wb_cpu_we  (wb_mem_we ),
    .o_wb_cpu_cyc (wb_mem_cyc),
    .i_wb_cpu_rdt (wb_mem_rdt),
    .i_wb_cpu_ack (wb_mem_ack)
  );


  serv_top #(
    .RESET_PC (32'h0000_0000),
    .PRE_REGISTER(1),
    .RESET_STRATEGY (reset_strategy),
    .WITH_CSR (with_csr),
    .COMPRESSED(compress),
    .ALIGN(align))
  cpu
  (
    .clk          (serv_clk),
    .i_rst        (reset),
    .i_timer_irq  (timer_irq),

    .o_rf_rreq    (rf_rreq),
    .o_rf_wreq    (rf_wreq),
    .i_rf_ready   (rf_ready),
    .o_wreg0      (wreg0),
    .o_wreg1      (wreg1),
    .o_wen0       (wen0),
    .o_wen1       (wen1),
    .o_wdata0     (wdata0),
    .o_wdata1     (wdata1),
    .o_rreg0      (rreg0),
    .o_rreg1      (rreg1),
    .i_rdata0     (rdata0),
    .i_rdata1     (rdata1),

    .o_ibus_adr   (wb_ibus_adr),
    .o_ibus_cyc   (wb_ibus_cyc),
    .i_ibus_rdt   (wb_ibus_rdt),
    .i_ibus_ack   (wb_ibus_ack),

    .o_dbus_adr   (wb_dbus_adr),
    .o_dbus_dat   (wb_dbus_dat),
    .o_dbus_sel   (wb_dbus_sel),
    .o_dbus_we    (wb_dbus_we),
    .o_dbus_cyc   (wb_dbus_cyc),
    .i_dbus_rdt   (wb_dbus_rdt),
    .i_dbus_ack   (wb_dbus_ack)
  );


  scanchain_local #(
    .SCAN_LENGTH(96))
  u_scanchain_local
  (
    // Inputs from TinyTapeout scanchain to our internal scanchain
    .clk_in          (clk),
    .data_in         (data),
    .scan_select_in  (scan_select),

    // Pass all signals out from our internal scanchain, only really need data
    .clk_out         (io_out[0]),
    .data_out        (io_out[1]),
    .scan_select_out (io_out[2]),

    // data
    .module_data_out ({
      // Bus interface
      wb_mem_adr[31:0],   // 32
      wb_mem_dat,         // 32
      wb_mem_sel,         // 4
      wb_mem_we,          // 1
      wb_mem_cyc,         // 1
      // RF interface
      rf_wreq,            // 1
      rf_rreq,            // 1
      wreg0,              // 5
      wreg1,              // 5
      wen0,               // 1
      wen1,               // 1
      wdata0,             // 1
      wdata1,             // 1
      rreg0,              // 5
      rreg1}),            // 5

    .module_data_in  ({
      // Bus interface
      wb_mem_rdt,         // 32
      wb_mem_ack,         // 1
      timer_irq,          // 1
      rf_ready,           // 1
      rdata0,             // 1
      rdata1})            // 1
  );

endmodule
