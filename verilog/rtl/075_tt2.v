/** tt2.v
 * Author: Aidan Medcalf
 * 
 * Top-level TinyTapeout 2 wrapper
 */

`default_nettype none

module AidanMedcalf_pid_controller (
    input  [7:0] io_in,
    output [7:0] io_out
);

    wire clk;
    wire reset;
    //wire enable;
    wire cfg_clk;
    wire cfg_mosi;
    wire cfg_cs;
    wire pv_in_miso;

    assign clk        = io_in[0];
    assign reset      = io_in[1];
    // io_in[2] not used
    //assign enable     = io_in[2];
    assign cfg_clk    = io_in[3];
    assign cfg_mosi   = io_in[4];
    // io_in[5] not used
    assign cfg_cs     = io_in[6];
    assign pv_in_miso = io_in[7];

    wire pv_in_clk;
    wire pv_in_cs;
    reg  [1:0] pv_in_cs_hist;
    wire out_clk, out_cs, out_mosi;

    assign io_out[0] = pv_in_clk;
    assign io_out[1] = pv_in_cs;
    //assign io_out[2] = 1'b0; // io_out[2] not used
    //assign io_out[3] = pid_stb_d1;
    //assign io_out[7:4] = out;
    assign io_out[2] = out_clk;
    assign io_out[3] = out_mosi;
    assign io_out[4] = out_cs;
    assign io_out[7:5] = 1'b0; // not used

    // Configuration registers
    //reg  [7:0] cfg_buf[4];
    wire [7:0] sp;
    wire [7:0] kp;
    wire [7:0] ki;
    //wire [7:0] kd;

    //assign sp = cfg_buf[0][3:0];
    //assign kp = cfg_buf[0][7:4];
    //assign ki = cfg_buf[1][3:0];
    //assign kd = cfg_buf[1][7:4];
    //assign stb_level[7:0] = cfg_buf[2];
    //assign stb_level[15:8] = cfg_buf[3];

    assign sp = cfg_spi_buffer[7:0];
    assign kp = cfg_spi_buffer[15:8];
    assign ki = cfg_spi_buffer[23:16];
    //assign kd = cfg_spi_buffer[31:24];

    wire pv_stb;
    wire pid_stb;
    reg pid_stb_d1;

    wire pid_rst;
    assign pid_rst = reset || !cfg_cs;

    // I/O registers
    reg [7:0] in_pv;
    reg [7:0] out;

    // Slave SPI for configuration
    //wire cfg_spi_done;
    wire [23:0] cfg_spi_buffer;
    spi_slave_in #(.BITS(24)) cfg_spi(.reset(reset), .clk(clk), .cs(cfg_cs), .sck(cfg_clk), .mosi(cfg_mosi), .out_buf(cfg_spi_buffer));

    // Shift input in
    spi_master_in spi_in(.reset(pid_rst), .clk(clk),
                           .miso(pv_in_miso), .start(pv_stb),
                           .out_buf(in_pv), .sck(pv_in_clk), .cs(pv_in_cs));

    // Shift output out
    spi_master_out spi_out(.reset(pid_rst), .clk(clk), .in_buf(out),
                           .start(pid_stb_d1),
                           .sck(out_clk), .cs(out_cs), .mosi(out_mosi));

    // PID core
    pid pid (.reset(pid_rst), .clk(clk), .pv_stb(pid_stb),
             .sp(sp), .pv(in_pv),
             .kp(kp), .ki(ki),
             .stimulus(out));
    
    strobe #(.BITS(16)) pv_stb_gen(.reset(reset), .clk(clk), .out(pv_stb));

    assign pid_stb = pv_in_cs_hist[0] && !pv_in_cs_hist[1];

    always @(posedge clk) begin
        if (reset) begin
            pid_stb_d1 <= 'b0;
            pv_in_cs_hist <= 'b0;
        end else begin
            pv_in_cs_hist <= { pv_in_cs_hist[0], pv_in_cs };
            pid_stb_d1 <= pid_stb;
        end
    end

endmodule

/*
module edge_detect (
    input  reset,
    input  clk,
    input  sig,
    input  pol,
    output out
);
    reg sigin;
    reg siglast;
    assign out = reset ? 1'b0 : (pol ? ((!siglast) && sigin) : (siglast && (!sigin)));
    always @(posedge clk) begin
        { siglast, sigin } <= { sigin, sig };
        //sigin <= sig;
        //siglast <= sigin;
    end
endmodule
*/

module strobe #(
    parameter BITS=8
) (
    input reset,
    input clk,
    output out
);
    reg  [BITS-1:0] count;
    wire [BITS-1:0] next;
    assign next = count + 'b1;
    assign out = next == 'b0;
    always @(posedge clk) begin
        if (reset) begin
            count <= 'b0;
        end else begin
            count <= next;
        end
    end
endmodule
