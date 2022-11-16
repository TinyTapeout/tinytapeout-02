///////////////////////////////////////////////////////////////////////////
// M0 - 16-bit serial SUBLEQ processor
//
// Copyright 2022 William Moyes
//

`default_nettype none
`timescale 100us/10ps


///////////////////////////////////////////////////////////////////////////
// SPI Controller
//
// 16-bit Address + 16-bit Data controller and timing generator
//
module SPIController (
  // System Interfaces
  input wire clk,
  input wire rst,

  // SPI Bus Interfaces
  output reg CS0,
  output reg CS1,
  output reg SPICLK,
  output reg MOSI,
  input wire MISO,

  // Input Signals
  input wire Addr15, 		// Sampled on Phase 01
  input wire Read_notWrite,	// Sampled on Phase 16
  input wire Addr,		// Sampled on Phase 18[bit0/LSB], 20[bit1], ..., 44[bit13], 46[bit14/MSB], bit 15 not sampled (see Addr15)
  input wire Data,		// Sampled on Phase 50[bit0/LSB], 52[bit1], ..., 78[bit14], 80[bit15/MSB]


  // Timing Output Signals
  output reg ShiftAddr,		// Asserted when the Address should be shifted
  output reg ShiftDataRead,     // Asserted when the data register collecting data read from memory should be shifted
  output reg ShiftDataWrite,    // Asserted when the data regsiter providing data to be written to memory should be shifted
  output reg PresetCarry,       // Asserted the clock before data motion starts
  output reg EndOfPhase         //
);

  // SPI sequencer
  reg [6:0] SPIphase;
  always @(posedge clk) begin
    if (rst)
      SPIphase <= 0;
    else if (SPIphase == 83)
      SPIphase <= 0;
    else
      SPIphase <= SPIphase + 1;
  end

  // SPI bus signal generator
  always @(posedge clk) begin
    if (SPIphase <= 1) begin
      CS0 <= 1;
      CS1 <= 1;
      SPICLK <= 0;
      MOSI <= 0;
    end else begin
      CS0 <= CSreg;
      CS1 <= !CSreg;
      if (SPIphase <= 81)
        SPICLK <= SPIphase[0];
      else
        SPICLK <= 0;

      if (SPIphase <= 13)
        MOSI <= 0;
      else if (SPIphase <= 15)
        MOSI <= 1;
      else if (SPIphase <= 17) begin
        if (SPIphase[0] == 0)
          MOSI <= Read_notWrite;
      end else if (SPIphase <= 47) begin
        if (SPIphase[0] == 0)
          MOSI <= Addr;		// TODO: Generate the Address Shift timing pulse output
      end else if (SPIphase <= 49)
        MOSI <= 0;
      else begin
        if (Read_notWrite)
          MOSI <= 0;
        else begin
          if (SPIphase[0] == 0)
            MOSI <= Data;      	// TODO: Generate the Address Shift timing pulse output
        end
      end
    end
  end

  // Generate Address Shift Enable Signals
  always @(posedge clk) begin
    ShiftAddr <= ((SPIphase >= 18) && (SPIphase <= 48) && (SPIphase[0] == 0));
    ShiftDataRead <= ((SPIphase >= 51) && (SPIphase <= 81) && (SPIphase[0] == 1) && Read_notWrite);
    ShiftDataWrite <= ((SPIphase >= 50) && (SPIphase <= 80) && (SPIphase[0] == 0) && !Read_notWrite);
    PresetCarry <= (SPIphase == 17);
    EndOfPhase <= (SPIphase == 83);
  end

  reg CSreg;
  always @(posedge clk) begin
    if (SPIphase == 1)
      CSreg <= Addr15;
  end

endmodule



///////////////////////////////////////////////////////////////////////////
// M0 top level
//
module moyes0_top_module (
  input  [7:0] io_in,
  output [7:0] io_out
);

  // --- ASIC Inputs ---
  wire clk     = io_in[0];      // System clock (~6000 Hz)
  wire rst     = io_in[1];      // Reset line, active high
  wire spi_miso= io_in[2];      // SPI bus, ASIC input, target output
  wire uart_rx = io_in[3];      // Serial port, ASIC Receive
  wire in4     = io_in[4];
  wire in5     = io_in[5];
  wire in6     = io_in[6];
  wire in7     = io_in[7];

  // --- ASIC Outputs ---
  wire spi_cs0;
  wire spi_cs1;
  wire spi_clk;
  wire spi_mosi;
  wire uart_tx;
  wire out5;
  wire out6;
  wire out7;

  wire [7:0] io_out;
  assign io_out[0] = spi_cs0;  // SPI bus, Chip Select for ROM, Words 0000-7FFF
  assign io_out[1] = spi_cs1;  // SPI bus, Chip Select for RAM, Words 8000-FFFF
  assign io_out[2] = spi_clk;  // SPI bus, Clock
  assign io_out[3] = spi_mosi; // SPI bus, ASIC output, target input
  assign io_out[4] = uart_tx;  // Serial port, ASIC Transmit
  assign io_out[5] = out5;
  assign io_out[6] = out6;
  assign io_out[7] = out7;

  // --- Internal Timing Signals ---
  wire ShiftAddr;
  wire ShiftDataRead;
  wire ShiftDataWrite;
  wire PresetCarry;
  wire EndOfPhase;

  // --- SPI Control Signals
  wire Addr15;
  wire Read_notWrite;
  wire SPIAddr;
  wire SPIDataIn;

  // --- CPU Registers ---
  reg [15:0] PC;
  reg [15:0] TMP;
  reg [15:0] ADR;
  reg PCCarry;
  reg TBorrow;
  reg TZero;
  reg LEQ;


  SPIController spi (
     // System Interfaces
    .clk(clk),
    .rst(rst),

    // SPI Bus Interfaces
    .CS0(spi_cs0),
    .CS1(spi_cs1),
    .SPICLK(spi_clk),
    .MOSI(spi_mosi),
    .MISO(spi_miso),

    // Input Signals
    .Addr15(Addr15),
    .Read_notWrite(Read_notWrite),
    .Addr(SPIAddr),
    .Data(SPIDataIn),

    // Timing Output Signals
    .ShiftAddr(ShiftAddr),
    .ShiftDataRead(ShiftDataRead),
    .ShiftDataWrite(ShiftDataWrite),
    .PresetCarry(PresetCarry),
    .EndOfPhase(EndOfPhase)
  );

  reg [2:0]  CPUphase;
  always @(posedge clk) begin
    if (rst)
      CPUphase <= 3'd0;
    else if (!EndOfPhase)
      CPUphase <= CPUphase;
    else begin
      if (CPUphase == 3'd5)
         CPUphase <= 3'd0;
      else
         CPUphase <= CPUphase + 3'd1;
    end
  end

  wire PCphase = (CPUphase == 0) || (CPUphase == 2) || (CPUphase == 5);

  assign Addr15 = PCphase ? PC[15] : ADR[15];

  assign Read_notWrite = (CPUphase != 4);

  always @(posedge clk) begin

    if (rst)
      PC  <= 16'h0000;
    else begin
      if (PresetCarry)
        PCCarry <= 1;

      if (PCphase && ShiftAddr) begin
        PCCarry <= PC[0] & PCCarry;
        PC <= {PC[0] ^ PCCarry, PC[15:1]};
      end

      if ((CPUphase == 5) && ShiftDataRead) begin
        PC <= {LEQ ? spi_miso : PC[0], PC[15:1]};
      end
    end
  end

  assign SPIAddr = PCphase ? PC[0] : ADR[0];

  assign SPIDataIn = TMP[0];

  wire ReadADR = (CPUphase == 0) || (CPUphase == 2);
  wire ReadTMP = (CPUphase == 1) || (CPUphase == 3);

  always @(posedge clk) begin
    if (ReadADR & ShiftDataRead)
      ADR <= {spi_miso, ADR[15:1]};

    if (!PCphase & ShiftAddr)
      ADR <= {ADR[0], ADR[15:1]};
  end


  wire sub_b;
  wire sub_r;
  assign {sub_b, sub_r} = spi_miso - TMP[0] - TBorrow;

  always @(posedge clk) begin
    if (PresetCarry) begin
      TBorrow <= 0;
      TZero <= 1;
    end

    if ((CPUphase == 1) & ShiftDataRead)
      TMP <= {spi_miso, TMP[15:1]};

    if ((CPUphase == 3) & ShiftDataRead) begin
      TBorrow <= sub_b;
      TMP <= {sub_r, TMP[15:1]};
      if (sub_r)
        TZero <= 0;
    end

    if (!Read_notWrite & ShiftDataWrite)
      TMP <= {TMP[0], TMP[15:1]};

  end

  always @(posedge clk) begin
    if (EndOfPhase & (CPUphase == 3)) begin
      LEQ <= TZero | TBorrow;
    end
  end



endmodule
