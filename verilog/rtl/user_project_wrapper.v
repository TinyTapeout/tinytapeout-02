// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 * THIS FILE HAS BEEN GENERATED USING multi_tools_project CODEGEN
 * IF YOU NEED TO MAKE EDITS TO IT, EDIT codegen/caravel_iface_header.txt
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vdda1,       // User area 1 3.3V supply
    inout vdda2,       // User area 2 3.3V supply
    inout vssa1,       // User area 1 analog ground
    inout vssa2,       // User area 2 analog ground
    inout vccd1,       // User area 1 1.8V supply
    inout vccd2,       // User area 2 1.8v supply
    inout vssd1,       // User area 1 digital ground
    inout vssd2,       // User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

    // start of module instantiation

    wire sc_clk_out, sc_data_out, sc_latch_out, sc_scan_out;
    wire sc_clk_in,  sc_data_in;

    scan_controller #(.NUM_DESIGNS(473)) scan_controller (
       .clk                    (wb_clk_i),
       .reset                  (wb_rst_i),
       .active_select          (io_in[20:12]),
       .inputs                 (io_in[28:21]),
       .outputs                (io_out[36:29]),
       .ready                  (io_out[37]),
       .slow_clk               (io_out[10]),
       .set_clk_div            (io_in[11]),

       .scan_clk_out           (sc_clk_out),
       .scan_clk_in            (sc_clk_in),
       .scan_data_out          (sc_data_out),
       .scan_data_in           (sc_data_in),
       .scan_select            (sc_scan_out),
       .scan_latch_en          (sc_latch_out),

       .la_scan_clk_in         (la_data_in[0]),
       .la_scan_data_in        (la_data_in[1]),
       .la_scan_data_out       (la_data_out[0]),
       .la_scan_select         (la_data_in[2]),
       .la_scan_latch_en       (la_data_in[3]),

       .driver_sel             (io_in[9:8]),

       .oeb                    (io_oeb)
    );

    // [000] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_000_clk_out, sw_000_data_out, sw_000_scan_out, sw_000_latch_out;
    wire [7:0] sw_000_module_data_in;
    wire [7:0] sw_000_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_0 (
        .clk_in          (sc_clk_out),
        .data_in         (sc_data_out),
        .scan_select_in  (sc_scan_out),
        .latch_enable_in (sc_latch_out),
        .clk_out         (sw_000_clk_out),
        .data_out        (sw_000_data_out),
        .scan_select_out (sw_000_scan_out),
        .latch_enable_out(sw_000_latch_out),
        .module_data_in  (sw_000_module_data_in),
        .module_data_out (sw_000_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_0 (
        .io_in  (sw_000_module_data_in),
        .io_out (sw_000_module_data_out)
    );

    // [001] https://github.com/Fraserbc/tt02-simon
    wire sw_001_clk_out, sw_001_data_out, sw_001_scan_out, sw_001_latch_out;
    wire [7:0] sw_001_module_data_in;
    wire [7:0] sw_001_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_1 (
        .clk_in          (sw_000_clk_out),
        .data_in         (sw_000_data_out),
        .scan_select_in  (sw_000_scan_out),
        .latch_enable_in (sw_000_latch_out),
        .clk_out         (sw_001_clk_out),
        .data_out        (sw_001_data_out),
        .scan_select_out (sw_001_scan_out),
        .latch_enable_out(sw_001_latch_out),
        .module_data_in  (sw_001_module_data_in),
        .module_data_out (sw_001_module_data_out)
    );

    fraserbc_simon fraserbc_simon_1 (
        .io_in  (sw_001_module_data_in),
        .io_out (sw_001_module_data_out)
    );

    // [002] https://github.com/TomKeddie/tinytapeout-2022-2
    wire sw_002_clk_out, sw_002_data_out, sw_002_scan_out, sw_002_latch_out;
    wire [7:0] sw_002_module_data_in;
    wire [7:0] sw_002_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_2 (
        .clk_in          (sw_001_clk_out),
        .data_in         (sw_001_data_out),
        .scan_select_in  (sw_001_scan_out),
        .latch_enable_in (sw_001_latch_out),
        .clk_out         (sw_002_clk_out),
        .data_out        (sw_002_data_out),
        .scan_select_out (sw_002_scan_out),
        .latch_enable_out(sw_002_latch_out),
        .module_data_in  (sw_002_module_data_in),
        .module_data_out (sw_002_module_data_out)
    );

    tomkeddie_top_tto tomkeddie_top_tto_2 (
        .io_in  (sw_002_module_data_in),
        .io_out (sw_002_module_data_out)
    );

    // [003] https://github.com/chrisruk/matrixchip
    wire sw_003_clk_out, sw_003_data_out, sw_003_scan_out, sw_003_latch_out;
    wire [7:0] sw_003_module_data_in;
    wire [7:0] sw_003_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_3 (
        .clk_in          (sw_002_clk_out),
        .data_in         (sw_002_data_out),
        .scan_select_in  (sw_002_scan_out),
        .latch_enable_in (sw_002_latch_out),
        .clk_out         (sw_003_clk_out),
        .data_out        (sw_003_data_out),
        .scan_select_out (sw_003_scan_out),
        .latch_enable_out(sw_003_latch_out),
        .module_data_in  (sw_003_module_data_in),
        .module_data_out (sw_003_module_data_out)
    );

    chrisruk_matrix chrisruk_matrix_3 (
        .io_in  (sw_003_module_data_in),
        .io_out (sw_003_module_data_out)
    );

    // [004] https://github.com/loxodes/tt02-submission-loxodes
    wire sw_004_clk_out, sw_004_data_out, sw_004_scan_out, sw_004_latch_out;
    wire [7:0] sw_004_module_data_in;
    wire [7:0] sw_004_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_4 (
        .clk_in          (sw_003_clk_out),
        .data_in         (sw_003_data_out),
        .scan_select_in  (sw_003_scan_out),
        .latch_enable_in (sw_003_latch_out),
        .clk_out         (sw_004_clk_out),
        .data_out        (sw_004_data_out),
        .scan_select_out (sw_004_scan_out),
        .latch_enable_out(sw_004_latch_out),
        .module_data_in  (sw_004_module_data_in),
        .module_data_out (sw_004_module_data_out)
    );

    loxodes_sequencer loxodes_sequencer_4 (
        .io_in  (sw_004_module_data_in),
        .io_out (sw_004_module_data_out)
    );

    // [005] https://github.com/migcorre/tt02-dc
    wire sw_005_clk_out, sw_005_data_out, sw_005_scan_out, sw_005_latch_out;
    wire [7:0] sw_005_module_data_in;
    wire [7:0] sw_005_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_5 (
        .clk_in          (sw_004_clk_out),
        .data_in         (sw_004_data_out),
        .scan_select_in  (sw_004_scan_out),
        .latch_enable_in (sw_004_latch_out),
        .clk_out         (sw_005_clk_out),
        .data_out        (sw_005_data_out),
        .scan_select_out (sw_005_scan_out),
        .latch_enable_out(sw_005_latch_out),
        .module_data_in  (sw_005_module_data_in),
        .module_data_out (sw_005_module_data_out)
    );

    migcorre_pwm migcorre_pwm_5 (
        .io_in  (sw_005_module_data_in),
        .io_out (sw_005_module_data_out)
    );

    // [006] https://github.com/ryancor/tt02-submission-template
    wire sw_006_clk_out, sw_006_data_out, sw_006_scan_out, sw_006_latch_out;
    wire [7:0] sw_006_module_data_in;
    wire [7:0] sw_006_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_6 (
        .clk_in          (sw_005_clk_out),
        .data_in         (sw_005_data_out),
        .scan_select_in  (sw_005_scan_out),
        .latch_enable_in (sw_005_latch_out),
        .clk_out         (sw_006_clk_out),
        .data_out        (sw_006_data_out),
        .scan_select_out (sw_006_scan_out),
        .latch_enable_out(sw_006_latch_out),
        .module_data_in  (sw_006_module_data_in),
        .module_data_out (sw_006_module_data_out)
    );

    cpu_top cpu_top_6 (
        .io_in  (sw_006_module_data_in),
        .io_out (sw_006_module_data_out)
    );

    // [007] https://github.com/AidanGood/tt02-McCoy
    wire sw_007_clk_out, sw_007_data_out, sw_007_scan_out, sw_007_latch_out;
    wire [7:0] sw_007_module_data_in;
    wire [7:0] sw_007_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_7 (
        .clk_in          (sw_006_clk_out),
        .data_in         (sw_006_data_out),
        .scan_select_in  (sw_006_scan_out),
        .latch_enable_in (sw_006_latch_out),
        .clk_out         (sw_007_clk_out),
        .data_out        (sw_007_data_out),
        .scan_select_out (sw_007_scan_out),
        .latch_enable_out(sw_007_latch_out),
        .module_data_in  (sw_007_module_data_in),
        .module_data_out (sw_007_module_data_out)
    );

    aidan_McCoy aidan_McCoy_7 (
        .io_in  (sw_007_module_data_in),
        .io_out (sw_007_module_data_out)
    );

    // [008] https://github.com/azdle/binary-clock-asic
    wire sw_008_clk_out, sw_008_data_out, sw_008_scan_out, sw_008_latch_out;
    wire [7:0] sw_008_module_data_in;
    wire [7:0] sw_008_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_8 (
        .clk_in          (sw_007_clk_out),
        .data_in         (sw_007_data_out),
        .scan_select_in  (sw_007_scan_out),
        .latch_enable_in (sw_007_latch_out),
        .clk_out         (sw_008_clk_out),
        .data_out        (sw_008_data_out),
        .scan_select_out (sw_008_scan_out),
        .latch_enable_out(sw_008_latch_out),
        .module_data_in  (sw_008_module_data_in),
        .module_data_out (sw_008_module_data_out)
    );

    azdle_binary_clock azdle_binary_clock_8 (
        .io_in  (sw_008_module_data_in),
        .io_out (sw_008_module_data_out)
    );

    // [009] https://github.com/justinP-wrk/tt02-TinySensor
    wire sw_009_clk_out, sw_009_data_out, sw_009_scan_out, sw_009_latch_out;
    wire [7:0] sw_009_module_data_in;
    wire [7:0] sw_009_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_9 (
        .clk_in          (sw_008_clk_out),
        .data_in         (sw_008_data_out),
        .scan_select_in  (sw_008_scan_out),
        .latch_enable_in (sw_008_latch_out),
        .clk_out         (sw_009_clk_out),
        .data_out        (sw_009_data_out),
        .scan_select_out (sw_009_scan_out),
        .latch_enable_out(sw_009_latch_out),
        .module_data_in  (sw_009_module_data_in),
        .module_data_out (sw_009_module_data_out)
    );

    user_module_347787021138264660 user_module_347787021138264660_9 (
        .io_in  (sw_009_module_data_in),
        .io_out (sw_009_module_data_out)
    );

    // [010] https://github.com/jar/tt02_sram
    wire sw_010_clk_out, sw_010_data_out, sw_010_scan_out, sw_010_latch_out;
    wire [7:0] sw_010_module_data_in;
    wire [7:0] sw_010_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_10 (
        .clk_in          (sw_009_clk_out),
        .data_in         (sw_009_data_out),
        .scan_select_in  (sw_009_scan_out),
        .latch_enable_in (sw_009_latch_out),
        .clk_out         (sw_010_clk_out),
        .data_out        (sw_010_data_out),
        .scan_select_out (sw_010_scan_out),
        .latch_enable_out(sw_010_latch_out),
        .module_data_in  (sw_010_module_data_in),
        .module_data_out (sw_010_module_data_out)
    );

    jar_sram_top jar_sram_top_10 (
        .io_in  (sw_010_module_data_in),
        .io_out (sw_010_module_data_out)
    );

    // [011] https://github.com/JensIMS/tt02-trafficlight
    wire sw_011_clk_out, sw_011_data_out, sw_011_scan_out, sw_011_latch_out;
    wire [7:0] sw_011_module_data_in;
    wire [7:0] sw_011_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_11 (
        .clk_in          (sw_010_clk_out),
        .data_in         (sw_010_data_out),
        .scan_select_in  (sw_010_scan_out),
        .latch_enable_in (sw_010_latch_out),
        .clk_out         (sw_011_clk_out),
        .data_out        (sw_011_data_out),
        .scan_select_out (sw_011_scan_out),
        .latch_enable_out(sw_011_latch_out),
        .module_data_in  (sw_011_module_data_in),
        .module_data_out (sw_011_module_data_out)
    );

    user_module_347690870424732244 user_module_347690870424732244_11 (
        .io_in  (sw_011_module_data_in),
        .io_out (sw_011_module_data_out)
    );

    // [012] https://github.com/svd321/tt02-Ising
    wire sw_012_clk_out, sw_012_data_out, sw_012_scan_out, sw_012_latch_out;
    wire [7:0] sw_012_module_data_in;
    wire [7:0] sw_012_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_12 (
        .clk_in          (sw_011_clk_out),
        .data_in         (sw_011_data_out),
        .scan_select_in  (sw_011_scan_out),
        .latch_enable_in (sw_011_latch_out),
        .clk_out         (sw_012_clk_out),
        .data_out        (sw_012_data_out),
        .scan_select_out (sw_012_scan_out),
        .latch_enable_out(sw_012_latch_out),
        .module_data_in  (sw_012_module_data_in),
        .module_data_out (sw_012_module_data_out)
    );

    user_module_347592305412145748 user_module_347592305412145748_12 (
        .io_in  (sw_012_module_data_in),
        .io_out (sw_012_module_data_out)
    );

    // [013] https://github.com/89Mods/tt2-AvalonSemi-5401
    wire sw_013_clk_out, sw_013_data_out, sw_013_scan_out, sw_013_latch_out;
    wire [7:0] sw_013_module_data_in;
    wire [7:0] sw_013_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_13 (
        .clk_in          (sw_012_clk_out),
        .data_in         (sw_012_data_out),
        .scan_select_in  (sw_012_scan_out),
        .latch_enable_in (sw_012_latch_out),
        .clk_out         (sw_013_clk_out),
        .data_out        (sw_013_data_out),
        .scan_select_out (sw_013_scan_out),
        .latch_enable_out(sw_013_latch_out),
        .module_data_in  (sw_013_module_data_in),
        .module_data_out (sw_013_module_data_out)
    );

    tholin_avalonsemi_5401 tholin_avalonsemi_5401_13 (
        .io_in  (sw_013_module_data_in),
        .io_out (sw_013_module_data_out)
    );

    // [014] https://github.com/RiceShelley/tiny-fft
    wire sw_014_clk_out, sw_014_data_out, sw_014_scan_out, sw_014_latch_out;
    wire [7:0] sw_014_module_data_in;
    wire [7:0] sw_014_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_14 (
        .clk_in          (sw_013_clk_out),
        .data_in         (sw_013_data_out),
        .scan_select_in  (sw_013_scan_out),
        .latch_enable_in (sw_013_latch_out),
        .clk_out         (sw_014_clk_out),
        .data_out        (sw_014_data_out),
        .scan_select_out (sw_014_scan_out),
        .latch_enable_out(sw_014_latch_out),
        .module_data_in  (sw_014_module_data_in),
        .module_data_out (sw_014_module_data_out)
    );

    tiny_fft tiny_fft_14 (
        .io_in  (sw_014_module_data_in),
        .io_out (sw_014_module_data_out)
    );

    // [015] https://github.com/moyesw/tt02-moyesw-StreamIntegrator
    wire sw_015_clk_out, sw_015_data_out, sw_015_scan_out, sw_015_latch_out;
    wire [7:0] sw_015_module_data_in;
    wire [7:0] sw_015_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_15 (
        .clk_in          (sw_014_clk_out),
        .data_in         (sw_014_data_out),
        .scan_select_in  (sw_014_scan_out),
        .latch_enable_in (sw_014_latch_out),
        .clk_out         (sw_015_clk_out),
        .data_out        (sw_015_data_out),
        .scan_select_out (sw_015_scan_out),
        .latch_enable_out(sw_015_latch_out),
        .module_data_in  (sw_015_module_data_in),
        .module_data_out (sw_015_module_data_out)
    );

    user_module_346553315158393428 user_module_346553315158393428_15 (
        .io_in  (sw_015_module_data_in),
        .io_out (sw_015_module_data_out)
    );

    // [016] https://github.com/Tschucker/tt02-submission-tiny-fir
    wire sw_016_clk_out, sw_016_data_out, sw_016_scan_out, sw_016_latch_out;
    wire [7:0] sw_016_module_data_in;
    wire [7:0] sw_016_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_16 (
        .clk_in          (sw_015_clk_out),
        .data_in         (sw_015_data_out),
        .scan_select_in  (sw_015_scan_out),
        .latch_enable_in (sw_015_latch_out),
        .clk_out         (sw_016_clk_out),
        .data_out        (sw_016_data_out),
        .scan_select_out (sw_016_scan_out),
        .latch_enable_out(sw_016_latch_out),
        .module_data_in  (sw_016_module_data_in),
        .module_data_out (sw_016_module_data_out)
    );

    user_module_347894637149553236 user_module_347894637149553236_16 (
        .io_in  (sw_016_module_data_in),
        .io_out (sw_016_module_data_out)
    );

    // [017] https://github.com/steieio/tt02-submission-universal-sr
    wire sw_017_clk_out, sw_017_data_out, sw_017_scan_out, sw_017_latch_out;
    wire [7:0] sw_017_module_data_in;
    wire [7:0] sw_017_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_17 (
        .clk_in          (sw_016_clk_out),
        .data_in         (sw_016_data_out),
        .scan_select_in  (sw_016_scan_out),
        .latch_enable_in (sw_016_latch_out),
        .clk_out         (sw_017_clk_out),
        .data_out        (sw_017_data_out),
        .scan_select_out (sw_017_scan_out),
        .latch_enable_out(sw_017_latch_out),
        .module_data_in  (sw_017_module_data_in),
        .module_data_out (sw_017_module_data_out)
    );

    user_module_346916357828248146 user_module_346916357828248146_17 (
        .io_in  (sw_017_module_data_in),
        .io_out (sw_017_module_data_out)
    );

    // [018] https://github.com/leardilap/tt02-LUTRAM
    wire sw_018_clk_out, sw_018_data_out, sw_018_scan_out, sw_018_latch_out;
    wire [7:0] sw_018_module_data_in;
    wire [7:0] sw_018_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_18 (
        .clk_in          (sw_017_clk_out),
        .data_in         (sw_017_data_out),
        .scan_select_in  (sw_017_scan_out),
        .latch_enable_in (sw_017_latch_out),
        .clk_out         (sw_018_clk_out),
        .data_out        (sw_018_data_out),
        .scan_select_out (sw_018_scan_out),
        .latch_enable_out(sw_018_latch_out),
        .module_data_in  (sw_018_module_data_in),
        .module_data_out (sw_018_module_data_out)
    );

    user_module_347594509754827347 user_module_347594509754827347_18 (
        .io_in  (sw_018_module_data_in),
        .io_out (sw_018_module_data_out)
    );

    // [019] https://github.com/ekliptik/tt02-chase-the-beat
    wire sw_019_clk_out, sw_019_data_out, sw_019_scan_out, sw_019_latch_out;
    wire [7:0] sw_019_module_data_in;
    wire [7:0] sw_019_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_19 (
        .clk_in          (sw_018_clk_out),
        .data_in         (sw_018_data_out),
        .scan_select_in  (sw_018_scan_out),
        .latch_enable_in (sw_018_latch_out),
        .clk_out         (sw_019_clk_out),
        .data_out        (sw_019_data_out),
        .scan_select_out (sw_019_scan_out),
        .latch_enable_out(sw_019_latch_out),
        .module_data_in  (sw_019_module_data_in),
        .module_data_out (sw_019_module_data_out)
    );

    chase_the_beat chase_the_beat_19 (
        .io_in  (sw_019_module_data_in),
        .io_out (sw_019_module_data_out)
    );

    // [020] https://github.com/maehw/tt02-bcd-7segment-encoder
    wire sw_020_clk_out, sw_020_data_out, sw_020_scan_out, sw_020_latch_out;
    wire [7:0] sw_020_module_data_in;
    wire [7:0] sw_020_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_20 (
        .clk_in          (sw_019_clk_out),
        .data_in         (sw_019_data_out),
        .scan_select_in  (sw_019_scan_out),
        .latch_enable_in (sw_019_latch_out),
        .clk_out         (sw_020_clk_out),
        .data_out        (sw_020_data_out),
        .scan_select_out (sw_020_scan_out),
        .latch_enable_out(sw_020_latch_out),
        .module_data_in  (sw_020_module_data_in),
        .module_data_out (sw_020_module_data_out)
    );

    user_module_347688030570545747 user_module_347688030570545747_20 (
        .io_in  (sw_020_module_data_in),
        .io_out (sw_020_module_data_out)
    );

    // [021] https://github.com/benevpi/tt02-LED-flasher
    wire sw_021_clk_out, sw_021_data_out, sw_021_scan_out, sw_021_latch_out;
    wire [7:0] sw_021_module_data_in;
    wire [7:0] sw_021_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_21 (
        .clk_in          (sw_020_clk_out),
        .data_in         (sw_020_data_out),
        .scan_select_in  (sw_020_scan_out),
        .latch_enable_in (sw_020_latch_out),
        .clk_out         (sw_021_clk_out),
        .data_out        (sw_021_data_out),
        .scan_select_out (sw_021_scan_out),
        .latch_enable_out(sw_021_latch_out),
        .module_data_in  (sw_021_module_data_in),
        .module_data_out (sw_021_module_data_out)
    );

    user_module_342981109408072274 user_module_342981109408072274_21 (
        .io_in  (sw_021_module_data_in),
        .io_out (sw_021_module_data_out)
    );

    // [022] https://github.com/kuriousd/tt02-4bit-multiplier
    wire sw_022_clk_out, sw_022_data_out, sw_022_scan_out, sw_022_latch_out;
    wire [7:0] sw_022_module_data_in;
    wire [7:0] sw_022_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_22 (
        .clk_in          (sw_021_clk_out),
        .data_in         (sw_021_data_out),
        .scan_select_in  (sw_021_scan_out),
        .latch_enable_in (sw_021_latch_out),
        .clk_out         (sw_022_clk_out),
        .data_out        (sw_022_data_out),
        .scan_select_out (sw_022_scan_out),
        .latch_enable_out(sw_022_latch_out),
        .module_data_in  (sw_022_module_data_in),
        .module_data_out (sw_022_module_data_out)
    );

    asic_multiplier_wrapper asic_multiplier_wrapper_22 (
        .io_in  (sw_022_module_data_in),
        .io_out (sw_022_module_data_out)
    );

    // [023] https://github.com/89Mods/tt2-avalonsemi-TBB1143
    wire sw_023_clk_out, sw_023_data_out, sw_023_scan_out, sw_023_latch_out;
    wire [7:0] sw_023_module_data_in;
    wire [7:0] sw_023_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_23 (
        .clk_in          (sw_022_clk_out),
        .data_in         (sw_022_data_out),
        .scan_select_in  (sw_022_scan_out),
        .latch_enable_in (sw_022_latch_out),
        .clk_out         (sw_023_clk_out),
        .data_out        (sw_023_data_out),
        .scan_select_out (sw_023_scan_out),
        .latch_enable_out(sw_023_latch_out),
        .module_data_in  (sw_023_module_data_in),
        .module_data_out (sw_023_module_data_out)
    );

    tholin_avalonsemi_tbb1143 tholin_avalonsemi_tbb1143_23 (
        .io_in  (sw_023_module_data_in),
        .io_out (sw_023_module_data_out)
    );

    // [024] https://github.com/TomKeddie/tinytapeout-2022-2a
    wire sw_024_clk_out, sw_024_data_out, sw_024_scan_out, sw_024_latch_out;
    wire [7:0] sw_024_module_data_in;
    wire [7:0] sw_024_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_24 (
        .clk_in          (sw_023_clk_out),
        .data_in         (sw_023_data_out),
        .scan_select_in  (sw_023_scan_out),
        .latch_enable_in (sw_023_latch_out),
        .clk_out         (sw_024_clk_out),
        .data_out        (sw_024_data_out),
        .scan_select_out (sw_024_scan_out),
        .latch_enable_out(sw_024_latch_out),
        .module_data_in  (sw_024_module_data_in),
        .module_data_out (sw_024_module_data_out)
    );

    tomkeddie_top_tto_a tomkeddie_top_tto_a_24 (
        .io_in  (sw_024_module_data_in),
        .io_out (sw_024_module_data_out)
    );

    // [025] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_025_clk_out, sw_025_data_out, sw_025_scan_out, sw_025_latch_out;
    wire [7:0] sw_025_module_data_in;
    wire [7:0] sw_025_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_25 (
        .clk_in          (sw_024_clk_out),
        .data_in         (sw_024_data_out),
        .scan_select_in  (sw_024_scan_out),
        .latch_enable_in (sw_024_latch_out),
        .clk_out         (sw_025_clk_out),
        .data_out        (sw_025_data_out),
        .scan_select_out (sw_025_scan_out),
        .latch_enable_out(sw_025_latch_out),
        .module_data_in  (sw_025_module_data_in),
        .module_data_out (sw_025_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_25 (
        .io_in  (sw_025_module_data_in),
        .io_out (sw_025_module_data_out)
    );

    // [026] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_026_clk_out, sw_026_data_out, sw_026_scan_out, sw_026_latch_out;
    wire [7:0] sw_026_module_data_in;
    wire [7:0] sw_026_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_26 (
        .clk_in          (sw_025_clk_out),
        .data_in         (sw_025_data_out),
        .scan_select_in  (sw_025_scan_out),
        .latch_enable_in (sw_025_latch_out),
        .clk_out         (sw_026_clk_out),
        .data_out        (sw_026_data_out),
        .scan_select_out (sw_026_scan_out),
        .latch_enable_out(sw_026_latch_out),
        .module_data_in  (sw_026_module_data_in),
        .module_data_out (sw_026_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_26 (
        .io_in  (sw_026_module_data_in),
        .io_out (sw_026_module_data_out)
    );

    // [027] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_027_clk_out, sw_027_data_out, sw_027_scan_out, sw_027_latch_out;
    wire [7:0] sw_027_module_data_in;
    wire [7:0] sw_027_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_27 (
        .clk_in          (sw_026_clk_out),
        .data_in         (sw_026_data_out),
        .scan_select_in  (sw_026_scan_out),
        .latch_enable_in (sw_026_latch_out),
        .clk_out         (sw_027_clk_out),
        .data_out        (sw_027_data_out),
        .scan_select_out (sw_027_scan_out),
        .latch_enable_out(sw_027_latch_out),
        .module_data_in  (sw_027_module_data_in),
        .module_data_out (sw_027_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_27 (
        .io_in  (sw_027_module_data_in),
        .io_out (sw_027_module_data_out)
    );

    // [028] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_028_clk_out, sw_028_data_out, sw_028_scan_out, sw_028_latch_out;
    wire [7:0] sw_028_module_data_in;
    wire [7:0] sw_028_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_28 (
        .clk_in          (sw_027_clk_out),
        .data_in         (sw_027_data_out),
        .scan_select_in  (sw_027_scan_out),
        .latch_enable_in (sw_027_latch_out),
        .clk_out         (sw_028_clk_out),
        .data_out        (sw_028_data_out),
        .scan_select_out (sw_028_scan_out),
        .latch_enable_out(sw_028_latch_out),
        .module_data_in  (sw_028_module_data_in),
        .module_data_out (sw_028_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_28 (
        .io_in  (sw_028_module_data_in),
        .io_out (sw_028_module_data_out)
    );

    // [029] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_029_clk_out, sw_029_data_out, sw_029_scan_out, sw_029_latch_out;
    wire [7:0] sw_029_module_data_in;
    wire [7:0] sw_029_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_29 (
        .clk_in          (sw_028_clk_out),
        .data_in         (sw_028_data_out),
        .scan_select_in  (sw_028_scan_out),
        .latch_enable_in (sw_028_latch_out),
        .clk_out         (sw_029_clk_out),
        .data_out        (sw_029_data_out),
        .scan_select_out (sw_029_scan_out),
        .latch_enable_out(sw_029_latch_out),
        .module_data_in  (sw_029_module_data_in),
        .module_data_out (sw_029_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_29 (
        .io_in  (sw_029_module_data_in),
        .io_out (sw_029_module_data_out)
    );

    // [030] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_030_clk_out, sw_030_data_out, sw_030_scan_out, sw_030_latch_out;
    wire [7:0] sw_030_module_data_in;
    wire [7:0] sw_030_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_30 (
        .clk_in          (sw_029_clk_out),
        .data_in         (sw_029_data_out),
        .scan_select_in  (sw_029_scan_out),
        .latch_enable_in (sw_029_latch_out),
        .clk_out         (sw_030_clk_out),
        .data_out        (sw_030_data_out),
        .scan_select_out (sw_030_scan_out),
        .latch_enable_out(sw_030_latch_out),
        .module_data_in  (sw_030_module_data_in),
        .module_data_out (sw_030_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_30 (
        .io_in  (sw_030_module_data_in),
        .io_out (sw_030_module_data_out)
    );

    // [031] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_031_clk_out, sw_031_data_out, sw_031_scan_out, sw_031_latch_out;
    wire [7:0] sw_031_module_data_in;
    wire [7:0] sw_031_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_31 (
        .clk_in          (sw_030_clk_out),
        .data_in         (sw_030_data_out),
        .scan_select_in  (sw_030_scan_out),
        .latch_enable_in (sw_030_latch_out),
        .clk_out         (sw_031_clk_out),
        .data_out        (sw_031_data_out),
        .scan_select_out (sw_031_scan_out),
        .latch_enable_out(sw_031_latch_out),
        .module_data_in  (sw_031_module_data_in),
        .module_data_out (sw_031_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_31 (
        .io_in  (sw_031_module_data_in),
        .io_out (sw_031_module_data_out)
    );

    // [032] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_032_clk_out, sw_032_data_out, sw_032_scan_out, sw_032_latch_out;
    wire [7:0] sw_032_module_data_in;
    wire [7:0] sw_032_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_32 (
        .clk_in          (sw_031_clk_out),
        .data_in         (sw_031_data_out),
        .scan_select_in  (sw_031_scan_out),
        .latch_enable_in (sw_031_latch_out),
        .clk_out         (sw_032_clk_out),
        .data_out        (sw_032_data_out),
        .scan_select_out (sw_032_scan_out),
        .latch_enable_out(sw_032_latch_out),
        .module_data_in  (sw_032_module_data_in),
        .module_data_out (sw_032_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_32 (
        .io_in  (sw_032_module_data_in),
        .io_out (sw_032_module_data_out)
    );

    // [033] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_033_clk_out, sw_033_data_out, sw_033_scan_out, sw_033_latch_out;
    wire [7:0] sw_033_module_data_in;
    wire [7:0] sw_033_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_33 (
        .clk_in          (sw_032_clk_out),
        .data_in         (sw_032_data_out),
        .scan_select_in  (sw_032_scan_out),
        .latch_enable_in (sw_032_latch_out),
        .clk_out         (sw_033_clk_out),
        .data_out        (sw_033_data_out),
        .scan_select_out (sw_033_scan_out),
        .latch_enable_out(sw_033_latch_out),
        .module_data_in  (sw_033_module_data_in),
        .module_data_out (sw_033_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_33 (
        .io_in  (sw_033_module_data_in),
        .io_out (sw_033_module_data_out)
    );

    // [034] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_034_clk_out, sw_034_data_out, sw_034_scan_out, sw_034_latch_out;
    wire [7:0] sw_034_module_data_in;
    wire [7:0] sw_034_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_34 (
        .clk_in          (sw_033_clk_out),
        .data_in         (sw_033_data_out),
        .scan_select_in  (sw_033_scan_out),
        .latch_enable_in (sw_033_latch_out),
        .clk_out         (sw_034_clk_out),
        .data_out        (sw_034_data_out),
        .scan_select_out (sw_034_scan_out),
        .latch_enable_out(sw_034_latch_out),
        .module_data_in  (sw_034_module_data_in),
        .module_data_out (sw_034_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_34 (
        .io_in  (sw_034_module_data_in),
        .io_out (sw_034_module_data_out)
    );

    // [035] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_035_clk_out, sw_035_data_out, sw_035_scan_out, sw_035_latch_out;
    wire [7:0] sw_035_module_data_in;
    wire [7:0] sw_035_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_35 (
        .clk_in          (sw_034_clk_out),
        .data_in         (sw_034_data_out),
        .scan_select_in  (sw_034_scan_out),
        .latch_enable_in (sw_034_latch_out),
        .clk_out         (sw_035_clk_out),
        .data_out        (sw_035_data_out),
        .scan_select_out (sw_035_scan_out),
        .latch_enable_out(sw_035_latch_out),
        .module_data_in  (sw_035_module_data_in),
        .module_data_out (sw_035_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_35 (
        .io_in  (sw_035_module_data_in),
        .io_out (sw_035_module_data_out)
    );

    // [036] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_036_clk_out, sw_036_data_out, sw_036_scan_out, sw_036_latch_out;
    wire [7:0] sw_036_module_data_in;
    wire [7:0] sw_036_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_36 (
        .clk_in          (sw_035_clk_out),
        .data_in         (sw_035_data_out),
        .scan_select_in  (sw_035_scan_out),
        .latch_enable_in (sw_035_latch_out),
        .clk_out         (sw_036_clk_out),
        .data_out        (sw_036_data_out),
        .scan_select_out (sw_036_scan_out),
        .latch_enable_out(sw_036_latch_out),
        .module_data_in  (sw_036_module_data_in),
        .module_data_out (sw_036_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_36 (
        .io_in  (sw_036_module_data_in),
        .io_out (sw_036_module_data_out)
    );

    // [037] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_037_clk_out, sw_037_data_out, sw_037_scan_out, sw_037_latch_out;
    wire [7:0] sw_037_module_data_in;
    wire [7:0] sw_037_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_37 (
        .clk_in          (sw_036_clk_out),
        .data_in         (sw_036_data_out),
        .scan_select_in  (sw_036_scan_out),
        .latch_enable_in (sw_036_latch_out),
        .clk_out         (sw_037_clk_out),
        .data_out        (sw_037_data_out),
        .scan_select_out (sw_037_scan_out),
        .latch_enable_out(sw_037_latch_out),
        .module_data_in  (sw_037_module_data_in),
        .module_data_out (sw_037_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_37 (
        .io_in  (sw_037_module_data_in),
        .io_out (sw_037_module_data_out)
    );

    // [038] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_038_clk_out, sw_038_data_out, sw_038_scan_out, sw_038_latch_out;
    wire [7:0] sw_038_module_data_in;
    wire [7:0] sw_038_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_38 (
        .clk_in          (sw_037_clk_out),
        .data_in         (sw_037_data_out),
        .scan_select_in  (sw_037_scan_out),
        .latch_enable_in (sw_037_latch_out),
        .clk_out         (sw_038_clk_out),
        .data_out        (sw_038_data_out),
        .scan_select_out (sw_038_scan_out),
        .latch_enable_out(sw_038_latch_out),
        .module_data_in  (sw_038_module_data_in),
        .module_data_out (sw_038_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_38 (
        .io_in  (sw_038_module_data_in),
        .io_out (sw_038_module_data_out)
    );

    // [039] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_039_clk_out, sw_039_data_out, sw_039_scan_out, sw_039_latch_out;
    wire [7:0] sw_039_module_data_in;
    wire [7:0] sw_039_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_39 (
        .clk_in          (sw_038_clk_out),
        .data_in         (sw_038_data_out),
        .scan_select_in  (sw_038_scan_out),
        .latch_enable_in (sw_038_latch_out),
        .clk_out         (sw_039_clk_out),
        .data_out        (sw_039_data_out),
        .scan_select_out (sw_039_scan_out),
        .latch_enable_out(sw_039_latch_out),
        .module_data_in  (sw_039_module_data_in),
        .module_data_out (sw_039_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_39 (
        .io_in  (sw_039_module_data_in),
        .io_out (sw_039_module_data_out)
    );

    // [040] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_040_clk_out, sw_040_data_out, sw_040_scan_out, sw_040_latch_out;
    wire [7:0] sw_040_module_data_in;
    wire [7:0] sw_040_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_40 (
        .clk_in          (sw_039_clk_out),
        .data_in         (sw_039_data_out),
        .scan_select_in  (sw_039_scan_out),
        .latch_enable_in (sw_039_latch_out),
        .clk_out         (sw_040_clk_out),
        .data_out        (sw_040_data_out),
        .scan_select_out (sw_040_scan_out),
        .latch_enable_out(sw_040_latch_out),
        .module_data_in  (sw_040_module_data_in),
        .module_data_out (sw_040_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_40 (
        .io_in  (sw_040_module_data_in),
        .io_out (sw_040_module_data_out)
    );

    // [041] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_041_clk_out, sw_041_data_out, sw_041_scan_out, sw_041_latch_out;
    wire [7:0] sw_041_module_data_in;
    wire [7:0] sw_041_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_41 (
        .clk_in          (sw_040_clk_out),
        .data_in         (sw_040_data_out),
        .scan_select_in  (sw_040_scan_out),
        .latch_enable_in (sw_040_latch_out),
        .clk_out         (sw_041_clk_out),
        .data_out        (sw_041_data_out),
        .scan_select_out (sw_041_scan_out),
        .latch_enable_out(sw_041_latch_out),
        .module_data_in  (sw_041_module_data_in),
        .module_data_out (sw_041_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_41 (
        .io_in  (sw_041_module_data_in),
        .io_out (sw_041_module_data_out)
    );

    // [042] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_042_clk_out, sw_042_data_out, sw_042_scan_out, sw_042_latch_out;
    wire [7:0] sw_042_module_data_in;
    wire [7:0] sw_042_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_42 (
        .clk_in          (sw_041_clk_out),
        .data_in         (sw_041_data_out),
        .scan_select_in  (sw_041_scan_out),
        .latch_enable_in (sw_041_latch_out),
        .clk_out         (sw_042_clk_out),
        .data_out        (sw_042_data_out),
        .scan_select_out (sw_042_scan_out),
        .latch_enable_out(sw_042_latch_out),
        .module_data_in  (sw_042_module_data_in),
        .module_data_out (sw_042_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_42 (
        .io_in  (sw_042_module_data_in),
        .io_out (sw_042_module_data_out)
    );

    // [043] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_043_clk_out, sw_043_data_out, sw_043_scan_out, sw_043_latch_out;
    wire [7:0] sw_043_module_data_in;
    wire [7:0] sw_043_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_43 (
        .clk_in          (sw_042_clk_out),
        .data_in         (sw_042_data_out),
        .scan_select_in  (sw_042_scan_out),
        .latch_enable_in (sw_042_latch_out),
        .clk_out         (sw_043_clk_out),
        .data_out        (sw_043_data_out),
        .scan_select_out (sw_043_scan_out),
        .latch_enable_out(sw_043_latch_out),
        .module_data_in  (sw_043_module_data_in),
        .module_data_out (sw_043_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_43 (
        .io_in  (sw_043_module_data_in),
        .io_out (sw_043_module_data_out)
    );

    // [044] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_044_clk_out, sw_044_data_out, sw_044_scan_out, sw_044_latch_out;
    wire [7:0] sw_044_module_data_in;
    wire [7:0] sw_044_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_44 (
        .clk_in          (sw_043_clk_out),
        .data_in         (sw_043_data_out),
        .scan_select_in  (sw_043_scan_out),
        .latch_enable_in (sw_043_latch_out),
        .clk_out         (sw_044_clk_out),
        .data_out        (sw_044_data_out),
        .scan_select_out (sw_044_scan_out),
        .latch_enable_out(sw_044_latch_out),
        .module_data_in  (sw_044_module_data_in),
        .module_data_out (sw_044_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_44 (
        .io_in  (sw_044_module_data_in),
        .io_out (sw_044_module_data_out)
    );

    // [045] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_045_clk_out, sw_045_data_out, sw_045_scan_out, sw_045_latch_out;
    wire [7:0] sw_045_module_data_in;
    wire [7:0] sw_045_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_45 (
        .clk_in          (sw_044_clk_out),
        .data_in         (sw_044_data_out),
        .scan_select_in  (sw_044_scan_out),
        .latch_enable_in (sw_044_latch_out),
        .clk_out         (sw_045_clk_out),
        .data_out        (sw_045_data_out),
        .scan_select_out (sw_045_scan_out),
        .latch_enable_out(sw_045_latch_out),
        .module_data_in  (sw_045_module_data_in),
        .module_data_out (sw_045_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_45 (
        .io_in  (sw_045_module_data_in),
        .io_out (sw_045_module_data_out)
    );

    // [046] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_046_clk_out, sw_046_data_out, sw_046_scan_out, sw_046_latch_out;
    wire [7:0] sw_046_module_data_in;
    wire [7:0] sw_046_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_46 (
        .clk_in          (sw_045_clk_out),
        .data_in         (sw_045_data_out),
        .scan_select_in  (sw_045_scan_out),
        .latch_enable_in (sw_045_latch_out),
        .clk_out         (sw_046_clk_out),
        .data_out        (sw_046_data_out),
        .scan_select_out (sw_046_scan_out),
        .latch_enable_out(sw_046_latch_out),
        .module_data_in  (sw_046_module_data_in),
        .module_data_out (sw_046_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_46 (
        .io_in  (sw_046_module_data_in),
        .io_out (sw_046_module_data_out)
    );

    // [047] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_047_clk_out, sw_047_data_out, sw_047_scan_out, sw_047_latch_out;
    wire [7:0] sw_047_module_data_in;
    wire [7:0] sw_047_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_47 (
        .clk_in          (sw_046_clk_out),
        .data_in         (sw_046_data_out),
        .scan_select_in  (sw_046_scan_out),
        .latch_enable_in (sw_046_latch_out),
        .clk_out         (sw_047_clk_out),
        .data_out        (sw_047_data_out),
        .scan_select_out (sw_047_scan_out),
        .latch_enable_out(sw_047_latch_out),
        .module_data_in  (sw_047_module_data_in),
        .module_data_out (sw_047_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_47 (
        .io_in  (sw_047_module_data_in),
        .io_out (sw_047_module_data_out)
    );

    // [048] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_048_clk_out, sw_048_data_out, sw_048_scan_out, sw_048_latch_out;
    wire [7:0] sw_048_module_data_in;
    wire [7:0] sw_048_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_48 (
        .clk_in          (sw_047_clk_out),
        .data_in         (sw_047_data_out),
        .scan_select_in  (sw_047_scan_out),
        .latch_enable_in (sw_047_latch_out),
        .clk_out         (sw_048_clk_out),
        .data_out        (sw_048_data_out),
        .scan_select_out (sw_048_scan_out),
        .latch_enable_out(sw_048_latch_out),
        .module_data_in  (sw_048_module_data_in),
        .module_data_out (sw_048_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_48 (
        .io_in  (sw_048_module_data_in),
        .io_out (sw_048_module_data_out)
    );

    // [049] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_049_clk_out, sw_049_data_out, sw_049_scan_out, sw_049_latch_out;
    wire [7:0] sw_049_module_data_in;
    wire [7:0] sw_049_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_49 (
        .clk_in          (sw_048_clk_out),
        .data_in         (sw_048_data_out),
        .scan_select_in  (sw_048_scan_out),
        .latch_enable_in (sw_048_latch_out),
        .clk_out         (sw_049_clk_out),
        .data_out        (sw_049_data_out),
        .scan_select_out (sw_049_scan_out),
        .latch_enable_out(sw_049_latch_out),
        .module_data_in  (sw_049_module_data_in),
        .module_data_out (sw_049_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_49 (
        .io_in  (sw_049_module_data_in),
        .io_out (sw_049_module_data_out)
    );

    // [050] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_050_clk_out, sw_050_data_out, sw_050_scan_out, sw_050_latch_out;
    wire [7:0] sw_050_module_data_in;
    wire [7:0] sw_050_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_50 (
        .clk_in          (sw_049_clk_out),
        .data_in         (sw_049_data_out),
        .scan_select_in  (sw_049_scan_out),
        .latch_enable_in (sw_049_latch_out),
        .clk_out         (sw_050_clk_out),
        .data_out        (sw_050_data_out),
        .scan_select_out (sw_050_scan_out),
        .latch_enable_out(sw_050_latch_out),
        .module_data_in  (sw_050_module_data_in),
        .module_data_out (sw_050_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_50 (
        .io_in  (sw_050_module_data_in),
        .io_out (sw_050_module_data_out)
    );

    // [051] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_051_clk_out, sw_051_data_out, sw_051_scan_out, sw_051_latch_out;
    wire [7:0] sw_051_module_data_in;
    wire [7:0] sw_051_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_51 (
        .clk_in          (sw_050_clk_out),
        .data_in         (sw_050_data_out),
        .scan_select_in  (sw_050_scan_out),
        .latch_enable_in (sw_050_latch_out),
        .clk_out         (sw_051_clk_out),
        .data_out        (sw_051_data_out),
        .scan_select_out (sw_051_scan_out),
        .latch_enable_out(sw_051_latch_out),
        .module_data_in  (sw_051_module_data_in),
        .module_data_out (sw_051_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_51 (
        .io_in  (sw_051_module_data_in),
        .io_out (sw_051_module_data_out)
    );

    // [052] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_052_clk_out, sw_052_data_out, sw_052_scan_out, sw_052_latch_out;
    wire [7:0] sw_052_module_data_in;
    wire [7:0] sw_052_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_52 (
        .clk_in          (sw_051_clk_out),
        .data_in         (sw_051_data_out),
        .scan_select_in  (sw_051_scan_out),
        .latch_enable_in (sw_051_latch_out),
        .clk_out         (sw_052_clk_out),
        .data_out        (sw_052_data_out),
        .scan_select_out (sw_052_scan_out),
        .latch_enable_out(sw_052_latch_out),
        .module_data_in  (sw_052_module_data_in),
        .module_data_out (sw_052_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_52 (
        .io_in  (sw_052_module_data_in),
        .io_out (sw_052_module_data_out)
    );

    // [053] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_053_clk_out, sw_053_data_out, sw_053_scan_out, sw_053_latch_out;
    wire [7:0] sw_053_module_data_in;
    wire [7:0] sw_053_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_53 (
        .clk_in          (sw_052_clk_out),
        .data_in         (sw_052_data_out),
        .scan_select_in  (sw_052_scan_out),
        .latch_enable_in (sw_052_latch_out),
        .clk_out         (sw_053_clk_out),
        .data_out        (sw_053_data_out),
        .scan_select_out (sw_053_scan_out),
        .latch_enable_out(sw_053_latch_out),
        .module_data_in  (sw_053_module_data_in),
        .module_data_out (sw_053_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_53 (
        .io_in  (sw_053_module_data_in),
        .io_out (sw_053_module_data_out)
    );

    // [054] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_054_clk_out, sw_054_data_out, sw_054_scan_out, sw_054_latch_out;
    wire [7:0] sw_054_module_data_in;
    wire [7:0] sw_054_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_54 (
        .clk_in          (sw_053_clk_out),
        .data_in         (sw_053_data_out),
        .scan_select_in  (sw_053_scan_out),
        .latch_enable_in (sw_053_latch_out),
        .clk_out         (sw_054_clk_out),
        .data_out        (sw_054_data_out),
        .scan_select_out (sw_054_scan_out),
        .latch_enable_out(sw_054_latch_out),
        .module_data_in  (sw_054_module_data_in),
        .module_data_out (sw_054_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_54 (
        .io_in  (sw_054_module_data_in),
        .io_out (sw_054_module_data_out)
    );

    // [055] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_055_clk_out, sw_055_data_out, sw_055_scan_out, sw_055_latch_out;
    wire [7:0] sw_055_module_data_in;
    wire [7:0] sw_055_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_55 (
        .clk_in          (sw_054_clk_out),
        .data_in         (sw_054_data_out),
        .scan_select_in  (sw_054_scan_out),
        .latch_enable_in (sw_054_latch_out),
        .clk_out         (sw_055_clk_out),
        .data_out        (sw_055_data_out),
        .scan_select_out (sw_055_scan_out),
        .latch_enable_out(sw_055_latch_out),
        .module_data_in  (sw_055_module_data_in),
        .module_data_out (sw_055_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_55 (
        .io_in  (sw_055_module_data_in),
        .io_out (sw_055_module_data_out)
    );

    // [056] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_056_clk_out, sw_056_data_out, sw_056_scan_out, sw_056_latch_out;
    wire [7:0] sw_056_module_data_in;
    wire [7:0] sw_056_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_56 (
        .clk_in          (sw_055_clk_out),
        .data_in         (sw_055_data_out),
        .scan_select_in  (sw_055_scan_out),
        .latch_enable_in (sw_055_latch_out),
        .clk_out         (sw_056_clk_out),
        .data_out        (sw_056_data_out),
        .scan_select_out (sw_056_scan_out),
        .latch_enable_out(sw_056_latch_out),
        .module_data_in  (sw_056_module_data_in),
        .module_data_out (sw_056_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_56 (
        .io_in  (sw_056_module_data_in),
        .io_out (sw_056_module_data_out)
    );

    // [057] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_057_clk_out, sw_057_data_out, sw_057_scan_out, sw_057_latch_out;
    wire [7:0] sw_057_module_data_in;
    wire [7:0] sw_057_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_57 (
        .clk_in          (sw_056_clk_out),
        .data_in         (sw_056_data_out),
        .scan_select_in  (sw_056_scan_out),
        .latch_enable_in (sw_056_latch_out),
        .clk_out         (sw_057_clk_out),
        .data_out        (sw_057_data_out),
        .scan_select_out (sw_057_scan_out),
        .latch_enable_out(sw_057_latch_out),
        .module_data_in  (sw_057_module_data_in),
        .module_data_out (sw_057_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_57 (
        .io_in  (sw_057_module_data_in),
        .io_out (sw_057_module_data_out)
    );

    // [058] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_058_clk_out, sw_058_data_out, sw_058_scan_out, sw_058_latch_out;
    wire [7:0] sw_058_module_data_in;
    wire [7:0] sw_058_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_58 (
        .clk_in          (sw_057_clk_out),
        .data_in         (sw_057_data_out),
        .scan_select_in  (sw_057_scan_out),
        .latch_enable_in (sw_057_latch_out),
        .clk_out         (sw_058_clk_out),
        .data_out        (sw_058_data_out),
        .scan_select_out (sw_058_scan_out),
        .latch_enable_out(sw_058_latch_out),
        .module_data_in  (sw_058_module_data_in),
        .module_data_out (sw_058_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_58 (
        .io_in  (sw_058_module_data_in),
        .io_out (sw_058_module_data_out)
    );

    // [059] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_059_clk_out, sw_059_data_out, sw_059_scan_out, sw_059_latch_out;
    wire [7:0] sw_059_module_data_in;
    wire [7:0] sw_059_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_59 (
        .clk_in          (sw_058_clk_out),
        .data_in         (sw_058_data_out),
        .scan_select_in  (sw_058_scan_out),
        .latch_enable_in (sw_058_latch_out),
        .clk_out         (sw_059_clk_out),
        .data_out        (sw_059_data_out),
        .scan_select_out (sw_059_scan_out),
        .latch_enable_out(sw_059_latch_out),
        .module_data_in  (sw_059_module_data_in),
        .module_data_out (sw_059_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_59 (
        .io_in  (sw_059_module_data_in),
        .io_out (sw_059_module_data_out)
    );

    // [060] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_060_clk_out, sw_060_data_out, sw_060_scan_out, sw_060_latch_out;
    wire [7:0] sw_060_module_data_in;
    wire [7:0] sw_060_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_60 (
        .clk_in          (sw_059_clk_out),
        .data_in         (sw_059_data_out),
        .scan_select_in  (sw_059_scan_out),
        .latch_enable_in (sw_059_latch_out),
        .clk_out         (sw_060_clk_out),
        .data_out        (sw_060_data_out),
        .scan_select_out (sw_060_scan_out),
        .latch_enable_out(sw_060_latch_out),
        .module_data_in  (sw_060_module_data_in),
        .module_data_out (sw_060_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_60 (
        .io_in  (sw_060_module_data_in),
        .io_out (sw_060_module_data_out)
    );

    // [061] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_061_clk_out, sw_061_data_out, sw_061_scan_out, sw_061_latch_out;
    wire [7:0] sw_061_module_data_in;
    wire [7:0] sw_061_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_61 (
        .clk_in          (sw_060_clk_out),
        .data_in         (sw_060_data_out),
        .scan_select_in  (sw_060_scan_out),
        .latch_enable_in (sw_060_latch_out),
        .clk_out         (sw_061_clk_out),
        .data_out        (sw_061_data_out),
        .scan_select_out (sw_061_scan_out),
        .latch_enable_out(sw_061_latch_out),
        .module_data_in  (sw_061_module_data_in),
        .module_data_out (sw_061_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_61 (
        .io_in  (sw_061_module_data_in),
        .io_out (sw_061_module_data_out)
    );

    // [062] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_062_clk_out, sw_062_data_out, sw_062_scan_out, sw_062_latch_out;
    wire [7:0] sw_062_module_data_in;
    wire [7:0] sw_062_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_62 (
        .clk_in          (sw_061_clk_out),
        .data_in         (sw_061_data_out),
        .scan_select_in  (sw_061_scan_out),
        .latch_enable_in (sw_061_latch_out),
        .clk_out         (sw_062_clk_out),
        .data_out        (sw_062_data_out),
        .scan_select_out (sw_062_scan_out),
        .latch_enable_out(sw_062_latch_out),
        .module_data_in  (sw_062_module_data_in),
        .module_data_out (sw_062_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_62 (
        .io_in  (sw_062_module_data_in),
        .io_out (sw_062_module_data_out)
    );

    // [063] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_063_clk_out, sw_063_data_out, sw_063_scan_out, sw_063_latch_out;
    wire [7:0] sw_063_module_data_in;
    wire [7:0] sw_063_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_63 (
        .clk_in          (sw_062_clk_out),
        .data_in         (sw_062_data_out),
        .scan_select_in  (sw_062_scan_out),
        .latch_enable_in (sw_062_latch_out),
        .clk_out         (sw_063_clk_out),
        .data_out        (sw_063_data_out),
        .scan_select_out (sw_063_scan_out),
        .latch_enable_out(sw_063_latch_out),
        .module_data_in  (sw_063_module_data_in),
        .module_data_out (sw_063_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_63 (
        .io_in  (sw_063_module_data_in),
        .io_out (sw_063_module_data_out)
    );

    // [064] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_064_clk_out, sw_064_data_out, sw_064_scan_out, sw_064_latch_out;
    wire [7:0] sw_064_module_data_in;
    wire [7:0] sw_064_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_64 (
        .clk_in          (sw_063_clk_out),
        .data_in         (sw_063_data_out),
        .scan_select_in  (sw_063_scan_out),
        .latch_enable_in (sw_063_latch_out),
        .clk_out         (sw_064_clk_out),
        .data_out        (sw_064_data_out),
        .scan_select_out (sw_064_scan_out),
        .latch_enable_out(sw_064_latch_out),
        .module_data_in  (sw_064_module_data_in),
        .module_data_out (sw_064_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_64 (
        .io_in  (sw_064_module_data_in),
        .io_out (sw_064_module_data_out)
    );

    // [065] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_065_clk_out, sw_065_data_out, sw_065_scan_out, sw_065_latch_out;
    wire [7:0] sw_065_module_data_in;
    wire [7:0] sw_065_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_65 (
        .clk_in          (sw_064_clk_out),
        .data_in         (sw_064_data_out),
        .scan_select_in  (sw_064_scan_out),
        .latch_enable_in (sw_064_latch_out),
        .clk_out         (sw_065_clk_out),
        .data_out        (sw_065_data_out),
        .scan_select_out (sw_065_scan_out),
        .latch_enable_out(sw_065_latch_out),
        .module_data_in  (sw_065_module_data_in),
        .module_data_out (sw_065_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_65 (
        .io_in  (sw_065_module_data_in),
        .io_out (sw_065_module_data_out)
    );

    // [066] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_066_clk_out, sw_066_data_out, sw_066_scan_out, sw_066_latch_out;
    wire [7:0] sw_066_module_data_in;
    wire [7:0] sw_066_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_66 (
        .clk_in          (sw_065_clk_out),
        .data_in         (sw_065_data_out),
        .scan_select_in  (sw_065_scan_out),
        .latch_enable_in (sw_065_latch_out),
        .clk_out         (sw_066_clk_out),
        .data_out        (sw_066_data_out),
        .scan_select_out (sw_066_scan_out),
        .latch_enable_out(sw_066_latch_out),
        .module_data_in  (sw_066_module_data_in),
        .module_data_out (sw_066_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_66 (
        .io_in  (sw_066_module_data_in),
        .io_out (sw_066_module_data_out)
    );

    // [067] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_067_clk_out, sw_067_data_out, sw_067_scan_out, sw_067_latch_out;
    wire [7:0] sw_067_module_data_in;
    wire [7:0] sw_067_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_67 (
        .clk_in          (sw_066_clk_out),
        .data_in         (sw_066_data_out),
        .scan_select_in  (sw_066_scan_out),
        .latch_enable_in (sw_066_latch_out),
        .clk_out         (sw_067_clk_out),
        .data_out        (sw_067_data_out),
        .scan_select_out (sw_067_scan_out),
        .latch_enable_out(sw_067_latch_out),
        .module_data_in  (sw_067_module_data_in),
        .module_data_out (sw_067_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_67 (
        .io_in  (sw_067_module_data_in),
        .io_out (sw_067_module_data_out)
    );

    // [068] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_068_clk_out, sw_068_data_out, sw_068_scan_out, sw_068_latch_out;
    wire [7:0] sw_068_module_data_in;
    wire [7:0] sw_068_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_68 (
        .clk_in          (sw_067_clk_out),
        .data_in         (sw_067_data_out),
        .scan_select_in  (sw_067_scan_out),
        .latch_enable_in (sw_067_latch_out),
        .clk_out         (sw_068_clk_out),
        .data_out        (sw_068_data_out),
        .scan_select_out (sw_068_scan_out),
        .latch_enable_out(sw_068_latch_out),
        .module_data_in  (sw_068_module_data_in),
        .module_data_out (sw_068_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_68 (
        .io_in  (sw_068_module_data_in),
        .io_out (sw_068_module_data_out)
    );

    // [069] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_069_clk_out, sw_069_data_out, sw_069_scan_out, sw_069_latch_out;
    wire [7:0] sw_069_module_data_in;
    wire [7:0] sw_069_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_69 (
        .clk_in          (sw_068_clk_out),
        .data_in         (sw_068_data_out),
        .scan_select_in  (sw_068_scan_out),
        .latch_enable_in (sw_068_latch_out),
        .clk_out         (sw_069_clk_out),
        .data_out        (sw_069_data_out),
        .scan_select_out (sw_069_scan_out),
        .latch_enable_out(sw_069_latch_out),
        .module_data_in  (sw_069_module_data_in),
        .module_data_out (sw_069_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_69 (
        .io_in  (sw_069_module_data_in),
        .io_out (sw_069_module_data_out)
    );

    // [070] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_070_clk_out, sw_070_data_out, sw_070_scan_out, sw_070_latch_out;
    wire [7:0] sw_070_module_data_in;
    wire [7:0] sw_070_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_70 (
        .clk_in          (sw_069_clk_out),
        .data_in         (sw_069_data_out),
        .scan_select_in  (sw_069_scan_out),
        .latch_enable_in (sw_069_latch_out),
        .clk_out         (sw_070_clk_out),
        .data_out        (sw_070_data_out),
        .scan_select_out (sw_070_scan_out),
        .latch_enable_out(sw_070_latch_out),
        .module_data_in  (sw_070_module_data_in),
        .module_data_out (sw_070_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_70 (
        .io_in  (sw_070_module_data_in),
        .io_out (sw_070_module_data_out)
    );

    // [071] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_071_clk_out, sw_071_data_out, sw_071_scan_out, sw_071_latch_out;
    wire [7:0] sw_071_module_data_in;
    wire [7:0] sw_071_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_71 (
        .clk_in          (sw_070_clk_out),
        .data_in         (sw_070_data_out),
        .scan_select_in  (sw_070_scan_out),
        .latch_enable_in (sw_070_latch_out),
        .clk_out         (sw_071_clk_out),
        .data_out        (sw_071_data_out),
        .scan_select_out (sw_071_scan_out),
        .latch_enable_out(sw_071_latch_out),
        .module_data_in  (sw_071_module_data_in),
        .module_data_out (sw_071_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_71 (
        .io_in  (sw_071_module_data_in),
        .io_out (sw_071_module_data_out)
    );

    // [072] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_072_clk_out, sw_072_data_out, sw_072_scan_out, sw_072_latch_out;
    wire [7:0] sw_072_module_data_in;
    wire [7:0] sw_072_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_72 (
        .clk_in          (sw_071_clk_out),
        .data_in         (sw_071_data_out),
        .scan_select_in  (sw_071_scan_out),
        .latch_enable_in (sw_071_latch_out),
        .clk_out         (sw_072_clk_out),
        .data_out        (sw_072_data_out),
        .scan_select_out (sw_072_scan_out),
        .latch_enable_out(sw_072_latch_out),
        .module_data_in  (sw_072_module_data_in),
        .module_data_out (sw_072_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_72 (
        .io_in  (sw_072_module_data_in),
        .io_out (sw_072_module_data_out)
    );

    // [073] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_073_clk_out, sw_073_data_out, sw_073_scan_out, sw_073_latch_out;
    wire [7:0] sw_073_module_data_in;
    wire [7:0] sw_073_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_73 (
        .clk_in          (sw_072_clk_out),
        .data_in         (sw_072_data_out),
        .scan_select_in  (sw_072_scan_out),
        .latch_enable_in (sw_072_latch_out),
        .clk_out         (sw_073_clk_out),
        .data_out        (sw_073_data_out),
        .scan_select_out (sw_073_scan_out),
        .latch_enable_out(sw_073_latch_out),
        .module_data_in  (sw_073_module_data_in),
        .module_data_out (sw_073_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_73 (
        .io_in  (sw_073_module_data_in),
        .io_out (sw_073_module_data_out)
    );

    // [074] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_074_clk_out, sw_074_data_out, sw_074_scan_out, sw_074_latch_out;
    wire [7:0] sw_074_module_data_in;
    wire [7:0] sw_074_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_74 (
        .clk_in          (sw_073_clk_out),
        .data_in         (sw_073_data_out),
        .scan_select_in  (sw_073_scan_out),
        .latch_enable_in (sw_073_latch_out),
        .clk_out         (sw_074_clk_out),
        .data_out        (sw_074_data_out),
        .scan_select_out (sw_074_scan_out),
        .latch_enable_out(sw_074_latch_out),
        .module_data_in  (sw_074_module_data_in),
        .module_data_out (sw_074_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_74 (
        .io_in  (sw_074_module_data_in),
        .io_out (sw_074_module_data_out)
    );

    // [075] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_075_clk_out, sw_075_data_out, sw_075_scan_out, sw_075_latch_out;
    wire [7:0] sw_075_module_data_in;
    wire [7:0] sw_075_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_75 (
        .clk_in          (sw_074_clk_out),
        .data_in         (sw_074_data_out),
        .scan_select_in  (sw_074_scan_out),
        .latch_enable_in (sw_074_latch_out),
        .clk_out         (sw_075_clk_out),
        .data_out        (sw_075_data_out),
        .scan_select_out (sw_075_scan_out),
        .latch_enable_out(sw_075_latch_out),
        .module_data_in  (sw_075_module_data_in),
        .module_data_out (sw_075_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_75 (
        .io_in  (sw_075_module_data_in),
        .io_out (sw_075_module_data_out)
    );

    // [076] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_076_clk_out, sw_076_data_out, sw_076_scan_out, sw_076_latch_out;
    wire [7:0] sw_076_module_data_in;
    wire [7:0] sw_076_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_76 (
        .clk_in          (sw_075_clk_out),
        .data_in         (sw_075_data_out),
        .scan_select_in  (sw_075_scan_out),
        .latch_enable_in (sw_075_latch_out),
        .clk_out         (sw_076_clk_out),
        .data_out        (sw_076_data_out),
        .scan_select_out (sw_076_scan_out),
        .latch_enable_out(sw_076_latch_out),
        .module_data_in  (sw_076_module_data_in),
        .module_data_out (sw_076_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_76 (
        .io_in  (sw_076_module_data_in),
        .io_out (sw_076_module_data_out)
    );

    // [077] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_077_clk_out, sw_077_data_out, sw_077_scan_out, sw_077_latch_out;
    wire [7:0] sw_077_module_data_in;
    wire [7:0] sw_077_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_77 (
        .clk_in          (sw_076_clk_out),
        .data_in         (sw_076_data_out),
        .scan_select_in  (sw_076_scan_out),
        .latch_enable_in (sw_076_latch_out),
        .clk_out         (sw_077_clk_out),
        .data_out        (sw_077_data_out),
        .scan_select_out (sw_077_scan_out),
        .latch_enable_out(sw_077_latch_out),
        .module_data_in  (sw_077_module_data_in),
        .module_data_out (sw_077_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_77 (
        .io_in  (sw_077_module_data_in),
        .io_out (sw_077_module_data_out)
    );

    // [078] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_078_clk_out, sw_078_data_out, sw_078_scan_out, sw_078_latch_out;
    wire [7:0] sw_078_module_data_in;
    wire [7:0] sw_078_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_78 (
        .clk_in          (sw_077_clk_out),
        .data_in         (sw_077_data_out),
        .scan_select_in  (sw_077_scan_out),
        .latch_enable_in (sw_077_latch_out),
        .clk_out         (sw_078_clk_out),
        .data_out        (sw_078_data_out),
        .scan_select_out (sw_078_scan_out),
        .latch_enable_out(sw_078_latch_out),
        .module_data_in  (sw_078_module_data_in),
        .module_data_out (sw_078_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_78 (
        .io_in  (sw_078_module_data_in),
        .io_out (sw_078_module_data_out)
    );

    // [079] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_079_clk_out, sw_079_data_out, sw_079_scan_out, sw_079_latch_out;
    wire [7:0] sw_079_module_data_in;
    wire [7:0] sw_079_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_79 (
        .clk_in          (sw_078_clk_out),
        .data_in         (sw_078_data_out),
        .scan_select_in  (sw_078_scan_out),
        .latch_enable_in (sw_078_latch_out),
        .clk_out         (sw_079_clk_out),
        .data_out        (sw_079_data_out),
        .scan_select_out (sw_079_scan_out),
        .latch_enable_out(sw_079_latch_out),
        .module_data_in  (sw_079_module_data_in),
        .module_data_out (sw_079_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_79 (
        .io_in  (sw_079_module_data_in),
        .io_out (sw_079_module_data_out)
    );

    // [080] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_080_clk_out, sw_080_data_out, sw_080_scan_out, sw_080_latch_out;
    wire [7:0] sw_080_module_data_in;
    wire [7:0] sw_080_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_80 (
        .clk_in          (sw_079_clk_out),
        .data_in         (sw_079_data_out),
        .scan_select_in  (sw_079_scan_out),
        .latch_enable_in (sw_079_latch_out),
        .clk_out         (sw_080_clk_out),
        .data_out        (sw_080_data_out),
        .scan_select_out (sw_080_scan_out),
        .latch_enable_out(sw_080_latch_out),
        .module_data_in  (sw_080_module_data_in),
        .module_data_out (sw_080_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_80 (
        .io_in  (sw_080_module_data_in),
        .io_out (sw_080_module_data_out)
    );

    // [081] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_081_clk_out, sw_081_data_out, sw_081_scan_out, sw_081_latch_out;
    wire [7:0] sw_081_module_data_in;
    wire [7:0] sw_081_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_81 (
        .clk_in          (sw_080_clk_out),
        .data_in         (sw_080_data_out),
        .scan_select_in  (sw_080_scan_out),
        .latch_enable_in (sw_080_latch_out),
        .clk_out         (sw_081_clk_out),
        .data_out        (sw_081_data_out),
        .scan_select_out (sw_081_scan_out),
        .latch_enable_out(sw_081_latch_out),
        .module_data_in  (sw_081_module_data_in),
        .module_data_out (sw_081_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_81 (
        .io_in  (sw_081_module_data_in),
        .io_out (sw_081_module_data_out)
    );

    // [082] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_082_clk_out, sw_082_data_out, sw_082_scan_out, sw_082_latch_out;
    wire [7:0] sw_082_module_data_in;
    wire [7:0] sw_082_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_82 (
        .clk_in          (sw_081_clk_out),
        .data_in         (sw_081_data_out),
        .scan_select_in  (sw_081_scan_out),
        .latch_enable_in (sw_081_latch_out),
        .clk_out         (sw_082_clk_out),
        .data_out        (sw_082_data_out),
        .scan_select_out (sw_082_scan_out),
        .latch_enable_out(sw_082_latch_out),
        .module_data_in  (sw_082_module_data_in),
        .module_data_out (sw_082_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_82 (
        .io_in  (sw_082_module_data_in),
        .io_out (sw_082_module_data_out)
    );

    // [083] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_083_clk_out, sw_083_data_out, sw_083_scan_out, sw_083_latch_out;
    wire [7:0] sw_083_module_data_in;
    wire [7:0] sw_083_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_83 (
        .clk_in          (sw_082_clk_out),
        .data_in         (sw_082_data_out),
        .scan_select_in  (sw_082_scan_out),
        .latch_enable_in (sw_082_latch_out),
        .clk_out         (sw_083_clk_out),
        .data_out        (sw_083_data_out),
        .scan_select_out (sw_083_scan_out),
        .latch_enable_out(sw_083_latch_out),
        .module_data_in  (sw_083_module_data_in),
        .module_data_out (sw_083_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_83 (
        .io_in  (sw_083_module_data_in),
        .io_out (sw_083_module_data_out)
    );

    // [084] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_084_clk_out, sw_084_data_out, sw_084_scan_out, sw_084_latch_out;
    wire [7:0] sw_084_module_data_in;
    wire [7:0] sw_084_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_84 (
        .clk_in          (sw_083_clk_out),
        .data_in         (sw_083_data_out),
        .scan_select_in  (sw_083_scan_out),
        .latch_enable_in (sw_083_latch_out),
        .clk_out         (sw_084_clk_out),
        .data_out        (sw_084_data_out),
        .scan_select_out (sw_084_scan_out),
        .latch_enable_out(sw_084_latch_out),
        .module_data_in  (sw_084_module_data_in),
        .module_data_out (sw_084_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_84 (
        .io_in  (sw_084_module_data_in),
        .io_out (sw_084_module_data_out)
    );

    // [085] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_085_clk_out, sw_085_data_out, sw_085_scan_out, sw_085_latch_out;
    wire [7:0] sw_085_module_data_in;
    wire [7:0] sw_085_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_85 (
        .clk_in          (sw_084_clk_out),
        .data_in         (sw_084_data_out),
        .scan_select_in  (sw_084_scan_out),
        .latch_enable_in (sw_084_latch_out),
        .clk_out         (sw_085_clk_out),
        .data_out        (sw_085_data_out),
        .scan_select_out (sw_085_scan_out),
        .latch_enable_out(sw_085_latch_out),
        .module_data_in  (sw_085_module_data_in),
        .module_data_out (sw_085_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_85 (
        .io_in  (sw_085_module_data_in),
        .io_out (sw_085_module_data_out)
    );

    // [086] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_086_clk_out, sw_086_data_out, sw_086_scan_out, sw_086_latch_out;
    wire [7:0] sw_086_module_data_in;
    wire [7:0] sw_086_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_86 (
        .clk_in          (sw_085_clk_out),
        .data_in         (sw_085_data_out),
        .scan_select_in  (sw_085_scan_out),
        .latch_enable_in (sw_085_latch_out),
        .clk_out         (sw_086_clk_out),
        .data_out        (sw_086_data_out),
        .scan_select_out (sw_086_scan_out),
        .latch_enable_out(sw_086_latch_out),
        .module_data_in  (sw_086_module_data_in),
        .module_data_out (sw_086_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_86 (
        .io_in  (sw_086_module_data_in),
        .io_out (sw_086_module_data_out)
    );

    // [087] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_087_clk_out, sw_087_data_out, sw_087_scan_out, sw_087_latch_out;
    wire [7:0] sw_087_module_data_in;
    wire [7:0] sw_087_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_87 (
        .clk_in          (sw_086_clk_out),
        .data_in         (sw_086_data_out),
        .scan_select_in  (sw_086_scan_out),
        .latch_enable_in (sw_086_latch_out),
        .clk_out         (sw_087_clk_out),
        .data_out        (sw_087_data_out),
        .scan_select_out (sw_087_scan_out),
        .latch_enable_out(sw_087_latch_out),
        .module_data_in  (sw_087_module_data_in),
        .module_data_out (sw_087_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_87 (
        .io_in  (sw_087_module_data_in),
        .io_out (sw_087_module_data_out)
    );

    // [088] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_088_clk_out, sw_088_data_out, sw_088_scan_out, sw_088_latch_out;
    wire [7:0] sw_088_module_data_in;
    wire [7:0] sw_088_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_88 (
        .clk_in          (sw_087_clk_out),
        .data_in         (sw_087_data_out),
        .scan_select_in  (sw_087_scan_out),
        .latch_enable_in (sw_087_latch_out),
        .clk_out         (sw_088_clk_out),
        .data_out        (sw_088_data_out),
        .scan_select_out (sw_088_scan_out),
        .latch_enable_out(sw_088_latch_out),
        .module_data_in  (sw_088_module_data_in),
        .module_data_out (sw_088_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_88 (
        .io_in  (sw_088_module_data_in),
        .io_out (sw_088_module_data_out)
    );

    // [089] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_089_clk_out, sw_089_data_out, sw_089_scan_out, sw_089_latch_out;
    wire [7:0] sw_089_module_data_in;
    wire [7:0] sw_089_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_89 (
        .clk_in          (sw_088_clk_out),
        .data_in         (sw_088_data_out),
        .scan_select_in  (sw_088_scan_out),
        .latch_enable_in (sw_088_latch_out),
        .clk_out         (sw_089_clk_out),
        .data_out        (sw_089_data_out),
        .scan_select_out (sw_089_scan_out),
        .latch_enable_out(sw_089_latch_out),
        .module_data_in  (sw_089_module_data_in),
        .module_data_out (sw_089_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_89 (
        .io_in  (sw_089_module_data_in),
        .io_out (sw_089_module_data_out)
    );

    // [090] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_090_clk_out, sw_090_data_out, sw_090_scan_out, sw_090_latch_out;
    wire [7:0] sw_090_module_data_in;
    wire [7:0] sw_090_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_90 (
        .clk_in          (sw_089_clk_out),
        .data_in         (sw_089_data_out),
        .scan_select_in  (sw_089_scan_out),
        .latch_enable_in (sw_089_latch_out),
        .clk_out         (sw_090_clk_out),
        .data_out        (sw_090_data_out),
        .scan_select_out (sw_090_scan_out),
        .latch_enable_out(sw_090_latch_out),
        .module_data_in  (sw_090_module_data_in),
        .module_data_out (sw_090_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_90 (
        .io_in  (sw_090_module_data_in),
        .io_out (sw_090_module_data_out)
    );

    // [091] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_091_clk_out, sw_091_data_out, sw_091_scan_out, sw_091_latch_out;
    wire [7:0] sw_091_module_data_in;
    wire [7:0] sw_091_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_91 (
        .clk_in          (sw_090_clk_out),
        .data_in         (sw_090_data_out),
        .scan_select_in  (sw_090_scan_out),
        .latch_enable_in (sw_090_latch_out),
        .clk_out         (sw_091_clk_out),
        .data_out        (sw_091_data_out),
        .scan_select_out (sw_091_scan_out),
        .latch_enable_out(sw_091_latch_out),
        .module_data_in  (sw_091_module_data_in),
        .module_data_out (sw_091_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_91 (
        .io_in  (sw_091_module_data_in),
        .io_out (sw_091_module_data_out)
    );

    // [092] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_092_clk_out, sw_092_data_out, sw_092_scan_out, sw_092_latch_out;
    wire [7:0] sw_092_module_data_in;
    wire [7:0] sw_092_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_92 (
        .clk_in          (sw_091_clk_out),
        .data_in         (sw_091_data_out),
        .scan_select_in  (sw_091_scan_out),
        .latch_enable_in (sw_091_latch_out),
        .clk_out         (sw_092_clk_out),
        .data_out        (sw_092_data_out),
        .scan_select_out (sw_092_scan_out),
        .latch_enable_out(sw_092_latch_out),
        .module_data_in  (sw_092_module_data_in),
        .module_data_out (sw_092_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_92 (
        .io_in  (sw_092_module_data_in),
        .io_out (sw_092_module_data_out)
    );

    // [093] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_093_clk_out, sw_093_data_out, sw_093_scan_out, sw_093_latch_out;
    wire [7:0] sw_093_module_data_in;
    wire [7:0] sw_093_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_93 (
        .clk_in          (sw_092_clk_out),
        .data_in         (sw_092_data_out),
        .scan_select_in  (sw_092_scan_out),
        .latch_enable_in (sw_092_latch_out),
        .clk_out         (sw_093_clk_out),
        .data_out        (sw_093_data_out),
        .scan_select_out (sw_093_scan_out),
        .latch_enable_out(sw_093_latch_out),
        .module_data_in  (sw_093_module_data_in),
        .module_data_out (sw_093_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_93 (
        .io_in  (sw_093_module_data_in),
        .io_out (sw_093_module_data_out)
    );

    // [094] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_094_clk_out, sw_094_data_out, sw_094_scan_out, sw_094_latch_out;
    wire [7:0] sw_094_module_data_in;
    wire [7:0] sw_094_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_94 (
        .clk_in          (sw_093_clk_out),
        .data_in         (sw_093_data_out),
        .scan_select_in  (sw_093_scan_out),
        .latch_enable_in (sw_093_latch_out),
        .clk_out         (sw_094_clk_out),
        .data_out        (sw_094_data_out),
        .scan_select_out (sw_094_scan_out),
        .latch_enable_out(sw_094_latch_out),
        .module_data_in  (sw_094_module_data_in),
        .module_data_out (sw_094_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_94 (
        .io_in  (sw_094_module_data_in),
        .io_out (sw_094_module_data_out)
    );

    // [095] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_095_clk_out, sw_095_data_out, sw_095_scan_out, sw_095_latch_out;
    wire [7:0] sw_095_module_data_in;
    wire [7:0] sw_095_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_95 (
        .clk_in          (sw_094_clk_out),
        .data_in         (sw_094_data_out),
        .scan_select_in  (sw_094_scan_out),
        .latch_enable_in (sw_094_latch_out),
        .clk_out         (sw_095_clk_out),
        .data_out        (sw_095_data_out),
        .scan_select_out (sw_095_scan_out),
        .latch_enable_out(sw_095_latch_out),
        .module_data_in  (sw_095_module_data_in),
        .module_data_out (sw_095_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_95 (
        .io_in  (sw_095_module_data_in),
        .io_out (sw_095_module_data_out)
    );

    // [096] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_096_clk_out, sw_096_data_out, sw_096_scan_out, sw_096_latch_out;
    wire [7:0] sw_096_module_data_in;
    wire [7:0] sw_096_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_96 (
        .clk_in          (sw_095_clk_out),
        .data_in         (sw_095_data_out),
        .scan_select_in  (sw_095_scan_out),
        .latch_enable_in (sw_095_latch_out),
        .clk_out         (sw_096_clk_out),
        .data_out        (sw_096_data_out),
        .scan_select_out (sw_096_scan_out),
        .latch_enable_out(sw_096_latch_out),
        .module_data_in  (sw_096_module_data_in),
        .module_data_out (sw_096_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_96 (
        .io_in  (sw_096_module_data_in),
        .io_out (sw_096_module_data_out)
    );

    // [097] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_097_clk_out, sw_097_data_out, sw_097_scan_out, sw_097_latch_out;
    wire [7:0] sw_097_module_data_in;
    wire [7:0] sw_097_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_97 (
        .clk_in          (sw_096_clk_out),
        .data_in         (sw_096_data_out),
        .scan_select_in  (sw_096_scan_out),
        .latch_enable_in (sw_096_latch_out),
        .clk_out         (sw_097_clk_out),
        .data_out        (sw_097_data_out),
        .scan_select_out (sw_097_scan_out),
        .latch_enable_out(sw_097_latch_out),
        .module_data_in  (sw_097_module_data_in),
        .module_data_out (sw_097_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_97 (
        .io_in  (sw_097_module_data_in),
        .io_out (sw_097_module_data_out)
    );

    // [098] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_098_clk_out, sw_098_data_out, sw_098_scan_out, sw_098_latch_out;
    wire [7:0] sw_098_module_data_in;
    wire [7:0] sw_098_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_98 (
        .clk_in          (sw_097_clk_out),
        .data_in         (sw_097_data_out),
        .scan_select_in  (sw_097_scan_out),
        .latch_enable_in (sw_097_latch_out),
        .clk_out         (sw_098_clk_out),
        .data_out        (sw_098_data_out),
        .scan_select_out (sw_098_scan_out),
        .latch_enable_out(sw_098_latch_out),
        .module_data_in  (sw_098_module_data_in),
        .module_data_out (sw_098_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_98 (
        .io_in  (sw_098_module_data_in),
        .io_out (sw_098_module_data_out)
    );

    // [099] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_099_clk_out, sw_099_data_out, sw_099_scan_out, sw_099_latch_out;
    wire [7:0] sw_099_module_data_in;
    wire [7:0] sw_099_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_99 (
        .clk_in          (sw_098_clk_out),
        .data_in         (sw_098_data_out),
        .scan_select_in  (sw_098_scan_out),
        .latch_enable_in (sw_098_latch_out),
        .clk_out         (sw_099_clk_out),
        .data_out        (sw_099_data_out),
        .scan_select_out (sw_099_scan_out),
        .latch_enable_out(sw_099_latch_out),
        .module_data_in  (sw_099_module_data_in),
        .module_data_out (sw_099_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_99 (
        .io_in  (sw_099_module_data_in),
        .io_out (sw_099_module_data_out)
    );

    // [100] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_100_clk_out, sw_100_data_out, sw_100_scan_out, sw_100_latch_out;
    wire [7:0] sw_100_module_data_in;
    wire [7:0] sw_100_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_100 (
        .clk_in          (sw_099_clk_out),
        .data_in         (sw_099_data_out),
        .scan_select_in  (sw_099_scan_out),
        .latch_enable_in (sw_099_latch_out),
        .clk_out         (sw_100_clk_out),
        .data_out        (sw_100_data_out),
        .scan_select_out (sw_100_scan_out),
        .latch_enable_out(sw_100_latch_out),
        .module_data_in  (sw_100_module_data_in),
        .module_data_out (sw_100_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_100 (
        .io_in  (sw_100_module_data_in),
        .io_out (sw_100_module_data_out)
    );

    // [101] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_101_clk_out, sw_101_data_out, sw_101_scan_out, sw_101_latch_out;
    wire [7:0] sw_101_module_data_in;
    wire [7:0] sw_101_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_101 (
        .clk_in          (sw_100_clk_out),
        .data_in         (sw_100_data_out),
        .scan_select_in  (sw_100_scan_out),
        .latch_enable_in (sw_100_latch_out),
        .clk_out         (sw_101_clk_out),
        .data_out        (sw_101_data_out),
        .scan_select_out (sw_101_scan_out),
        .latch_enable_out(sw_101_latch_out),
        .module_data_in  (sw_101_module_data_in),
        .module_data_out (sw_101_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_101 (
        .io_in  (sw_101_module_data_in),
        .io_out (sw_101_module_data_out)
    );

    // [102] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_102_clk_out, sw_102_data_out, sw_102_scan_out, sw_102_latch_out;
    wire [7:0] sw_102_module_data_in;
    wire [7:0] sw_102_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_102 (
        .clk_in          (sw_101_clk_out),
        .data_in         (sw_101_data_out),
        .scan_select_in  (sw_101_scan_out),
        .latch_enable_in (sw_101_latch_out),
        .clk_out         (sw_102_clk_out),
        .data_out        (sw_102_data_out),
        .scan_select_out (sw_102_scan_out),
        .latch_enable_out(sw_102_latch_out),
        .module_data_in  (sw_102_module_data_in),
        .module_data_out (sw_102_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_102 (
        .io_in  (sw_102_module_data_in),
        .io_out (sw_102_module_data_out)
    );

    // [103] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_103_clk_out, sw_103_data_out, sw_103_scan_out, sw_103_latch_out;
    wire [7:0] sw_103_module_data_in;
    wire [7:0] sw_103_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_103 (
        .clk_in          (sw_102_clk_out),
        .data_in         (sw_102_data_out),
        .scan_select_in  (sw_102_scan_out),
        .latch_enable_in (sw_102_latch_out),
        .clk_out         (sw_103_clk_out),
        .data_out        (sw_103_data_out),
        .scan_select_out (sw_103_scan_out),
        .latch_enable_out(sw_103_latch_out),
        .module_data_in  (sw_103_module_data_in),
        .module_data_out (sw_103_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_103 (
        .io_in  (sw_103_module_data_in),
        .io_out (sw_103_module_data_out)
    );

    // [104] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_104_clk_out, sw_104_data_out, sw_104_scan_out, sw_104_latch_out;
    wire [7:0] sw_104_module_data_in;
    wire [7:0] sw_104_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_104 (
        .clk_in          (sw_103_clk_out),
        .data_in         (sw_103_data_out),
        .scan_select_in  (sw_103_scan_out),
        .latch_enable_in (sw_103_latch_out),
        .clk_out         (sw_104_clk_out),
        .data_out        (sw_104_data_out),
        .scan_select_out (sw_104_scan_out),
        .latch_enable_out(sw_104_latch_out),
        .module_data_in  (sw_104_module_data_in),
        .module_data_out (sw_104_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_104 (
        .io_in  (sw_104_module_data_in),
        .io_out (sw_104_module_data_out)
    );

    // [105] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_105_clk_out, sw_105_data_out, sw_105_scan_out, sw_105_latch_out;
    wire [7:0] sw_105_module_data_in;
    wire [7:0] sw_105_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_105 (
        .clk_in          (sw_104_clk_out),
        .data_in         (sw_104_data_out),
        .scan_select_in  (sw_104_scan_out),
        .latch_enable_in (sw_104_latch_out),
        .clk_out         (sw_105_clk_out),
        .data_out        (sw_105_data_out),
        .scan_select_out (sw_105_scan_out),
        .latch_enable_out(sw_105_latch_out),
        .module_data_in  (sw_105_module_data_in),
        .module_data_out (sw_105_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_105 (
        .io_in  (sw_105_module_data_in),
        .io_out (sw_105_module_data_out)
    );

    // [106] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_106_clk_out, sw_106_data_out, sw_106_scan_out, sw_106_latch_out;
    wire [7:0] sw_106_module_data_in;
    wire [7:0] sw_106_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_106 (
        .clk_in          (sw_105_clk_out),
        .data_in         (sw_105_data_out),
        .scan_select_in  (sw_105_scan_out),
        .latch_enable_in (sw_105_latch_out),
        .clk_out         (sw_106_clk_out),
        .data_out        (sw_106_data_out),
        .scan_select_out (sw_106_scan_out),
        .latch_enable_out(sw_106_latch_out),
        .module_data_in  (sw_106_module_data_in),
        .module_data_out (sw_106_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_106 (
        .io_in  (sw_106_module_data_in),
        .io_out (sw_106_module_data_out)
    );

    // [107] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_107_clk_out, sw_107_data_out, sw_107_scan_out, sw_107_latch_out;
    wire [7:0] sw_107_module_data_in;
    wire [7:0] sw_107_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_107 (
        .clk_in          (sw_106_clk_out),
        .data_in         (sw_106_data_out),
        .scan_select_in  (sw_106_scan_out),
        .latch_enable_in (sw_106_latch_out),
        .clk_out         (sw_107_clk_out),
        .data_out        (sw_107_data_out),
        .scan_select_out (sw_107_scan_out),
        .latch_enable_out(sw_107_latch_out),
        .module_data_in  (sw_107_module_data_in),
        .module_data_out (sw_107_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_107 (
        .io_in  (sw_107_module_data_in),
        .io_out (sw_107_module_data_out)
    );

    // [108] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_108_clk_out, sw_108_data_out, sw_108_scan_out, sw_108_latch_out;
    wire [7:0] sw_108_module_data_in;
    wire [7:0] sw_108_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_108 (
        .clk_in          (sw_107_clk_out),
        .data_in         (sw_107_data_out),
        .scan_select_in  (sw_107_scan_out),
        .latch_enable_in (sw_107_latch_out),
        .clk_out         (sw_108_clk_out),
        .data_out        (sw_108_data_out),
        .scan_select_out (sw_108_scan_out),
        .latch_enable_out(sw_108_latch_out),
        .module_data_in  (sw_108_module_data_in),
        .module_data_out (sw_108_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_108 (
        .io_in  (sw_108_module_data_in),
        .io_out (sw_108_module_data_out)
    );

    // [109] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_109_clk_out, sw_109_data_out, sw_109_scan_out, sw_109_latch_out;
    wire [7:0] sw_109_module_data_in;
    wire [7:0] sw_109_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_109 (
        .clk_in          (sw_108_clk_out),
        .data_in         (sw_108_data_out),
        .scan_select_in  (sw_108_scan_out),
        .latch_enable_in (sw_108_latch_out),
        .clk_out         (sw_109_clk_out),
        .data_out        (sw_109_data_out),
        .scan_select_out (sw_109_scan_out),
        .latch_enable_out(sw_109_latch_out),
        .module_data_in  (sw_109_module_data_in),
        .module_data_out (sw_109_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_109 (
        .io_in  (sw_109_module_data_in),
        .io_out (sw_109_module_data_out)
    );

    // [110] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_110_clk_out, sw_110_data_out, sw_110_scan_out, sw_110_latch_out;
    wire [7:0] sw_110_module_data_in;
    wire [7:0] sw_110_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_110 (
        .clk_in          (sw_109_clk_out),
        .data_in         (sw_109_data_out),
        .scan_select_in  (sw_109_scan_out),
        .latch_enable_in (sw_109_latch_out),
        .clk_out         (sw_110_clk_out),
        .data_out        (sw_110_data_out),
        .scan_select_out (sw_110_scan_out),
        .latch_enable_out(sw_110_latch_out),
        .module_data_in  (sw_110_module_data_in),
        .module_data_out (sw_110_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_110 (
        .io_in  (sw_110_module_data_in),
        .io_out (sw_110_module_data_out)
    );

    // [111] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_111_clk_out, sw_111_data_out, sw_111_scan_out, sw_111_latch_out;
    wire [7:0] sw_111_module_data_in;
    wire [7:0] sw_111_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_111 (
        .clk_in          (sw_110_clk_out),
        .data_in         (sw_110_data_out),
        .scan_select_in  (sw_110_scan_out),
        .latch_enable_in (sw_110_latch_out),
        .clk_out         (sw_111_clk_out),
        .data_out        (sw_111_data_out),
        .scan_select_out (sw_111_scan_out),
        .latch_enable_out(sw_111_latch_out),
        .module_data_in  (sw_111_module_data_in),
        .module_data_out (sw_111_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_111 (
        .io_in  (sw_111_module_data_in),
        .io_out (sw_111_module_data_out)
    );

    // [112] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_112_clk_out, sw_112_data_out, sw_112_scan_out, sw_112_latch_out;
    wire [7:0] sw_112_module_data_in;
    wire [7:0] sw_112_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_112 (
        .clk_in          (sw_111_clk_out),
        .data_in         (sw_111_data_out),
        .scan_select_in  (sw_111_scan_out),
        .latch_enable_in (sw_111_latch_out),
        .clk_out         (sw_112_clk_out),
        .data_out        (sw_112_data_out),
        .scan_select_out (sw_112_scan_out),
        .latch_enable_out(sw_112_latch_out),
        .module_data_in  (sw_112_module_data_in),
        .module_data_out (sw_112_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_112 (
        .io_in  (sw_112_module_data_in),
        .io_out (sw_112_module_data_out)
    );

    // [113] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_113_clk_out, sw_113_data_out, sw_113_scan_out, sw_113_latch_out;
    wire [7:0] sw_113_module_data_in;
    wire [7:0] sw_113_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_113 (
        .clk_in          (sw_112_clk_out),
        .data_in         (sw_112_data_out),
        .scan_select_in  (sw_112_scan_out),
        .latch_enable_in (sw_112_latch_out),
        .clk_out         (sw_113_clk_out),
        .data_out        (sw_113_data_out),
        .scan_select_out (sw_113_scan_out),
        .latch_enable_out(sw_113_latch_out),
        .module_data_in  (sw_113_module_data_in),
        .module_data_out (sw_113_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_113 (
        .io_in  (sw_113_module_data_in),
        .io_out (sw_113_module_data_out)
    );

    // [114] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_114_clk_out, sw_114_data_out, sw_114_scan_out, sw_114_latch_out;
    wire [7:0] sw_114_module_data_in;
    wire [7:0] sw_114_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_114 (
        .clk_in          (sw_113_clk_out),
        .data_in         (sw_113_data_out),
        .scan_select_in  (sw_113_scan_out),
        .latch_enable_in (sw_113_latch_out),
        .clk_out         (sw_114_clk_out),
        .data_out        (sw_114_data_out),
        .scan_select_out (sw_114_scan_out),
        .latch_enable_out(sw_114_latch_out),
        .module_data_in  (sw_114_module_data_in),
        .module_data_out (sw_114_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_114 (
        .io_in  (sw_114_module_data_in),
        .io_out (sw_114_module_data_out)
    );

    // [115] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_115_clk_out, sw_115_data_out, sw_115_scan_out, sw_115_latch_out;
    wire [7:0] sw_115_module_data_in;
    wire [7:0] sw_115_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_115 (
        .clk_in          (sw_114_clk_out),
        .data_in         (sw_114_data_out),
        .scan_select_in  (sw_114_scan_out),
        .latch_enable_in (sw_114_latch_out),
        .clk_out         (sw_115_clk_out),
        .data_out        (sw_115_data_out),
        .scan_select_out (sw_115_scan_out),
        .latch_enable_out(sw_115_latch_out),
        .module_data_in  (sw_115_module_data_in),
        .module_data_out (sw_115_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_115 (
        .io_in  (sw_115_module_data_in),
        .io_out (sw_115_module_data_out)
    );

    // [116] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_116_clk_out, sw_116_data_out, sw_116_scan_out, sw_116_latch_out;
    wire [7:0] sw_116_module_data_in;
    wire [7:0] sw_116_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_116 (
        .clk_in          (sw_115_clk_out),
        .data_in         (sw_115_data_out),
        .scan_select_in  (sw_115_scan_out),
        .latch_enable_in (sw_115_latch_out),
        .clk_out         (sw_116_clk_out),
        .data_out        (sw_116_data_out),
        .scan_select_out (sw_116_scan_out),
        .latch_enable_out(sw_116_latch_out),
        .module_data_in  (sw_116_module_data_in),
        .module_data_out (sw_116_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_116 (
        .io_in  (sw_116_module_data_in),
        .io_out (sw_116_module_data_out)
    );

    // [117] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_117_clk_out, sw_117_data_out, sw_117_scan_out, sw_117_latch_out;
    wire [7:0] sw_117_module_data_in;
    wire [7:0] sw_117_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_117 (
        .clk_in          (sw_116_clk_out),
        .data_in         (sw_116_data_out),
        .scan_select_in  (sw_116_scan_out),
        .latch_enable_in (sw_116_latch_out),
        .clk_out         (sw_117_clk_out),
        .data_out        (sw_117_data_out),
        .scan_select_out (sw_117_scan_out),
        .latch_enable_out(sw_117_latch_out),
        .module_data_in  (sw_117_module_data_in),
        .module_data_out (sw_117_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_117 (
        .io_in  (sw_117_module_data_in),
        .io_out (sw_117_module_data_out)
    );

    // [118] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_118_clk_out, sw_118_data_out, sw_118_scan_out, sw_118_latch_out;
    wire [7:0] sw_118_module_data_in;
    wire [7:0] sw_118_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_118 (
        .clk_in          (sw_117_clk_out),
        .data_in         (sw_117_data_out),
        .scan_select_in  (sw_117_scan_out),
        .latch_enable_in (sw_117_latch_out),
        .clk_out         (sw_118_clk_out),
        .data_out        (sw_118_data_out),
        .scan_select_out (sw_118_scan_out),
        .latch_enable_out(sw_118_latch_out),
        .module_data_in  (sw_118_module_data_in),
        .module_data_out (sw_118_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_118 (
        .io_in  (sw_118_module_data_in),
        .io_out (sw_118_module_data_out)
    );

    // [119] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_119_clk_out, sw_119_data_out, sw_119_scan_out, sw_119_latch_out;
    wire [7:0] sw_119_module_data_in;
    wire [7:0] sw_119_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_119 (
        .clk_in          (sw_118_clk_out),
        .data_in         (sw_118_data_out),
        .scan_select_in  (sw_118_scan_out),
        .latch_enable_in (sw_118_latch_out),
        .clk_out         (sw_119_clk_out),
        .data_out        (sw_119_data_out),
        .scan_select_out (sw_119_scan_out),
        .latch_enable_out(sw_119_latch_out),
        .module_data_in  (sw_119_module_data_in),
        .module_data_out (sw_119_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_119 (
        .io_in  (sw_119_module_data_in),
        .io_out (sw_119_module_data_out)
    );

    // [120] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_120_clk_out, sw_120_data_out, sw_120_scan_out, sw_120_latch_out;
    wire [7:0] sw_120_module_data_in;
    wire [7:0] sw_120_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_120 (
        .clk_in          (sw_119_clk_out),
        .data_in         (sw_119_data_out),
        .scan_select_in  (sw_119_scan_out),
        .latch_enable_in (sw_119_latch_out),
        .clk_out         (sw_120_clk_out),
        .data_out        (sw_120_data_out),
        .scan_select_out (sw_120_scan_out),
        .latch_enable_out(sw_120_latch_out),
        .module_data_in  (sw_120_module_data_in),
        .module_data_out (sw_120_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_120 (
        .io_in  (sw_120_module_data_in),
        .io_out (sw_120_module_data_out)
    );

    // [121] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_121_clk_out, sw_121_data_out, sw_121_scan_out, sw_121_latch_out;
    wire [7:0] sw_121_module_data_in;
    wire [7:0] sw_121_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_121 (
        .clk_in          (sw_120_clk_out),
        .data_in         (sw_120_data_out),
        .scan_select_in  (sw_120_scan_out),
        .latch_enable_in (sw_120_latch_out),
        .clk_out         (sw_121_clk_out),
        .data_out        (sw_121_data_out),
        .scan_select_out (sw_121_scan_out),
        .latch_enable_out(sw_121_latch_out),
        .module_data_in  (sw_121_module_data_in),
        .module_data_out (sw_121_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_121 (
        .io_in  (sw_121_module_data_in),
        .io_out (sw_121_module_data_out)
    );

    // [122] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_122_clk_out, sw_122_data_out, sw_122_scan_out, sw_122_latch_out;
    wire [7:0] sw_122_module_data_in;
    wire [7:0] sw_122_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_122 (
        .clk_in          (sw_121_clk_out),
        .data_in         (sw_121_data_out),
        .scan_select_in  (sw_121_scan_out),
        .latch_enable_in (sw_121_latch_out),
        .clk_out         (sw_122_clk_out),
        .data_out        (sw_122_data_out),
        .scan_select_out (sw_122_scan_out),
        .latch_enable_out(sw_122_latch_out),
        .module_data_in  (sw_122_module_data_in),
        .module_data_out (sw_122_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_122 (
        .io_in  (sw_122_module_data_in),
        .io_out (sw_122_module_data_out)
    );

    // [123] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_123_clk_out, sw_123_data_out, sw_123_scan_out, sw_123_latch_out;
    wire [7:0] sw_123_module_data_in;
    wire [7:0] sw_123_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_123 (
        .clk_in          (sw_122_clk_out),
        .data_in         (sw_122_data_out),
        .scan_select_in  (sw_122_scan_out),
        .latch_enable_in (sw_122_latch_out),
        .clk_out         (sw_123_clk_out),
        .data_out        (sw_123_data_out),
        .scan_select_out (sw_123_scan_out),
        .latch_enable_out(sw_123_latch_out),
        .module_data_in  (sw_123_module_data_in),
        .module_data_out (sw_123_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_123 (
        .io_in  (sw_123_module_data_in),
        .io_out (sw_123_module_data_out)
    );

    // [124] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_124_clk_out, sw_124_data_out, sw_124_scan_out, sw_124_latch_out;
    wire [7:0] sw_124_module_data_in;
    wire [7:0] sw_124_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_124 (
        .clk_in          (sw_123_clk_out),
        .data_in         (sw_123_data_out),
        .scan_select_in  (sw_123_scan_out),
        .latch_enable_in (sw_123_latch_out),
        .clk_out         (sw_124_clk_out),
        .data_out        (sw_124_data_out),
        .scan_select_out (sw_124_scan_out),
        .latch_enable_out(sw_124_latch_out),
        .module_data_in  (sw_124_module_data_in),
        .module_data_out (sw_124_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_124 (
        .io_in  (sw_124_module_data_in),
        .io_out (sw_124_module_data_out)
    );

    // [125] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_125_clk_out, sw_125_data_out, sw_125_scan_out, sw_125_latch_out;
    wire [7:0] sw_125_module_data_in;
    wire [7:0] sw_125_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_125 (
        .clk_in          (sw_124_clk_out),
        .data_in         (sw_124_data_out),
        .scan_select_in  (sw_124_scan_out),
        .latch_enable_in (sw_124_latch_out),
        .clk_out         (sw_125_clk_out),
        .data_out        (sw_125_data_out),
        .scan_select_out (sw_125_scan_out),
        .latch_enable_out(sw_125_latch_out),
        .module_data_in  (sw_125_module_data_in),
        .module_data_out (sw_125_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_125 (
        .io_in  (sw_125_module_data_in),
        .io_out (sw_125_module_data_out)
    );

    // [126] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_126_clk_out, sw_126_data_out, sw_126_scan_out, sw_126_latch_out;
    wire [7:0] sw_126_module_data_in;
    wire [7:0] sw_126_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_126 (
        .clk_in          (sw_125_clk_out),
        .data_in         (sw_125_data_out),
        .scan_select_in  (sw_125_scan_out),
        .latch_enable_in (sw_125_latch_out),
        .clk_out         (sw_126_clk_out),
        .data_out        (sw_126_data_out),
        .scan_select_out (sw_126_scan_out),
        .latch_enable_out(sw_126_latch_out),
        .module_data_in  (sw_126_module_data_in),
        .module_data_out (sw_126_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_126 (
        .io_in  (sw_126_module_data_in),
        .io_out (sw_126_module_data_out)
    );

    // [127] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_127_clk_out, sw_127_data_out, sw_127_scan_out, sw_127_latch_out;
    wire [7:0] sw_127_module_data_in;
    wire [7:0] sw_127_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_127 (
        .clk_in          (sw_126_clk_out),
        .data_in         (sw_126_data_out),
        .scan_select_in  (sw_126_scan_out),
        .latch_enable_in (sw_126_latch_out),
        .clk_out         (sw_127_clk_out),
        .data_out        (sw_127_data_out),
        .scan_select_out (sw_127_scan_out),
        .latch_enable_out(sw_127_latch_out),
        .module_data_in  (sw_127_module_data_in),
        .module_data_out (sw_127_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_127 (
        .io_in  (sw_127_module_data_in),
        .io_out (sw_127_module_data_out)
    );

    // [128] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_128_clk_out, sw_128_data_out, sw_128_scan_out, sw_128_latch_out;
    wire [7:0] sw_128_module_data_in;
    wire [7:0] sw_128_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_128 (
        .clk_in          (sw_127_clk_out),
        .data_in         (sw_127_data_out),
        .scan_select_in  (sw_127_scan_out),
        .latch_enable_in (sw_127_latch_out),
        .clk_out         (sw_128_clk_out),
        .data_out        (sw_128_data_out),
        .scan_select_out (sw_128_scan_out),
        .latch_enable_out(sw_128_latch_out),
        .module_data_in  (sw_128_module_data_in),
        .module_data_out (sw_128_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_128 (
        .io_in  (sw_128_module_data_in),
        .io_out (sw_128_module_data_out)
    );

    // [129] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_129_clk_out, sw_129_data_out, sw_129_scan_out, sw_129_latch_out;
    wire [7:0] sw_129_module_data_in;
    wire [7:0] sw_129_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_129 (
        .clk_in          (sw_128_clk_out),
        .data_in         (sw_128_data_out),
        .scan_select_in  (sw_128_scan_out),
        .latch_enable_in (sw_128_latch_out),
        .clk_out         (sw_129_clk_out),
        .data_out        (sw_129_data_out),
        .scan_select_out (sw_129_scan_out),
        .latch_enable_out(sw_129_latch_out),
        .module_data_in  (sw_129_module_data_in),
        .module_data_out (sw_129_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_129 (
        .io_in  (sw_129_module_data_in),
        .io_out (sw_129_module_data_out)
    );

    // [130] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_130_clk_out, sw_130_data_out, sw_130_scan_out, sw_130_latch_out;
    wire [7:0] sw_130_module_data_in;
    wire [7:0] sw_130_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_130 (
        .clk_in          (sw_129_clk_out),
        .data_in         (sw_129_data_out),
        .scan_select_in  (sw_129_scan_out),
        .latch_enable_in (sw_129_latch_out),
        .clk_out         (sw_130_clk_out),
        .data_out        (sw_130_data_out),
        .scan_select_out (sw_130_scan_out),
        .latch_enable_out(sw_130_latch_out),
        .module_data_in  (sw_130_module_data_in),
        .module_data_out (sw_130_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_130 (
        .io_in  (sw_130_module_data_in),
        .io_out (sw_130_module_data_out)
    );

    // [131] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_131_clk_out, sw_131_data_out, sw_131_scan_out, sw_131_latch_out;
    wire [7:0] sw_131_module_data_in;
    wire [7:0] sw_131_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_131 (
        .clk_in          (sw_130_clk_out),
        .data_in         (sw_130_data_out),
        .scan_select_in  (sw_130_scan_out),
        .latch_enable_in (sw_130_latch_out),
        .clk_out         (sw_131_clk_out),
        .data_out        (sw_131_data_out),
        .scan_select_out (sw_131_scan_out),
        .latch_enable_out(sw_131_latch_out),
        .module_data_in  (sw_131_module_data_in),
        .module_data_out (sw_131_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_131 (
        .io_in  (sw_131_module_data_in),
        .io_out (sw_131_module_data_out)
    );

    // [132] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_132_clk_out, sw_132_data_out, sw_132_scan_out, sw_132_latch_out;
    wire [7:0] sw_132_module_data_in;
    wire [7:0] sw_132_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_132 (
        .clk_in          (sw_131_clk_out),
        .data_in         (sw_131_data_out),
        .scan_select_in  (sw_131_scan_out),
        .latch_enable_in (sw_131_latch_out),
        .clk_out         (sw_132_clk_out),
        .data_out        (sw_132_data_out),
        .scan_select_out (sw_132_scan_out),
        .latch_enable_out(sw_132_latch_out),
        .module_data_in  (sw_132_module_data_in),
        .module_data_out (sw_132_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_132 (
        .io_in  (sw_132_module_data_in),
        .io_out (sw_132_module_data_out)
    );

    // [133] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_133_clk_out, sw_133_data_out, sw_133_scan_out, sw_133_latch_out;
    wire [7:0] sw_133_module_data_in;
    wire [7:0] sw_133_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_133 (
        .clk_in          (sw_132_clk_out),
        .data_in         (sw_132_data_out),
        .scan_select_in  (sw_132_scan_out),
        .latch_enable_in (sw_132_latch_out),
        .clk_out         (sw_133_clk_out),
        .data_out        (sw_133_data_out),
        .scan_select_out (sw_133_scan_out),
        .latch_enable_out(sw_133_latch_out),
        .module_data_in  (sw_133_module_data_in),
        .module_data_out (sw_133_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_133 (
        .io_in  (sw_133_module_data_in),
        .io_out (sw_133_module_data_out)
    );

    // [134] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_134_clk_out, sw_134_data_out, sw_134_scan_out, sw_134_latch_out;
    wire [7:0] sw_134_module_data_in;
    wire [7:0] sw_134_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_134 (
        .clk_in          (sw_133_clk_out),
        .data_in         (sw_133_data_out),
        .scan_select_in  (sw_133_scan_out),
        .latch_enable_in (sw_133_latch_out),
        .clk_out         (sw_134_clk_out),
        .data_out        (sw_134_data_out),
        .scan_select_out (sw_134_scan_out),
        .latch_enable_out(sw_134_latch_out),
        .module_data_in  (sw_134_module_data_in),
        .module_data_out (sw_134_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_134 (
        .io_in  (sw_134_module_data_in),
        .io_out (sw_134_module_data_out)
    );

    // [135] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_135_clk_out, sw_135_data_out, sw_135_scan_out, sw_135_latch_out;
    wire [7:0] sw_135_module_data_in;
    wire [7:0] sw_135_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_135 (
        .clk_in          (sw_134_clk_out),
        .data_in         (sw_134_data_out),
        .scan_select_in  (sw_134_scan_out),
        .latch_enable_in (sw_134_latch_out),
        .clk_out         (sw_135_clk_out),
        .data_out        (sw_135_data_out),
        .scan_select_out (sw_135_scan_out),
        .latch_enable_out(sw_135_latch_out),
        .module_data_in  (sw_135_module_data_in),
        .module_data_out (sw_135_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_135 (
        .io_in  (sw_135_module_data_in),
        .io_out (sw_135_module_data_out)
    );

    // [136] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_136_clk_out, sw_136_data_out, sw_136_scan_out, sw_136_latch_out;
    wire [7:0] sw_136_module_data_in;
    wire [7:0] sw_136_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_136 (
        .clk_in          (sw_135_clk_out),
        .data_in         (sw_135_data_out),
        .scan_select_in  (sw_135_scan_out),
        .latch_enable_in (sw_135_latch_out),
        .clk_out         (sw_136_clk_out),
        .data_out        (sw_136_data_out),
        .scan_select_out (sw_136_scan_out),
        .latch_enable_out(sw_136_latch_out),
        .module_data_in  (sw_136_module_data_in),
        .module_data_out (sw_136_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_136 (
        .io_in  (sw_136_module_data_in),
        .io_out (sw_136_module_data_out)
    );

    // [137] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_137_clk_out, sw_137_data_out, sw_137_scan_out, sw_137_latch_out;
    wire [7:0] sw_137_module_data_in;
    wire [7:0] sw_137_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_137 (
        .clk_in          (sw_136_clk_out),
        .data_in         (sw_136_data_out),
        .scan_select_in  (sw_136_scan_out),
        .latch_enable_in (sw_136_latch_out),
        .clk_out         (sw_137_clk_out),
        .data_out        (sw_137_data_out),
        .scan_select_out (sw_137_scan_out),
        .latch_enable_out(sw_137_latch_out),
        .module_data_in  (sw_137_module_data_in),
        .module_data_out (sw_137_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_137 (
        .io_in  (sw_137_module_data_in),
        .io_out (sw_137_module_data_out)
    );

    // [138] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_138_clk_out, sw_138_data_out, sw_138_scan_out, sw_138_latch_out;
    wire [7:0] sw_138_module_data_in;
    wire [7:0] sw_138_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_138 (
        .clk_in          (sw_137_clk_out),
        .data_in         (sw_137_data_out),
        .scan_select_in  (sw_137_scan_out),
        .latch_enable_in (sw_137_latch_out),
        .clk_out         (sw_138_clk_out),
        .data_out        (sw_138_data_out),
        .scan_select_out (sw_138_scan_out),
        .latch_enable_out(sw_138_latch_out),
        .module_data_in  (sw_138_module_data_in),
        .module_data_out (sw_138_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_138 (
        .io_in  (sw_138_module_data_in),
        .io_out (sw_138_module_data_out)
    );

    // [139] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_139_clk_out, sw_139_data_out, sw_139_scan_out, sw_139_latch_out;
    wire [7:0] sw_139_module_data_in;
    wire [7:0] sw_139_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_139 (
        .clk_in          (sw_138_clk_out),
        .data_in         (sw_138_data_out),
        .scan_select_in  (sw_138_scan_out),
        .latch_enable_in (sw_138_latch_out),
        .clk_out         (sw_139_clk_out),
        .data_out        (sw_139_data_out),
        .scan_select_out (sw_139_scan_out),
        .latch_enable_out(sw_139_latch_out),
        .module_data_in  (sw_139_module_data_in),
        .module_data_out (sw_139_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_139 (
        .io_in  (sw_139_module_data_in),
        .io_out (sw_139_module_data_out)
    );

    // [140] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_140_clk_out, sw_140_data_out, sw_140_scan_out, sw_140_latch_out;
    wire [7:0] sw_140_module_data_in;
    wire [7:0] sw_140_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_140 (
        .clk_in          (sw_139_clk_out),
        .data_in         (sw_139_data_out),
        .scan_select_in  (sw_139_scan_out),
        .latch_enable_in (sw_139_latch_out),
        .clk_out         (sw_140_clk_out),
        .data_out        (sw_140_data_out),
        .scan_select_out (sw_140_scan_out),
        .latch_enable_out(sw_140_latch_out),
        .module_data_in  (sw_140_module_data_in),
        .module_data_out (sw_140_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_140 (
        .io_in  (sw_140_module_data_in),
        .io_out (sw_140_module_data_out)
    );

    // [141] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_141_clk_out, sw_141_data_out, sw_141_scan_out, sw_141_latch_out;
    wire [7:0] sw_141_module_data_in;
    wire [7:0] sw_141_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_141 (
        .clk_in          (sw_140_clk_out),
        .data_in         (sw_140_data_out),
        .scan_select_in  (sw_140_scan_out),
        .latch_enable_in (sw_140_latch_out),
        .clk_out         (sw_141_clk_out),
        .data_out        (sw_141_data_out),
        .scan_select_out (sw_141_scan_out),
        .latch_enable_out(sw_141_latch_out),
        .module_data_in  (sw_141_module_data_in),
        .module_data_out (sw_141_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_141 (
        .io_in  (sw_141_module_data_in),
        .io_out (sw_141_module_data_out)
    );

    // [142] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_142_clk_out, sw_142_data_out, sw_142_scan_out, sw_142_latch_out;
    wire [7:0] sw_142_module_data_in;
    wire [7:0] sw_142_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_142 (
        .clk_in          (sw_141_clk_out),
        .data_in         (sw_141_data_out),
        .scan_select_in  (sw_141_scan_out),
        .latch_enable_in (sw_141_latch_out),
        .clk_out         (sw_142_clk_out),
        .data_out        (sw_142_data_out),
        .scan_select_out (sw_142_scan_out),
        .latch_enable_out(sw_142_latch_out),
        .module_data_in  (sw_142_module_data_in),
        .module_data_out (sw_142_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_142 (
        .io_in  (sw_142_module_data_in),
        .io_out (sw_142_module_data_out)
    );

    // [143] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_143_clk_out, sw_143_data_out, sw_143_scan_out, sw_143_latch_out;
    wire [7:0] sw_143_module_data_in;
    wire [7:0] sw_143_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_143 (
        .clk_in          (sw_142_clk_out),
        .data_in         (sw_142_data_out),
        .scan_select_in  (sw_142_scan_out),
        .latch_enable_in (sw_142_latch_out),
        .clk_out         (sw_143_clk_out),
        .data_out        (sw_143_data_out),
        .scan_select_out (sw_143_scan_out),
        .latch_enable_out(sw_143_latch_out),
        .module_data_in  (sw_143_module_data_in),
        .module_data_out (sw_143_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_143 (
        .io_in  (sw_143_module_data_in),
        .io_out (sw_143_module_data_out)
    );

    // [144] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_144_clk_out, sw_144_data_out, sw_144_scan_out, sw_144_latch_out;
    wire [7:0] sw_144_module_data_in;
    wire [7:0] sw_144_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_144 (
        .clk_in          (sw_143_clk_out),
        .data_in         (sw_143_data_out),
        .scan_select_in  (sw_143_scan_out),
        .latch_enable_in (sw_143_latch_out),
        .clk_out         (sw_144_clk_out),
        .data_out        (sw_144_data_out),
        .scan_select_out (sw_144_scan_out),
        .latch_enable_out(sw_144_latch_out),
        .module_data_in  (sw_144_module_data_in),
        .module_data_out (sw_144_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_144 (
        .io_in  (sw_144_module_data_in),
        .io_out (sw_144_module_data_out)
    );

    // [145] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_145_clk_out, sw_145_data_out, sw_145_scan_out, sw_145_latch_out;
    wire [7:0] sw_145_module_data_in;
    wire [7:0] sw_145_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_145 (
        .clk_in          (sw_144_clk_out),
        .data_in         (sw_144_data_out),
        .scan_select_in  (sw_144_scan_out),
        .latch_enable_in (sw_144_latch_out),
        .clk_out         (sw_145_clk_out),
        .data_out        (sw_145_data_out),
        .scan_select_out (sw_145_scan_out),
        .latch_enable_out(sw_145_latch_out),
        .module_data_in  (sw_145_module_data_in),
        .module_data_out (sw_145_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_145 (
        .io_in  (sw_145_module_data_in),
        .io_out (sw_145_module_data_out)
    );

    // [146] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_146_clk_out, sw_146_data_out, sw_146_scan_out, sw_146_latch_out;
    wire [7:0] sw_146_module_data_in;
    wire [7:0] sw_146_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_146 (
        .clk_in          (sw_145_clk_out),
        .data_in         (sw_145_data_out),
        .scan_select_in  (sw_145_scan_out),
        .latch_enable_in (sw_145_latch_out),
        .clk_out         (sw_146_clk_out),
        .data_out        (sw_146_data_out),
        .scan_select_out (sw_146_scan_out),
        .latch_enable_out(sw_146_latch_out),
        .module_data_in  (sw_146_module_data_in),
        .module_data_out (sw_146_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_146 (
        .io_in  (sw_146_module_data_in),
        .io_out (sw_146_module_data_out)
    );

    // [147] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_147_clk_out, sw_147_data_out, sw_147_scan_out, sw_147_latch_out;
    wire [7:0] sw_147_module_data_in;
    wire [7:0] sw_147_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_147 (
        .clk_in          (sw_146_clk_out),
        .data_in         (sw_146_data_out),
        .scan_select_in  (sw_146_scan_out),
        .latch_enable_in (sw_146_latch_out),
        .clk_out         (sw_147_clk_out),
        .data_out        (sw_147_data_out),
        .scan_select_out (sw_147_scan_out),
        .latch_enable_out(sw_147_latch_out),
        .module_data_in  (sw_147_module_data_in),
        .module_data_out (sw_147_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_147 (
        .io_in  (sw_147_module_data_in),
        .io_out (sw_147_module_data_out)
    );

    // [148] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_148_clk_out, sw_148_data_out, sw_148_scan_out, sw_148_latch_out;
    wire [7:0] sw_148_module_data_in;
    wire [7:0] sw_148_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_148 (
        .clk_in          (sw_147_clk_out),
        .data_in         (sw_147_data_out),
        .scan_select_in  (sw_147_scan_out),
        .latch_enable_in (sw_147_latch_out),
        .clk_out         (sw_148_clk_out),
        .data_out        (sw_148_data_out),
        .scan_select_out (sw_148_scan_out),
        .latch_enable_out(sw_148_latch_out),
        .module_data_in  (sw_148_module_data_in),
        .module_data_out (sw_148_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_148 (
        .io_in  (sw_148_module_data_in),
        .io_out (sw_148_module_data_out)
    );

    // [149] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_149_clk_out, sw_149_data_out, sw_149_scan_out, sw_149_latch_out;
    wire [7:0] sw_149_module_data_in;
    wire [7:0] sw_149_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_149 (
        .clk_in          (sw_148_clk_out),
        .data_in         (sw_148_data_out),
        .scan_select_in  (sw_148_scan_out),
        .latch_enable_in (sw_148_latch_out),
        .clk_out         (sw_149_clk_out),
        .data_out        (sw_149_data_out),
        .scan_select_out (sw_149_scan_out),
        .latch_enable_out(sw_149_latch_out),
        .module_data_in  (sw_149_module_data_in),
        .module_data_out (sw_149_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_149 (
        .io_in  (sw_149_module_data_in),
        .io_out (sw_149_module_data_out)
    );

    // [150] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_150_clk_out, sw_150_data_out, sw_150_scan_out, sw_150_latch_out;
    wire [7:0] sw_150_module_data_in;
    wire [7:0] sw_150_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_150 (
        .clk_in          (sw_149_clk_out),
        .data_in         (sw_149_data_out),
        .scan_select_in  (sw_149_scan_out),
        .latch_enable_in (sw_149_latch_out),
        .clk_out         (sw_150_clk_out),
        .data_out        (sw_150_data_out),
        .scan_select_out (sw_150_scan_out),
        .latch_enable_out(sw_150_latch_out),
        .module_data_in  (sw_150_module_data_in),
        .module_data_out (sw_150_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_150 (
        .io_in  (sw_150_module_data_in),
        .io_out (sw_150_module_data_out)
    );

    // [151] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_151_clk_out, sw_151_data_out, sw_151_scan_out, sw_151_latch_out;
    wire [7:0] sw_151_module_data_in;
    wire [7:0] sw_151_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_151 (
        .clk_in          (sw_150_clk_out),
        .data_in         (sw_150_data_out),
        .scan_select_in  (sw_150_scan_out),
        .latch_enable_in (sw_150_latch_out),
        .clk_out         (sw_151_clk_out),
        .data_out        (sw_151_data_out),
        .scan_select_out (sw_151_scan_out),
        .latch_enable_out(sw_151_latch_out),
        .module_data_in  (sw_151_module_data_in),
        .module_data_out (sw_151_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_151 (
        .io_in  (sw_151_module_data_in),
        .io_out (sw_151_module_data_out)
    );

    // [152] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_152_clk_out, sw_152_data_out, sw_152_scan_out, sw_152_latch_out;
    wire [7:0] sw_152_module_data_in;
    wire [7:0] sw_152_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_152 (
        .clk_in          (sw_151_clk_out),
        .data_in         (sw_151_data_out),
        .scan_select_in  (sw_151_scan_out),
        .latch_enable_in (sw_151_latch_out),
        .clk_out         (sw_152_clk_out),
        .data_out        (sw_152_data_out),
        .scan_select_out (sw_152_scan_out),
        .latch_enable_out(sw_152_latch_out),
        .module_data_in  (sw_152_module_data_in),
        .module_data_out (sw_152_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_152 (
        .io_in  (sw_152_module_data_in),
        .io_out (sw_152_module_data_out)
    );

    // [153] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_153_clk_out, sw_153_data_out, sw_153_scan_out, sw_153_latch_out;
    wire [7:0] sw_153_module_data_in;
    wire [7:0] sw_153_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_153 (
        .clk_in          (sw_152_clk_out),
        .data_in         (sw_152_data_out),
        .scan_select_in  (sw_152_scan_out),
        .latch_enable_in (sw_152_latch_out),
        .clk_out         (sw_153_clk_out),
        .data_out        (sw_153_data_out),
        .scan_select_out (sw_153_scan_out),
        .latch_enable_out(sw_153_latch_out),
        .module_data_in  (sw_153_module_data_in),
        .module_data_out (sw_153_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_153 (
        .io_in  (sw_153_module_data_in),
        .io_out (sw_153_module_data_out)
    );

    // [154] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_154_clk_out, sw_154_data_out, sw_154_scan_out, sw_154_latch_out;
    wire [7:0] sw_154_module_data_in;
    wire [7:0] sw_154_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_154 (
        .clk_in          (sw_153_clk_out),
        .data_in         (sw_153_data_out),
        .scan_select_in  (sw_153_scan_out),
        .latch_enable_in (sw_153_latch_out),
        .clk_out         (sw_154_clk_out),
        .data_out        (sw_154_data_out),
        .scan_select_out (sw_154_scan_out),
        .latch_enable_out(sw_154_latch_out),
        .module_data_in  (sw_154_module_data_in),
        .module_data_out (sw_154_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_154 (
        .io_in  (sw_154_module_data_in),
        .io_out (sw_154_module_data_out)
    );

    // [155] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_155_clk_out, sw_155_data_out, sw_155_scan_out, sw_155_latch_out;
    wire [7:0] sw_155_module_data_in;
    wire [7:0] sw_155_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_155 (
        .clk_in          (sw_154_clk_out),
        .data_in         (sw_154_data_out),
        .scan_select_in  (sw_154_scan_out),
        .latch_enable_in (sw_154_latch_out),
        .clk_out         (sw_155_clk_out),
        .data_out        (sw_155_data_out),
        .scan_select_out (sw_155_scan_out),
        .latch_enable_out(sw_155_latch_out),
        .module_data_in  (sw_155_module_data_in),
        .module_data_out (sw_155_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_155 (
        .io_in  (sw_155_module_data_in),
        .io_out (sw_155_module_data_out)
    );

    // [156] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_156_clk_out, sw_156_data_out, sw_156_scan_out, sw_156_latch_out;
    wire [7:0] sw_156_module_data_in;
    wire [7:0] sw_156_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_156 (
        .clk_in          (sw_155_clk_out),
        .data_in         (sw_155_data_out),
        .scan_select_in  (sw_155_scan_out),
        .latch_enable_in (sw_155_latch_out),
        .clk_out         (sw_156_clk_out),
        .data_out        (sw_156_data_out),
        .scan_select_out (sw_156_scan_out),
        .latch_enable_out(sw_156_latch_out),
        .module_data_in  (sw_156_module_data_in),
        .module_data_out (sw_156_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_156 (
        .io_in  (sw_156_module_data_in),
        .io_out (sw_156_module_data_out)
    );

    // [157] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_157_clk_out, sw_157_data_out, sw_157_scan_out, sw_157_latch_out;
    wire [7:0] sw_157_module_data_in;
    wire [7:0] sw_157_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_157 (
        .clk_in          (sw_156_clk_out),
        .data_in         (sw_156_data_out),
        .scan_select_in  (sw_156_scan_out),
        .latch_enable_in (sw_156_latch_out),
        .clk_out         (sw_157_clk_out),
        .data_out        (sw_157_data_out),
        .scan_select_out (sw_157_scan_out),
        .latch_enable_out(sw_157_latch_out),
        .module_data_in  (sw_157_module_data_in),
        .module_data_out (sw_157_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_157 (
        .io_in  (sw_157_module_data_in),
        .io_out (sw_157_module_data_out)
    );

    // [158] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_158_clk_out, sw_158_data_out, sw_158_scan_out, sw_158_latch_out;
    wire [7:0] sw_158_module_data_in;
    wire [7:0] sw_158_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_158 (
        .clk_in          (sw_157_clk_out),
        .data_in         (sw_157_data_out),
        .scan_select_in  (sw_157_scan_out),
        .latch_enable_in (sw_157_latch_out),
        .clk_out         (sw_158_clk_out),
        .data_out        (sw_158_data_out),
        .scan_select_out (sw_158_scan_out),
        .latch_enable_out(sw_158_latch_out),
        .module_data_in  (sw_158_module_data_in),
        .module_data_out (sw_158_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_158 (
        .io_in  (sw_158_module_data_in),
        .io_out (sw_158_module_data_out)
    );

    // [159] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_159_clk_out, sw_159_data_out, sw_159_scan_out, sw_159_latch_out;
    wire [7:0] sw_159_module_data_in;
    wire [7:0] sw_159_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_159 (
        .clk_in          (sw_158_clk_out),
        .data_in         (sw_158_data_out),
        .scan_select_in  (sw_158_scan_out),
        .latch_enable_in (sw_158_latch_out),
        .clk_out         (sw_159_clk_out),
        .data_out        (sw_159_data_out),
        .scan_select_out (sw_159_scan_out),
        .latch_enable_out(sw_159_latch_out),
        .module_data_in  (sw_159_module_data_in),
        .module_data_out (sw_159_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_159 (
        .io_in  (sw_159_module_data_in),
        .io_out (sw_159_module_data_out)
    );

    // [160] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_160_clk_out, sw_160_data_out, sw_160_scan_out, sw_160_latch_out;
    wire [7:0] sw_160_module_data_in;
    wire [7:0] sw_160_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_160 (
        .clk_in          (sw_159_clk_out),
        .data_in         (sw_159_data_out),
        .scan_select_in  (sw_159_scan_out),
        .latch_enable_in (sw_159_latch_out),
        .clk_out         (sw_160_clk_out),
        .data_out        (sw_160_data_out),
        .scan_select_out (sw_160_scan_out),
        .latch_enable_out(sw_160_latch_out),
        .module_data_in  (sw_160_module_data_in),
        .module_data_out (sw_160_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_160 (
        .io_in  (sw_160_module_data_in),
        .io_out (sw_160_module_data_out)
    );

    // [161] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_161_clk_out, sw_161_data_out, sw_161_scan_out, sw_161_latch_out;
    wire [7:0] sw_161_module_data_in;
    wire [7:0] sw_161_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_161 (
        .clk_in          (sw_160_clk_out),
        .data_in         (sw_160_data_out),
        .scan_select_in  (sw_160_scan_out),
        .latch_enable_in (sw_160_latch_out),
        .clk_out         (sw_161_clk_out),
        .data_out        (sw_161_data_out),
        .scan_select_out (sw_161_scan_out),
        .latch_enable_out(sw_161_latch_out),
        .module_data_in  (sw_161_module_data_in),
        .module_data_out (sw_161_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_161 (
        .io_in  (sw_161_module_data_in),
        .io_out (sw_161_module_data_out)
    );

    // [162] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_162_clk_out, sw_162_data_out, sw_162_scan_out, sw_162_latch_out;
    wire [7:0] sw_162_module_data_in;
    wire [7:0] sw_162_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_162 (
        .clk_in          (sw_161_clk_out),
        .data_in         (sw_161_data_out),
        .scan_select_in  (sw_161_scan_out),
        .latch_enable_in (sw_161_latch_out),
        .clk_out         (sw_162_clk_out),
        .data_out        (sw_162_data_out),
        .scan_select_out (sw_162_scan_out),
        .latch_enable_out(sw_162_latch_out),
        .module_data_in  (sw_162_module_data_in),
        .module_data_out (sw_162_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_162 (
        .io_in  (sw_162_module_data_in),
        .io_out (sw_162_module_data_out)
    );

    // [163] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_163_clk_out, sw_163_data_out, sw_163_scan_out, sw_163_latch_out;
    wire [7:0] sw_163_module_data_in;
    wire [7:0] sw_163_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_163 (
        .clk_in          (sw_162_clk_out),
        .data_in         (sw_162_data_out),
        .scan_select_in  (sw_162_scan_out),
        .latch_enable_in (sw_162_latch_out),
        .clk_out         (sw_163_clk_out),
        .data_out        (sw_163_data_out),
        .scan_select_out (sw_163_scan_out),
        .latch_enable_out(sw_163_latch_out),
        .module_data_in  (sw_163_module_data_in),
        .module_data_out (sw_163_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_163 (
        .io_in  (sw_163_module_data_in),
        .io_out (sw_163_module_data_out)
    );

    // [164] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_164_clk_out, sw_164_data_out, sw_164_scan_out, sw_164_latch_out;
    wire [7:0] sw_164_module_data_in;
    wire [7:0] sw_164_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_164 (
        .clk_in          (sw_163_clk_out),
        .data_in         (sw_163_data_out),
        .scan_select_in  (sw_163_scan_out),
        .latch_enable_in (sw_163_latch_out),
        .clk_out         (sw_164_clk_out),
        .data_out        (sw_164_data_out),
        .scan_select_out (sw_164_scan_out),
        .latch_enable_out(sw_164_latch_out),
        .module_data_in  (sw_164_module_data_in),
        .module_data_out (sw_164_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_164 (
        .io_in  (sw_164_module_data_in),
        .io_out (sw_164_module_data_out)
    );

    // [165] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_165_clk_out, sw_165_data_out, sw_165_scan_out, sw_165_latch_out;
    wire [7:0] sw_165_module_data_in;
    wire [7:0] sw_165_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_165 (
        .clk_in          (sw_164_clk_out),
        .data_in         (sw_164_data_out),
        .scan_select_in  (sw_164_scan_out),
        .latch_enable_in (sw_164_latch_out),
        .clk_out         (sw_165_clk_out),
        .data_out        (sw_165_data_out),
        .scan_select_out (sw_165_scan_out),
        .latch_enable_out(sw_165_latch_out),
        .module_data_in  (sw_165_module_data_in),
        .module_data_out (sw_165_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_165 (
        .io_in  (sw_165_module_data_in),
        .io_out (sw_165_module_data_out)
    );

    // [166] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_166_clk_out, sw_166_data_out, sw_166_scan_out, sw_166_latch_out;
    wire [7:0] sw_166_module_data_in;
    wire [7:0] sw_166_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_166 (
        .clk_in          (sw_165_clk_out),
        .data_in         (sw_165_data_out),
        .scan_select_in  (sw_165_scan_out),
        .latch_enable_in (sw_165_latch_out),
        .clk_out         (sw_166_clk_out),
        .data_out        (sw_166_data_out),
        .scan_select_out (sw_166_scan_out),
        .latch_enable_out(sw_166_latch_out),
        .module_data_in  (sw_166_module_data_in),
        .module_data_out (sw_166_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_166 (
        .io_in  (sw_166_module_data_in),
        .io_out (sw_166_module_data_out)
    );

    // [167] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_167_clk_out, sw_167_data_out, sw_167_scan_out, sw_167_latch_out;
    wire [7:0] sw_167_module_data_in;
    wire [7:0] sw_167_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_167 (
        .clk_in          (sw_166_clk_out),
        .data_in         (sw_166_data_out),
        .scan_select_in  (sw_166_scan_out),
        .latch_enable_in (sw_166_latch_out),
        .clk_out         (sw_167_clk_out),
        .data_out        (sw_167_data_out),
        .scan_select_out (sw_167_scan_out),
        .latch_enable_out(sw_167_latch_out),
        .module_data_in  (sw_167_module_data_in),
        .module_data_out (sw_167_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_167 (
        .io_in  (sw_167_module_data_in),
        .io_out (sw_167_module_data_out)
    );

    // [168] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_168_clk_out, sw_168_data_out, sw_168_scan_out, sw_168_latch_out;
    wire [7:0] sw_168_module_data_in;
    wire [7:0] sw_168_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_168 (
        .clk_in          (sw_167_clk_out),
        .data_in         (sw_167_data_out),
        .scan_select_in  (sw_167_scan_out),
        .latch_enable_in (sw_167_latch_out),
        .clk_out         (sw_168_clk_out),
        .data_out        (sw_168_data_out),
        .scan_select_out (sw_168_scan_out),
        .latch_enable_out(sw_168_latch_out),
        .module_data_in  (sw_168_module_data_in),
        .module_data_out (sw_168_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_168 (
        .io_in  (sw_168_module_data_in),
        .io_out (sw_168_module_data_out)
    );

    // [169] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_169_clk_out, sw_169_data_out, sw_169_scan_out, sw_169_latch_out;
    wire [7:0] sw_169_module_data_in;
    wire [7:0] sw_169_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_169 (
        .clk_in          (sw_168_clk_out),
        .data_in         (sw_168_data_out),
        .scan_select_in  (sw_168_scan_out),
        .latch_enable_in (sw_168_latch_out),
        .clk_out         (sw_169_clk_out),
        .data_out        (sw_169_data_out),
        .scan_select_out (sw_169_scan_out),
        .latch_enable_out(sw_169_latch_out),
        .module_data_in  (sw_169_module_data_in),
        .module_data_out (sw_169_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_169 (
        .io_in  (sw_169_module_data_in),
        .io_out (sw_169_module_data_out)
    );

    // [170] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_170_clk_out, sw_170_data_out, sw_170_scan_out, sw_170_latch_out;
    wire [7:0] sw_170_module_data_in;
    wire [7:0] sw_170_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_170 (
        .clk_in          (sw_169_clk_out),
        .data_in         (sw_169_data_out),
        .scan_select_in  (sw_169_scan_out),
        .latch_enable_in (sw_169_latch_out),
        .clk_out         (sw_170_clk_out),
        .data_out        (sw_170_data_out),
        .scan_select_out (sw_170_scan_out),
        .latch_enable_out(sw_170_latch_out),
        .module_data_in  (sw_170_module_data_in),
        .module_data_out (sw_170_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_170 (
        .io_in  (sw_170_module_data_in),
        .io_out (sw_170_module_data_out)
    );

    // [171] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_171_clk_out, sw_171_data_out, sw_171_scan_out, sw_171_latch_out;
    wire [7:0] sw_171_module_data_in;
    wire [7:0] sw_171_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_171 (
        .clk_in          (sw_170_clk_out),
        .data_in         (sw_170_data_out),
        .scan_select_in  (sw_170_scan_out),
        .latch_enable_in (sw_170_latch_out),
        .clk_out         (sw_171_clk_out),
        .data_out        (sw_171_data_out),
        .scan_select_out (sw_171_scan_out),
        .latch_enable_out(sw_171_latch_out),
        .module_data_in  (sw_171_module_data_in),
        .module_data_out (sw_171_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_171 (
        .io_in  (sw_171_module_data_in),
        .io_out (sw_171_module_data_out)
    );

    // [172] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_172_clk_out, sw_172_data_out, sw_172_scan_out, sw_172_latch_out;
    wire [7:0] sw_172_module_data_in;
    wire [7:0] sw_172_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_172 (
        .clk_in          (sw_171_clk_out),
        .data_in         (sw_171_data_out),
        .scan_select_in  (sw_171_scan_out),
        .latch_enable_in (sw_171_latch_out),
        .clk_out         (sw_172_clk_out),
        .data_out        (sw_172_data_out),
        .scan_select_out (sw_172_scan_out),
        .latch_enable_out(sw_172_latch_out),
        .module_data_in  (sw_172_module_data_in),
        .module_data_out (sw_172_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_172 (
        .io_in  (sw_172_module_data_in),
        .io_out (sw_172_module_data_out)
    );

    // [173] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_173_clk_out, sw_173_data_out, sw_173_scan_out, sw_173_latch_out;
    wire [7:0] sw_173_module_data_in;
    wire [7:0] sw_173_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_173 (
        .clk_in          (sw_172_clk_out),
        .data_in         (sw_172_data_out),
        .scan_select_in  (sw_172_scan_out),
        .latch_enable_in (sw_172_latch_out),
        .clk_out         (sw_173_clk_out),
        .data_out        (sw_173_data_out),
        .scan_select_out (sw_173_scan_out),
        .latch_enable_out(sw_173_latch_out),
        .module_data_in  (sw_173_module_data_in),
        .module_data_out (sw_173_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_173 (
        .io_in  (sw_173_module_data_in),
        .io_out (sw_173_module_data_out)
    );

    // [174] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_174_clk_out, sw_174_data_out, sw_174_scan_out, sw_174_latch_out;
    wire [7:0] sw_174_module_data_in;
    wire [7:0] sw_174_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_174 (
        .clk_in          (sw_173_clk_out),
        .data_in         (sw_173_data_out),
        .scan_select_in  (sw_173_scan_out),
        .latch_enable_in (sw_173_latch_out),
        .clk_out         (sw_174_clk_out),
        .data_out        (sw_174_data_out),
        .scan_select_out (sw_174_scan_out),
        .latch_enable_out(sw_174_latch_out),
        .module_data_in  (sw_174_module_data_in),
        .module_data_out (sw_174_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_174 (
        .io_in  (sw_174_module_data_in),
        .io_out (sw_174_module_data_out)
    );

    // [175] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_175_clk_out, sw_175_data_out, sw_175_scan_out, sw_175_latch_out;
    wire [7:0] sw_175_module_data_in;
    wire [7:0] sw_175_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_175 (
        .clk_in          (sw_174_clk_out),
        .data_in         (sw_174_data_out),
        .scan_select_in  (sw_174_scan_out),
        .latch_enable_in (sw_174_latch_out),
        .clk_out         (sw_175_clk_out),
        .data_out        (sw_175_data_out),
        .scan_select_out (sw_175_scan_out),
        .latch_enable_out(sw_175_latch_out),
        .module_data_in  (sw_175_module_data_in),
        .module_data_out (sw_175_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_175 (
        .io_in  (sw_175_module_data_in),
        .io_out (sw_175_module_data_out)
    );

    // [176] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_176_clk_out, sw_176_data_out, sw_176_scan_out, sw_176_latch_out;
    wire [7:0] sw_176_module_data_in;
    wire [7:0] sw_176_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_176 (
        .clk_in          (sw_175_clk_out),
        .data_in         (sw_175_data_out),
        .scan_select_in  (sw_175_scan_out),
        .latch_enable_in (sw_175_latch_out),
        .clk_out         (sw_176_clk_out),
        .data_out        (sw_176_data_out),
        .scan_select_out (sw_176_scan_out),
        .latch_enable_out(sw_176_latch_out),
        .module_data_in  (sw_176_module_data_in),
        .module_data_out (sw_176_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_176 (
        .io_in  (sw_176_module_data_in),
        .io_out (sw_176_module_data_out)
    );

    // [177] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_177_clk_out, sw_177_data_out, sw_177_scan_out, sw_177_latch_out;
    wire [7:0] sw_177_module_data_in;
    wire [7:0] sw_177_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_177 (
        .clk_in          (sw_176_clk_out),
        .data_in         (sw_176_data_out),
        .scan_select_in  (sw_176_scan_out),
        .latch_enable_in (sw_176_latch_out),
        .clk_out         (sw_177_clk_out),
        .data_out        (sw_177_data_out),
        .scan_select_out (sw_177_scan_out),
        .latch_enable_out(sw_177_latch_out),
        .module_data_in  (sw_177_module_data_in),
        .module_data_out (sw_177_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_177 (
        .io_in  (sw_177_module_data_in),
        .io_out (sw_177_module_data_out)
    );

    // [178] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_178_clk_out, sw_178_data_out, sw_178_scan_out, sw_178_latch_out;
    wire [7:0] sw_178_module_data_in;
    wire [7:0] sw_178_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_178 (
        .clk_in          (sw_177_clk_out),
        .data_in         (sw_177_data_out),
        .scan_select_in  (sw_177_scan_out),
        .latch_enable_in (sw_177_latch_out),
        .clk_out         (sw_178_clk_out),
        .data_out        (sw_178_data_out),
        .scan_select_out (sw_178_scan_out),
        .latch_enable_out(sw_178_latch_out),
        .module_data_in  (sw_178_module_data_in),
        .module_data_out (sw_178_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_178 (
        .io_in  (sw_178_module_data_in),
        .io_out (sw_178_module_data_out)
    );

    // [179] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_179_clk_out, sw_179_data_out, sw_179_scan_out, sw_179_latch_out;
    wire [7:0] sw_179_module_data_in;
    wire [7:0] sw_179_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_179 (
        .clk_in          (sw_178_clk_out),
        .data_in         (sw_178_data_out),
        .scan_select_in  (sw_178_scan_out),
        .latch_enable_in (sw_178_latch_out),
        .clk_out         (sw_179_clk_out),
        .data_out        (sw_179_data_out),
        .scan_select_out (sw_179_scan_out),
        .latch_enable_out(sw_179_latch_out),
        .module_data_in  (sw_179_module_data_in),
        .module_data_out (sw_179_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_179 (
        .io_in  (sw_179_module_data_in),
        .io_out (sw_179_module_data_out)
    );

    // [180] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_180_clk_out, sw_180_data_out, sw_180_scan_out, sw_180_latch_out;
    wire [7:0] sw_180_module_data_in;
    wire [7:0] sw_180_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_180 (
        .clk_in          (sw_179_clk_out),
        .data_in         (sw_179_data_out),
        .scan_select_in  (sw_179_scan_out),
        .latch_enable_in (sw_179_latch_out),
        .clk_out         (sw_180_clk_out),
        .data_out        (sw_180_data_out),
        .scan_select_out (sw_180_scan_out),
        .latch_enable_out(sw_180_latch_out),
        .module_data_in  (sw_180_module_data_in),
        .module_data_out (sw_180_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_180 (
        .io_in  (sw_180_module_data_in),
        .io_out (sw_180_module_data_out)
    );

    // [181] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_181_clk_out, sw_181_data_out, sw_181_scan_out, sw_181_latch_out;
    wire [7:0] sw_181_module_data_in;
    wire [7:0] sw_181_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_181 (
        .clk_in          (sw_180_clk_out),
        .data_in         (sw_180_data_out),
        .scan_select_in  (sw_180_scan_out),
        .latch_enable_in (sw_180_latch_out),
        .clk_out         (sw_181_clk_out),
        .data_out        (sw_181_data_out),
        .scan_select_out (sw_181_scan_out),
        .latch_enable_out(sw_181_latch_out),
        .module_data_in  (sw_181_module_data_in),
        .module_data_out (sw_181_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_181 (
        .io_in  (sw_181_module_data_in),
        .io_out (sw_181_module_data_out)
    );

    // [182] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_182_clk_out, sw_182_data_out, sw_182_scan_out, sw_182_latch_out;
    wire [7:0] sw_182_module_data_in;
    wire [7:0] sw_182_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_182 (
        .clk_in          (sw_181_clk_out),
        .data_in         (sw_181_data_out),
        .scan_select_in  (sw_181_scan_out),
        .latch_enable_in (sw_181_latch_out),
        .clk_out         (sw_182_clk_out),
        .data_out        (sw_182_data_out),
        .scan_select_out (sw_182_scan_out),
        .latch_enable_out(sw_182_latch_out),
        .module_data_in  (sw_182_module_data_in),
        .module_data_out (sw_182_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_182 (
        .io_in  (sw_182_module_data_in),
        .io_out (sw_182_module_data_out)
    );

    // [183] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_183_clk_out, sw_183_data_out, sw_183_scan_out, sw_183_latch_out;
    wire [7:0] sw_183_module_data_in;
    wire [7:0] sw_183_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_183 (
        .clk_in          (sw_182_clk_out),
        .data_in         (sw_182_data_out),
        .scan_select_in  (sw_182_scan_out),
        .latch_enable_in (sw_182_latch_out),
        .clk_out         (sw_183_clk_out),
        .data_out        (sw_183_data_out),
        .scan_select_out (sw_183_scan_out),
        .latch_enable_out(sw_183_latch_out),
        .module_data_in  (sw_183_module_data_in),
        .module_data_out (sw_183_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_183 (
        .io_in  (sw_183_module_data_in),
        .io_out (sw_183_module_data_out)
    );

    // [184] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_184_clk_out, sw_184_data_out, sw_184_scan_out, sw_184_latch_out;
    wire [7:0] sw_184_module_data_in;
    wire [7:0] sw_184_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_184 (
        .clk_in          (sw_183_clk_out),
        .data_in         (sw_183_data_out),
        .scan_select_in  (sw_183_scan_out),
        .latch_enable_in (sw_183_latch_out),
        .clk_out         (sw_184_clk_out),
        .data_out        (sw_184_data_out),
        .scan_select_out (sw_184_scan_out),
        .latch_enable_out(sw_184_latch_out),
        .module_data_in  (sw_184_module_data_in),
        .module_data_out (sw_184_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_184 (
        .io_in  (sw_184_module_data_in),
        .io_out (sw_184_module_data_out)
    );

    // [185] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_185_clk_out, sw_185_data_out, sw_185_scan_out, sw_185_latch_out;
    wire [7:0] sw_185_module_data_in;
    wire [7:0] sw_185_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_185 (
        .clk_in          (sw_184_clk_out),
        .data_in         (sw_184_data_out),
        .scan_select_in  (sw_184_scan_out),
        .latch_enable_in (sw_184_latch_out),
        .clk_out         (sw_185_clk_out),
        .data_out        (sw_185_data_out),
        .scan_select_out (sw_185_scan_out),
        .latch_enable_out(sw_185_latch_out),
        .module_data_in  (sw_185_module_data_in),
        .module_data_out (sw_185_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_185 (
        .io_in  (sw_185_module_data_in),
        .io_out (sw_185_module_data_out)
    );

    // [186] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_186_clk_out, sw_186_data_out, sw_186_scan_out, sw_186_latch_out;
    wire [7:0] sw_186_module_data_in;
    wire [7:0] sw_186_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_186 (
        .clk_in          (sw_185_clk_out),
        .data_in         (sw_185_data_out),
        .scan_select_in  (sw_185_scan_out),
        .latch_enable_in (sw_185_latch_out),
        .clk_out         (sw_186_clk_out),
        .data_out        (sw_186_data_out),
        .scan_select_out (sw_186_scan_out),
        .latch_enable_out(sw_186_latch_out),
        .module_data_in  (sw_186_module_data_in),
        .module_data_out (sw_186_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_186 (
        .io_in  (sw_186_module_data_in),
        .io_out (sw_186_module_data_out)
    );

    // [187] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_187_clk_out, sw_187_data_out, sw_187_scan_out, sw_187_latch_out;
    wire [7:0] sw_187_module_data_in;
    wire [7:0] sw_187_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_187 (
        .clk_in          (sw_186_clk_out),
        .data_in         (sw_186_data_out),
        .scan_select_in  (sw_186_scan_out),
        .latch_enable_in (sw_186_latch_out),
        .clk_out         (sw_187_clk_out),
        .data_out        (sw_187_data_out),
        .scan_select_out (sw_187_scan_out),
        .latch_enable_out(sw_187_latch_out),
        .module_data_in  (sw_187_module_data_in),
        .module_data_out (sw_187_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_187 (
        .io_in  (sw_187_module_data_in),
        .io_out (sw_187_module_data_out)
    );

    // [188] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_188_clk_out, sw_188_data_out, sw_188_scan_out, sw_188_latch_out;
    wire [7:0] sw_188_module_data_in;
    wire [7:0] sw_188_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_188 (
        .clk_in          (sw_187_clk_out),
        .data_in         (sw_187_data_out),
        .scan_select_in  (sw_187_scan_out),
        .latch_enable_in (sw_187_latch_out),
        .clk_out         (sw_188_clk_out),
        .data_out        (sw_188_data_out),
        .scan_select_out (sw_188_scan_out),
        .latch_enable_out(sw_188_latch_out),
        .module_data_in  (sw_188_module_data_in),
        .module_data_out (sw_188_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_188 (
        .io_in  (sw_188_module_data_in),
        .io_out (sw_188_module_data_out)
    );

    // [189] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_189_clk_out, sw_189_data_out, sw_189_scan_out, sw_189_latch_out;
    wire [7:0] sw_189_module_data_in;
    wire [7:0] sw_189_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_189 (
        .clk_in          (sw_188_clk_out),
        .data_in         (sw_188_data_out),
        .scan_select_in  (sw_188_scan_out),
        .latch_enable_in (sw_188_latch_out),
        .clk_out         (sw_189_clk_out),
        .data_out        (sw_189_data_out),
        .scan_select_out (sw_189_scan_out),
        .latch_enable_out(sw_189_latch_out),
        .module_data_in  (sw_189_module_data_in),
        .module_data_out (sw_189_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_189 (
        .io_in  (sw_189_module_data_in),
        .io_out (sw_189_module_data_out)
    );

    // [190] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_190_clk_out, sw_190_data_out, sw_190_scan_out, sw_190_latch_out;
    wire [7:0] sw_190_module_data_in;
    wire [7:0] sw_190_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_190 (
        .clk_in          (sw_189_clk_out),
        .data_in         (sw_189_data_out),
        .scan_select_in  (sw_189_scan_out),
        .latch_enable_in (sw_189_latch_out),
        .clk_out         (sw_190_clk_out),
        .data_out        (sw_190_data_out),
        .scan_select_out (sw_190_scan_out),
        .latch_enable_out(sw_190_latch_out),
        .module_data_in  (sw_190_module_data_in),
        .module_data_out (sw_190_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_190 (
        .io_in  (sw_190_module_data_in),
        .io_out (sw_190_module_data_out)
    );

    // [191] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_191_clk_out, sw_191_data_out, sw_191_scan_out, sw_191_latch_out;
    wire [7:0] sw_191_module_data_in;
    wire [7:0] sw_191_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_191 (
        .clk_in          (sw_190_clk_out),
        .data_in         (sw_190_data_out),
        .scan_select_in  (sw_190_scan_out),
        .latch_enable_in (sw_190_latch_out),
        .clk_out         (sw_191_clk_out),
        .data_out        (sw_191_data_out),
        .scan_select_out (sw_191_scan_out),
        .latch_enable_out(sw_191_latch_out),
        .module_data_in  (sw_191_module_data_in),
        .module_data_out (sw_191_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_191 (
        .io_in  (sw_191_module_data_in),
        .io_out (sw_191_module_data_out)
    );

    // [192] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_192_clk_out, sw_192_data_out, sw_192_scan_out, sw_192_latch_out;
    wire [7:0] sw_192_module_data_in;
    wire [7:0] sw_192_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_192 (
        .clk_in          (sw_191_clk_out),
        .data_in         (sw_191_data_out),
        .scan_select_in  (sw_191_scan_out),
        .latch_enable_in (sw_191_latch_out),
        .clk_out         (sw_192_clk_out),
        .data_out        (sw_192_data_out),
        .scan_select_out (sw_192_scan_out),
        .latch_enable_out(sw_192_latch_out),
        .module_data_in  (sw_192_module_data_in),
        .module_data_out (sw_192_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_192 (
        .io_in  (sw_192_module_data_in),
        .io_out (sw_192_module_data_out)
    );

    // [193] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_193_clk_out, sw_193_data_out, sw_193_scan_out, sw_193_latch_out;
    wire [7:0] sw_193_module_data_in;
    wire [7:0] sw_193_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_193 (
        .clk_in          (sw_192_clk_out),
        .data_in         (sw_192_data_out),
        .scan_select_in  (sw_192_scan_out),
        .latch_enable_in (sw_192_latch_out),
        .clk_out         (sw_193_clk_out),
        .data_out        (sw_193_data_out),
        .scan_select_out (sw_193_scan_out),
        .latch_enable_out(sw_193_latch_out),
        .module_data_in  (sw_193_module_data_in),
        .module_data_out (sw_193_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_193 (
        .io_in  (sw_193_module_data_in),
        .io_out (sw_193_module_data_out)
    );

    // [194] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_194_clk_out, sw_194_data_out, sw_194_scan_out, sw_194_latch_out;
    wire [7:0] sw_194_module_data_in;
    wire [7:0] sw_194_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_194 (
        .clk_in          (sw_193_clk_out),
        .data_in         (sw_193_data_out),
        .scan_select_in  (sw_193_scan_out),
        .latch_enable_in (sw_193_latch_out),
        .clk_out         (sw_194_clk_out),
        .data_out        (sw_194_data_out),
        .scan_select_out (sw_194_scan_out),
        .latch_enable_out(sw_194_latch_out),
        .module_data_in  (sw_194_module_data_in),
        .module_data_out (sw_194_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_194 (
        .io_in  (sw_194_module_data_in),
        .io_out (sw_194_module_data_out)
    );

    // [195] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_195_clk_out, sw_195_data_out, sw_195_scan_out, sw_195_latch_out;
    wire [7:0] sw_195_module_data_in;
    wire [7:0] sw_195_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_195 (
        .clk_in          (sw_194_clk_out),
        .data_in         (sw_194_data_out),
        .scan_select_in  (sw_194_scan_out),
        .latch_enable_in (sw_194_latch_out),
        .clk_out         (sw_195_clk_out),
        .data_out        (sw_195_data_out),
        .scan_select_out (sw_195_scan_out),
        .latch_enable_out(sw_195_latch_out),
        .module_data_in  (sw_195_module_data_in),
        .module_data_out (sw_195_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_195 (
        .io_in  (sw_195_module_data_in),
        .io_out (sw_195_module_data_out)
    );

    // [196] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_196_clk_out, sw_196_data_out, sw_196_scan_out, sw_196_latch_out;
    wire [7:0] sw_196_module_data_in;
    wire [7:0] sw_196_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_196 (
        .clk_in          (sw_195_clk_out),
        .data_in         (sw_195_data_out),
        .scan_select_in  (sw_195_scan_out),
        .latch_enable_in (sw_195_latch_out),
        .clk_out         (sw_196_clk_out),
        .data_out        (sw_196_data_out),
        .scan_select_out (sw_196_scan_out),
        .latch_enable_out(sw_196_latch_out),
        .module_data_in  (sw_196_module_data_in),
        .module_data_out (sw_196_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_196 (
        .io_in  (sw_196_module_data_in),
        .io_out (sw_196_module_data_out)
    );

    // [197] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_197_clk_out, sw_197_data_out, sw_197_scan_out, sw_197_latch_out;
    wire [7:0] sw_197_module_data_in;
    wire [7:0] sw_197_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_197 (
        .clk_in          (sw_196_clk_out),
        .data_in         (sw_196_data_out),
        .scan_select_in  (sw_196_scan_out),
        .latch_enable_in (sw_196_latch_out),
        .clk_out         (sw_197_clk_out),
        .data_out        (sw_197_data_out),
        .scan_select_out (sw_197_scan_out),
        .latch_enable_out(sw_197_latch_out),
        .module_data_in  (sw_197_module_data_in),
        .module_data_out (sw_197_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_197 (
        .io_in  (sw_197_module_data_in),
        .io_out (sw_197_module_data_out)
    );

    // [198] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_198_clk_out, sw_198_data_out, sw_198_scan_out, sw_198_latch_out;
    wire [7:0] sw_198_module_data_in;
    wire [7:0] sw_198_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_198 (
        .clk_in          (sw_197_clk_out),
        .data_in         (sw_197_data_out),
        .scan_select_in  (sw_197_scan_out),
        .latch_enable_in (sw_197_latch_out),
        .clk_out         (sw_198_clk_out),
        .data_out        (sw_198_data_out),
        .scan_select_out (sw_198_scan_out),
        .latch_enable_out(sw_198_latch_out),
        .module_data_in  (sw_198_module_data_in),
        .module_data_out (sw_198_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_198 (
        .io_in  (sw_198_module_data_in),
        .io_out (sw_198_module_data_out)
    );

    // [199] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_199_clk_out, sw_199_data_out, sw_199_scan_out, sw_199_latch_out;
    wire [7:0] sw_199_module_data_in;
    wire [7:0] sw_199_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_199 (
        .clk_in          (sw_198_clk_out),
        .data_in         (sw_198_data_out),
        .scan_select_in  (sw_198_scan_out),
        .latch_enable_in (sw_198_latch_out),
        .clk_out         (sw_199_clk_out),
        .data_out        (sw_199_data_out),
        .scan_select_out (sw_199_scan_out),
        .latch_enable_out(sw_199_latch_out),
        .module_data_in  (sw_199_module_data_in),
        .module_data_out (sw_199_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_199 (
        .io_in  (sw_199_module_data_in),
        .io_out (sw_199_module_data_out)
    );

    // [200] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_200_clk_out, sw_200_data_out, sw_200_scan_out, sw_200_latch_out;
    wire [7:0] sw_200_module_data_in;
    wire [7:0] sw_200_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_200 (
        .clk_in          (sw_199_clk_out),
        .data_in         (sw_199_data_out),
        .scan_select_in  (sw_199_scan_out),
        .latch_enable_in (sw_199_latch_out),
        .clk_out         (sw_200_clk_out),
        .data_out        (sw_200_data_out),
        .scan_select_out (sw_200_scan_out),
        .latch_enable_out(sw_200_latch_out),
        .module_data_in  (sw_200_module_data_in),
        .module_data_out (sw_200_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_200 (
        .io_in  (sw_200_module_data_in),
        .io_out (sw_200_module_data_out)
    );

    // [201] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_201_clk_out, sw_201_data_out, sw_201_scan_out, sw_201_latch_out;
    wire [7:0] sw_201_module_data_in;
    wire [7:0] sw_201_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_201 (
        .clk_in          (sw_200_clk_out),
        .data_in         (sw_200_data_out),
        .scan_select_in  (sw_200_scan_out),
        .latch_enable_in (sw_200_latch_out),
        .clk_out         (sw_201_clk_out),
        .data_out        (sw_201_data_out),
        .scan_select_out (sw_201_scan_out),
        .latch_enable_out(sw_201_latch_out),
        .module_data_in  (sw_201_module_data_in),
        .module_data_out (sw_201_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_201 (
        .io_in  (sw_201_module_data_in),
        .io_out (sw_201_module_data_out)
    );

    // [202] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_202_clk_out, sw_202_data_out, sw_202_scan_out, sw_202_latch_out;
    wire [7:0] sw_202_module_data_in;
    wire [7:0] sw_202_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_202 (
        .clk_in          (sw_201_clk_out),
        .data_in         (sw_201_data_out),
        .scan_select_in  (sw_201_scan_out),
        .latch_enable_in (sw_201_latch_out),
        .clk_out         (sw_202_clk_out),
        .data_out        (sw_202_data_out),
        .scan_select_out (sw_202_scan_out),
        .latch_enable_out(sw_202_latch_out),
        .module_data_in  (sw_202_module_data_in),
        .module_data_out (sw_202_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_202 (
        .io_in  (sw_202_module_data_in),
        .io_out (sw_202_module_data_out)
    );

    // [203] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_203_clk_out, sw_203_data_out, sw_203_scan_out, sw_203_latch_out;
    wire [7:0] sw_203_module_data_in;
    wire [7:0] sw_203_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_203 (
        .clk_in          (sw_202_clk_out),
        .data_in         (sw_202_data_out),
        .scan_select_in  (sw_202_scan_out),
        .latch_enable_in (sw_202_latch_out),
        .clk_out         (sw_203_clk_out),
        .data_out        (sw_203_data_out),
        .scan_select_out (sw_203_scan_out),
        .latch_enable_out(sw_203_latch_out),
        .module_data_in  (sw_203_module_data_in),
        .module_data_out (sw_203_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_203 (
        .io_in  (sw_203_module_data_in),
        .io_out (sw_203_module_data_out)
    );

    // [204] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_204_clk_out, sw_204_data_out, sw_204_scan_out, sw_204_latch_out;
    wire [7:0] sw_204_module_data_in;
    wire [7:0] sw_204_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_204 (
        .clk_in          (sw_203_clk_out),
        .data_in         (sw_203_data_out),
        .scan_select_in  (sw_203_scan_out),
        .latch_enable_in (sw_203_latch_out),
        .clk_out         (sw_204_clk_out),
        .data_out        (sw_204_data_out),
        .scan_select_out (sw_204_scan_out),
        .latch_enable_out(sw_204_latch_out),
        .module_data_in  (sw_204_module_data_in),
        .module_data_out (sw_204_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_204 (
        .io_in  (sw_204_module_data_in),
        .io_out (sw_204_module_data_out)
    );

    // [205] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_205_clk_out, sw_205_data_out, sw_205_scan_out, sw_205_latch_out;
    wire [7:0] sw_205_module_data_in;
    wire [7:0] sw_205_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_205 (
        .clk_in          (sw_204_clk_out),
        .data_in         (sw_204_data_out),
        .scan_select_in  (sw_204_scan_out),
        .latch_enable_in (sw_204_latch_out),
        .clk_out         (sw_205_clk_out),
        .data_out        (sw_205_data_out),
        .scan_select_out (sw_205_scan_out),
        .latch_enable_out(sw_205_latch_out),
        .module_data_in  (sw_205_module_data_in),
        .module_data_out (sw_205_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_205 (
        .io_in  (sw_205_module_data_in),
        .io_out (sw_205_module_data_out)
    );

    // [206] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_206_clk_out, sw_206_data_out, sw_206_scan_out, sw_206_latch_out;
    wire [7:0] sw_206_module_data_in;
    wire [7:0] sw_206_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_206 (
        .clk_in          (sw_205_clk_out),
        .data_in         (sw_205_data_out),
        .scan_select_in  (sw_205_scan_out),
        .latch_enable_in (sw_205_latch_out),
        .clk_out         (sw_206_clk_out),
        .data_out        (sw_206_data_out),
        .scan_select_out (sw_206_scan_out),
        .latch_enable_out(sw_206_latch_out),
        .module_data_in  (sw_206_module_data_in),
        .module_data_out (sw_206_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_206 (
        .io_in  (sw_206_module_data_in),
        .io_out (sw_206_module_data_out)
    );

    // [207] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_207_clk_out, sw_207_data_out, sw_207_scan_out, sw_207_latch_out;
    wire [7:0] sw_207_module_data_in;
    wire [7:0] sw_207_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_207 (
        .clk_in          (sw_206_clk_out),
        .data_in         (sw_206_data_out),
        .scan_select_in  (sw_206_scan_out),
        .latch_enable_in (sw_206_latch_out),
        .clk_out         (sw_207_clk_out),
        .data_out        (sw_207_data_out),
        .scan_select_out (sw_207_scan_out),
        .latch_enable_out(sw_207_latch_out),
        .module_data_in  (sw_207_module_data_in),
        .module_data_out (sw_207_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_207 (
        .io_in  (sw_207_module_data_in),
        .io_out (sw_207_module_data_out)
    );

    // [208] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_208_clk_out, sw_208_data_out, sw_208_scan_out, sw_208_latch_out;
    wire [7:0] sw_208_module_data_in;
    wire [7:0] sw_208_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_208 (
        .clk_in          (sw_207_clk_out),
        .data_in         (sw_207_data_out),
        .scan_select_in  (sw_207_scan_out),
        .latch_enable_in (sw_207_latch_out),
        .clk_out         (sw_208_clk_out),
        .data_out        (sw_208_data_out),
        .scan_select_out (sw_208_scan_out),
        .latch_enable_out(sw_208_latch_out),
        .module_data_in  (sw_208_module_data_in),
        .module_data_out (sw_208_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_208 (
        .io_in  (sw_208_module_data_in),
        .io_out (sw_208_module_data_out)
    );

    // [209] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_209_clk_out, sw_209_data_out, sw_209_scan_out, sw_209_latch_out;
    wire [7:0] sw_209_module_data_in;
    wire [7:0] sw_209_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_209 (
        .clk_in          (sw_208_clk_out),
        .data_in         (sw_208_data_out),
        .scan_select_in  (sw_208_scan_out),
        .latch_enable_in (sw_208_latch_out),
        .clk_out         (sw_209_clk_out),
        .data_out        (sw_209_data_out),
        .scan_select_out (sw_209_scan_out),
        .latch_enable_out(sw_209_latch_out),
        .module_data_in  (sw_209_module_data_in),
        .module_data_out (sw_209_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_209 (
        .io_in  (sw_209_module_data_in),
        .io_out (sw_209_module_data_out)
    );

    // [210] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_210_clk_out, sw_210_data_out, sw_210_scan_out, sw_210_latch_out;
    wire [7:0] sw_210_module_data_in;
    wire [7:0] sw_210_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_210 (
        .clk_in          (sw_209_clk_out),
        .data_in         (sw_209_data_out),
        .scan_select_in  (sw_209_scan_out),
        .latch_enable_in (sw_209_latch_out),
        .clk_out         (sw_210_clk_out),
        .data_out        (sw_210_data_out),
        .scan_select_out (sw_210_scan_out),
        .latch_enable_out(sw_210_latch_out),
        .module_data_in  (sw_210_module_data_in),
        .module_data_out (sw_210_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_210 (
        .io_in  (sw_210_module_data_in),
        .io_out (sw_210_module_data_out)
    );

    // [211] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_211_clk_out, sw_211_data_out, sw_211_scan_out, sw_211_latch_out;
    wire [7:0] sw_211_module_data_in;
    wire [7:0] sw_211_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_211 (
        .clk_in          (sw_210_clk_out),
        .data_in         (sw_210_data_out),
        .scan_select_in  (sw_210_scan_out),
        .latch_enable_in (sw_210_latch_out),
        .clk_out         (sw_211_clk_out),
        .data_out        (sw_211_data_out),
        .scan_select_out (sw_211_scan_out),
        .latch_enable_out(sw_211_latch_out),
        .module_data_in  (sw_211_module_data_in),
        .module_data_out (sw_211_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_211 (
        .io_in  (sw_211_module_data_in),
        .io_out (sw_211_module_data_out)
    );

    // [212] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_212_clk_out, sw_212_data_out, sw_212_scan_out, sw_212_latch_out;
    wire [7:0] sw_212_module_data_in;
    wire [7:0] sw_212_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_212 (
        .clk_in          (sw_211_clk_out),
        .data_in         (sw_211_data_out),
        .scan_select_in  (sw_211_scan_out),
        .latch_enable_in (sw_211_latch_out),
        .clk_out         (sw_212_clk_out),
        .data_out        (sw_212_data_out),
        .scan_select_out (sw_212_scan_out),
        .latch_enable_out(sw_212_latch_out),
        .module_data_in  (sw_212_module_data_in),
        .module_data_out (sw_212_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_212 (
        .io_in  (sw_212_module_data_in),
        .io_out (sw_212_module_data_out)
    );

    // [213] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_213_clk_out, sw_213_data_out, sw_213_scan_out, sw_213_latch_out;
    wire [7:0] sw_213_module_data_in;
    wire [7:0] sw_213_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_213 (
        .clk_in          (sw_212_clk_out),
        .data_in         (sw_212_data_out),
        .scan_select_in  (sw_212_scan_out),
        .latch_enable_in (sw_212_latch_out),
        .clk_out         (sw_213_clk_out),
        .data_out        (sw_213_data_out),
        .scan_select_out (sw_213_scan_out),
        .latch_enable_out(sw_213_latch_out),
        .module_data_in  (sw_213_module_data_in),
        .module_data_out (sw_213_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_213 (
        .io_in  (sw_213_module_data_in),
        .io_out (sw_213_module_data_out)
    );

    // [214] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_214_clk_out, sw_214_data_out, sw_214_scan_out, sw_214_latch_out;
    wire [7:0] sw_214_module_data_in;
    wire [7:0] sw_214_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_214 (
        .clk_in          (sw_213_clk_out),
        .data_in         (sw_213_data_out),
        .scan_select_in  (sw_213_scan_out),
        .latch_enable_in (sw_213_latch_out),
        .clk_out         (sw_214_clk_out),
        .data_out        (sw_214_data_out),
        .scan_select_out (sw_214_scan_out),
        .latch_enable_out(sw_214_latch_out),
        .module_data_in  (sw_214_module_data_in),
        .module_data_out (sw_214_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_214 (
        .io_in  (sw_214_module_data_in),
        .io_out (sw_214_module_data_out)
    );

    // [215] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_215_clk_out, sw_215_data_out, sw_215_scan_out, sw_215_latch_out;
    wire [7:0] sw_215_module_data_in;
    wire [7:0] sw_215_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_215 (
        .clk_in          (sw_214_clk_out),
        .data_in         (sw_214_data_out),
        .scan_select_in  (sw_214_scan_out),
        .latch_enable_in (sw_214_latch_out),
        .clk_out         (sw_215_clk_out),
        .data_out        (sw_215_data_out),
        .scan_select_out (sw_215_scan_out),
        .latch_enable_out(sw_215_latch_out),
        .module_data_in  (sw_215_module_data_in),
        .module_data_out (sw_215_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_215 (
        .io_in  (sw_215_module_data_in),
        .io_out (sw_215_module_data_out)
    );

    // [216] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_216_clk_out, sw_216_data_out, sw_216_scan_out, sw_216_latch_out;
    wire [7:0] sw_216_module_data_in;
    wire [7:0] sw_216_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_216 (
        .clk_in          (sw_215_clk_out),
        .data_in         (sw_215_data_out),
        .scan_select_in  (sw_215_scan_out),
        .latch_enable_in (sw_215_latch_out),
        .clk_out         (sw_216_clk_out),
        .data_out        (sw_216_data_out),
        .scan_select_out (sw_216_scan_out),
        .latch_enable_out(sw_216_latch_out),
        .module_data_in  (sw_216_module_data_in),
        .module_data_out (sw_216_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_216 (
        .io_in  (sw_216_module_data_in),
        .io_out (sw_216_module_data_out)
    );

    // [217] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_217_clk_out, sw_217_data_out, sw_217_scan_out, sw_217_latch_out;
    wire [7:0] sw_217_module_data_in;
    wire [7:0] sw_217_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_217 (
        .clk_in          (sw_216_clk_out),
        .data_in         (sw_216_data_out),
        .scan_select_in  (sw_216_scan_out),
        .latch_enable_in (sw_216_latch_out),
        .clk_out         (sw_217_clk_out),
        .data_out        (sw_217_data_out),
        .scan_select_out (sw_217_scan_out),
        .latch_enable_out(sw_217_latch_out),
        .module_data_in  (sw_217_module_data_in),
        .module_data_out (sw_217_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_217 (
        .io_in  (sw_217_module_data_in),
        .io_out (sw_217_module_data_out)
    );

    // [218] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_218_clk_out, sw_218_data_out, sw_218_scan_out, sw_218_latch_out;
    wire [7:0] sw_218_module_data_in;
    wire [7:0] sw_218_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_218 (
        .clk_in          (sw_217_clk_out),
        .data_in         (sw_217_data_out),
        .scan_select_in  (sw_217_scan_out),
        .latch_enable_in (sw_217_latch_out),
        .clk_out         (sw_218_clk_out),
        .data_out        (sw_218_data_out),
        .scan_select_out (sw_218_scan_out),
        .latch_enable_out(sw_218_latch_out),
        .module_data_in  (sw_218_module_data_in),
        .module_data_out (sw_218_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_218 (
        .io_in  (sw_218_module_data_in),
        .io_out (sw_218_module_data_out)
    );

    // [219] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_219_clk_out, sw_219_data_out, sw_219_scan_out, sw_219_latch_out;
    wire [7:0] sw_219_module_data_in;
    wire [7:0] sw_219_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_219 (
        .clk_in          (sw_218_clk_out),
        .data_in         (sw_218_data_out),
        .scan_select_in  (sw_218_scan_out),
        .latch_enable_in (sw_218_latch_out),
        .clk_out         (sw_219_clk_out),
        .data_out        (sw_219_data_out),
        .scan_select_out (sw_219_scan_out),
        .latch_enable_out(sw_219_latch_out),
        .module_data_in  (sw_219_module_data_in),
        .module_data_out (sw_219_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_219 (
        .io_in  (sw_219_module_data_in),
        .io_out (sw_219_module_data_out)
    );

    // [220] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_220_clk_out, sw_220_data_out, sw_220_scan_out, sw_220_latch_out;
    wire [7:0] sw_220_module_data_in;
    wire [7:0] sw_220_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_220 (
        .clk_in          (sw_219_clk_out),
        .data_in         (sw_219_data_out),
        .scan_select_in  (sw_219_scan_out),
        .latch_enable_in (sw_219_latch_out),
        .clk_out         (sw_220_clk_out),
        .data_out        (sw_220_data_out),
        .scan_select_out (sw_220_scan_out),
        .latch_enable_out(sw_220_latch_out),
        .module_data_in  (sw_220_module_data_in),
        .module_data_out (sw_220_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_220 (
        .io_in  (sw_220_module_data_in),
        .io_out (sw_220_module_data_out)
    );

    // [221] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_221_clk_out, sw_221_data_out, sw_221_scan_out, sw_221_latch_out;
    wire [7:0] sw_221_module_data_in;
    wire [7:0] sw_221_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_221 (
        .clk_in          (sw_220_clk_out),
        .data_in         (sw_220_data_out),
        .scan_select_in  (sw_220_scan_out),
        .latch_enable_in (sw_220_latch_out),
        .clk_out         (sw_221_clk_out),
        .data_out        (sw_221_data_out),
        .scan_select_out (sw_221_scan_out),
        .latch_enable_out(sw_221_latch_out),
        .module_data_in  (sw_221_module_data_in),
        .module_data_out (sw_221_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_221 (
        .io_in  (sw_221_module_data_in),
        .io_out (sw_221_module_data_out)
    );

    // [222] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_222_clk_out, sw_222_data_out, sw_222_scan_out, sw_222_latch_out;
    wire [7:0] sw_222_module_data_in;
    wire [7:0] sw_222_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_222 (
        .clk_in          (sw_221_clk_out),
        .data_in         (sw_221_data_out),
        .scan_select_in  (sw_221_scan_out),
        .latch_enable_in (sw_221_latch_out),
        .clk_out         (sw_222_clk_out),
        .data_out        (sw_222_data_out),
        .scan_select_out (sw_222_scan_out),
        .latch_enable_out(sw_222_latch_out),
        .module_data_in  (sw_222_module_data_in),
        .module_data_out (sw_222_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_222 (
        .io_in  (sw_222_module_data_in),
        .io_out (sw_222_module_data_out)
    );

    // [223] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_223_clk_out, sw_223_data_out, sw_223_scan_out, sw_223_latch_out;
    wire [7:0] sw_223_module_data_in;
    wire [7:0] sw_223_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_223 (
        .clk_in          (sw_222_clk_out),
        .data_in         (sw_222_data_out),
        .scan_select_in  (sw_222_scan_out),
        .latch_enable_in (sw_222_latch_out),
        .clk_out         (sw_223_clk_out),
        .data_out        (sw_223_data_out),
        .scan_select_out (sw_223_scan_out),
        .latch_enable_out(sw_223_latch_out),
        .module_data_in  (sw_223_module_data_in),
        .module_data_out (sw_223_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_223 (
        .io_in  (sw_223_module_data_in),
        .io_out (sw_223_module_data_out)
    );

    // [224] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_224_clk_out, sw_224_data_out, sw_224_scan_out, sw_224_latch_out;
    wire [7:0] sw_224_module_data_in;
    wire [7:0] sw_224_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_224 (
        .clk_in          (sw_223_clk_out),
        .data_in         (sw_223_data_out),
        .scan_select_in  (sw_223_scan_out),
        .latch_enable_in (sw_223_latch_out),
        .clk_out         (sw_224_clk_out),
        .data_out        (sw_224_data_out),
        .scan_select_out (sw_224_scan_out),
        .latch_enable_out(sw_224_latch_out),
        .module_data_in  (sw_224_module_data_in),
        .module_data_out (sw_224_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_224 (
        .io_in  (sw_224_module_data_in),
        .io_out (sw_224_module_data_out)
    );

    // [225] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_225_clk_out, sw_225_data_out, sw_225_scan_out, sw_225_latch_out;
    wire [7:0] sw_225_module_data_in;
    wire [7:0] sw_225_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_225 (
        .clk_in          (sw_224_clk_out),
        .data_in         (sw_224_data_out),
        .scan_select_in  (sw_224_scan_out),
        .latch_enable_in (sw_224_latch_out),
        .clk_out         (sw_225_clk_out),
        .data_out        (sw_225_data_out),
        .scan_select_out (sw_225_scan_out),
        .latch_enable_out(sw_225_latch_out),
        .module_data_in  (sw_225_module_data_in),
        .module_data_out (sw_225_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_225 (
        .io_in  (sw_225_module_data_in),
        .io_out (sw_225_module_data_out)
    );

    // [226] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_226_clk_out, sw_226_data_out, sw_226_scan_out, sw_226_latch_out;
    wire [7:0] sw_226_module_data_in;
    wire [7:0] sw_226_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_226 (
        .clk_in          (sw_225_clk_out),
        .data_in         (sw_225_data_out),
        .scan_select_in  (sw_225_scan_out),
        .latch_enable_in (sw_225_latch_out),
        .clk_out         (sw_226_clk_out),
        .data_out        (sw_226_data_out),
        .scan_select_out (sw_226_scan_out),
        .latch_enable_out(sw_226_latch_out),
        .module_data_in  (sw_226_module_data_in),
        .module_data_out (sw_226_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_226 (
        .io_in  (sw_226_module_data_in),
        .io_out (sw_226_module_data_out)
    );

    // [227] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_227_clk_out, sw_227_data_out, sw_227_scan_out, sw_227_latch_out;
    wire [7:0] sw_227_module_data_in;
    wire [7:0] sw_227_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_227 (
        .clk_in          (sw_226_clk_out),
        .data_in         (sw_226_data_out),
        .scan_select_in  (sw_226_scan_out),
        .latch_enable_in (sw_226_latch_out),
        .clk_out         (sw_227_clk_out),
        .data_out        (sw_227_data_out),
        .scan_select_out (sw_227_scan_out),
        .latch_enable_out(sw_227_latch_out),
        .module_data_in  (sw_227_module_data_in),
        .module_data_out (sw_227_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_227 (
        .io_in  (sw_227_module_data_in),
        .io_out (sw_227_module_data_out)
    );

    // [228] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_228_clk_out, sw_228_data_out, sw_228_scan_out, sw_228_latch_out;
    wire [7:0] sw_228_module_data_in;
    wire [7:0] sw_228_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_228 (
        .clk_in          (sw_227_clk_out),
        .data_in         (sw_227_data_out),
        .scan_select_in  (sw_227_scan_out),
        .latch_enable_in (sw_227_latch_out),
        .clk_out         (sw_228_clk_out),
        .data_out        (sw_228_data_out),
        .scan_select_out (sw_228_scan_out),
        .latch_enable_out(sw_228_latch_out),
        .module_data_in  (sw_228_module_data_in),
        .module_data_out (sw_228_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_228 (
        .io_in  (sw_228_module_data_in),
        .io_out (sw_228_module_data_out)
    );

    // [229] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_229_clk_out, sw_229_data_out, sw_229_scan_out, sw_229_latch_out;
    wire [7:0] sw_229_module_data_in;
    wire [7:0] sw_229_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_229 (
        .clk_in          (sw_228_clk_out),
        .data_in         (sw_228_data_out),
        .scan_select_in  (sw_228_scan_out),
        .latch_enable_in (sw_228_latch_out),
        .clk_out         (sw_229_clk_out),
        .data_out        (sw_229_data_out),
        .scan_select_out (sw_229_scan_out),
        .latch_enable_out(sw_229_latch_out),
        .module_data_in  (sw_229_module_data_in),
        .module_data_out (sw_229_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_229 (
        .io_in  (sw_229_module_data_in),
        .io_out (sw_229_module_data_out)
    );

    // [230] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_230_clk_out, sw_230_data_out, sw_230_scan_out, sw_230_latch_out;
    wire [7:0] sw_230_module_data_in;
    wire [7:0] sw_230_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_230 (
        .clk_in          (sw_229_clk_out),
        .data_in         (sw_229_data_out),
        .scan_select_in  (sw_229_scan_out),
        .latch_enable_in (sw_229_latch_out),
        .clk_out         (sw_230_clk_out),
        .data_out        (sw_230_data_out),
        .scan_select_out (sw_230_scan_out),
        .latch_enable_out(sw_230_latch_out),
        .module_data_in  (sw_230_module_data_in),
        .module_data_out (sw_230_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_230 (
        .io_in  (sw_230_module_data_in),
        .io_out (sw_230_module_data_out)
    );

    // [231] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_231_clk_out, sw_231_data_out, sw_231_scan_out, sw_231_latch_out;
    wire [7:0] sw_231_module_data_in;
    wire [7:0] sw_231_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_231 (
        .clk_in          (sw_230_clk_out),
        .data_in         (sw_230_data_out),
        .scan_select_in  (sw_230_scan_out),
        .latch_enable_in (sw_230_latch_out),
        .clk_out         (sw_231_clk_out),
        .data_out        (sw_231_data_out),
        .scan_select_out (sw_231_scan_out),
        .latch_enable_out(sw_231_latch_out),
        .module_data_in  (sw_231_module_data_in),
        .module_data_out (sw_231_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_231 (
        .io_in  (sw_231_module_data_in),
        .io_out (sw_231_module_data_out)
    );

    // [232] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_232_clk_out, sw_232_data_out, sw_232_scan_out, sw_232_latch_out;
    wire [7:0] sw_232_module_data_in;
    wire [7:0] sw_232_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_232 (
        .clk_in          (sw_231_clk_out),
        .data_in         (sw_231_data_out),
        .scan_select_in  (sw_231_scan_out),
        .latch_enable_in (sw_231_latch_out),
        .clk_out         (sw_232_clk_out),
        .data_out        (sw_232_data_out),
        .scan_select_out (sw_232_scan_out),
        .latch_enable_out(sw_232_latch_out),
        .module_data_in  (sw_232_module_data_in),
        .module_data_out (sw_232_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_232 (
        .io_in  (sw_232_module_data_in),
        .io_out (sw_232_module_data_out)
    );

    // [233] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_233_clk_out, sw_233_data_out, sw_233_scan_out, sw_233_latch_out;
    wire [7:0] sw_233_module_data_in;
    wire [7:0] sw_233_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_233 (
        .clk_in          (sw_232_clk_out),
        .data_in         (sw_232_data_out),
        .scan_select_in  (sw_232_scan_out),
        .latch_enable_in (sw_232_latch_out),
        .clk_out         (sw_233_clk_out),
        .data_out        (sw_233_data_out),
        .scan_select_out (sw_233_scan_out),
        .latch_enable_out(sw_233_latch_out),
        .module_data_in  (sw_233_module_data_in),
        .module_data_out (sw_233_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_233 (
        .io_in  (sw_233_module_data_in),
        .io_out (sw_233_module_data_out)
    );

    // [234] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_234_clk_out, sw_234_data_out, sw_234_scan_out, sw_234_latch_out;
    wire [7:0] sw_234_module_data_in;
    wire [7:0] sw_234_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_234 (
        .clk_in          (sw_233_clk_out),
        .data_in         (sw_233_data_out),
        .scan_select_in  (sw_233_scan_out),
        .latch_enable_in (sw_233_latch_out),
        .clk_out         (sw_234_clk_out),
        .data_out        (sw_234_data_out),
        .scan_select_out (sw_234_scan_out),
        .latch_enable_out(sw_234_latch_out),
        .module_data_in  (sw_234_module_data_in),
        .module_data_out (sw_234_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_234 (
        .io_in  (sw_234_module_data_in),
        .io_out (sw_234_module_data_out)
    );

    // [235] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_235_clk_out, sw_235_data_out, sw_235_scan_out, sw_235_latch_out;
    wire [7:0] sw_235_module_data_in;
    wire [7:0] sw_235_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_235 (
        .clk_in          (sw_234_clk_out),
        .data_in         (sw_234_data_out),
        .scan_select_in  (sw_234_scan_out),
        .latch_enable_in (sw_234_latch_out),
        .clk_out         (sw_235_clk_out),
        .data_out        (sw_235_data_out),
        .scan_select_out (sw_235_scan_out),
        .latch_enable_out(sw_235_latch_out),
        .module_data_in  (sw_235_module_data_in),
        .module_data_out (sw_235_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_235 (
        .io_in  (sw_235_module_data_in),
        .io_out (sw_235_module_data_out)
    );

    // [236] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_236_clk_out, sw_236_data_out, sw_236_scan_out, sw_236_latch_out;
    wire [7:0] sw_236_module_data_in;
    wire [7:0] sw_236_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_236 (
        .clk_in          (sw_235_clk_out),
        .data_in         (sw_235_data_out),
        .scan_select_in  (sw_235_scan_out),
        .latch_enable_in (sw_235_latch_out),
        .clk_out         (sw_236_clk_out),
        .data_out        (sw_236_data_out),
        .scan_select_out (sw_236_scan_out),
        .latch_enable_out(sw_236_latch_out),
        .module_data_in  (sw_236_module_data_in),
        .module_data_out (sw_236_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_236 (
        .io_in  (sw_236_module_data_in),
        .io_out (sw_236_module_data_out)
    );

    // [237] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_237_clk_out, sw_237_data_out, sw_237_scan_out, sw_237_latch_out;
    wire [7:0] sw_237_module_data_in;
    wire [7:0] sw_237_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_237 (
        .clk_in          (sw_236_clk_out),
        .data_in         (sw_236_data_out),
        .scan_select_in  (sw_236_scan_out),
        .latch_enable_in (sw_236_latch_out),
        .clk_out         (sw_237_clk_out),
        .data_out        (sw_237_data_out),
        .scan_select_out (sw_237_scan_out),
        .latch_enable_out(sw_237_latch_out),
        .module_data_in  (sw_237_module_data_in),
        .module_data_out (sw_237_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_237 (
        .io_in  (sw_237_module_data_in),
        .io_out (sw_237_module_data_out)
    );

    // [238] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_238_clk_out, sw_238_data_out, sw_238_scan_out, sw_238_latch_out;
    wire [7:0] sw_238_module_data_in;
    wire [7:0] sw_238_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_238 (
        .clk_in          (sw_237_clk_out),
        .data_in         (sw_237_data_out),
        .scan_select_in  (sw_237_scan_out),
        .latch_enable_in (sw_237_latch_out),
        .clk_out         (sw_238_clk_out),
        .data_out        (sw_238_data_out),
        .scan_select_out (sw_238_scan_out),
        .latch_enable_out(sw_238_latch_out),
        .module_data_in  (sw_238_module_data_in),
        .module_data_out (sw_238_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_238 (
        .io_in  (sw_238_module_data_in),
        .io_out (sw_238_module_data_out)
    );

    // [239] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_239_clk_out, sw_239_data_out, sw_239_scan_out, sw_239_latch_out;
    wire [7:0] sw_239_module_data_in;
    wire [7:0] sw_239_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_239 (
        .clk_in          (sw_238_clk_out),
        .data_in         (sw_238_data_out),
        .scan_select_in  (sw_238_scan_out),
        .latch_enable_in (sw_238_latch_out),
        .clk_out         (sw_239_clk_out),
        .data_out        (sw_239_data_out),
        .scan_select_out (sw_239_scan_out),
        .latch_enable_out(sw_239_latch_out),
        .module_data_in  (sw_239_module_data_in),
        .module_data_out (sw_239_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_239 (
        .io_in  (sw_239_module_data_in),
        .io_out (sw_239_module_data_out)
    );

    // [240] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_240_clk_out, sw_240_data_out, sw_240_scan_out, sw_240_latch_out;
    wire [7:0] sw_240_module_data_in;
    wire [7:0] sw_240_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_240 (
        .clk_in          (sw_239_clk_out),
        .data_in         (sw_239_data_out),
        .scan_select_in  (sw_239_scan_out),
        .latch_enable_in (sw_239_latch_out),
        .clk_out         (sw_240_clk_out),
        .data_out        (sw_240_data_out),
        .scan_select_out (sw_240_scan_out),
        .latch_enable_out(sw_240_latch_out),
        .module_data_in  (sw_240_module_data_in),
        .module_data_out (sw_240_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_240 (
        .io_in  (sw_240_module_data_in),
        .io_out (sw_240_module_data_out)
    );

    // [241] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_241_clk_out, sw_241_data_out, sw_241_scan_out, sw_241_latch_out;
    wire [7:0] sw_241_module_data_in;
    wire [7:0] sw_241_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_241 (
        .clk_in          (sw_240_clk_out),
        .data_in         (sw_240_data_out),
        .scan_select_in  (sw_240_scan_out),
        .latch_enable_in (sw_240_latch_out),
        .clk_out         (sw_241_clk_out),
        .data_out        (sw_241_data_out),
        .scan_select_out (sw_241_scan_out),
        .latch_enable_out(sw_241_latch_out),
        .module_data_in  (sw_241_module_data_in),
        .module_data_out (sw_241_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_241 (
        .io_in  (sw_241_module_data_in),
        .io_out (sw_241_module_data_out)
    );

    // [242] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_242_clk_out, sw_242_data_out, sw_242_scan_out, sw_242_latch_out;
    wire [7:0] sw_242_module_data_in;
    wire [7:0] sw_242_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_242 (
        .clk_in          (sw_241_clk_out),
        .data_in         (sw_241_data_out),
        .scan_select_in  (sw_241_scan_out),
        .latch_enable_in (sw_241_latch_out),
        .clk_out         (sw_242_clk_out),
        .data_out        (sw_242_data_out),
        .scan_select_out (sw_242_scan_out),
        .latch_enable_out(sw_242_latch_out),
        .module_data_in  (sw_242_module_data_in),
        .module_data_out (sw_242_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_242 (
        .io_in  (sw_242_module_data_in),
        .io_out (sw_242_module_data_out)
    );

    // [243] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_243_clk_out, sw_243_data_out, sw_243_scan_out, sw_243_latch_out;
    wire [7:0] sw_243_module_data_in;
    wire [7:0] sw_243_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_243 (
        .clk_in          (sw_242_clk_out),
        .data_in         (sw_242_data_out),
        .scan_select_in  (sw_242_scan_out),
        .latch_enable_in (sw_242_latch_out),
        .clk_out         (sw_243_clk_out),
        .data_out        (sw_243_data_out),
        .scan_select_out (sw_243_scan_out),
        .latch_enable_out(sw_243_latch_out),
        .module_data_in  (sw_243_module_data_in),
        .module_data_out (sw_243_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_243 (
        .io_in  (sw_243_module_data_in),
        .io_out (sw_243_module_data_out)
    );

    // [244] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_244_clk_out, sw_244_data_out, sw_244_scan_out, sw_244_latch_out;
    wire [7:0] sw_244_module_data_in;
    wire [7:0] sw_244_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_244 (
        .clk_in          (sw_243_clk_out),
        .data_in         (sw_243_data_out),
        .scan_select_in  (sw_243_scan_out),
        .latch_enable_in (sw_243_latch_out),
        .clk_out         (sw_244_clk_out),
        .data_out        (sw_244_data_out),
        .scan_select_out (sw_244_scan_out),
        .latch_enable_out(sw_244_latch_out),
        .module_data_in  (sw_244_module_data_in),
        .module_data_out (sw_244_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_244 (
        .io_in  (sw_244_module_data_in),
        .io_out (sw_244_module_data_out)
    );

    // [245] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_245_clk_out, sw_245_data_out, sw_245_scan_out, sw_245_latch_out;
    wire [7:0] sw_245_module_data_in;
    wire [7:0] sw_245_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_245 (
        .clk_in          (sw_244_clk_out),
        .data_in         (sw_244_data_out),
        .scan_select_in  (sw_244_scan_out),
        .latch_enable_in (sw_244_latch_out),
        .clk_out         (sw_245_clk_out),
        .data_out        (sw_245_data_out),
        .scan_select_out (sw_245_scan_out),
        .latch_enable_out(sw_245_latch_out),
        .module_data_in  (sw_245_module_data_in),
        .module_data_out (sw_245_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_245 (
        .io_in  (sw_245_module_data_in),
        .io_out (sw_245_module_data_out)
    );

    // [246] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_246_clk_out, sw_246_data_out, sw_246_scan_out, sw_246_latch_out;
    wire [7:0] sw_246_module_data_in;
    wire [7:0] sw_246_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_246 (
        .clk_in          (sw_245_clk_out),
        .data_in         (sw_245_data_out),
        .scan_select_in  (sw_245_scan_out),
        .latch_enable_in (sw_245_latch_out),
        .clk_out         (sw_246_clk_out),
        .data_out        (sw_246_data_out),
        .scan_select_out (sw_246_scan_out),
        .latch_enable_out(sw_246_latch_out),
        .module_data_in  (sw_246_module_data_in),
        .module_data_out (sw_246_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_246 (
        .io_in  (sw_246_module_data_in),
        .io_out (sw_246_module_data_out)
    );

    // [247] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_247_clk_out, sw_247_data_out, sw_247_scan_out, sw_247_latch_out;
    wire [7:0] sw_247_module_data_in;
    wire [7:0] sw_247_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_247 (
        .clk_in          (sw_246_clk_out),
        .data_in         (sw_246_data_out),
        .scan_select_in  (sw_246_scan_out),
        .latch_enable_in (sw_246_latch_out),
        .clk_out         (sw_247_clk_out),
        .data_out        (sw_247_data_out),
        .scan_select_out (sw_247_scan_out),
        .latch_enable_out(sw_247_latch_out),
        .module_data_in  (sw_247_module_data_in),
        .module_data_out (sw_247_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_247 (
        .io_in  (sw_247_module_data_in),
        .io_out (sw_247_module_data_out)
    );

    // [248] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_248_clk_out, sw_248_data_out, sw_248_scan_out, sw_248_latch_out;
    wire [7:0] sw_248_module_data_in;
    wire [7:0] sw_248_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_248 (
        .clk_in          (sw_247_clk_out),
        .data_in         (sw_247_data_out),
        .scan_select_in  (sw_247_scan_out),
        .latch_enable_in (sw_247_latch_out),
        .clk_out         (sw_248_clk_out),
        .data_out        (sw_248_data_out),
        .scan_select_out (sw_248_scan_out),
        .latch_enable_out(sw_248_latch_out),
        .module_data_in  (sw_248_module_data_in),
        .module_data_out (sw_248_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_248 (
        .io_in  (sw_248_module_data_in),
        .io_out (sw_248_module_data_out)
    );

    // [249] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_249_clk_out, sw_249_data_out, sw_249_scan_out, sw_249_latch_out;
    wire [7:0] sw_249_module_data_in;
    wire [7:0] sw_249_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_249 (
        .clk_in          (sw_248_clk_out),
        .data_in         (sw_248_data_out),
        .scan_select_in  (sw_248_scan_out),
        .latch_enable_in (sw_248_latch_out),
        .clk_out         (sw_249_clk_out),
        .data_out        (sw_249_data_out),
        .scan_select_out (sw_249_scan_out),
        .latch_enable_out(sw_249_latch_out),
        .module_data_in  (sw_249_module_data_in),
        .module_data_out (sw_249_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_249 (
        .io_in  (sw_249_module_data_in),
        .io_out (sw_249_module_data_out)
    );

    // [250] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_250_clk_out, sw_250_data_out, sw_250_scan_out, sw_250_latch_out;
    wire [7:0] sw_250_module_data_in;
    wire [7:0] sw_250_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_250 (
        .clk_in          (sw_249_clk_out),
        .data_in         (sw_249_data_out),
        .scan_select_in  (sw_249_scan_out),
        .latch_enable_in (sw_249_latch_out),
        .clk_out         (sw_250_clk_out),
        .data_out        (sw_250_data_out),
        .scan_select_out (sw_250_scan_out),
        .latch_enable_out(sw_250_latch_out),
        .module_data_in  (sw_250_module_data_in),
        .module_data_out (sw_250_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_250 (
        .io_in  (sw_250_module_data_in),
        .io_out (sw_250_module_data_out)
    );

    // [251] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_251_clk_out, sw_251_data_out, sw_251_scan_out, sw_251_latch_out;
    wire [7:0] sw_251_module_data_in;
    wire [7:0] sw_251_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_251 (
        .clk_in          (sw_250_clk_out),
        .data_in         (sw_250_data_out),
        .scan_select_in  (sw_250_scan_out),
        .latch_enable_in (sw_250_latch_out),
        .clk_out         (sw_251_clk_out),
        .data_out        (sw_251_data_out),
        .scan_select_out (sw_251_scan_out),
        .latch_enable_out(sw_251_latch_out),
        .module_data_in  (sw_251_module_data_in),
        .module_data_out (sw_251_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_251 (
        .io_in  (sw_251_module_data_in),
        .io_out (sw_251_module_data_out)
    );

    // [252] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_252_clk_out, sw_252_data_out, sw_252_scan_out, sw_252_latch_out;
    wire [7:0] sw_252_module_data_in;
    wire [7:0] sw_252_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_252 (
        .clk_in          (sw_251_clk_out),
        .data_in         (sw_251_data_out),
        .scan_select_in  (sw_251_scan_out),
        .latch_enable_in (sw_251_latch_out),
        .clk_out         (sw_252_clk_out),
        .data_out        (sw_252_data_out),
        .scan_select_out (sw_252_scan_out),
        .latch_enable_out(sw_252_latch_out),
        .module_data_in  (sw_252_module_data_in),
        .module_data_out (sw_252_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_252 (
        .io_in  (sw_252_module_data_in),
        .io_out (sw_252_module_data_out)
    );

    // [253] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_253_clk_out, sw_253_data_out, sw_253_scan_out, sw_253_latch_out;
    wire [7:0] sw_253_module_data_in;
    wire [7:0] sw_253_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_253 (
        .clk_in          (sw_252_clk_out),
        .data_in         (sw_252_data_out),
        .scan_select_in  (sw_252_scan_out),
        .latch_enable_in (sw_252_latch_out),
        .clk_out         (sw_253_clk_out),
        .data_out        (sw_253_data_out),
        .scan_select_out (sw_253_scan_out),
        .latch_enable_out(sw_253_latch_out),
        .module_data_in  (sw_253_module_data_in),
        .module_data_out (sw_253_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_253 (
        .io_in  (sw_253_module_data_in),
        .io_out (sw_253_module_data_out)
    );

    // [254] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_254_clk_out, sw_254_data_out, sw_254_scan_out, sw_254_latch_out;
    wire [7:0] sw_254_module_data_in;
    wire [7:0] sw_254_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_254 (
        .clk_in          (sw_253_clk_out),
        .data_in         (sw_253_data_out),
        .scan_select_in  (sw_253_scan_out),
        .latch_enable_in (sw_253_latch_out),
        .clk_out         (sw_254_clk_out),
        .data_out        (sw_254_data_out),
        .scan_select_out (sw_254_scan_out),
        .latch_enable_out(sw_254_latch_out),
        .module_data_in  (sw_254_module_data_in),
        .module_data_out (sw_254_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_254 (
        .io_in  (sw_254_module_data_in),
        .io_out (sw_254_module_data_out)
    );

    // [255] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_255_clk_out, sw_255_data_out, sw_255_scan_out, sw_255_latch_out;
    wire [7:0] sw_255_module_data_in;
    wire [7:0] sw_255_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_255 (
        .clk_in          (sw_254_clk_out),
        .data_in         (sw_254_data_out),
        .scan_select_in  (sw_254_scan_out),
        .latch_enable_in (sw_254_latch_out),
        .clk_out         (sw_255_clk_out),
        .data_out        (sw_255_data_out),
        .scan_select_out (sw_255_scan_out),
        .latch_enable_out(sw_255_latch_out),
        .module_data_in  (sw_255_module_data_in),
        .module_data_out (sw_255_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_255 (
        .io_in  (sw_255_module_data_in),
        .io_out (sw_255_module_data_out)
    );

    // [256] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_256_clk_out, sw_256_data_out, sw_256_scan_out, sw_256_latch_out;
    wire [7:0] sw_256_module_data_in;
    wire [7:0] sw_256_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_256 (
        .clk_in          (sw_255_clk_out),
        .data_in         (sw_255_data_out),
        .scan_select_in  (sw_255_scan_out),
        .latch_enable_in (sw_255_latch_out),
        .clk_out         (sw_256_clk_out),
        .data_out        (sw_256_data_out),
        .scan_select_out (sw_256_scan_out),
        .latch_enable_out(sw_256_latch_out),
        .module_data_in  (sw_256_module_data_in),
        .module_data_out (sw_256_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_256 (
        .io_in  (sw_256_module_data_in),
        .io_out (sw_256_module_data_out)
    );

    // [257] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_257_clk_out, sw_257_data_out, sw_257_scan_out, sw_257_latch_out;
    wire [7:0] sw_257_module_data_in;
    wire [7:0] sw_257_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_257 (
        .clk_in          (sw_256_clk_out),
        .data_in         (sw_256_data_out),
        .scan_select_in  (sw_256_scan_out),
        .latch_enable_in (sw_256_latch_out),
        .clk_out         (sw_257_clk_out),
        .data_out        (sw_257_data_out),
        .scan_select_out (sw_257_scan_out),
        .latch_enable_out(sw_257_latch_out),
        .module_data_in  (sw_257_module_data_in),
        .module_data_out (sw_257_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_257 (
        .io_in  (sw_257_module_data_in),
        .io_out (sw_257_module_data_out)
    );

    // [258] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_258_clk_out, sw_258_data_out, sw_258_scan_out, sw_258_latch_out;
    wire [7:0] sw_258_module_data_in;
    wire [7:0] sw_258_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_258 (
        .clk_in          (sw_257_clk_out),
        .data_in         (sw_257_data_out),
        .scan_select_in  (sw_257_scan_out),
        .latch_enable_in (sw_257_latch_out),
        .clk_out         (sw_258_clk_out),
        .data_out        (sw_258_data_out),
        .scan_select_out (sw_258_scan_out),
        .latch_enable_out(sw_258_latch_out),
        .module_data_in  (sw_258_module_data_in),
        .module_data_out (sw_258_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_258 (
        .io_in  (sw_258_module_data_in),
        .io_out (sw_258_module_data_out)
    );

    // [259] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_259_clk_out, sw_259_data_out, sw_259_scan_out, sw_259_latch_out;
    wire [7:0] sw_259_module_data_in;
    wire [7:0] sw_259_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_259 (
        .clk_in          (sw_258_clk_out),
        .data_in         (sw_258_data_out),
        .scan_select_in  (sw_258_scan_out),
        .latch_enable_in (sw_258_latch_out),
        .clk_out         (sw_259_clk_out),
        .data_out        (sw_259_data_out),
        .scan_select_out (sw_259_scan_out),
        .latch_enable_out(sw_259_latch_out),
        .module_data_in  (sw_259_module_data_in),
        .module_data_out (sw_259_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_259 (
        .io_in  (sw_259_module_data_in),
        .io_out (sw_259_module_data_out)
    );

    // [260] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_260_clk_out, sw_260_data_out, sw_260_scan_out, sw_260_latch_out;
    wire [7:0] sw_260_module_data_in;
    wire [7:0] sw_260_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_260 (
        .clk_in          (sw_259_clk_out),
        .data_in         (sw_259_data_out),
        .scan_select_in  (sw_259_scan_out),
        .latch_enable_in (sw_259_latch_out),
        .clk_out         (sw_260_clk_out),
        .data_out        (sw_260_data_out),
        .scan_select_out (sw_260_scan_out),
        .latch_enable_out(sw_260_latch_out),
        .module_data_in  (sw_260_module_data_in),
        .module_data_out (sw_260_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_260 (
        .io_in  (sw_260_module_data_in),
        .io_out (sw_260_module_data_out)
    );

    // [261] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_261_clk_out, sw_261_data_out, sw_261_scan_out, sw_261_latch_out;
    wire [7:0] sw_261_module_data_in;
    wire [7:0] sw_261_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_261 (
        .clk_in          (sw_260_clk_out),
        .data_in         (sw_260_data_out),
        .scan_select_in  (sw_260_scan_out),
        .latch_enable_in (sw_260_latch_out),
        .clk_out         (sw_261_clk_out),
        .data_out        (sw_261_data_out),
        .scan_select_out (sw_261_scan_out),
        .latch_enable_out(sw_261_latch_out),
        .module_data_in  (sw_261_module_data_in),
        .module_data_out (sw_261_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_261 (
        .io_in  (sw_261_module_data_in),
        .io_out (sw_261_module_data_out)
    );

    // [262] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_262_clk_out, sw_262_data_out, sw_262_scan_out, sw_262_latch_out;
    wire [7:0] sw_262_module_data_in;
    wire [7:0] sw_262_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_262 (
        .clk_in          (sw_261_clk_out),
        .data_in         (sw_261_data_out),
        .scan_select_in  (sw_261_scan_out),
        .latch_enable_in (sw_261_latch_out),
        .clk_out         (sw_262_clk_out),
        .data_out        (sw_262_data_out),
        .scan_select_out (sw_262_scan_out),
        .latch_enable_out(sw_262_latch_out),
        .module_data_in  (sw_262_module_data_in),
        .module_data_out (sw_262_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_262 (
        .io_in  (sw_262_module_data_in),
        .io_out (sw_262_module_data_out)
    );

    // [263] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_263_clk_out, sw_263_data_out, sw_263_scan_out, sw_263_latch_out;
    wire [7:0] sw_263_module_data_in;
    wire [7:0] sw_263_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_263 (
        .clk_in          (sw_262_clk_out),
        .data_in         (sw_262_data_out),
        .scan_select_in  (sw_262_scan_out),
        .latch_enable_in (sw_262_latch_out),
        .clk_out         (sw_263_clk_out),
        .data_out        (sw_263_data_out),
        .scan_select_out (sw_263_scan_out),
        .latch_enable_out(sw_263_latch_out),
        .module_data_in  (sw_263_module_data_in),
        .module_data_out (sw_263_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_263 (
        .io_in  (sw_263_module_data_in),
        .io_out (sw_263_module_data_out)
    );

    // [264] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_264_clk_out, sw_264_data_out, sw_264_scan_out, sw_264_latch_out;
    wire [7:0] sw_264_module_data_in;
    wire [7:0] sw_264_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_264 (
        .clk_in          (sw_263_clk_out),
        .data_in         (sw_263_data_out),
        .scan_select_in  (sw_263_scan_out),
        .latch_enable_in (sw_263_latch_out),
        .clk_out         (sw_264_clk_out),
        .data_out        (sw_264_data_out),
        .scan_select_out (sw_264_scan_out),
        .latch_enable_out(sw_264_latch_out),
        .module_data_in  (sw_264_module_data_in),
        .module_data_out (sw_264_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_264 (
        .io_in  (sw_264_module_data_in),
        .io_out (sw_264_module_data_out)
    );

    // [265] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_265_clk_out, sw_265_data_out, sw_265_scan_out, sw_265_latch_out;
    wire [7:0] sw_265_module_data_in;
    wire [7:0] sw_265_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_265 (
        .clk_in          (sw_264_clk_out),
        .data_in         (sw_264_data_out),
        .scan_select_in  (sw_264_scan_out),
        .latch_enable_in (sw_264_latch_out),
        .clk_out         (sw_265_clk_out),
        .data_out        (sw_265_data_out),
        .scan_select_out (sw_265_scan_out),
        .latch_enable_out(sw_265_latch_out),
        .module_data_in  (sw_265_module_data_in),
        .module_data_out (sw_265_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_265 (
        .io_in  (sw_265_module_data_in),
        .io_out (sw_265_module_data_out)
    );

    // [266] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_266_clk_out, sw_266_data_out, sw_266_scan_out, sw_266_latch_out;
    wire [7:0] sw_266_module_data_in;
    wire [7:0] sw_266_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_266 (
        .clk_in          (sw_265_clk_out),
        .data_in         (sw_265_data_out),
        .scan_select_in  (sw_265_scan_out),
        .latch_enable_in (sw_265_latch_out),
        .clk_out         (sw_266_clk_out),
        .data_out        (sw_266_data_out),
        .scan_select_out (sw_266_scan_out),
        .latch_enable_out(sw_266_latch_out),
        .module_data_in  (sw_266_module_data_in),
        .module_data_out (sw_266_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_266 (
        .io_in  (sw_266_module_data_in),
        .io_out (sw_266_module_data_out)
    );

    // [267] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_267_clk_out, sw_267_data_out, sw_267_scan_out, sw_267_latch_out;
    wire [7:0] sw_267_module_data_in;
    wire [7:0] sw_267_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_267 (
        .clk_in          (sw_266_clk_out),
        .data_in         (sw_266_data_out),
        .scan_select_in  (sw_266_scan_out),
        .latch_enable_in (sw_266_latch_out),
        .clk_out         (sw_267_clk_out),
        .data_out        (sw_267_data_out),
        .scan_select_out (sw_267_scan_out),
        .latch_enable_out(sw_267_latch_out),
        .module_data_in  (sw_267_module_data_in),
        .module_data_out (sw_267_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_267 (
        .io_in  (sw_267_module_data_in),
        .io_out (sw_267_module_data_out)
    );

    // [268] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_268_clk_out, sw_268_data_out, sw_268_scan_out, sw_268_latch_out;
    wire [7:0] sw_268_module_data_in;
    wire [7:0] sw_268_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_268 (
        .clk_in          (sw_267_clk_out),
        .data_in         (sw_267_data_out),
        .scan_select_in  (sw_267_scan_out),
        .latch_enable_in (sw_267_latch_out),
        .clk_out         (sw_268_clk_out),
        .data_out        (sw_268_data_out),
        .scan_select_out (sw_268_scan_out),
        .latch_enable_out(sw_268_latch_out),
        .module_data_in  (sw_268_module_data_in),
        .module_data_out (sw_268_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_268 (
        .io_in  (sw_268_module_data_in),
        .io_out (sw_268_module_data_out)
    );

    // [269] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_269_clk_out, sw_269_data_out, sw_269_scan_out, sw_269_latch_out;
    wire [7:0] sw_269_module_data_in;
    wire [7:0] sw_269_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_269 (
        .clk_in          (sw_268_clk_out),
        .data_in         (sw_268_data_out),
        .scan_select_in  (sw_268_scan_out),
        .latch_enable_in (sw_268_latch_out),
        .clk_out         (sw_269_clk_out),
        .data_out        (sw_269_data_out),
        .scan_select_out (sw_269_scan_out),
        .latch_enable_out(sw_269_latch_out),
        .module_data_in  (sw_269_module_data_in),
        .module_data_out (sw_269_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_269 (
        .io_in  (sw_269_module_data_in),
        .io_out (sw_269_module_data_out)
    );

    // [270] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_270_clk_out, sw_270_data_out, sw_270_scan_out, sw_270_latch_out;
    wire [7:0] sw_270_module_data_in;
    wire [7:0] sw_270_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_270 (
        .clk_in          (sw_269_clk_out),
        .data_in         (sw_269_data_out),
        .scan_select_in  (sw_269_scan_out),
        .latch_enable_in (sw_269_latch_out),
        .clk_out         (sw_270_clk_out),
        .data_out        (sw_270_data_out),
        .scan_select_out (sw_270_scan_out),
        .latch_enable_out(sw_270_latch_out),
        .module_data_in  (sw_270_module_data_in),
        .module_data_out (sw_270_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_270 (
        .io_in  (sw_270_module_data_in),
        .io_out (sw_270_module_data_out)
    );

    // [271] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_271_clk_out, sw_271_data_out, sw_271_scan_out, sw_271_latch_out;
    wire [7:0] sw_271_module_data_in;
    wire [7:0] sw_271_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_271 (
        .clk_in          (sw_270_clk_out),
        .data_in         (sw_270_data_out),
        .scan_select_in  (sw_270_scan_out),
        .latch_enable_in (sw_270_latch_out),
        .clk_out         (sw_271_clk_out),
        .data_out        (sw_271_data_out),
        .scan_select_out (sw_271_scan_out),
        .latch_enable_out(sw_271_latch_out),
        .module_data_in  (sw_271_module_data_in),
        .module_data_out (sw_271_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_271 (
        .io_in  (sw_271_module_data_in),
        .io_out (sw_271_module_data_out)
    );

    // [272] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_272_clk_out, sw_272_data_out, sw_272_scan_out, sw_272_latch_out;
    wire [7:0] sw_272_module_data_in;
    wire [7:0] sw_272_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_272 (
        .clk_in          (sw_271_clk_out),
        .data_in         (sw_271_data_out),
        .scan_select_in  (sw_271_scan_out),
        .latch_enable_in (sw_271_latch_out),
        .clk_out         (sw_272_clk_out),
        .data_out        (sw_272_data_out),
        .scan_select_out (sw_272_scan_out),
        .latch_enable_out(sw_272_latch_out),
        .module_data_in  (sw_272_module_data_in),
        .module_data_out (sw_272_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_272 (
        .io_in  (sw_272_module_data_in),
        .io_out (sw_272_module_data_out)
    );

    // [273] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_273_clk_out, sw_273_data_out, sw_273_scan_out, sw_273_latch_out;
    wire [7:0] sw_273_module_data_in;
    wire [7:0] sw_273_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_273 (
        .clk_in          (sw_272_clk_out),
        .data_in         (sw_272_data_out),
        .scan_select_in  (sw_272_scan_out),
        .latch_enable_in (sw_272_latch_out),
        .clk_out         (sw_273_clk_out),
        .data_out        (sw_273_data_out),
        .scan_select_out (sw_273_scan_out),
        .latch_enable_out(sw_273_latch_out),
        .module_data_in  (sw_273_module_data_in),
        .module_data_out (sw_273_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_273 (
        .io_in  (sw_273_module_data_in),
        .io_out (sw_273_module_data_out)
    );

    // [274] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_274_clk_out, sw_274_data_out, sw_274_scan_out, sw_274_latch_out;
    wire [7:0] sw_274_module_data_in;
    wire [7:0] sw_274_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_274 (
        .clk_in          (sw_273_clk_out),
        .data_in         (sw_273_data_out),
        .scan_select_in  (sw_273_scan_out),
        .latch_enable_in (sw_273_latch_out),
        .clk_out         (sw_274_clk_out),
        .data_out        (sw_274_data_out),
        .scan_select_out (sw_274_scan_out),
        .latch_enable_out(sw_274_latch_out),
        .module_data_in  (sw_274_module_data_in),
        .module_data_out (sw_274_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_274 (
        .io_in  (sw_274_module_data_in),
        .io_out (sw_274_module_data_out)
    );

    // [275] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_275_clk_out, sw_275_data_out, sw_275_scan_out, sw_275_latch_out;
    wire [7:0] sw_275_module_data_in;
    wire [7:0] sw_275_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_275 (
        .clk_in          (sw_274_clk_out),
        .data_in         (sw_274_data_out),
        .scan_select_in  (sw_274_scan_out),
        .latch_enable_in (sw_274_latch_out),
        .clk_out         (sw_275_clk_out),
        .data_out        (sw_275_data_out),
        .scan_select_out (sw_275_scan_out),
        .latch_enable_out(sw_275_latch_out),
        .module_data_in  (sw_275_module_data_in),
        .module_data_out (sw_275_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_275 (
        .io_in  (sw_275_module_data_in),
        .io_out (sw_275_module_data_out)
    );

    // [276] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_276_clk_out, sw_276_data_out, sw_276_scan_out, sw_276_latch_out;
    wire [7:0] sw_276_module_data_in;
    wire [7:0] sw_276_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_276 (
        .clk_in          (sw_275_clk_out),
        .data_in         (sw_275_data_out),
        .scan_select_in  (sw_275_scan_out),
        .latch_enable_in (sw_275_latch_out),
        .clk_out         (sw_276_clk_out),
        .data_out        (sw_276_data_out),
        .scan_select_out (sw_276_scan_out),
        .latch_enable_out(sw_276_latch_out),
        .module_data_in  (sw_276_module_data_in),
        .module_data_out (sw_276_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_276 (
        .io_in  (sw_276_module_data_in),
        .io_out (sw_276_module_data_out)
    );

    // [277] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_277_clk_out, sw_277_data_out, sw_277_scan_out, sw_277_latch_out;
    wire [7:0] sw_277_module_data_in;
    wire [7:0] sw_277_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_277 (
        .clk_in          (sw_276_clk_out),
        .data_in         (sw_276_data_out),
        .scan_select_in  (sw_276_scan_out),
        .latch_enable_in (sw_276_latch_out),
        .clk_out         (sw_277_clk_out),
        .data_out        (sw_277_data_out),
        .scan_select_out (sw_277_scan_out),
        .latch_enable_out(sw_277_latch_out),
        .module_data_in  (sw_277_module_data_in),
        .module_data_out (sw_277_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_277 (
        .io_in  (sw_277_module_data_in),
        .io_out (sw_277_module_data_out)
    );

    // [278] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_278_clk_out, sw_278_data_out, sw_278_scan_out, sw_278_latch_out;
    wire [7:0] sw_278_module_data_in;
    wire [7:0] sw_278_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_278 (
        .clk_in          (sw_277_clk_out),
        .data_in         (sw_277_data_out),
        .scan_select_in  (sw_277_scan_out),
        .latch_enable_in (sw_277_latch_out),
        .clk_out         (sw_278_clk_out),
        .data_out        (sw_278_data_out),
        .scan_select_out (sw_278_scan_out),
        .latch_enable_out(sw_278_latch_out),
        .module_data_in  (sw_278_module_data_in),
        .module_data_out (sw_278_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_278 (
        .io_in  (sw_278_module_data_in),
        .io_out (sw_278_module_data_out)
    );

    // [279] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_279_clk_out, sw_279_data_out, sw_279_scan_out, sw_279_latch_out;
    wire [7:0] sw_279_module_data_in;
    wire [7:0] sw_279_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_279 (
        .clk_in          (sw_278_clk_out),
        .data_in         (sw_278_data_out),
        .scan_select_in  (sw_278_scan_out),
        .latch_enable_in (sw_278_latch_out),
        .clk_out         (sw_279_clk_out),
        .data_out        (sw_279_data_out),
        .scan_select_out (sw_279_scan_out),
        .latch_enable_out(sw_279_latch_out),
        .module_data_in  (sw_279_module_data_in),
        .module_data_out (sw_279_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_279 (
        .io_in  (sw_279_module_data_in),
        .io_out (sw_279_module_data_out)
    );

    // [280] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_280_clk_out, sw_280_data_out, sw_280_scan_out, sw_280_latch_out;
    wire [7:0] sw_280_module_data_in;
    wire [7:0] sw_280_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_280 (
        .clk_in          (sw_279_clk_out),
        .data_in         (sw_279_data_out),
        .scan_select_in  (sw_279_scan_out),
        .latch_enable_in (sw_279_latch_out),
        .clk_out         (sw_280_clk_out),
        .data_out        (sw_280_data_out),
        .scan_select_out (sw_280_scan_out),
        .latch_enable_out(sw_280_latch_out),
        .module_data_in  (sw_280_module_data_in),
        .module_data_out (sw_280_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_280 (
        .io_in  (sw_280_module_data_in),
        .io_out (sw_280_module_data_out)
    );

    // [281] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_281_clk_out, sw_281_data_out, sw_281_scan_out, sw_281_latch_out;
    wire [7:0] sw_281_module_data_in;
    wire [7:0] sw_281_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_281 (
        .clk_in          (sw_280_clk_out),
        .data_in         (sw_280_data_out),
        .scan_select_in  (sw_280_scan_out),
        .latch_enable_in (sw_280_latch_out),
        .clk_out         (sw_281_clk_out),
        .data_out        (sw_281_data_out),
        .scan_select_out (sw_281_scan_out),
        .latch_enable_out(sw_281_latch_out),
        .module_data_in  (sw_281_module_data_in),
        .module_data_out (sw_281_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_281 (
        .io_in  (sw_281_module_data_in),
        .io_out (sw_281_module_data_out)
    );

    // [282] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_282_clk_out, sw_282_data_out, sw_282_scan_out, sw_282_latch_out;
    wire [7:0] sw_282_module_data_in;
    wire [7:0] sw_282_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_282 (
        .clk_in          (sw_281_clk_out),
        .data_in         (sw_281_data_out),
        .scan_select_in  (sw_281_scan_out),
        .latch_enable_in (sw_281_latch_out),
        .clk_out         (sw_282_clk_out),
        .data_out        (sw_282_data_out),
        .scan_select_out (sw_282_scan_out),
        .latch_enable_out(sw_282_latch_out),
        .module_data_in  (sw_282_module_data_in),
        .module_data_out (sw_282_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_282 (
        .io_in  (sw_282_module_data_in),
        .io_out (sw_282_module_data_out)
    );

    // [283] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_283_clk_out, sw_283_data_out, sw_283_scan_out, sw_283_latch_out;
    wire [7:0] sw_283_module_data_in;
    wire [7:0] sw_283_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_283 (
        .clk_in          (sw_282_clk_out),
        .data_in         (sw_282_data_out),
        .scan_select_in  (sw_282_scan_out),
        .latch_enable_in (sw_282_latch_out),
        .clk_out         (sw_283_clk_out),
        .data_out        (sw_283_data_out),
        .scan_select_out (sw_283_scan_out),
        .latch_enable_out(sw_283_latch_out),
        .module_data_in  (sw_283_module_data_in),
        .module_data_out (sw_283_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_283 (
        .io_in  (sw_283_module_data_in),
        .io_out (sw_283_module_data_out)
    );

    // [284] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_284_clk_out, sw_284_data_out, sw_284_scan_out, sw_284_latch_out;
    wire [7:0] sw_284_module_data_in;
    wire [7:0] sw_284_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_284 (
        .clk_in          (sw_283_clk_out),
        .data_in         (sw_283_data_out),
        .scan_select_in  (sw_283_scan_out),
        .latch_enable_in (sw_283_latch_out),
        .clk_out         (sw_284_clk_out),
        .data_out        (sw_284_data_out),
        .scan_select_out (sw_284_scan_out),
        .latch_enable_out(sw_284_latch_out),
        .module_data_in  (sw_284_module_data_in),
        .module_data_out (sw_284_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_284 (
        .io_in  (sw_284_module_data_in),
        .io_out (sw_284_module_data_out)
    );

    // [285] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_285_clk_out, sw_285_data_out, sw_285_scan_out, sw_285_latch_out;
    wire [7:0] sw_285_module_data_in;
    wire [7:0] sw_285_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_285 (
        .clk_in          (sw_284_clk_out),
        .data_in         (sw_284_data_out),
        .scan_select_in  (sw_284_scan_out),
        .latch_enable_in (sw_284_latch_out),
        .clk_out         (sw_285_clk_out),
        .data_out        (sw_285_data_out),
        .scan_select_out (sw_285_scan_out),
        .latch_enable_out(sw_285_latch_out),
        .module_data_in  (sw_285_module_data_in),
        .module_data_out (sw_285_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_285 (
        .io_in  (sw_285_module_data_in),
        .io_out (sw_285_module_data_out)
    );

    // [286] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_286_clk_out, sw_286_data_out, sw_286_scan_out, sw_286_latch_out;
    wire [7:0] sw_286_module_data_in;
    wire [7:0] sw_286_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_286 (
        .clk_in          (sw_285_clk_out),
        .data_in         (sw_285_data_out),
        .scan_select_in  (sw_285_scan_out),
        .latch_enable_in (sw_285_latch_out),
        .clk_out         (sw_286_clk_out),
        .data_out        (sw_286_data_out),
        .scan_select_out (sw_286_scan_out),
        .latch_enable_out(sw_286_latch_out),
        .module_data_in  (sw_286_module_data_in),
        .module_data_out (sw_286_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_286 (
        .io_in  (sw_286_module_data_in),
        .io_out (sw_286_module_data_out)
    );

    // [287] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_287_clk_out, sw_287_data_out, sw_287_scan_out, sw_287_latch_out;
    wire [7:0] sw_287_module_data_in;
    wire [7:0] sw_287_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_287 (
        .clk_in          (sw_286_clk_out),
        .data_in         (sw_286_data_out),
        .scan_select_in  (sw_286_scan_out),
        .latch_enable_in (sw_286_latch_out),
        .clk_out         (sw_287_clk_out),
        .data_out        (sw_287_data_out),
        .scan_select_out (sw_287_scan_out),
        .latch_enable_out(sw_287_latch_out),
        .module_data_in  (sw_287_module_data_in),
        .module_data_out (sw_287_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_287 (
        .io_in  (sw_287_module_data_in),
        .io_out (sw_287_module_data_out)
    );

    // [288] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_288_clk_out, sw_288_data_out, sw_288_scan_out, sw_288_latch_out;
    wire [7:0] sw_288_module_data_in;
    wire [7:0] sw_288_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_288 (
        .clk_in          (sw_287_clk_out),
        .data_in         (sw_287_data_out),
        .scan_select_in  (sw_287_scan_out),
        .latch_enable_in (sw_287_latch_out),
        .clk_out         (sw_288_clk_out),
        .data_out        (sw_288_data_out),
        .scan_select_out (sw_288_scan_out),
        .latch_enable_out(sw_288_latch_out),
        .module_data_in  (sw_288_module_data_in),
        .module_data_out (sw_288_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_288 (
        .io_in  (sw_288_module_data_in),
        .io_out (sw_288_module_data_out)
    );

    // [289] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_289_clk_out, sw_289_data_out, sw_289_scan_out, sw_289_latch_out;
    wire [7:0] sw_289_module_data_in;
    wire [7:0] sw_289_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_289 (
        .clk_in          (sw_288_clk_out),
        .data_in         (sw_288_data_out),
        .scan_select_in  (sw_288_scan_out),
        .latch_enable_in (sw_288_latch_out),
        .clk_out         (sw_289_clk_out),
        .data_out        (sw_289_data_out),
        .scan_select_out (sw_289_scan_out),
        .latch_enable_out(sw_289_latch_out),
        .module_data_in  (sw_289_module_data_in),
        .module_data_out (sw_289_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_289 (
        .io_in  (sw_289_module_data_in),
        .io_out (sw_289_module_data_out)
    );

    // [290] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_290_clk_out, sw_290_data_out, sw_290_scan_out, sw_290_latch_out;
    wire [7:0] sw_290_module_data_in;
    wire [7:0] sw_290_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_290 (
        .clk_in          (sw_289_clk_out),
        .data_in         (sw_289_data_out),
        .scan_select_in  (sw_289_scan_out),
        .latch_enable_in (sw_289_latch_out),
        .clk_out         (sw_290_clk_out),
        .data_out        (sw_290_data_out),
        .scan_select_out (sw_290_scan_out),
        .latch_enable_out(sw_290_latch_out),
        .module_data_in  (sw_290_module_data_in),
        .module_data_out (sw_290_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_290 (
        .io_in  (sw_290_module_data_in),
        .io_out (sw_290_module_data_out)
    );

    // [291] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_291_clk_out, sw_291_data_out, sw_291_scan_out, sw_291_latch_out;
    wire [7:0] sw_291_module_data_in;
    wire [7:0] sw_291_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_291 (
        .clk_in          (sw_290_clk_out),
        .data_in         (sw_290_data_out),
        .scan_select_in  (sw_290_scan_out),
        .latch_enable_in (sw_290_latch_out),
        .clk_out         (sw_291_clk_out),
        .data_out        (sw_291_data_out),
        .scan_select_out (sw_291_scan_out),
        .latch_enable_out(sw_291_latch_out),
        .module_data_in  (sw_291_module_data_in),
        .module_data_out (sw_291_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_291 (
        .io_in  (sw_291_module_data_in),
        .io_out (sw_291_module_data_out)
    );

    // [292] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_292_clk_out, sw_292_data_out, sw_292_scan_out, sw_292_latch_out;
    wire [7:0] sw_292_module_data_in;
    wire [7:0] sw_292_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_292 (
        .clk_in          (sw_291_clk_out),
        .data_in         (sw_291_data_out),
        .scan_select_in  (sw_291_scan_out),
        .latch_enable_in (sw_291_latch_out),
        .clk_out         (sw_292_clk_out),
        .data_out        (sw_292_data_out),
        .scan_select_out (sw_292_scan_out),
        .latch_enable_out(sw_292_latch_out),
        .module_data_in  (sw_292_module_data_in),
        .module_data_out (sw_292_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_292 (
        .io_in  (sw_292_module_data_in),
        .io_out (sw_292_module_data_out)
    );

    // [293] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_293_clk_out, sw_293_data_out, sw_293_scan_out, sw_293_latch_out;
    wire [7:0] sw_293_module_data_in;
    wire [7:0] sw_293_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_293 (
        .clk_in          (sw_292_clk_out),
        .data_in         (sw_292_data_out),
        .scan_select_in  (sw_292_scan_out),
        .latch_enable_in (sw_292_latch_out),
        .clk_out         (sw_293_clk_out),
        .data_out        (sw_293_data_out),
        .scan_select_out (sw_293_scan_out),
        .latch_enable_out(sw_293_latch_out),
        .module_data_in  (sw_293_module_data_in),
        .module_data_out (sw_293_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_293 (
        .io_in  (sw_293_module_data_in),
        .io_out (sw_293_module_data_out)
    );

    // [294] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_294_clk_out, sw_294_data_out, sw_294_scan_out, sw_294_latch_out;
    wire [7:0] sw_294_module_data_in;
    wire [7:0] sw_294_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_294 (
        .clk_in          (sw_293_clk_out),
        .data_in         (sw_293_data_out),
        .scan_select_in  (sw_293_scan_out),
        .latch_enable_in (sw_293_latch_out),
        .clk_out         (sw_294_clk_out),
        .data_out        (sw_294_data_out),
        .scan_select_out (sw_294_scan_out),
        .latch_enable_out(sw_294_latch_out),
        .module_data_in  (sw_294_module_data_in),
        .module_data_out (sw_294_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_294 (
        .io_in  (sw_294_module_data_in),
        .io_out (sw_294_module_data_out)
    );

    // [295] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_295_clk_out, sw_295_data_out, sw_295_scan_out, sw_295_latch_out;
    wire [7:0] sw_295_module_data_in;
    wire [7:0] sw_295_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_295 (
        .clk_in          (sw_294_clk_out),
        .data_in         (sw_294_data_out),
        .scan_select_in  (sw_294_scan_out),
        .latch_enable_in (sw_294_latch_out),
        .clk_out         (sw_295_clk_out),
        .data_out        (sw_295_data_out),
        .scan_select_out (sw_295_scan_out),
        .latch_enable_out(sw_295_latch_out),
        .module_data_in  (sw_295_module_data_in),
        .module_data_out (sw_295_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_295 (
        .io_in  (sw_295_module_data_in),
        .io_out (sw_295_module_data_out)
    );

    // [296] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_296_clk_out, sw_296_data_out, sw_296_scan_out, sw_296_latch_out;
    wire [7:0] sw_296_module_data_in;
    wire [7:0] sw_296_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_296 (
        .clk_in          (sw_295_clk_out),
        .data_in         (sw_295_data_out),
        .scan_select_in  (sw_295_scan_out),
        .latch_enable_in (sw_295_latch_out),
        .clk_out         (sw_296_clk_out),
        .data_out        (sw_296_data_out),
        .scan_select_out (sw_296_scan_out),
        .latch_enable_out(sw_296_latch_out),
        .module_data_in  (sw_296_module_data_in),
        .module_data_out (sw_296_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_296 (
        .io_in  (sw_296_module_data_in),
        .io_out (sw_296_module_data_out)
    );

    // [297] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_297_clk_out, sw_297_data_out, sw_297_scan_out, sw_297_latch_out;
    wire [7:0] sw_297_module_data_in;
    wire [7:0] sw_297_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_297 (
        .clk_in          (sw_296_clk_out),
        .data_in         (sw_296_data_out),
        .scan_select_in  (sw_296_scan_out),
        .latch_enable_in (sw_296_latch_out),
        .clk_out         (sw_297_clk_out),
        .data_out        (sw_297_data_out),
        .scan_select_out (sw_297_scan_out),
        .latch_enable_out(sw_297_latch_out),
        .module_data_in  (sw_297_module_data_in),
        .module_data_out (sw_297_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_297 (
        .io_in  (sw_297_module_data_in),
        .io_out (sw_297_module_data_out)
    );

    // [298] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_298_clk_out, sw_298_data_out, sw_298_scan_out, sw_298_latch_out;
    wire [7:0] sw_298_module_data_in;
    wire [7:0] sw_298_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_298 (
        .clk_in          (sw_297_clk_out),
        .data_in         (sw_297_data_out),
        .scan_select_in  (sw_297_scan_out),
        .latch_enable_in (sw_297_latch_out),
        .clk_out         (sw_298_clk_out),
        .data_out        (sw_298_data_out),
        .scan_select_out (sw_298_scan_out),
        .latch_enable_out(sw_298_latch_out),
        .module_data_in  (sw_298_module_data_in),
        .module_data_out (sw_298_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_298 (
        .io_in  (sw_298_module_data_in),
        .io_out (sw_298_module_data_out)
    );

    // [299] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_299_clk_out, sw_299_data_out, sw_299_scan_out, sw_299_latch_out;
    wire [7:0] sw_299_module_data_in;
    wire [7:0] sw_299_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_299 (
        .clk_in          (sw_298_clk_out),
        .data_in         (sw_298_data_out),
        .scan_select_in  (sw_298_scan_out),
        .latch_enable_in (sw_298_latch_out),
        .clk_out         (sw_299_clk_out),
        .data_out        (sw_299_data_out),
        .scan_select_out (sw_299_scan_out),
        .latch_enable_out(sw_299_latch_out),
        .module_data_in  (sw_299_module_data_in),
        .module_data_out (sw_299_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_299 (
        .io_in  (sw_299_module_data_in),
        .io_out (sw_299_module_data_out)
    );

    // [300] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_300_clk_out, sw_300_data_out, sw_300_scan_out, sw_300_latch_out;
    wire [7:0] sw_300_module_data_in;
    wire [7:0] sw_300_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_300 (
        .clk_in          (sw_299_clk_out),
        .data_in         (sw_299_data_out),
        .scan_select_in  (sw_299_scan_out),
        .latch_enable_in (sw_299_latch_out),
        .clk_out         (sw_300_clk_out),
        .data_out        (sw_300_data_out),
        .scan_select_out (sw_300_scan_out),
        .latch_enable_out(sw_300_latch_out),
        .module_data_in  (sw_300_module_data_in),
        .module_data_out (sw_300_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_300 (
        .io_in  (sw_300_module_data_in),
        .io_out (sw_300_module_data_out)
    );

    // [301] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_301_clk_out, sw_301_data_out, sw_301_scan_out, sw_301_latch_out;
    wire [7:0] sw_301_module_data_in;
    wire [7:0] sw_301_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_301 (
        .clk_in          (sw_300_clk_out),
        .data_in         (sw_300_data_out),
        .scan_select_in  (sw_300_scan_out),
        .latch_enable_in (sw_300_latch_out),
        .clk_out         (sw_301_clk_out),
        .data_out        (sw_301_data_out),
        .scan_select_out (sw_301_scan_out),
        .latch_enable_out(sw_301_latch_out),
        .module_data_in  (sw_301_module_data_in),
        .module_data_out (sw_301_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_301 (
        .io_in  (sw_301_module_data_in),
        .io_out (sw_301_module_data_out)
    );

    // [302] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_302_clk_out, sw_302_data_out, sw_302_scan_out, sw_302_latch_out;
    wire [7:0] sw_302_module_data_in;
    wire [7:0] sw_302_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_302 (
        .clk_in          (sw_301_clk_out),
        .data_in         (sw_301_data_out),
        .scan_select_in  (sw_301_scan_out),
        .latch_enable_in (sw_301_latch_out),
        .clk_out         (sw_302_clk_out),
        .data_out        (sw_302_data_out),
        .scan_select_out (sw_302_scan_out),
        .latch_enable_out(sw_302_latch_out),
        .module_data_in  (sw_302_module_data_in),
        .module_data_out (sw_302_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_302 (
        .io_in  (sw_302_module_data_in),
        .io_out (sw_302_module_data_out)
    );

    // [303] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_303_clk_out, sw_303_data_out, sw_303_scan_out, sw_303_latch_out;
    wire [7:0] sw_303_module_data_in;
    wire [7:0] sw_303_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_303 (
        .clk_in          (sw_302_clk_out),
        .data_in         (sw_302_data_out),
        .scan_select_in  (sw_302_scan_out),
        .latch_enable_in (sw_302_latch_out),
        .clk_out         (sw_303_clk_out),
        .data_out        (sw_303_data_out),
        .scan_select_out (sw_303_scan_out),
        .latch_enable_out(sw_303_latch_out),
        .module_data_in  (sw_303_module_data_in),
        .module_data_out (sw_303_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_303 (
        .io_in  (sw_303_module_data_in),
        .io_out (sw_303_module_data_out)
    );

    // [304] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_304_clk_out, sw_304_data_out, sw_304_scan_out, sw_304_latch_out;
    wire [7:0] sw_304_module_data_in;
    wire [7:0] sw_304_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_304 (
        .clk_in          (sw_303_clk_out),
        .data_in         (sw_303_data_out),
        .scan_select_in  (sw_303_scan_out),
        .latch_enable_in (sw_303_latch_out),
        .clk_out         (sw_304_clk_out),
        .data_out        (sw_304_data_out),
        .scan_select_out (sw_304_scan_out),
        .latch_enable_out(sw_304_latch_out),
        .module_data_in  (sw_304_module_data_in),
        .module_data_out (sw_304_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_304 (
        .io_in  (sw_304_module_data_in),
        .io_out (sw_304_module_data_out)
    );

    // [305] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_305_clk_out, sw_305_data_out, sw_305_scan_out, sw_305_latch_out;
    wire [7:0] sw_305_module_data_in;
    wire [7:0] sw_305_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_305 (
        .clk_in          (sw_304_clk_out),
        .data_in         (sw_304_data_out),
        .scan_select_in  (sw_304_scan_out),
        .latch_enable_in (sw_304_latch_out),
        .clk_out         (sw_305_clk_out),
        .data_out        (sw_305_data_out),
        .scan_select_out (sw_305_scan_out),
        .latch_enable_out(sw_305_latch_out),
        .module_data_in  (sw_305_module_data_in),
        .module_data_out (sw_305_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_305 (
        .io_in  (sw_305_module_data_in),
        .io_out (sw_305_module_data_out)
    );

    // [306] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_306_clk_out, sw_306_data_out, sw_306_scan_out, sw_306_latch_out;
    wire [7:0] sw_306_module_data_in;
    wire [7:0] sw_306_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_306 (
        .clk_in          (sw_305_clk_out),
        .data_in         (sw_305_data_out),
        .scan_select_in  (sw_305_scan_out),
        .latch_enable_in (sw_305_latch_out),
        .clk_out         (sw_306_clk_out),
        .data_out        (sw_306_data_out),
        .scan_select_out (sw_306_scan_out),
        .latch_enable_out(sw_306_latch_out),
        .module_data_in  (sw_306_module_data_in),
        .module_data_out (sw_306_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_306 (
        .io_in  (sw_306_module_data_in),
        .io_out (sw_306_module_data_out)
    );

    // [307] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_307_clk_out, sw_307_data_out, sw_307_scan_out, sw_307_latch_out;
    wire [7:0] sw_307_module_data_in;
    wire [7:0] sw_307_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_307 (
        .clk_in          (sw_306_clk_out),
        .data_in         (sw_306_data_out),
        .scan_select_in  (sw_306_scan_out),
        .latch_enable_in (sw_306_latch_out),
        .clk_out         (sw_307_clk_out),
        .data_out        (sw_307_data_out),
        .scan_select_out (sw_307_scan_out),
        .latch_enable_out(sw_307_latch_out),
        .module_data_in  (sw_307_module_data_in),
        .module_data_out (sw_307_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_307 (
        .io_in  (sw_307_module_data_in),
        .io_out (sw_307_module_data_out)
    );

    // [308] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_308_clk_out, sw_308_data_out, sw_308_scan_out, sw_308_latch_out;
    wire [7:0] sw_308_module_data_in;
    wire [7:0] sw_308_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_308 (
        .clk_in          (sw_307_clk_out),
        .data_in         (sw_307_data_out),
        .scan_select_in  (sw_307_scan_out),
        .latch_enable_in (sw_307_latch_out),
        .clk_out         (sw_308_clk_out),
        .data_out        (sw_308_data_out),
        .scan_select_out (sw_308_scan_out),
        .latch_enable_out(sw_308_latch_out),
        .module_data_in  (sw_308_module_data_in),
        .module_data_out (sw_308_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_308 (
        .io_in  (sw_308_module_data_in),
        .io_out (sw_308_module_data_out)
    );

    // [309] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_309_clk_out, sw_309_data_out, sw_309_scan_out, sw_309_latch_out;
    wire [7:0] sw_309_module_data_in;
    wire [7:0] sw_309_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_309 (
        .clk_in          (sw_308_clk_out),
        .data_in         (sw_308_data_out),
        .scan_select_in  (sw_308_scan_out),
        .latch_enable_in (sw_308_latch_out),
        .clk_out         (sw_309_clk_out),
        .data_out        (sw_309_data_out),
        .scan_select_out (sw_309_scan_out),
        .latch_enable_out(sw_309_latch_out),
        .module_data_in  (sw_309_module_data_in),
        .module_data_out (sw_309_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_309 (
        .io_in  (sw_309_module_data_in),
        .io_out (sw_309_module_data_out)
    );

    // [310] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_310_clk_out, sw_310_data_out, sw_310_scan_out, sw_310_latch_out;
    wire [7:0] sw_310_module_data_in;
    wire [7:0] sw_310_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_310 (
        .clk_in          (sw_309_clk_out),
        .data_in         (sw_309_data_out),
        .scan_select_in  (sw_309_scan_out),
        .latch_enable_in (sw_309_latch_out),
        .clk_out         (sw_310_clk_out),
        .data_out        (sw_310_data_out),
        .scan_select_out (sw_310_scan_out),
        .latch_enable_out(sw_310_latch_out),
        .module_data_in  (sw_310_module_data_in),
        .module_data_out (sw_310_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_310 (
        .io_in  (sw_310_module_data_in),
        .io_out (sw_310_module_data_out)
    );

    // [311] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_311_clk_out, sw_311_data_out, sw_311_scan_out, sw_311_latch_out;
    wire [7:0] sw_311_module_data_in;
    wire [7:0] sw_311_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_311 (
        .clk_in          (sw_310_clk_out),
        .data_in         (sw_310_data_out),
        .scan_select_in  (sw_310_scan_out),
        .latch_enable_in (sw_310_latch_out),
        .clk_out         (sw_311_clk_out),
        .data_out        (sw_311_data_out),
        .scan_select_out (sw_311_scan_out),
        .latch_enable_out(sw_311_latch_out),
        .module_data_in  (sw_311_module_data_in),
        .module_data_out (sw_311_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_311 (
        .io_in  (sw_311_module_data_in),
        .io_out (sw_311_module_data_out)
    );

    // [312] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_312_clk_out, sw_312_data_out, sw_312_scan_out, sw_312_latch_out;
    wire [7:0] sw_312_module_data_in;
    wire [7:0] sw_312_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_312 (
        .clk_in          (sw_311_clk_out),
        .data_in         (sw_311_data_out),
        .scan_select_in  (sw_311_scan_out),
        .latch_enable_in (sw_311_latch_out),
        .clk_out         (sw_312_clk_out),
        .data_out        (sw_312_data_out),
        .scan_select_out (sw_312_scan_out),
        .latch_enable_out(sw_312_latch_out),
        .module_data_in  (sw_312_module_data_in),
        .module_data_out (sw_312_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_312 (
        .io_in  (sw_312_module_data_in),
        .io_out (sw_312_module_data_out)
    );

    // [313] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_313_clk_out, sw_313_data_out, sw_313_scan_out, sw_313_latch_out;
    wire [7:0] sw_313_module_data_in;
    wire [7:0] sw_313_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_313 (
        .clk_in          (sw_312_clk_out),
        .data_in         (sw_312_data_out),
        .scan_select_in  (sw_312_scan_out),
        .latch_enable_in (sw_312_latch_out),
        .clk_out         (sw_313_clk_out),
        .data_out        (sw_313_data_out),
        .scan_select_out (sw_313_scan_out),
        .latch_enable_out(sw_313_latch_out),
        .module_data_in  (sw_313_module_data_in),
        .module_data_out (sw_313_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_313 (
        .io_in  (sw_313_module_data_in),
        .io_out (sw_313_module_data_out)
    );

    // [314] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_314_clk_out, sw_314_data_out, sw_314_scan_out, sw_314_latch_out;
    wire [7:0] sw_314_module_data_in;
    wire [7:0] sw_314_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_314 (
        .clk_in          (sw_313_clk_out),
        .data_in         (sw_313_data_out),
        .scan_select_in  (sw_313_scan_out),
        .latch_enable_in (sw_313_latch_out),
        .clk_out         (sw_314_clk_out),
        .data_out        (sw_314_data_out),
        .scan_select_out (sw_314_scan_out),
        .latch_enable_out(sw_314_latch_out),
        .module_data_in  (sw_314_module_data_in),
        .module_data_out (sw_314_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_314 (
        .io_in  (sw_314_module_data_in),
        .io_out (sw_314_module_data_out)
    );

    // [315] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_315_clk_out, sw_315_data_out, sw_315_scan_out, sw_315_latch_out;
    wire [7:0] sw_315_module_data_in;
    wire [7:0] sw_315_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_315 (
        .clk_in          (sw_314_clk_out),
        .data_in         (sw_314_data_out),
        .scan_select_in  (sw_314_scan_out),
        .latch_enable_in (sw_314_latch_out),
        .clk_out         (sw_315_clk_out),
        .data_out        (sw_315_data_out),
        .scan_select_out (sw_315_scan_out),
        .latch_enable_out(sw_315_latch_out),
        .module_data_in  (sw_315_module_data_in),
        .module_data_out (sw_315_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_315 (
        .io_in  (sw_315_module_data_in),
        .io_out (sw_315_module_data_out)
    );

    // [316] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_316_clk_out, sw_316_data_out, sw_316_scan_out, sw_316_latch_out;
    wire [7:0] sw_316_module_data_in;
    wire [7:0] sw_316_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_316 (
        .clk_in          (sw_315_clk_out),
        .data_in         (sw_315_data_out),
        .scan_select_in  (sw_315_scan_out),
        .latch_enable_in (sw_315_latch_out),
        .clk_out         (sw_316_clk_out),
        .data_out        (sw_316_data_out),
        .scan_select_out (sw_316_scan_out),
        .latch_enable_out(sw_316_latch_out),
        .module_data_in  (sw_316_module_data_in),
        .module_data_out (sw_316_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_316 (
        .io_in  (sw_316_module_data_in),
        .io_out (sw_316_module_data_out)
    );

    // [317] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_317_clk_out, sw_317_data_out, sw_317_scan_out, sw_317_latch_out;
    wire [7:0] sw_317_module_data_in;
    wire [7:0] sw_317_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_317 (
        .clk_in          (sw_316_clk_out),
        .data_in         (sw_316_data_out),
        .scan_select_in  (sw_316_scan_out),
        .latch_enable_in (sw_316_latch_out),
        .clk_out         (sw_317_clk_out),
        .data_out        (sw_317_data_out),
        .scan_select_out (sw_317_scan_out),
        .latch_enable_out(sw_317_latch_out),
        .module_data_in  (sw_317_module_data_in),
        .module_data_out (sw_317_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_317 (
        .io_in  (sw_317_module_data_in),
        .io_out (sw_317_module_data_out)
    );

    // [318] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_318_clk_out, sw_318_data_out, sw_318_scan_out, sw_318_latch_out;
    wire [7:0] sw_318_module_data_in;
    wire [7:0] sw_318_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_318 (
        .clk_in          (sw_317_clk_out),
        .data_in         (sw_317_data_out),
        .scan_select_in  (sw_317_scan_out),
        .latch_enable_in (sw_317_latch_out),
        .clk_out         (sw_318_clk_out),
        .data_out        (sw_318_data_out),
        .scan_select_out (sw_318_scan_out),
        .latch_enable_out(sw_318_latch_out),
        .module_data_in  (sw_318_module_data_in),
        .module_data_out (sw_318_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_318 (
        .io_in  (sw_318_module_data_in),
        .io_out (sw_318_module_data_out)
    );

    // [319] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_319_clk_out, sw_319_data_out, sw_319_scan_out, sw_319_latch_out;
    wire [7:0] sw_319_module_data_in;
    wire [7:0] sw_319_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_319 (
        .clk_in          (sw_318_clk_out),
        .data_in         (sw_318_data_out),
        .scan_select_in  (sw_318_scan_out),
        .latch_enable_in (sw_318_latch_out),
        .clk_out         (sw_319_clk_out),
        .data_out        (sw_319_data_out),
        .scan_select_out (sw_319_scan_out),
        .latch_enable_out(sw_319_latch_out),
        .module_data_in  (sw_319_module_data_in),
        .module_data_out (sw_319_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_319 (
        .io_in  (sw_319_module_data_in),
        .io_out (sw_319_module_data_out)
    );

    // [320] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_320_clk_out, sw_320_data_out, sw_320_scan_out, sw_320_latch_out;
    wire [7:0] sw_320_module_data_in;
    wire [7:0] sw_320_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_320 (
        .clk_in          (sw_319_clk_out),
        .data_in         (sw_319_data_out),
        .scan_select_in  (sw_319_scan_out),
        .latch_enable_in (sw_319_latch_out),
        .clk_out         (sw_320_clk_out),
        .data_out        (sw_320_data_out),
        .scan_select_out (sw_320_scan_out),
        .latch_enable_out(sw_320_latch_out),
        .module_data_in  (sw_320_module_data_in),
        .module_data_out (sw_320_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_320 (
        .io_in  (sw_320_module_data_in),
        .io_out (sw_320_module_data_out)
    );

    // [321] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_321_clk_out, sw_321_data_out, sw_321_scan_out, sw_321_latch_out;
    wire [7:0] sw_321_module_data_in;
    wire [7:0] sw_321_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_321 (
        .clk_in          (sw_320_clk_out),
        .data_in         (sw_320_data_out),
        .scan_select_in  (sw_320_scan_out),
        .latch_enable_in (sw_320_latch_out),
        .clk_out         (sw_321_clk_out),
        .data_out        (sw_321_data_out),
        .scan_select_out (sw_321_scan_out),
        .latch_enable_out(sw_321_latch_out),
        .module_data_in  (sw_321_module_data_in),
        .module_data_out (sw_321_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_321 (
        .io_in  (sw_321_module_data_in),
        .io_out (sw_321_module_data_out)
    );

    // [322] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_322_clk_out, sw_322_data_out, sw_322_scan_out, sw_322_latch_out;
    wire [7:0] sw_322_module_data_in;
    wire [7:0] sw_322_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_322 (
        .clk_in          (sw_321_clk_out),
        .data_in         (sw_321_data_out),
        .scan_select_in  (sw_321_scan_out),
        .latch_enable_in (sw_321_latch_out),
        .clk_out         (sw_322_clk_out),
        .data_out        (sw_322_data_out),
        .scan_select_out (sw_322_scan_out),
        .latch_enable_out(sw_322_latch_out),
        .module_data_in  (sw_322_module_data_in),
        .module_data_out (sw_322_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_322 (
        .io_in  (sw_322_module_data_in),
        .io_out (sw_322_module_data_out)
    );

    // [323] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_323_clk_out, sw_323_data_out, sw_323_scan_out, sw_323_latch_out;
    wire [7:0] sw_323_module_data_in;
    wire [7:0] sw_323_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_323 (
        .clk_in          (sw_322_clk_out),
        .data_in         (sw_322_data_out),
        .scan_select_in  (sw_322_scan_out),
        .latch_enable_in (sw_322_latch_out),
        .clk_out         (sw_323_clk_out),
        .data_out        (sw_323_data_out),
        .scan_select_out (sw_323_scan_out),
        .latch_enable_out(sw_323_latch_out),
        .module_data_in  (sw_323_module_data_in),
        .module_data_out (sw_323_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_323 (
        .io_in  (sw_323_module_data_in),
        .io_out (sw_323_module_data_out)
    );

    // [324] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_324_clk_out, sw_324_data_out, sw_324_scan_out, sw_324_latch_out;
    wire [7:0] sw_324_module_data_in;
    wire [7:0] sw_324_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_324 (
        .clk_in          (sw_323_clk_out),
        .data_in         (sw_323_data_out),
        .scan_select_in  (sw_323_scan_out),
        .latch_enable_in (sw_323_latch_out),
        .clk_out         (sw_324_clk_out),
        .data_out        (sw_324_data_out),
        .scan_select_out (sw_324_scan_out),
        .latch_enable_out(sw_324_latch_out),
        .module_data_in  (sw_324_module_data_in),
        .module_data_out (sw_324_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_324 (
        .io_in  (sw_324_module_data_in),
        .io_out (sw_324_module_data_out)
    );

    // [325] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_325_clk_out, sw_325_data_out, sw_325_scan_out, sw_325_latch_out;
    wire [7:0] sw_325_module_data_in;
    wire [7:0] sw_325_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_325 (
        .clk_in          (sw_324_clk_out),
        .data_in         (sw_324_data_out),
        .scan_select_in  (sw_324_scan_out),
        .latch_enable_in (sw_324_latch_out),
        .clk_out         (sw_325_clk_out),
        .data_out        (sw_325_data_out),
        .scan_select_out (sw_325_scan_out),
        .latch_enable_out(sw_325_latch_out),
        .module_data_in  (sw_325_module_data_in),
        .module_data_out (sw_325_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_325 (
        .io_in  (sw_325_module_data_in),
        .io_out (sw_325_module_data_out)
    );

    // [326] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_326_clk_out, sw_326_data_out, sw_326_scan_out, sw_326_latch_out;
    wire [7:0] sw_326_module_data_in;
    wire [7:0] sw_326_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_326 (
        .clk_in          (sw_325_clk_out),
        .data_in         (sw_325_data_out),
        .scan_select_in  (sw_325_scan_out),
        .latch_enable_in (sw_325_latch_out),
        .clk_out         (sw_326_clk_out),
        .data_out        (sw_326_data_out),
        .scan_select_out (sw_326_scan_out),
        .latch_enable_out(sw_326_latch_out),
        .module_data_in  (sw_326_module_data_in),
        .module_data_out (sw_326_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_326 (
        .io_in  (sw_326_module_data_in),
        .io_out (sw_326_module_data_out)
    );

    // [327] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_327_clk_out, sw_327_data_out, sw_327_scan_out, sw_327_latch_out;
    wire [7:0] sw_327_module_data_in;
    wire [7:0] sw_327_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_327 (
        .clk_in          (sw_326_clk_out),
        .data_in         (sw_326_data_out),
        .scan_select_in  (sw_326_scan_out),
        .latch_enable_in (sw_326_latch_out),
        .clk_out         (sw_327_clk_out),
        .data_out        (sw_327_data_out),
        .scan_select_out (sw_327_scan_out),
        .latch_enable_out(sw_327_latch_out),
        .module_data_in  (sw_327_module_data_in),
        .module_data_out (sw_327_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_327 (
        .io_in  (sw_327_module_data_in),
        .io_out (sw_327_module_data_out)
    );

    // [328] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_328_clk_out, sw_328_data_out, sw_328_scan_out, sw_328_latch_out;
    wire [7:0] sw_328_module_data_in;
    wire [7:0] sw_328_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_328 (
        .clk_in          (sw_327_clk_out),
        .data_in         (sw_327_data_out),
        .scan_select_in  (sw_327_scan_out),
        .latch_enable_in (sw_327_latch_out),
        .clk_out         (sw_328_clk_out),
        .data_out        (sw_328_data_out),
        .scan_select_out (sw_328_scan_out),
        .latch_enable_out(sw_328_latch_out),
        .module_data_in  (sw_328_module_data_in),
        .module_data_out (sw_328_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_328 (
        .io_in  (sw_328_module_data_in),
        .io_out (sw_328_module_data_out)
    );

    // [329] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_329_clk_out, sw_329_data_out, sw_329_scan_out, sw_329_latch_out;
    wire [7:0] sw_329_module_data_in;
    wire [7:0] sw_329_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_329 (
        .clk_in          (sw_328_clk_out),
        .data_in         (sw_328_data_out),
        .scan_select_in  (sw_328_scan_out),
        .latch_enable_in (sw_328_latch_out),
        .clk_out         (sw_329_clk_out),
        .data_out        (sw_329_data_out),
        .scan_select_out (sw_329_scan_out),
        .latch_enable_out(sw_329_latch_out),
        .module_data_in  (sw_329_module_data_in),
        .module_data_out (sw_329_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_329 (
        .io_in  (sw_329_module_data_in),
        .io_out (sw_329_module_data_out)
    );

    // [330] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_330_clk_out, sw_330_data_out, sw_330_scan_out, sw_330_latch_out;
    wire [7:0] sw_330_module_data_in;
    wire [7:0] sw_330_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_330 (
        .clk_in          (sw_329_clk_out),
        .data_in         (sw_329_data_out),
        .scan_select_in  (sw_329_scan_out),
        .latch_enable_in (sw_329_latch_out),
        .clk_out         (sw_330_clk_out),
        .data_out        (sw_330_data_out),
        .scan_select_out (sw_330_scan_out),
        .latch_enable_out(sw_330_latch_out),
        .module_data_in  (sw_330_module_data_in),
        .module_data_out (sw_330_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_330 (
        .io_in  (sw_330_module_data_in),
        .io_out (sw_330_module_data_out)
    );

    // [331] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_331_clk_out, sw_331_data_out, sw_331_scan_out, sw_331_latch_out;
    wire [7:0] sw_331_module_data_in;
    wire [7:0] sw_331_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_331 (
        .clk_in          (sw_330_clk_out),
        .data_in         (sw_330_data_out),
        .scan_select_in  (sw_330_scan_out),
        .latch_enable_in (sw_330_latch_out),
        .clk_out         (sw_331_clk_out),
        .data_out        (sw_331_data_out),
        .scan_select_out (sw_331_scan_out),
        .latch_enable_out(sw_331_latch_out),
        .module_data_in  (sw_331_module_data_in),
        .module_data_out (sw_331_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_331 (
        .io_in  (sw_331_module_data_in),
        .io_out (sw_331_module_data_out)
    );

    // [332] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_332_clk_out, sw_332_data_out, sw_332_scan_out, sw_332_latch_out;
    wire [7:0] sw_332_module_data_in;
    wire [7:0] sw_332_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_332 (
        .clk_in          (sw_331_clk_out),
        .data_in         (sw_331_data_out),
        .scan_select_in  (sw_331_scan_out),
        .latch_enable_in (sw_331_latch_out),
        .clk_out         (sw_332_clk_out),
        .data_out        (sw_332_data_out),
        .scan_select_out (sw_332_scan_out),
        .latch_enable_out(sw_332_latch_out),
        .module_data_in  (sw_332_module_data_in),
        .module_data_out (sw_332_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_332 (
        .io_in  (sw_332_module_data_in),
        .io_out (sw_332_module_data_out)
    );

    // [333] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_333_clk_out, sw_333_data_out, sw_333_scan_out, sw_333_latch_out;
    wire [7:0] sw_333_module_data_in;
    wire [7:0] sw_333_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_333 (
        .clk_in          (sw_332_clk_out),
        .data_in         (sw_332_data_out),
        .scan_select_in  (sw_332_scan_out),
        .latch_enable_in (sw_332_latch_out),
        .clk_out         (sw_333_clk_out),
        .data_out        (sw_333_data_out),
        .scan_select_out (sw_333_scan_out),
        .latch_enable_out(sw_333_latch_out),
        .module_data_in  (sw_333_module_data_in),
        .module_data_out (sw_333_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_333 (
        .io_in  (sw_333_module_data_in),
        .io_out (sw_333_module_data_out)
    );

    // [334] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_334_clk_out, sw_334_data_out, sw_334_scan_out, sw_334_latch_out;
    wire [7:0] sw_334_module_data_in;
    wire [7:0] sw_334_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_334 (
        .clk_in          (sw_333_clk_out),
        .data_in         (sw_333_data_out),
        .scan_select_in  (sw_333_scan_out),
        .latch_enable_in (sw_333_latch_out),
        .clk_out         (sw_334_clk_out),
        .data_out        (sw_334_data_out),
        .scan_select_out (sw_334_scan_out),
        .latch_enable_out(sw_334_latch_out),
        .module_data_in  (sw_334_module_data_in),
        .module_data_out (sw_334_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_334 (
        .io_in  (sw_334_module_data_in),
        .io_out (sw_334_module_data_out)
    );

    // [335] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_335_clk_out, sw_335_data_out, sw_335_scan_out, sw_335_latch_out;
    wire [7:0] sw_335_module_data_in;
    wire [7:0] sw_335_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_335 (
        .clk_in          (sw_334_clk_out),
        .data_in         (sw_334_data_out),
        .scan_select_in  (sw_334_scan_out),
        .latch_enable_in (sw_334_latch_out),
        .clk_out         (sw_335_clk_out),
        .data_out        (sw_335_data_out),
        .scan_select_out (sw_335_scan_out),
        .latch_enable_out(sw_335_latch_out),
        .module_data_in  (sw_335_module_data_in),
        .module_data_out (sw_335_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_335 (
        .io_in  (sw_335_module_data_in),
        .io_out (sw_335_module_data_out)
    );

    // [336] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_336_clk_out, sw_336_data_out, sw_336_scan_out, sw_336_latch_out;
    wire [7:0] sw_336_module_data_in;
    wire [7:0] sw_336_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_336 (
        .clk_in          (sw_335_clk_out),
        .data_in         (sw_335_data_out),
        .scan_select_in  (sw_335_scan_out),
        .latch_enable_in (sw_335_latch_out),
        .clk_out         (sw_336_clk_out),
        .data_out        (sw_336_data_out),
        .scan_select_out (sw_336_scan_out),
        .latch_enable_out(sw_336_latch_out),
        .module_data_in  (sw_336_module_data_in),
        .module_data_out (sw_336_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_336 (
        .io_in  (sw_336_module_data_in),
        .io_out (sw_336_module_data_out)
    );

    // [337] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_337_clk_out, sw_337_data_out, sw_337_scan_out, sw_337_latch_out;
    wire [7:0] sw_337_module_data_in;
    wire [7:0] sw_337_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_337 (
        .clk_in          (sw_336_clk_out),
        .data_in         (sw_336_data_out),
        .scan_select_in  (sw_336_scan_out),
        .latch_enable_in (sw_336_latch_out),
        .clk_out         (sw_337_clk_out),
        .data_out        (sw_337_data_out),
        .scan_select_out (sw_337_scan_out),
        .latch_enable_out(sw_337_latch_out),
        .module_data_in  (sw_337_module_data_in),
        .module_data_out (sw_337_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_337 (
        .io_in  (sw_337_module_data_in),
        .io_out (sw_337_module_data_out)
    );

    // [338] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_338_clk_out, sw_338_data_out, sw_338_scan_out, sw_338_latch_out;
    wire [7:0] sw_338_module_data_in;
    wire [7:0] sw_338_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_338 (
        .clk_in          (sw_337_clk_out),
        .data_in         (sw_337_data_out),
        .scan_select_in  (sw_337_scan_out),
        .latch_enable_in (sw_337_latch_out),
        .clk_out         (sw_338_clk_out),
        .data_out        (sw_338_data_out),
        .scan_select_out (sw_338_scan_out),
        .latch_enable_out(sw_338_latch_out),
        .module_data_in  (sw_338_module_data_in),
        .module_data_out (sw_338_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_338 (
        .io_in  (sw_338_module_data_in),
        .io_out (sw_338_module_data_out)
    );

    // [339] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_339_clk_out, sw_339_data_out, sw_339_scan_out, sw_339_latch_out;
    wire [7:0] sw_339_module_data_in;
    wire [7:0] sw_339_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_339 (
        .clk_in          (sw_338_clk_out),
        .data_in         (sw_338_data_out),
        .scan_select_in  (sw_338_scan_out),
        .latch_enable_in (sw_338_latch_out),
        .clk_out         (sw_339_clk_out),
        .data_out        (sw_339_data_out),
        .scan_select_out (sw_339_scan_out),
        .latch_enable_out(sw_339_latch_out),
        .module_data_in  (sw_339_module_data_in),
        .module_data_out (sw_339_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_339 (
        .io_in  (sw_339_module_data_in),
        .io_out (sw_339_module_data_out)
    );

    // [340] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_340_clk_out, sw_340_data_out, sw_340_scan_out, sw_340_latch_out;
    wire [7:0] sw_340_module_data_in;
    wire [7:0] sw_340_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_340 (
        .clk_in          (sw_339_clk_out),
        .data_in         (sw_339_data_out),
        .scan_select_in  (sw_339_scan_out),
        .latch_enable_in (sw_339_latch_out),
        .clk_out         (sw_340_clk_out),
        .data_out        (sw_340_data_out),
        .scan_select_out (sw_340_scan_out),
        .latch_enable_out(sw_340_latch_out),
        .module_data_in  (sw_340_module_data_in),
        .module_data_out (sw_340_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_340 (
        .io_in  (sw_340_module_data_in),
        .io_out (sw_340_module_data_out)
    );

    // [341] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_341_clk_out, sw_341_data_out, sw_341_scan_out, sw_341_latch_out;
    wire [7:0] sw_341_module_data_in;
    wire [7:0] sw_341_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_341 (
        .clk_in          (sw_340_clk_out),
        .data_in         (sw_340_data_out),
        .scan_select_in  (sw_340_scan_out),
        .latch_enable_in (sw_340_latch_out),
        .clk_out         (sw_341_clk_out),
        .data_out        (sw_341_data_out),
        .scan_select_out (sw_341_scan_out),
        .latch_enable_out(sw_341_latch_out),
        .module_data_in  (sw_341_module_data_in),
        .module_data_out (sw_341_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_341 (
        .io_in  (sw_341_module_data_in),
        .io_out (sw_341_module_data_out)
    );

    // [342] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_342_clk_out, sw_342_data_out, sw_342_scan_out, sw_342_latch_out;
    wire [7:0] sw_342_module_data_in;
    wire [7:0] sw_342_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_342 (
        .clk_in          (sw_341_clk_out),
        .data_in         (sw_341_data_out),
        .scan_select_in  (sw_341_scan_out),
        .latch_enable_in (sw_341_latch_out),
        .clk_out         (sw_342_clk_out),
        .data_out        (sw_342_data_out),
        .scan_select_out (sw_342_scan_out),
        .latch_enable_out(sw_342_latch_out),
        .module_data_in  (sw_342_module_data_in),
        .module_data_out (sw_342_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_342 (
        .io_in  (sw_342_module_data_in),
        .io_out (sw_342_module_data_out)
    );

    // [343] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_343_clk_out, sw_343_data_out, sw_343_scan_out, sw_343_latch_out;
    wire [7:0] sw_343_module_data_in;
    wire [7:0] sw_343_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_343 (
        .clk_in          (sw_342_clk_out),
        .data_in         (sw_342_data_out),
        .scan_select_in  (sw_342_scan_out),
        .latch_enable_in (sw_342_latch_out),
        .clk_out         (sw_343_clk_out),
        .data_out        (sw_343_data_out),
        .scan_select_out (sw_343_scan_out),
        .latch_enable_out(sw_343_latch_out),
        .module_data_in  (sw_343_module_data_in),
        .module_data_out (sw_343_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_343 (
        .io_in  (sw_343_module_data_in),
        .io_out (sw_343_module_data_out)
    );

    // [344] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_344_clk_out, sw_344_data_out, sw_344_scan_out, sw_344_latch_out;
    wire [7:0] sw_344_module_data_in;
    wire [7:0] sw_344_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_344 (
        .clk_in          (sw_343_clk_out),
        .data_in         (sw_343_data_out),
        .scan_select_in  (sw_343_scan_out),
        .latch_enable_in (sw_343_latch_out),
        .clk_out         (sw_344_clk_out),
        .data_out        (sw_344_data_out),
        .scan_select_out (sw_344_scan_out),
        .latch_enable_out(sw_344_latch_out),
        .module_data_in  (sw_344_module_data_in),
        .module_data_out (sw_344_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_344 (
        .io_in  (sw_344_module_data_in),
        .io_out (sw_344_module_data_out)
    );

    // [345] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_345_clk_out, sw_345_data_out, sw_345_scan_out, sw_345_latch_out;
    wire [7:0] sw_345_module_data_in;
    wire [7:0] sw_345_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_345 (
        .clk_in          (sw_344_clk_out),
        .data_in         (sw_344_data_out),
        .scan_select_in  (sw_344_scan_out),
        .latch_enable_in (sw_344_latch_out),
        .clk_out         (sw_345_clk_out),
        .data_out        (sw_345_data_out),
        .scan_select_out (sw_345_scan_out),
        .latch_enable_out(sw_345_latch_out),
        .module_data_in  (sw_345_module_data_in),
        .module_data_out (sw_345_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_345 (
        .io_in  (sw_345_module_data_in),
        .io_out (sw_345_module_data_out)
    );

    // [346] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_346_clk_out, sw_346_data_out, sw_346_scan_out, sw_346_latch_out;
    wire [7:0] sw_346_module_data_in;
    wire [7:0] sw_346_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_346 (
        .clk_in          (sw_345_clk_out),
        .data_in         (sw_345_data_out),
        .scan_select_in  (sw_345_scan_out),
        .latch_enable_in (sw_345_latch_out),
        .clk_out         (sw_346_clk_out),
        .data_out        (sw_346_data_out),
        .scan_select_out (sw_346_scan_out),
        .latch_enable_out(sw_346_latch_out),
        .module_data_in  (sw_346_module_data_in),
        .module_data_out (sw_346_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_346 (
        .io_in  (sw_346_module_data_in),
        .io_out (sw_346_module_data_out)
    );

    // [347] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_347_clk_out, sw_347_data_out, sw_347_scan_out, sw_347_latch_out;
    wire [7:0] sw_347_module_data_in;
    wire [7:0] sw_347_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_347 (
        .clk_in          (sw_346_clk_out),
        .data_in         (sw_346_data_out),
        .scan_select_in  (sw_346_scan_out),
        .latch_enable_in (sw_346_latch_out),
        .clk_out         (sw_347_clk_out),
        .data_out        (sw_347_data_out),
        .scan_select_out (sw_347_scan_out),
        .latch_enable_out(sw_347_latch_out),
        .module_data_in  (sw_347_module_data_in),
        .module_data_out (sw_347_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_347 (
        .io_in  (sw_347_module_data_in),
        .io_out (sw_347_module_data_out)
    );

    // [348] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_348_clk_out, sw_348_data_out, sw_348_scan_out, sw_348_latch_out;
    wire [7:0] sw_348_module_data_in;
    wire [7:0] sw_348_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_348 (
        .clk_in          (sw_347_clk_out),
        .data_in         (sw_347_data_out),
        .scan_select_in  (sw_347_scan_out),
        .latch_enable_in (sw_347_latch_out),
        .clk_out         (sw_348_clk_out),
        .data_out        (sw_348_data_out),
        .scan_select_out (sw_348_scan_out),
        .latch_enable_out(sw_348_latch_out),
        .module_data_in  (sw_348_module_data_in),
        .module_data_out (sw_348_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_348 (
        .io_in  (sw_348_module_data_in),
        .io_out (sw_348_module_data_out)
    );

    // [349] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_349_clk_out, sw_349_data_out, sw_349_scan_out, sw_349_latch_out;
    wire [7:0] sw_349_module_data_in;
    wire [7:0] sw_349_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_349 (
        .clk_in          (sw_348_clk_out),
        .data_in         (sw_348_data_out),
        .scan_select_in  (sw_348_scan_out),
        .latch_enable_in (sw_348_latch_out),
        .clk_out         (sw_349_clk_out),
        .data_out        (sw_349_data_out),
        .scan_select_out (sw_349_scan_out),
        .latch_enable_out(sw_349_latch_out),
        .module_data_in  (sw_349_module_data_in),
        .module_data_out (sw_349_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_349 (
        .io_in  (sw_349_module_data_in),
        .io_out (sw_349_module_data_out)
    );

    // [350] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_350_clk_out, sw_350_data_out, sw_350_scan_out, sw_350_latch_out;
    wire [7:0] sw_350_module_data_in;
    wire [7:0] sw_350_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_350 (
        .clk_in          (sw_349_clk_out),
        .data_in         (sw_349_data_out),
        .scan_select_in  (sw_349_scan_out),
        .latch_enable_in (sw_349_latch_out),
        .clk_out         (sw_350_clk_out),
        .data_out        (sw_350_data_out),
        .scan_select_out (sw_350_scan_out),
        .latch_enable_out(sw_350_latch_out),
        .module_data_in  (sw_350_module_data_in),
        .module_data_out (sw_350_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_350 (
        .io_in  (sw_350_module_data_in),
        .io_out (sw_350_module_data_out)
    );

    // [351] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_351_clk_out, sw_351_data_out, sw_351_scan_out, sw_351_latch_out;
    wire [7:0] sw_351_module_data_in;
    wire [7:0] sw_351_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_351 (
        .clk_in          (sw_350_clk_out),
        .data_in         (sw_350_data_out),
        .scan_select_in  (sw_350_scan_out),
        .latch_enable_in (sw_350_latch_out),
        .clk_out         (sw_351_clk_out),
        .data_out        (sw_351_data_out),
        .scan_select_out (sw_351_scan_out),
        .latch_enable_out(sw_351_latch_out),
        .module_data_in  (sw_351_module_data_in),
        .module_data_out (sw_351_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_351 (
        .io_in  (sw_351_module_data_in),
        .io_out (sw_351_module_data_out)
    );

    // [352] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_352_clk_out, sw_352_data_out, sw_352_scan_out, sw_352_latch_out;
    wire [7:0] sw_352_module_data_in;
    wire [7:0] sw_352_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_352 (
        .clk_in          (sw_351_clk_out),
        .data_in         (sw_351_data_out),
        .scan_select_in  (sw_351_scan_out),
        .latch_enable_in (sw_351_latch_out),
        .clk_out         (sw_352_clk_out),
        .data_out        (sw_352_data_out),
        .scan_select_out (sw_352_scan_out),
        .latch_enable_out(sw_352_latch_out),
        .module_data_in  (sw_352_module_data_in),
        .module_data_out (sw_352_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_352 (
        .io_in  (sw_352_module_data_in),
        .io_out (sw_352_module_data_out)
    );

    // [353] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_353_clk_out, sw_353_data_out, sw_353_scan_out, sw_353_latch_out;
    wire [7:0] sw_353_module_data_in;
    wire [7:0] sw_353_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_353 (
        .clk_in          (sw_352_clk_out),
        .data_in         (sw_352_data_out),
        .scan_select_in  (sw_352_scan_out),
        .latch_enable_in (sw_352_latch_out),
        .clk_out         (sw_353_clk_out),
        .data_out        (sw_353_data_out),
        .scan_select_out (sw_353_scan_out),
        .latch_enable_out(sw_353_latch_out),
        .module_data_in  (sw_353_module_data_in),
        .module_data_out (sw_353_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_353 (
        .io_in  (sw_353_module_data_in),
        .io_out (sw_353_module_data_out)
    );

    // [354] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_354_clk_out, sw_354_data_out, sw_354_scan_out, sw_354_latch_out;
    wire [7:0] sw_354_module_data_in;
    wire [7:0] sw_354_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_354 (
        .clk_in          (sw_353_clk_out),
        .data_in         (sw_353_data_out),
        .scan_select_in  (sw_353_scan_out),
        .latch_enable_in (sw_353_latch_out),
        .clk_out         (sw_354_clk_out),
        .data_out        (sw_354_data_out),
        .scan_select_out (sw_354_scan_out),
        .latch_enable_out(sw_354_latch_out),
        .module_data_in  (sw_354_module_data_in),
        .module_data_out (sw_354_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_354 (
        .io_in  (sw_354_module_data_in),
        .io_out (sw_354_module_data_out)
    );

    // [355] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_355_clk_out, sw_355_data_out, sw_355_scan_out, sw_355_latch_out;
    wire [7:0] sw_355_module_data_in;
    wire [7:0] sw_355_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_355 (
        .clk_in          (sw_354_clk_out),
        .data_in         (sw_354_data_out),
        .scan_select_in  (sw_354_scan_out),
        .latch_enable_in (sw_354_latch_out),
        .clk_out         (sw_355_clk_out),
        .data_out        (sw_355_data_out),
        .scan_select_out (sw_355_scan_out),
        .latch_enable_out(sw_355_latch_out),
        .module_data_in  (sw_355_module_data_in),
        .module_data_out (sw_355_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_355 (
        .io_in  (sw_355_module_data_in),
        .io_out (sw_355_module_data_out)
    );

    // [356] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_356_clk_out, sw_356_data_out, sw_356_scan_out, sw_356_latch_out;
    wire [7:0] sw_356_module_data_in;
    wire [7:0] sw_356_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_356 (
        .clk_in          (sw_355_clk_out),
        .data_in         (sw_355_data_out),
        .scan_select_in  (sw_355_scan_out),
        .latch_enable_in (sw_355_latch_out),
        .clk_out         (sw_356_clk_out),
        .data_out        (sw_356_data_out),
        .scan_select_out (sw_356_scan_out),
        .latch_enable_out(sw_356_latch_out),
        .module_data_in  (sw_356_module_data_in),
        .module_data_out (sw_356_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_356 (
        .io_in  (sw_356_module_data_in),
        .io_out (sw_356_module_data_out)
    );

    // [357] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_357_clk_out, sw_357_data_out, sw_357_scan_out, sw_357_latch_out;
    wire [7:0] sw_357_module_data_in;
    wire [7:0] sw_357_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_357 (
        .clk_in          (sw_356_clk_out),
        .data_in         (sw_356_data_out),
        .scan_select_in  (sw_356_scan_out),
        .latch_enable_in (sw_356_latch_out),
        .clk_out         (sw_357_clk_out),
        .data_out        (sw_357_data_out),
        .scan_select_out (sw_357_scan_out),
        .latch_enable_out(sw_357_latch_out),
        .module_data_in  (sw_357_module_data_in),
        .module_data_out (sw_357_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_357 (
        .io_in  (sw_357_module_data_in),
        .io_out (sw_357_module_data_out)
    );

    // [358] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_358_clk_out, sw_358_data_out, sw_358_scan_out, sw_358_latch_out;
    wire [7:0] sw_358_module_data_in;
    wire [7:0] sw_358_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_358 (
        .clk_in          (sw_357_clk_out),
        .data_in         (sw_357_data_out),
        .scan_select_in  (sw_357_scan_out),
        .latch_enable_in (sw_357_latch_out),
        .clk_out         (sw_358_clk_out),
        .data_out        (sw_358_data_out),
        .scan_select_out (sw_358_scan_out),
        .latch_enable_out(sw_358_latch_out),
        .module_data_in  (sw_358_module_data_in),
        .module_data_out (sw_358_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_358 (
        .io_in  (sw_358_module_data_in),
        .io_out (sw_358_module_data_out)
    );

    // [359] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_359_clk_out, sw_359_data_out, sw_359_scan_out, sw_359_latch_out;
    wire [7:0] sw_359_module_data_in;
    wire [7:0] sw_359_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_359 (
        .clk_in          (sw_358_clk_out),
        .data_in         (sw_358_data_out),
        .scan_select_in  (sw_358_scan_out),
        .latch_enable_in (sw_358_latch_out),
        .clk_out         (sw_359_clk_out),
        .data_out        (sw_359_data_out),
        .scan_select_out (sw_359_scan_out),
        .latch_enable_out(sw_359_latch_out),
        .module_data_in  (sw_359_module_data_in),
        .module_data_out (sw_359_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_359 (
        .io_in  (sw_359_module_data_in),
        .io_out (sw_359_module_data_out)
    );

    // [360] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_360_clk_out, sw_360_data_out, sw_360_scan_out, sw_360_latch_out;
    wire [7:0] sw_360_module_data_in;
    wire [7:0] sw_360_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_360 (
        .clk_in          (sw_359_clk_out),
        .data_in         (sw_359_data_out),
        .scan_select_in  (sw_359_scan_out),
        .latch_enable_in (sw_359_latch_out),
        .clk_out         (sw_360_clk_out),
        .data_out        (sw_360_data_out),
        .scan_select_out (sw_360_scan_out),
        .latch_enable_out(sw_360_latch_out),
        .module_data_in  (sw_360_module_data_in),
        .module_data_out (sw_360_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_360 (
        .io_in  (sw_360_module_data_in),
        .io_out (sw_360_module_data_out)
    );

    // [361] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_361_clk_out, sw_361_data_out, sw_361_scan_out, sw_361_latch_out;
    wire [7:0] sw_361_module_data_in;
    wire [7:0] sw_361_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_361 (
        .clk_in          (sw_360_clk_out),
        .data_in         (sw_360_data_out),
        .scan_select_in  (sw_360_scan_out),
        .latch_enable_in (sw_360_latch_out),
        .clk_out         (sw_361_clk_out),
        .data_out        (sw_361_data_out),
        .scan_select_out (sw_361_scan_out),
        .latch_enable_out(sw_361_latch_out),
        .module_data_in  (sw_361_module_data_in),
        .module_data_out (sw_361_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_361 (
        .io_in  (sw_361_module_data_in),
        .io_out (sw_361_module_data_out)
    );

    // [362] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_362_clk_out, sw_362_data_out, sw_362_scan_out, sw_362_latch_out;
    wire [7:0] sw_362_module_data_in;
    wire [7:0] sw_362_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_362 (
        .clk_in          (sw_361_clk_out),
        .data_in         (sw_361_data_out),
        .scan_select_in  (sw_361_scan_out),
        .latch_enable_in (sw_361_latch_out),
        .clk_out         (sw_362_clk_out),
        .data_out        (sw_362_data_out),
        .scan_select_out (sw_362_scan_out),
        .latch_enable_out(sw_362_latch_out),
        .module_data_in  (sw_362_module_data_in),
        .module_data_out (sw_362_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_362 (
        .io_in  (sw_362_module_data_in),
        .io_out (sw_362_module_data_out)
    );

    // [363] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_363_clk_out, sw_363_data_out, sw_363_scan_out, sw_363_latch_out;
    wire [7:0] sw_363_module_data_in;
    wire [7:0] sw_363_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_363 (
        .clk_in          (sw_362_clk_out),
        .data_in         (sw_362_data_out),
        .scan_select_in  (sw_362_scan_out),
        .latch_enable_in (sw_362_latch_out),
        .clk_out         (sw_363_clk_out),
        .data_out        (sw_363_data_out),
        .scan_select_out (sw_363_scan_out),
        .latch_enable_out(sw_363_latch_out),
        .module_data_in  (sw_363_module_data_in),
        .module_data_out (sw_363_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_363 (
        .io_in  (sw_363_module_data_in),
        .io_out (sw_363_module_data_out)
    );

    // [364] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_364_clk_out, sw_364_data_out, sw_364_scan_out, sw_364_latch_out;
    wire [7:0] sw_364_module_data_in;
    wire [7:0] sw_364_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_364 (
        .clk_in          (sw_363_clk_out),
        .data_in         (sw_363_data_out),
        .scan_select_in  (sw_363_scan_out),
        .latch_enable_in (sw_363_latch_out),
        .clk_out         (sw_364_clk_out),
        .data_out        (sw_364_data_out),
        .scan_select_out (sw_364_scan_out),
        .latch_enable_out(sw_364_latch_out),
        .module_data_in  (sw_364_module_data_in),
        .module_data_out (sw_364_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_364 (
        .io_in  (sw_364_module_data_in),
        .io_out (sw_364_module_data_out)
    );

    // [365] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_365_clk_out, sw_365_data_out, sw_365_scan_out, sw_365_latch_out;
    wire [7:0] sw_365_module_data_in;
    wire [7:0] sw_365_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_365 (
        .clk_in          (sw_364_clk_out),
        .data_in         (sw_364_data_out),
        .scan_select_in  (sw_364_scan_out),
        .latch_enable_in (sw_364_latch_out),
        .clk_out         (sw_365_clk_out),
        .data_out        (sw_365_data_out),
        .scan_select_out (sw_365_scan_out),
        .latch_enable_out(sw_365_latch_out),
        .module_data_in  (sw_365_module_data_in),
        .module_data_out (sw_365_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_365 (
        .io_in  (sw_365_module_data_in),
        .io_out (sw_365_module_data_out)
    );

    // [366] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_366_clk_out, sw_366_data_out, sw_366_scan_out, sw_366_latch_out;
    wire [7:0] sw_366_module_data_in;
    wire [7:0] sw_366_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_366 (
        .clk_in          (sw_365_clk_out),
        .data_in         (sw_365_data_out),
        .scan_select_in  (sw_365_scan_out),
        .latch_enable_in (sw_365_latch_out),
        .clk_out         (sw_366_clk_out),
        .data_out        (sw_366_data_out),
        .scan_select_out (sw_366_scan_out),
        .latch_enable_out(sw_366_latch_out),
        .module_data_in  (sw_366_module_data_in),
        .module_data_out (sw_366_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_366 (
        .io_in  (sw_366_module_data_in),
        .io_out (sw_366_module_data_out)
    );

    // [367] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_367_clk_out, sw_367_data_out, sw_367_scan_out, sw_367_latch_out;
    wire [7:0] sw_367_module_data_in;
    wire [7:0] sw_367_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_367 (
        .clk_in          (sw_366_clk_out),
        .data_in         (sw_366_data_out),
        .scan_select_in  (sw_366_scan_out),
        .latch_enable_in (sw_366_latch_out),
        .clk_out         (sw_367_clk_out),
        .data_out        (sw_367_data_out),
        .scan_select_out (sw_367_scan_out),
        .latch_enable_out(sw_367_latch_out),
        .module_data_in  (sw_367_module_data_in),
        .module_data_out (sw_367_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_367 (
        .io_in  (sw_367_module_data_in),
        .io_out (sw_367_module_data_out)
    );

    // [368] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_368_clk_out, sw_368_data_out, sw_368_scan_out, sw_368_latch_out;
    wire [7:0] sw_368_module_data_in;
    wire [7:0] sw_368_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_368 (
        .clk_in          (sw_367_clk_out),
        .data_in         (sw_367_data_out),
        .scan_select_in  (sw_367_scan_out),
        .latch_enable_in (sw_367_latch_out),
        .clk_out         (sw_368_clk_out),
        .data_out        (sw_368_data_out),
        .scan_select_out (sw_368_scan_out),
        .latch_enable_out(sw_368_latch_out),
        .module_data_in  (sw_368_module_data_in),
        .module_data_out (sw_368_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_368 (
        .io_in  (sw_368_module_data_in),
        .io_out (sw_368_module_data_out)
    );

    // [369] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_369_clk_out, sw_369_data_out, sw_369_scan_out, sw_369_latch_out;
    wire [7:0] sw_369_module_data_in;
    wire [7:0] sw_369_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_369 (
        .clk_in          (sw_368_clk_out),
        .data_in         (sw_368_data_out),
        .scan_select_in  (sw_368_scan_out),
        .latch_enable_in (sw_368_latch_out),
        .clk_out         (sw_369_clk_out),
        .data_out        (sw_369_data_out),
        .scan_select_out (sw_369_scan_out),
        .latch_enable_out(sw_369_latch_out),
        .module_data_in  (sw_369_module_data_in),
        .module_data_out (sw_369_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_369 (
        .io_in  (sw_369_module_data_in),
        .io_out (sw_369_module_data_out)
    );

    // [370] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_370_clk_out, sw_370_data_out, sw_370_scan_out, sw_370_latch_out;
    wire [7:0] sw_370_module_data_in;
    wire [7:0] sw_370_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_370 (
        .clk_in          (sw_369_clk_out),
        .data_in         (sw_369_data_out),
        .scan_select_in  (sw_369_scan_out),
        .latch_enable_in (sw_369_latch_out),
        .clk_out         (sw_370_clk_out),
        .data_out        (sw_370_data_out),
        .scan_select_out (sw_370_scan_out),
        .latch_enable_out(sw_370_latch_out),
        .module_data_in  (sw_370_module_data_in),
        .module_data_out (sw_370_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_370 (
        .io_in  (sw_370_module_data_in),
        .io_out (sw_370_module_data_out)
    );

    // [371] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_371_clk_out, sw_371_data_out, sw_371_scan_out, sw_371_latch_out;
    wire [7:0] sw_371_module_data_in;
    wire [7:0] sw_371_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_371 (
        .clk_in          (sw_370_clk_out),
        .data_in         (sw_370_data_out),
        .scan_select_in  (sw_370_scan_out),
        .latch_enable_in (sw_370_latch_out),
        .clk_out         (sw_371_clk_out),
        .data_out        (sw_371_data_out),
        .scan_select_out (sw_371_scan_out),
        .latch_enable_out(sw_371_latch_out),
        .module_data_in  (sw_371_module_data_in),
        .module_data_out (sw_371_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_371 (
        .io_in  (sw_371_module_data_in),
        .io_out (sw_371_module_data_out)
    );

    // [372] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_372_clk_out, sw_372_data_out, sw_372_scan_out, sw_372_latch_out;
    wire [7:0] sw_372_module_data_in;
    wire [7:0] sw_372_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_372 (
        .clk_in          (sw_371_clk_out),
        .data_in         (sw_371_data_out),
        .scan_select_in  (sw_371_scan_out),
        .latch_enable_in (sw_371_latch_out),
        .clk_out         (sw_372_clk_out),
        .data_out        (sw_372_data_out),
        .scan_select_out (sw_372_scan_out),
        .latch_enable_out(sw_372_latch_out),
        .module_data_in  (sw_372_module_data_in),
        .module_data_out (sw_372_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_372 (
        .io_in  (sw_372_module_data_in),
        .io_out (sw_372_module_data_out)
    );

    // [373] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_373_clk_out, sw_373_data_out, sw_373_scan_out, sw_373_latch_out;
    wire [7:0] sw_373_module_data_in;
    wire [7:0] sw_373_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_373 (
        .clk_in          (sw_372_clk_out),
        .data_in         (sw_372_data_out),
        .scan_select_in  (sw_372_scan_out),
        .latch_enable_in (sw_372_latch_out),
        .clk_out         (sw_373_clk_out),
        .data_out        (sw_373_data_out),
        .scan_select_out (sw_373_scan_out),
        .latch_enable_out(sw_373_latch_out),
        .module_data_in  (sw_373_module_data_in),
        .module_data_out (sw_373_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_373 (
        .io_in  (sw_373_module_data_in),
        .io_out (sw_373_module_data_out)
    );

    // [374] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_374_clk_out, sw_374_data_out, sw_374_scan_out, sw_374_latch_out;
    wire [7:0] sw_374_module_data_in;
    wire [7:0] sw_374_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_374 (
        .clk_in          (sw_373_clk_out),
        .data_in         (sw_373_data_out),
        .scan_select_in  (sw_373_scan_out),
        .latch_enable_in (sw_373_latch_out),
        .clk_out         (sw_374_clk_out),
        .data_out        (sw_374_data_out),
        .scan_select_out (sw_374_scan_out),
        .latch_enable_out(sw_374_latch_out),
        .module_data_in  (sw_374_module_data_in),
        .module_data_out (sw_374_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_374 (
        .io_in  (sw_374_module_data_in),
        .io_out (sw_374_module_data_out)
    );

    // [375] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_375_clk_out, sw_375_data_out, sw_375_scan_out, sw_375_latch_out;
    wire [7:0] sw_375_module_data_in;
    wire [7:0] sw_375_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_375 (
        .clk_in          (sw_374_clk_out),
        .data_in         (sw_374_data_out),
        .scan_select_in  (sw_374_scan_out),
        .latch_enable_in (sw_374_latch_out),
        .clk_out         (sw_375_clk_out),
        .data_out        (sw_375_data_out),
        .scan_select_out (sw_375_scan_out),
        .latch_enable_out(sw_375_latch_out),
        .module_data_in  (sw_375_module_data_in),
        .module_data_out (sw_375_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_375 (
        .io_in  (sw_375_module_data_in),
        .io_out (sw_375_module_data_out)
    );

    // [376] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_376_clk_out, sw_376_data_out, sw_376_scan_out, sw_376_latch_out;
    wire [7:0] sw_376_module_data_in;
    wire [7:0] sw_376_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_376 (
        .clk_in          (sw_375_clk_out),
        .data_in         (sw_375_data_out),
        .scan_select_in  (sw_375_scan_out),
        .latch_enable_in (sw_375_latch_out),
        .clk_out         (sw_376_clk_out),
        .data_out        (sw_376_data_out),
        .scan_select_out (sw_376_scan_out),
        .latch_enable_out(sw_376_latch_out),
        .module_data_in  (sw_376_module_data_in),
        .module_data_out (sw_376_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_376 (
        .io_in  (sw_376_module_data_in),
        .io_out (sw_376_module_data_out)
    );

    // [377] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_377_clk_out, sw_377_data_out, sw_377_scan_out, sw_377_latch_out;
    wire [7:0] sw_377_module_data_in;
    wire [7:0] sw_377_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_377 (
        .clk_in          (sw_376_clk_out),
        .data_in         (sw_376_data_out),
        .scan_select_in  (sw_376_scan_out),
        .latch_enable_in (sw_376_latch_out),
        .clk_out         (sw_377_clk_out),
        .data_out        (sw_377_data_out),
        .scan_select_out (sw_377_scan_out),
        .latch_enable_out(sw_377_latch_out),
        .module_data_in  (sw_377_module_data_in),
        .module_data_out (sw_377_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_377 (
        .io_in  (sw_377_module_data_in),
        .io_out (sw_377_module_data_out)
    );

    // [378] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_378_clk_out, sw_378_data_out, sw_378_scan_out, sw_378_latch_out;
    wire [7:0] sw_378_module_data_in;
    wire [7:0] sw_378_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_378 (
        .clk_in          (sw_377_clk_out),
        .data_in         (sw_377_data_out),
        .scan_select_in  (sw_377_scan_out),
        .latch_enable_in (sw_377_latch_out),
        .clk_out         (sw_378_clk_out),
        .data_out        (sw_378_data_out),
        .scan_select_out (sw_378_scan_out),
        .latch_enable_out(sw_378_latch_out),
        .module_data_in  (sw_378_module_data_in),
        .module_data_out (sw_378_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_378 (
        .io_in  (sw_378_module_data_in),
        .io_out (sw_378_module_data_out)
    );

    // [379] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_379_clk_out, sw_379_data_out, sw_379_scan_out, sw_379_latch_out;
    wire [7:0] sw_379_module_data_in;
    wire [7:0] sw_379_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_379 (
        .clk_in          (sw_378_clk_out),
        .data_in         (sw_378_data_out),
        .scan_select_in  (sw_378_scan_out),
        .latch_enable_in (sw_378_latch_out),
        .clk_out         (sw_379_clk_out),
        .data_out        (sw_379_data_out),
        .scan_select_out (sw_379_scan_out),
        .latch_enable_out(sw_379_latch_out),
        .module_data_in  (sw_379_module_data_in),
        .module_data_out (sw_379_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_379 (
        .io_in  (sw_379_module_data_in),
        .io_out (sw_379_module_data_out)
    );

    // [380] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_380_clk_out, sw_380_data_out, sw_380_scan_out, sw_380_latch_out;
    wire [7:0] sw_380_module_data_in;
    wire [7:0] sw_380_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_380 (
        .clk_in          (sw_379_clk_out),
        .data_in         (sw_379_data_out),
        .scan_select_in  (sw_379_scan_out),
        .latch_enable_in (sw_379_latch_out),
        .clk_out         (sw_380_clk_out),
        .data_out        (sw_380_data_out),
        .scan_select_out (sw_380_scan_out),
        .latch_enable_out(sw_380_latch_out),
        .module_data_in  (sw_380_module_data_in),
        .module_data_out (sw_380_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_380 (
        .io_in  (sw_380_module_data_in),
        .io_out (sw_380_module_data_out)
    );

    // [381] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_381_clk_out, sw_381_data_out, sw_381_scan_out, sw_381_latch_out;
    wire [7:0] sw_381_module_data_in;
    wire [7:0] sw_381_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_381 (
        .clk_in          (sw_380_clk_out),
        .data_in         (sw_380_data_out),
        .scan_select_in  (sw_380_scan_out),
        .latch_enable_in (sw_380_latch_out),
        .clk_out         (sw_381_clk_out),
        .data_out        (sw_381_data_out),
        .scan_select_out (sw_381_scan_out),
        .latch_enable_out(sw_381_latch_out),
        .module_data_in  (sw_381_module_data_in),
        .module_data_out (sw_381_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_381 (
        .io_in  (sw_381_module_data_in),
        .io_out (sw_381_module_data_out)
    );

    // [382] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_382_clk_out, sw_382_data_out, sw_382_scan_out, sw_382_latch_out;
    wire [7:0] sw_382_module_data_in;
    wire [7:0] sw_382_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_382 (
        .clk_in          (sw_381_clk_out),
        .data_in         (sw_381_data_out),
        .scan_select_in  (sw_381_scan_out),
        .latch_enable_in (sw_381_latch_out),
        .clk_out         (sw_382_clk_out),
        .data_out        (sw_382_data_out),
        .scan_select_out (sw_382_scan_out),
        .latch_enable_out(sw_382_latch_out),
        .module_data_in  (sw_382_module_data_in),
        .module_data_out (sw_382_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_382 (
        .io_in  (sw_382_module_data_in),
        .io_out (sw_382_module_data_out)
    );

    // [383] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_383_clk_out, sw_383_data_out, sw_383_scan_out, sw_383_latch_out;
    wire [7:0] sw_383_module_data_in;
    wire [7:0] sw_383_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_383 (
        .clk_in          (sw_382_clk_out),
        .data_in         (sw_382_data_out),
        .scan_select_in  (sw_382_scan_out),
        .latch_enable_in (sw_382_latch_out),
        .clk_out         (sw_383_clk_out),
        .data_out        (sw_383_data_out),
        .scan_select_out (sw_383_scan_out),
        .latch_enable_out(sw_383_latch_out),
        .module_data_in  (sw_383_module_data_in),
        .module_data_out (sw_383_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_383 (
        .io_in  (sw_383_module_data_in),
        .io_out (sw_383_module_data_out)
    );

    // [384] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_384_clk_out, sw_384_data_out, sw_384_scan_out, sw_384_latch_out;
    wire [7:0] sw_384_module_data_in;
    wire [7:0] sw_384_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_384 (
        .clk_in          (sw_383_clk_out),
        .data_in         (sw_383_data_out),
        .scan_select_in  (sw_383_scan_out),
        .latch_enable_in (sw_383_latch_out),
        .clk_out         (sw_384_clk_out),
        .data_out        (sw_384_data_out),
        .scan_select_out (sw_384_scan_out),
        .latch_enable_out(sw_384_latch_out),
        .module_data_in  (sw_384_module_data_in),
        .module_data_out (sw_384_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_384 (
        .io_in  (sw_384_module_data_in),
        .io_out (sw_384_module_data_out)
    );

    // [385] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_385_clk_out, sw_385_data_out, sw_385_scan_out, sw_385_latch_out;
    wire [7:0] sw_385_module_data_in;
    wire [7:0] sw_385_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_385 (
        .clk_in          (sw_384_clk_out),
        .data_in         (sw_384_data_out),
        .scan_select_in  (sw_384_scan_out),
        .latch_enable_in (sw_384_latch_out),
        .clk_out         (sw_385_clk_out),
        .data_out        (sw_385_data_out),
        .scan_select_out (sw_385_scan_out),
        .latch_enable_out(sw_385_latch_out),
        .module_data_in  (sw_385_module_data_in),
        .module_data_out (sw_385_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_385 (
        .io_in  (sw_385_module_data_in),
        .io_out (sw_385_module_data_out)
    );

    // [386] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_386_clk_out, sw_386_data_out, sw_386_scan_out, sw_386_latch_out;
    wire [7:0] sw_386_module_data_in;
    wire [7:0] sw_386_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_386 (
        .clk_in          (sw_385_clk_out),
        .data_in         (sw_385_data_out),
        .scan_select_in  (sw_385_scan_out),
        .latch_enable_in (sw_385_latch_out),
        .clk_out         (sw_386_clk_out),
        .data_out        (sw_386_data_out),
        .scan_select_out (sw_386_scan_out),
        .latch_enable_out(sw_386_latch_out),
        .module_data_in  (sw_386_module_data_in),
        .module_data_out (sw_386_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_386 (
        .io_in  (sw_386_module_data_in),
        .io_out (sw_386_module_data_out)
    );

    // [387] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_387_clk_out, sw_387_data_out, sw_387_scan_out, sw_387_latch_out;
    wire [7:0] sw_387_module_data_in;
    wire [7:0] sw_387_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_387 (
        .clk_in          (sw_386_clk_out),
        .data_in         (sw_386_data_out),
        .scan_select_in  (sw_386_scan_out),
        .latch_enable_in (sw_386_latch_out),
        .clk_out         (sw_387_clk_out),
        .data_out        (sw_387_data_out),
        .scan_select_out (sw_387_scan_out),
        .latch_enable_out(sw_387_latch_out),
        .module_data_in  (sw_387_module_data_in),
        .module_data_out (sw_387_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_387 (
        .io_in  (sw_387_module_data_in),
        .io_out (sw_387_module_data_out)
    );

    // [388] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_388_clk_out, sw_388_data_out, sw_388_scan_out, sw_388_latch_out;
    wire [7:0] sw_388_module_data_in;
    wire [7:0] sw_388_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_388 (
        .clk_in          (sw_387_clk_out),
        .data_in         (sw_387_data_out),
        .scan_select_in  (sw_387_scan_out),
        .latch_enable_in (sw_387_latch_out),
        .clk_out         (sw_388_clk_out),
        .data_out        (sw_388_data_out),
        .scan_select_out (sw_388_scan_out),
        .latch_enable_out(sw_388_latch_out),
        .module_data_in  (sw_388_module_data_in),
        .module_data_out (sw_388_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_388 (
        .io_in  (sw_388_module_data_in),
        .io_out (sw_388_module_data_out)
    );

    // [389] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_389_clk_out, sw_389_data_out, sw_389_scan_out, sw_389_latch_out;
    wire [7:0] sw_389_module_data_in;
    wire [7:0] sw_389_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_389 (
        .clk_in          (sw_388_clk_out),
        .data_in         (sw_388_data_out),
        .scan_select_in  (sw_388_scan_out),
        .latch_enable_in (sw_388_latch_out),
        .clk_out         (sw_389_clk_out),
        .data_out        (sw_389_data_out),
        .scan_select_out (sw_389_scan_out),
        .latch_enable_out(sw_389_latch_out),
        .module_data_in  (sw_389_module_data_in),
        .module_data_out (sw_389_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_389 (
        .io_in  (sw_389_module_data_in),
        .io_out (sw_389_module_data_out)
    );

    // [390] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_390_clk_out, sw_390_data_out, sw_390_scan_out, sw_390_latch_out;
    wire [7:0] sw_390_module_data_in;
    wire [7:0] sw_390_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_390 (
        .clk_in          (sw_389_clk_out),
        .data_in         (sw_389_data_out),
        .scan_select_in  (sw_389_scan_out),
        .latch_enable_in (sw_389_latch_out),
        .clk_out         (sw_390_clk_out),
        .data_out        (sw_390_data_out),
        .scan_select_out (sw_390_scan_out),
        .latch_enable_out(sw_390_latch_out),
        .module_data_in  (sw_390_module_data_in),
        .module_data_out (sw_390_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_390 (
        .io_in  (sw_390_module_data_in),
        .io_out (sw_390_module_data_out)
    );

    // [391] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_391_clk_out, sw_391_data_out, sw_391_scan_out, sw_391_latch_out;
    wire [7:0] sw_391_module_data_in;
    wire [7:0] sw_391_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_391 (
        .clk_in          (sw_390_clk_out),
        .data_in         (sw_390_data_out),
        .scan_select_in  (sw_390_scan_out),
        .latch_enable_in (sw_390_latch_out),
        .clk_out         (sw_391_clk_out),
        .data_out        (sw_391_data_out),
        .scan_select_out (sw_391_scan_out),
        .latch_enable_out(sw_391_latch_out),
        .module_data_in  (sw_391_module_data_in),
        .module_data_out (sw_391_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_391 (
        .io_in  (sw_391_module_data_in),
        .io_out (sw_391_module_data_out)
    );

    // [392] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_392_clk_out, sw_392_data_out, sw_392_scan_out, sw_392_latch_out;
    wire [7:0] sw_392_module_data_in;
    wire [7:0] sw_392_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_392 (
        .clk_in          (sw_391_clk_out),
        .data_in         (sw_391_data_out),
        .scan_select_in  (sw_391_scan_out),
        .latch_enable_in (sw_391_latch_out),
        .clk_out         (sw_392_clk_out),
        .data_out        (sw_392_data_out),
        .scan_select_out (sw_392_scan_out),
        .latch_enable_out(sw_392_latch_out),
        .module_data_in  (sw_392_module_data_in),
        .module_data_out (sw_392_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_392 (
        .io_in  (sw_392_module_data_in),
        .io_out (sw_392_module_data_out)
    );

    // [393] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_393_clk_out, sw_393_data_out, sw_393_scan_out, sw_393_latch_out;
    wire [7:0] sw_393_module_data_in;
    wire [7:0] sw_393_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_393 (
        .clk_in          (sw_392_clk_out),
        .data_in         (sw_392_data_out),
        .scan_select_in  (sw_392_scan_out),
        .latch_enable_in (sw_392_latch_out),
        .clk_out         (sw_393_clk_out),
        .data_out        (sw_393_data_out),
        .scan_select_out (sw_393_scan_out),
        .latch_enable_out(sw_393_latch_out),
        .module_data_in  (sw_393_module_data_in),
        .module_data_out (sw_393_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_393 (
        .io_in  (sw_393_module_data_in),
        .io_out (sw_393_module_data_out)
    );

    // [394] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_394_clk_out, sw_394_data_out, sw_394_scan_out, sw_394_latch_out;
    wire [7:0] sw_394_module_data_in;
    wire [7:0] sw_394_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_394 (
        .clk_in          (sw_393_clk_out),
        .data_in         (sw_393_data_out),
        .scan_select_in  (sw_393_scan_out),
        .latch_enable_in (sw_393_latch_out),
        .clk_out         (sw_394_clk_out),
        .data_out        (sw_394_data_out),
        .scan_select_out (sw_394_scan_out),
        .latch_enable_out(sw_394_latch_out),
        .module_data_in  (sw_394_module_data_in),
        .module_data_out (sw_394_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_394 (
        .io_in  (sw_394_module_data_in),
        .io_out (sw_394_module_data_out)
    );

    // [395] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_395_clk_out, sw_395_data_out, sw_395_scan_out, sw_395_latch_out;
    wire [7:0] sw_395_module_data_in;
    wire [7:0] sw_395_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_395 (
        .clk_in          (sw_394_clk_out),
        .data_in         (sw_394_data_out),
        .scan_select_in  (sw_394_scan_out),
        .latch_enable_in (sw_394_latch_out),
        .clk_out         (sw_395_clk_out),
        .data_out        (sw_395_data_out),
        .scan_select_out (sw_395_scan_out),
        .latch_enable_out(sw_395_latch_out),
        .module_data_in  (sw_395_module_data_in),
        .module_data_out (sw_395_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_395 (
        .io_in  (sw_395_module_data_in),
        .io_out (sw_395_module_data_out)
    );

    // [396] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_396_clk_out, sw_396_data_out, sw_396_scan_out, sw_396_latch_out;
    wire [7:0] sw_396_module_data_in;
    wire [7:0] sw_396_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_396 (
        .clk_in          (sw_395_clk_out),
        .data_in         (sw_395_data_out),
        .scan_select_in  (sw_395_scan_out),
        .latch_enable_in (sw_395_latch_out),
        .clk_out         (sw_396_clk_out),
        .data_out        (sw_396_data_out),
        .scan_select_out (sw_396_scan_out),
        .latch_enable_out(sw_396_latch_out),
        .module_data_in  (sw_396_module_data_in),
        .module_data_out (sw_396_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_396 (
        .io_in  (sw_396_module_data_in),
        .io_out (sw_396_module_data_out)
    );

    // [397] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_397_clk_out, sw_397_data_out, sw_397_scan_out, sw_397_latch_out;
    wire [7:0] sw_397_module_data_in;
    wire [7:0] sw_397_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_397 (
        .clk_in          (sw_396_clk_out),
        .data_in         (sw_396_data_out),
        .scan_select_in  (sw_396_scan_out),
        .latch_enable_in (sw_396_latch_out),
        .clk_out         (sw_397_clk_out),
        .data_out        (sw_397_data_out),
        .scan_select_out (sw_397_scan_out),
        .latch_enable_out(sw_397_latch_out),
        .module_data_in  (sw_397_module_data_in),
        .module_data_out (sw_397_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_397 (
        .io_in  (sw_397_module_data_in),
        .io_out (sw_397_module_data_out)
    );

    // [398] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_398_clk_out, sw_398_data_out, sw_398_scan_out, sw_398_latch_out;
    wire [7:0] sw_398_module_data_in;
    wire [7:0] sw_398_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_398 (
        .clk_in          (sw_397_clk_out),
        .data_in         (sw_397_data_out),
        .scan_select_in  (sw_397_scan_out),
        .latch_enable_in (sw_397_latch_out),
        .clk_out         (sw_398_clk_out),
        .data_out        (sw_398_data_out),
        .scan_select_out (sw_398_scan_out),
        .latch_enable_out(sw_398_latch_out),
        .module_data_in  (sw_398_module_data_in),
        .module_data_out (sw_398_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_398 (
        .io_in  (sw_398_module_data_in),
        .io_out (sw_398_module_data_out)
    );

    // [399] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_399_clk_out, sw_399_data_out, sw_399_scan_out, sw_399_latch_out;
    wire [7:0] sw_399_module_data_in;
    wire [7:0] sw_399_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_399 (
        .clk_in          (sw_398_clk_out),
        .data_in         (sw_398_data_out),
        .scan_select_in  (sw_398_scan_out),
        .latch_enable_in (sw_398_latch_out),
        .clk_out         (sw_399_clk_out),
        .data_out        (sw_399_data_out),
        .scan_select_out (sw_399_scan_out),
        .latch_enable_out(sw_399_latch_out),
        .module_data_in  (sw_399_module_data_in),
        .module_data_out (sw_399_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_399 (
        .io_in  (sw_399_module_data_in),
        .io_out (sw_399_module_data_out)
    );

    // [400] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_400_clk_out, sw_400_data_out, sw_400_scan_out, sw_400_latch_out;
    wire [7:0] sw_400_module_data_in;
    wire [7:0] sw_400_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_400 (
        .clk_in          (sw_399_clk_out),
        .data_in         (sw_399_data_out),
        .scan_select_in  (sw_399_scan_out),
        .latch_enable_in (sw_399_latch_out),
        .clk_out         (sw_400_clk_out),
        .data_out        (sw_400_data_out),
        .scan_select_out (sw_400_scan_out),
        .latch_enable_out(sw_400_latch_out),
        .module_data_in  (sw_400_module_data_in),
        .module_data_out (sw_400_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_400 (
        .io_in  (sw_400_module_data_in),
        .io_out (sw_400_module_data_out)
    );

    // [401] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_401_clk_out, sw_401_data_out, sw_401_scan_out, sw_401_latch_out;
    wire [7:0] sw_401_module_data_in;
    wire [7:0] sw_401_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_401 (
        .clk_in          (sw_400_clk_out),
        .data_in         (sw_400_data_out),
        .scan_select_in  (sw_400_scan_out),
        .latch_enable_in (sw_400_latch_out),
        .clk_out         (sw_401_clk_out),
        .data_out        (sw_401_data_out),
        .scan_select_out (sw_401_scan_out),
        .latch_enable_out(sw_401_latch_out),
        .module_data_in  (sw_401_module_data_in),
        .module_data_out (sw_401_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_401 (
        .io_in  (sw_401_module_data_in),
        .io_out (sw_401_module_data_out)
    );

    // [402] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_402_clk_out, sw_402_data_out, sw_402_scan_out, sw_402_latch_out;
    wire [7:0] sw_402_module_data_in;
    wire [7:0] sw_402_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_402 (
        .clk_in          (sw_401_clk_out),
        .data_in         (sw_401_data_out),
        .scan_select_in  (sw_401_scan_out),
        .latch_enable_in (sw_401_latch_out),
        .clk_out         (sw_402_clk_out),
        .data_out        (sw_402_data_out),
        .scan_select_out (sw_402_scan_out),
        .latch_enable_out(sw_402_latch_out),
        .module_data_in  (sw_402_module_data_in),
        .module_data_out (sw_402_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_402 (
        .io_in  (sw_402_module_data_in),
        .io_out (sw_402_module_data_out)
    );

    // [403] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_403_clk_out, sw_403_data_out, sw_403_scan_out, sw_403_latch_out;
    wire [7:0] sw_403_module_data_in;
    wire [7:0] sw_403_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_403 (
        .clk_in          (sw_402_clk_out),
        .data_in         (sw_402_data_out),
        .scan_select_in  (sw_402_scan_out),
        .latch_enable_in (sw_402_latch_out),
        .clk_out         (sw_403_clk_out),
        .data_out        (sw_403_data_out),
        .scan_select_out (sw_403_scan_out),
        .latch_enable_out(sw_403_latch_out),
        .module_data_in  (sw_403_module_data_in),
        .module_data_out (sw_403_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_403 (
        .io_in  (sw_403_module_data_in),
        .io_out (sw_403_module_data_out)
    );

    // [404] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_404_clk_out, sw_404_data_out, sw_404_scan_out, sw_404_latch_out;
    wire [7:0] sw_404_module_data_in;
    wire [7:0] sw_404_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_404 (
        .clk_in          (sw_403_clk_out),
        .data_in         (sw_403_data_out),
        .scan_select_in  (sw_403_scan_out),
        .latch_enable_in (sw_403_latch_out),
        .clk_out         (sw_404_clk_out),
        .data_out        (sw_404_data_out),
        .scan_select_out (sw_404_scan_out),
        .latch_enable_out(sw_404_latch_out),
        .module_data_in  (sw_404_module_data_in),
        .module_data_out (sw_404_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_404 (
        .io_in  (sw_404_module_data_in),
        .io_out (sw_404_module_data_out)
    );

    // [405] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_405_clk_out, sw_405_data_out, sw_405_scan_out, sw_405_latch_out;
    wire [7:0] sw_405_module_data_in;
    wire [7:0] sw_405_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_405 (
        .clk_in          (sw_404_clk_out),
        .data_in         (sw_404_data_out),
        .scan_select_in  (sw_404_scan_out),
        .latch_enable_in (sw_404_latch_out),
        .clk_out         (sw_405_clk_out),
        .data_out        (sw_405_data_out),
        .scan_select_out (sw_405_scan_out),
        .latch_enable_out(sw_405_latch_out),
        .module_data_in  (sw_405_module_data_in),
        .module_data_out (sw_405_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_405 (
        .io_in  (sw_405_module_data_in),
        .io_out (sw_405_module_data_out)
    );

    // [406] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_406_clk_out, sw_406_data_out, sw_406_scan_out, sw_406_latch_out;
    wire [7:0] sw_406_module_data_in;
    wire [7:0] sw_406_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_406 (
        .clk_in          (sw_405_clk_out),
        .data_in         (sw_405_data_out),
        .scan_select_in  (sw_405_scan_out),
        .latch_enable_in (sw_405_latch_out),
        .clk_out         (sw_406_clk_out),
        .data_out        (sw_406_data_out),
        .scan_select_out (sw_406_scan_out),
        .latch_enable_out(sw_406_latch_out),
        .module_data_in  (sw_406_module_data_in),
        .module_data_out (sw_406_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_406 (
        .io_in  (sw_406_module_data_in),
        .io_out (sw_406_module_data_out)
    );

    // [407] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_407_clk_out, sw_407_data_out, sw_407_scan_out, sw_407_latch_out;
    wire [7:0] sw_407_module_data_in;
    wire [7:0] sw_407_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_407 (
        .clk_in          (sw_406_clk_out),
        .data_in         (sw_406_data_out),
        .scan_select_in  (sw_406_scan_out),
        .latch_enable_in (sw_406_latch_out),
        .clk_out         (sw_407_clk_out),
        .data_out        (sw_407_data_out),
        .scan_select_out (sw_407_scan_out),
        .latch_enable_out(sw_407_latch_out),
        .module_data_in  (sw_407_module_data_in),
        .module_data_out (sw_407_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_407 (
        .io_in  (sw_407_module_data_in),
        .io_out (sw_407_module_data_out)
    );

    // [408] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_408_clk_out, sw_408_data_out, sw_408_scan_out, sw_408_latch_out;
    wire [7:0] sw_408_module_data_in;
    wire [7:0] sw_408_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_408 (
        .clk_in          (sw_407_clk_out),
        .data_in         (sw_407_data_out),
        .scan_select_in  (sw_407_scan_out),
        .latch_enable_in (sw_407_latch_out),
        .clk_out         (sw_408_clk_out),
        .data_out        (sw_408_data_out),
        .scan_select_out (sw_408_scan_out),
        .latch_enable_out(sw_408_latch_out),
        .module_data_in  (sw_408_module_data_in),
        .module_data_out (sw_408_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_408 (
        .io_in  (sw_408_module_data_in),
        .io_out (sw_408_module_data_out)
    );

    // [409] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_409_clk_out, sw_409_data_out, sw_409_scan_out, sw_409_latch_out;
    wire [7:0] sw_409_module_data_in;
    wire [7:0] sw_409_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_409 (
        .clk_in          (sw_408_clk_out),
        .data_in         (sw_408_data_out),
        .scan_select_in  (sw_408_scan_out),
        .latch_enable_in (sw_408_latch_out),
        .clk_out         (sw_409_clk_out),
        .data_out        (sw_409_data_out),
        .scan_select_out (sw_409_scan_out),
        .latch_enable_out(sw_409_latch_out),
        .module_data_in  (sw_409_module_data_in),
        .module_data_out (sw_409_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_409 (
        .io_in  (sw_409_module_data_in),
        .io_out (sw_409_module_data_out)
    );

    // [410] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_410_clk_out, sw_410_data_out, sw_410_scan_out, sw_410_latch_out;
    wire [7:0] sw_410_module_data_in;
    wire [7:0] sw_410_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_410 (
        .clk_in          (sw_409_clk_out),
        .data_in         (sw_409_data_out),
        .scan_select_in  (sw_409_scan_out),
        .latch_enable_in (sw_409_latch_out),
        .clk_out         (sw_410_clk_out),
        .data_out        (sw_410_data_out),
        .scan_select_out (sw_410_scan_out),
        .latch_enable_out(sw_410_latch_out),
        .module_data_in  (sw_410_module_data_in),
        .module_data_out (sw_410_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_410 (
        .io_in  (sw_410_module_data_in),
        .io_out (sw_410_module_data_out)
    );

    // [411] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_411_clk_out, sw_411_data_out, sw_411_scan_out, sw_411_latch_out;
    wire [7:0] sw_411_module_data_in;
    wire [7:0] sw_411_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_411 (
        .clk_in          (sw_410_clk_out),
        .data_in         (sw_410_data_out),
        .scan_select_in  (sw_410_scan_out),
        .latch_enable_in (sw_410_latch_out),
        .clk_out         (sw_411_clk_out),
        .data_out        (sw_411_data_out),
        .scan_select_out (sw_411_scan_out),
        .latch_enable_out(sw_411_latch_out),
        .module_data_in  (sw_411_module_data_in),
        .module_data_out (sw_411_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_411 (
        .io_in  (sw_411_module_data_in),
        .io_out (sw_411_module_data_out)
    );

    // [412] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_412_clk_out, sw_412_data_out, sw_412_scan_out, sw_412_latch_out;
    wire [7:0] sw_412_module_data_in;
    wire [7:0] sw_412_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_412 (
        .clk_in          (sw_411_clk_out),
        .data_in         (sw_411_data_out),
        .scan_select_in  (sw_411_scan_out),
        .latch_enable_in (sw_411_latch_out),
        .clk_out         (sw_412_clk_out),
        .data_out        (sw_412_data_out),
        .scan_select_out (sw_412_scan_out),
        .latch_enable_out(sw_412_latch_out),
        .module_data_in  (sw_412_module_data_in),
        .module_data_out (sw_412_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_412 (
        .io_in  (sw_412_module_data_in),
        .io_out (sw_412_module_data_out)
    );

    // [413] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_413_clk_out, sw_413_data_out, sw_413_scan_out, sw_413_latch_out;
    wire [7:0] sw_413_module_data_in;
    wire [7:0] sw_413_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_413 (
        .clk_in          (sw_412_clk_out),
        .data_in         (sw_412_data_out),
        .scan_select_in  (sw_412_scan_out),
        .latch_enable_in (sw_412_latch_out),
        .clk_out         (sw_413_clk_out),
        .data_out        (sw_413_data_out),
        .scan_select_out (sw_413_scan_out),
        .latch_enable_out(sw_413_latch_out),
        .module_data_in  (sw_413_module_data_in),
        .module_data_out (sw_413_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_413 (
        .io_in  (sw_413_module_data_in),
        .io_out (sw_413_module_data_out)
    );

    // [414] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_414_clk_out, sw_414_data_out, sw_414_scan_out, sw_414_latch_out;
    wire [7:0] sw_414_module_data_in;
    wire [7:0] sw_414_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_414 (
        .clk_in          (sw_413_clk_out),
        .data_in         (sw_413_data_out),
        .scan_select_in  (sw_413_scan_out),
        .latch_enable_in (sw_413_latch_out),
        .clk_out         (sw_414_clk_out),
        .data_out        (sw_414_data_out),
        .scan_select_out (sw_414_scan_out),
        .latch_enable_out(sw_414_latch_out),
        .module_data_in  (sw_414_module_data_in),
        .module_data_out (sw_414_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_414 (
        .io_in  (sw_414_module_data_in),
        .io_out (sw_414_module_data_out)
    );

    // [415] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_415_clk_out, sw_415_data_out, sw_415_scan_out, sw_415_latch_out;
    wire [7:0] sw_415_module_data_in;
    wire [7:0] sw_415_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_415 (
        .clk_in          (sw_414_clk_out),
        .data_in         (sw_414_data_out),
        .scan_select_in  (sw_414_scan_out),
        .latch_enable_in (sw_414_latch_out),
        .clk_out         (sw_415_clk_out),
        .data_out        (sw_415_data_out),
        .scan_select_out (sw_415_scan_out),
        .latch_enable_out(sw_415_latch_out),
        .module_data_in  (sw_415_module_data_in),
        .module_data_out (sw_415_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_415 (
        .io_in  (sw_415_module_data_in),
        .io_out (sw_415_module_data_out)
    );

    // [416] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_416_clk_out, sw_416_data_out, sw_416_scan_out, sw_416_latch_out;
    wire [7:0] sw_416_module_data_in;
    wire [7:0] sw_416_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_416 (
        .clk_in          (sw_415_clk_out),
        .data_in         (sw_415_data_out),
        .scan_select_in  (sw_415_scan_out),
        .latch_enable_in (sw_415_latch_out),
        .clk_out         (sw_416_clk_out),
        .data_out        (sw_416_data_out),
        .scan_select_out (sw_416_scan_out),
        .latch_enable_out(sw_416_latch_out),
        .module_data_in  (sw_416_module_data_in),
        .module_data_out (sw_416_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_416 (
        .io_in  (sw_416_module_data_in),
        .io_out (sw_416_module_data_out)
    );

    // [417] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_417_clk_out, sw_417_data_out, sw_417_scan_out, sw_417_latch_out;
    wire [7:0] sw_417_module_data_in;
    wire [7:0] sw_417_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_417 (
        .clk_in          (sw_416_clk_out),
        .data_in         (sw_416_data_out),
        .scan_select_in  (sw_416_scan_out),
        .latch_enable_in (sw_416_latch_out),
        .clk_out         (sw_417_clk_out),
        .data_out        (sw_417_data_out),
        .scan_select_out (sw_417_scan_out),
        .latch_enable_out(sw_417_latch_out),
        .module_data_in  (sw_417_module_data_in),
        .module_data_out (sw_417_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_417 (
        .io_in  (sw_417_module_data_in),
        .io_out (sw_417_module_data_out)
    );

    // [418] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_418_clk_out, sw_418_data_out, sw_418_scan_out, sw_418_latch_out;
    wire [7:0] sw_418_module_data_in;
    wire [7:0] sw_418_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_418 (
        .clk_in          (sw_417_clk_out),
        .data_in         (sw_417_data_out),
        .scan_select_in  (sw_417_scan_out),
        .latch_enable_in (sw_417_latch_out),
        .clk_out         (sw_418_clk_out),
        .data_out        (sw_418_data_out),
        .scan_select_out (sw_418_scan_out),
        .latch_enable_out(sw_418_latch_out),
        .module_data_in  (sw_418_module_data_in),
        .module_data_out (sw_418_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_418 (
        .io_in  (sw_418_module_data_in),
        .io_out (sw_418_module_data_out)
    );

    // [419] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_419_clk_out, sw_419_data_out, sw_419_scan_out, sw_419_latch_out;
    wire [7:0] sw_419_module_data_in;
    wire [7:0] sw_419_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_419 (
        .clk_in          (sw_418_clk_out),
        .data_in         (sw_418_data_out),
        .scan_select_in  (sw_418_scan_out),
        .latch_enable_in (sw_418_latch_out),
        .clk_out         (sw_419_clk_out),
        .data_out        (sw_419_data_out),
        .scan_select_out (sw_419_scan_out),
        .latch_enable_out(sw_419_latch_out),
        .module_data_in  (sw_419_module_data_in),
        .module_data_out (sw_419_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_419 (
        .io_in  (sw_419_module_data_in),
        .io_out (sw_419_module_data_out)
    );

    // [420] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_420_clk_out, sw_420_data_out, sw_420_scan_out, sw_420_latch_out;
    wire [7:0] sw_420_module_data_in;
    wire [7:0] sw_420_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_420 (
        .clk_in          (sw_419_clk_out),
        .data_in         (sw_419_data_out),
        .scan_select_in  (sw_419_scan_out),
        .latch_enable_in (sw_419_latch_out),
        .clk_out         (sw_420_clk_out),
        .data_out        (sw_420_data_out),
        .scan_select_out (sw_420_scan_out),
        .latch_enable_out(sw_420_latch_out),
        .module_data_in  (sw_420_module_data_in),
        .module_data_out (sw_420_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_420 (
        .io_in  (sw_420_module_data_in),
        .io_out (sw_420_module_data_out)
    );

    // [421] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_421_clk_out, sw_421_data_out, sw_421_scan_out, sw_421_latch_out;
    wire [7:0] sw_421_module_data_in;
    wire [7:0] sw_421_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_421 (
        .clk_in          (sw_420_clk_out),
        .data_in         (sw_420_data_out),
        .scan_select_in  (sw_420_scan_out),
        .latch_enable_in (sw_420_latch_out),
        .clk_out         (sw_421_clk_out),
        .data_out        (sw_421_data_out),
        .scan_select_out (sw_421_scan_out),
        .latch_enable_out(sw_421_latch_out),
        .module_data_in  (sw_421_module_data_in),
        .module_data_out (sw_421_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_421 (
        .io_in  (sw_421_module_data_in),
        .io_out (sw_421_module_data_out)
    );

    // [422] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_422_clk_out, sw_422_data_out, sw_422_scan_out, sw_422_latch_out;
    wire [7:0] sw_422_module_data_in;
    wire [7:0] sw_422_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_422 (
        .clk_in          (sw_421_clk_out),
        .data_in         (sw_421_data_out),
        .scan_select_in  (sw_421_scan_out),
        .latch_enable_in (sw_421_latch_out),
        .clk_out         (sw_422_clk_out),
        .data_out        (sw_422_data_out),
        .scan_select_out (sw_422_scan_out),
        .latch_enable_out(sw_422_latch_out),
        .module_data_in  (sw_422_module_data_in),
        .module_data_out (sw_422_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_422 (
        .io_in  (sw_422_module_data_in),
        .io_out (sw_422_module_data_out)
    );

    // [423] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_423_clk_out, sw_423_data_out, sw_423_scan_out, sw_423_latch_out;
    wire [7:0] sw_423_module_data_in;
    wire [7:0] sw_423_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_423 (
        .clk_in          (sw_422_clk_out),
        .data_in         (sw_422_data_out),
        .scan_select_in  (sw_422_scan_out),
        .latch_enable_in (sw_422_latch_out),
        .clk_out         (sw_423_clk_out),
        .data_out        (sw_423_data_out),
        .scan_select_out (sw_423_scan_out),
        .latch_enable_out(sw_423_latch_out),
        .module_data_in  (sw_423_module_data_in),
        .module_data_out (sw_423_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_423 (
        .io_in  (sw_423_module_data_in),
        .io_out (sw_423_module_data_out)
    );

    // [424] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_424_clk_out, sw_424_data_out, sw_424_scan_out, sw_424_latch_out;
    wire [7:0] sw_424_module_data_in;
    wire [7:0] sw_424_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_424 (
        .clk_in          (sw_423_clk_out),
        .data_in         (sw_423_data_out),
        .scan_select_in  (sw_423_scan_out),
        .latch_enable_in (sw_423_latch_out),
        .clk_out         (sw_424_clk_out),
        .data_out        (sw_424_data_out),
        .scan_select_out (sw_424_scan_out),
        .latch_enable_out(sw_424_latch_out),
        .module_data_in  (sw_424_module_data_in),
        .module_data_out (sw_424_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_424 (
        .io_in  (sw_424_module_data_in),
        .io_out (sw_424_module_data_out)
    );

    // [425] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_425_clk_out, sw_425_data_out, sw_425_scan_out, sw_425_latch_out;
    wire [7:0] sw_425_module_data_in;
    wire [7:0] sw_425_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_425 (
        .clk_in          (sw_424_clk_out),
        .data_in         (sw_424_data_out),
        .scan_select_in  (sw_424_scan_out),
        .latch_enable_in (sw_424_latch_out),
        .clk_out         (sw_425_clk_out),
        .data_out        (sw_425_data_out),
        .scan_select_out (sw_425_scan_out),
        .latch_enable_out(sw_425_latch_out),
        .module_data_in  (sw_425_module_data_in),
        .module_data_out (sw_425_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_425 (
        .io_in  (sw_425_module_data_in),
        .io_out (sw_425_module_data_out)
    );

    // [426] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_426_clk_out, sw_426_data_out, sw_426_scan_out, sw_426_latch_out;
    wire [7:0] sw_426_module_data_in;
    wire [7:0] sw_426_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_426 (
        .clk_in          (sw_425_clk_out),
        .data_in         (sw_425_data_out),
        .scan_select_in  (sw_425_scan_out),
        .latch_enable_in (sw_425_latch_out),
        .clk_out         (sw_426_clk_out),
        .data_out        (sw_426_data_out),
        .scan_select_out (sw_426_scan_out),
        .latch_enable_out(sw_426_latch_out),
        .module_data_in  (sw_426_module_data_in),
        .module_data_out (sw_426_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_426 (
        .io_in  (sw_426_module_data_in),
        .io_out (sw_426_module_data_out)
    );

    // [427] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_427_clk_out, sw_427_data_out, sw_427_scan_out, sw_427_latch_out;
    wire [7:0] sw_427_module_data_in;
    wire [7:0] sw_427_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_427 (
        .clk_in          (sw_426_clk_out),
        .data_in         (sw_426_data_out),
        .scan_select_in  (sw_426_scan_out),
        .latch_enable_in (sw_426_latch_out),
        .clk_out         (sw_427_clk_out),
        .data_out        (sw_427_data_out),
        .scan_select_out (sw_427_scan_out),
        .latch_enable_out(sw_427_latch_out),
        .module_data_in  (sw_427_module_data_in),
        .module_data_out (sw_427_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_427 (
        .io_in  (sw_427_module_data_in),
        .io_out (sw_427_module_data_out)
    );

    // [428] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_428_clk_out, sw_428_data_out, sw_428_scan_out, sw_428_latch_out;
    wire [7:0] sw_428_module_data_in;
    wire [7:0] sw_428_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_428 (
        .clk_in          (sw_427_clk_out),
        .data_in         (sw_427_data_out),
        .scan_select_in  (sw_427_scan_out),
        .latch_enable_in (sw_427_latch_out),
        .clk_out         (sw_428_clk_out),
        .data_out        (sw_428_data_out),
        .scan_select_out (sw_428_scan_out),
        .latch_enable_out(sw_428_latch_out),
        .module_data_in  (sw_428_module_data_in),
        .module_data_out (sw_428_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_428 (
        .io_in  (sw_428_module_data_in),
        .io_out (sw_428_module_data_out)
    );

    // [429] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_429_clk_out, sw_429_data_out, sw_429_scan_out, sw_429_latch_out;
    wire [7:0] sw_429_module_data_in;
    wire [7:0] sw_429_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_429 (
        .clk_in          (sw_428_clk_out),
        .data_in         (sw_428_data_out),
        .scan_select_in  (sw_428_scan_out),
        .latch_enable_in (sw_428_latch_out),
        .clk_out         (sw_429_clk_out),
        .data_out        (sw_429_data_out),
        .scan_select_out (sw_429_scan_out),
        .latch_enable_out(sw_429_latch_out),
        .module_data_in  (sw_429_module_data_in),
        .module_data_out (sw_429_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_429 (
        .io_in  (sw_429_module_data_in),
        .io_out (sw_429_module_data_out)
    );

    // [430] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_430_clk_out, sw_430_data_out, sw_430_scan_out, sw_430_latch_out;
    wire [7:0] sw_430_module_data_in;
    wire [7:0] sw_430_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_430 (
        .clk_in          (sw_429_clk_out),
        .data_in         (sw_429_data_out),
        .scan_select_in  (sw_429_scan_out),
        .latch_enable_in (sw_429_latch_out),
        .clk_out         (sw_430_clk_out),
        .data_out        (sw_430_data_out),
        .scan_select_out (sw_430_scan_out),
        .latch_enable_out(sw_430_latch_out),
        .module_data_in  (sw_430_module_data_in),
        .module_data_out (sw_430_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_430 (
        .io_in  (sw_430_module_data_in),
        .io_out (sw_430_module_data_out)
    );

    // [431] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_431_clk_out, sw_431_data_out, sw_431_scan_out, sw_431_latch_out;
    wire [7:0] sw_431_module_data_in;
    wire [7:0] sw_431_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_431 (
        .clk_in          (sw_430_clk_out),
        .data_in         (sw_430_data_out),
        .scan_select_in  (sw_430_scan_out),
        .latch_enable_in (sw_430_latch_out),
        .clk_out         (sw_431_clk_out),
        .data_out        (sw_431_data_out),
        .scan_select_out (sw_431_scan_out),
        .latch_enable_out(sw_431_latch_out),
        .module_data_in  (sw_431_module_data_in),
        .module_data_out (sw_431_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_431 (
        .io_in  (sw_431_module_data_in),
        .io_out (sw_431_module_data_out)
    );

    // [432] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_432_clk_out, sw_432_data_out, sw_432_scan_out, sw_432_latch_out;
    wire [7:0] sw_432_module_data_in;
    wire [7:0] sw_432_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_432 (
        .clk_in          (sw_431_clk_out),
        .data_in         (sw_431_data_out),
        .scan_select_in  (sw_431_scan_out),
        .latch_enable_in (sw_431_latch_out),
        .clk_out         (sw_432_clk_out),
        .data_out        (sw_432_data_out),
        .scan_select_out (sw_432_scan_out),
        .latch_enable_out(sw_432_latch_out),
        .module_data_in  (sw_432_module_data_in),
        .module_data_out (sw_432_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_432 (
        .io_in  (sw_432_module_data_in),
        .io_out (sw_432_module_data_out)
    );

    // [433] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_433_clk_out, sw_433_data_out, sw_433_scan_out, sw_433_latch_out;
    wire [7:0] sw_433_module_data_in;
    wire [7:0] sw_433_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_433 (
        .clk_in          (sw_432_clk_out),
        .data_in         (sw_432_data_out),
        .scan_select_in  (sw_432_scan_out),
        .latch_enable_in (sw_432_latch_out),
        .clk_out         (sw_433_clk_out),
        .data_out        (sw_433_data_out),
        .scan_select_out (sw_433_scan_out),
        .latch_enable_out(sw_433_latch_out),
        .module_data_in  (sw_433_module_data_in),
        .module_data_out (sw_433_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_433 (
        .io_in  (sw_433_module_data_in),
        .io_out (sw_433_module_data_out)
    );

    // [434] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_434_clk_out, sw_434_data_out, sw_434_scan_out, sw_434_latch_out;
    wire [7:0] sw_434_module_data_in;
    wire [7:0] sw_434_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_434 (
        .clk_in          (sw_433_clk_out),
        .data_in         (sw_433_data_out),
        .scan_select_in  (sw_433_scan_out),
        .latch_enable_in (sw_433_latch_out),
        .clk_out         (sw_434_clk_out),
        .data_out        (sw_434_data_out),
        .scan_select_out (sw_434_scan_out),
        .latch_enable_out(sw_434_latch_out),
        .module_data_in  (sw_434_module_data_in),
        .module_data_out (sw_434_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_434 (
        .io_in  (sw_434_module_data_in),
        .io_out (sw_434_module_data_out)
    );

    // [435] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_435_clk_out, sw_435_data_out, sw_435_scan_out, sw_435_latch_out;
    wire [7:0] sw_435_module_data_in;
    wire [7:0] sw_435_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_435 (
        .clk_in          (sw_434_clk_out),
        .data_in         (sw_434_data_out),
        .scan_select_in  (sw_434_scan_out),
        .latch_enable_in (sw_434_latch_out),
        .clk_out         (sw_435_clk_out),
        .data_out        (sw_435_data_out),
        .scan_select_out (sw_435_scan_out),
        .latch_enable_out(sw_435_latch_out),
        .module_data_in  (sw_435_module_data_in),
        .module_data_out (sw_435_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_435 (
        .io_in  (sw_435_module_data_in),
        .io_out (sw_435_module_data_out)
    );

    // [436] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_436_clk_out, sw_436_data_out, sw_436_scan_out, sw_436_latch_out;
    wire [7:0] sw_436_module_data_in;
    wire [7:0] sw_436_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_436 (
        .clk_in          (sw_435_clk_out),
        .data_in         (sw_435_data_out),
        .scan_select_in  (sw_435_scan_out),
        .latch_enable_in (sw_435_latch_out),
        .clk_out         (sw_436_clk_out),
        .data_out        (sw_436_data_out),
        .scan_select_out (sw_436_scan_out),
        .latch_enable_out(sw_436_latch_out),
        .module_data_in  (sw_436_module_data_in),
        .module_data_out (sw_436_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_436 (
        .io_in  (sw_436_module_data_in),
        .io_out (sw_436_module_data_out)
    );

    // [437] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_437_clk_out, sw_437_data_out, sw_437_scan_out, sw_437_latch_out;
    wire [7:0] sw_437_module_data_in;
    wire [7:0] sw_437_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_437 (
        .clk_in          (sw_436_clk_out),
        .data_in         (sw_436_data_out),
        .scan_select_in  (sw_436_scan_out),
        .latch_enable_in (sw_436_latch_out),
        .clk_out         (sw_437_clk_out),
        .data_out        (sw_437_data_out),
        .scan_select_out (sw_437_scan_out),
        .latch_enable_out(sw_437_latch_out),
        .module_data_in  (sw_437_module_data_in),
        .module_data_out (sw_437_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_437 (
        .io_in  (sw_437_module_data_in),
        .io_out (sw_437_module_data_out)
    );

    // [438] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_438_clk_out, sw_438_data_out, sw_438_scan_out, sw_438_latch_out;
    wire [7:0] sw_438_module_data_in;
    wire [7:0] sw_438_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_438 (
        .clk_in          (sw_437_clk_out),
        .data_in         (sw_437_data_out),
        .scan_select_in  (sw_437_scan_out),
        .latch_enable_in (sw_437_latch_out),
        .clk_out         (sw_438_clk_out),
        .data_out        (sw_438_data_out),
        .scan_select_out (sw_438_scan_out),
        .latch_enable_out(sw_438_latch_out),
        .module_data_in  (sw_438_module_data_in),
        .module_data_out (sw_438_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_438 (
        .io_in  (sw_438_module_data_in),
        .io_out (sw_438_module_data_out)
    );

    // [439] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_439_clk_out, sw_439_data_out, sw_439_scan_out, sw_439_latch_out;
    wire [7:0] sw_439_module_data_in;
    wire [7:0] sw_439_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_439 (
        .clk_in          (sw_438_clk_out),
        .data_in         (sw_438_data_out),
        .scan_select_in  (sw_438_scan_out),
        .latch_enable_in (sw_438_latch_out),
        .clk_out         (sw_439_clk_out),
        .data_out        (sw_439_data_out),
        .scan_select_out (sw_439_scan_out),
        .latch_enable_out(sw_439_latch_out),
        .module_data_in  (sw_439_module_data_in),
        .module_data_out (sw_439_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_439 (
        .io_in  (sw_439_module_data_in),
        .io_out (sw_439_module_data_out)
    );

    // [440] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_440_clk_out, sw_440_data_out, sw_440_scan_out, sw_440_latch_out;
    wire [7:0] sw_440_module_data_in;
    wire [7:0] sw_440_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_440 (
        .clk_in          (sw_439_clk_out),
        .data_in         (sw_439_data_out),
        .scan_select_in  (sw_439_scan_out),
        .latch_enable_in (sw_439_latch_out),
        .clk_out         (sw_440_clk_out),
        .data_out        (sw_440_data_out),
        .scan_select_out (sw_440_scan_out),
        .latch_enable_out(sw_440_latch_out),
        .module_data_in  (sw_440_module_data_in),
        .module_data_out (sw_440_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_440 (
        .io_in  (sw_440_module_data_in),
        .io_out (sw_440_module_data_out)
    );

    // [441] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_441_clk_out, sw_441_data_out, sw_441_scan_out, sw_441_latch_out;
    wire [7:0] sw_441_module_data_in;
    wire [7:0] sw_441_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_441 (
        .clk_in          (sw_440_clk_out),
        .data_in         (sw_440_data_out),
        .scan_select_in  (sw_440_scan_out),
        .latch_enable_in (sw_440_latch_out),
        .clk_out         (sw_441_clk_out),
        .data_out        (sw_441_data_out),
        .scan_select_out (sw_441_scan_out),
        .latch_enable_out(sw_441_latch_out),
        .module_data_in  (sw_441_module_data_in),
        .module_data_out (sw_441_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_441 (
        .io_in  (sw_441_module_data_in),
        .io_out (sw_441_module_data_out)
    );

    // [442] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_442_clk_out, sw_442_data_out, sw_442_scan_out, sw_442_latch_out;
    wire [7:0] sw_442_module_data_in;
    wire [7:0] sw_442_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_442 (
        .clk_in          (sw_441_clk_out),
        .data_in         (sw_441_data_out),
        .scan_select_in  (sw_441_scan_out),
        .latch_enable_in (sw_441_latch_out),
        .clk_out         (sw_442_clk_out),
        .data_out        (sw_442_data_out),
        .scan_select_out (sw_442_scan_out),
        .latch_enable_out(sw_442_latch_out),
        .module_data_in  (sw_442_module_data_in),
        .module_data_out (sw_442_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_442 (
        .io_in  (sw_442_module_data_in),
        .io_out (sw_442_module_data_out)
    );

    // [443] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_443_clk_out, sw_443_data_out, sw_443_scan_out, sw_443_latch_out;
    wire [7:0] sw_443_module_data_in;
    wire [7:0] sw_443_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_443 (
        .clk_in          (sw_442_clk_out),
        .data_in         (sw_442_data_out),
        .scan_select_in  (sw_442_scan_out),
        .latch_enable_in (sw_442_latch_out),
        .clk_out         (sw_443_clk_out),
        .data_out        (sw_443_data_out),
        .scan_select_out (sw_443_scan_out),
        .latch_enable_out(sw_443_latch_out),
        .module_data_in  (sw_443_module_data_in),
        .module_data_out (sw_443_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_443 (
        .io_in  (sw_443_module_data_in),
        .io_out (sw_443_module_data_out)
    );

    // [444] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_444_clk_out, sw_444_data_out, sw_444_scan_out, sw_444_latch_out;
    wire [7:0] sw_444_module_data_in;
    wire [7:0] sw_444_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_444 (
        .clk_in          (sw_443_clk_out),
        .data_in         (sw_443_data_out),
        .scan_select_in  (sw_443_scan_out),
        .latch_enable_in (sw_443_latch_out),
        .clk_out         (sw_444_clk_out),
        .data_out        (sw_444_data_out),
        .scan_select_out (sw_444_scan_out),
        .latch_enable_out(sw_444_latch_out),
        .module_data_in  (sw_444_module_data_in),
        .module_data_out (sw_444_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_444 (
        .io_in  (sw_444_module_data_in),
        .io_out (sw_444_module_data_out)
    );

    // [445] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_445_clk_out, sw_445_data_out, sw_445_scan_out, sw_445_latch_out;
    wire [7:0] sw_445_module_data_in;
    wire [7:0] sw_445_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_445 (
        .clk_in          (sw_444_clk_out),
        .data_in         (sw_444_data_out),
        .scan_select_in  (sw_444_scan_out),
        .latch_enable_in (sw_444_latch_out),
        .clk_out         (sw_445_clk_out),
        .data_out        (sw_445_data_out),
        .scan_select_out (sw_445_scan_out),
        .latch_enable_out(sw_445_latch_out),
        .module_data_in  (sw_445_module_data_in),
        .module_data_out (sw_445_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_445 (
        .io_in  (sw_445_module_data_in),
        .io_out (sw_445_module_data_out)
    );

    // [446] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_446_clk_out, sw_446_data_out, sw_446_scan_out, sw_446_latch_out;
    wire [7:0] sw_446_module_data_in;
    wire [7:0] sw_446_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_446 (
        .clk_in          (sw_445_clk_out),
        .data_in         (sw_445_data_out),
        .scan_select_in  (sw_445_scan_out),
        .latch_enable_in (sw_445_latch_out),
        .clk_out         (sw_446_clk_out),
        .data_out        (sw_446_data_out),
        .scan_select_out (sw_446_scan_out),
        .latch_enable_out(sw_446_latch_out),
        .module_data_in  (sw_446_module_data_in),
        .module_data_out (sw_446_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_446 (
        .io_in  (sw_446_module_data_in),
        .io_out (sw_446_module_data_out)
    );

    // [447] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_447_clk_out, sw_447_data_out, sw_447_scan_out, sw_447_latch_out;
    wire [7:0] sw_447_module_data_in;
    wire [7:0] sw_447_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_447 (
        .clk_in          (sw_446_clk_out),
        .data_in         (sw_446_data_out),
        .scan_select_in  (sw_446_scan_out),
        .latch_enable_in (sw_446_latch_out),
        .clk_out         (sw_447_clk_out),
        .data_out        (sw_447_data_out),
        .scan_select_out (sw_447_scan_out),
        .latch_enable_out(sw_447_latch_out),
        .module_data_in  (sw_447_module_data_in),
        .module_data_out (sw_447_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_447 (
        .io_in  (sw_447_module_data_in),
        .io_out (sw_447_module_data_out)
    );

    // [448] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_448_clk_out, sw_448_data_out, sw_448_scan_out, sw_448_latch_out;
    wire [7:0] sw_448_module_data_in;
    wire [7:0] sw_448_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_448 (
        .clk_in          (sw_447_clk_out),
        .data_in         (sw_447_data_out),
        .scan_select_in  (sw_447_scan_out),
        .latch_enable_in (sw_447_latch_out),
        .clk_out         (sw_448_clk_out),
        .data_out        (sw_448_data_out),
        .scan_select_out (sw_448_scan_out),
        .latch_enable_out(sw_448_latch_out),
        .module_data_in  (sw_448_module_data_in),
        .module_data_out (sw_448_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_448 (
        .io_in  (sw_448_module_data_in),
        .io_out (sw_448_module_data_out)
    );

    // [449] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_449_clk_out, sw_449_data_out, sw_449_scan_out, sw_449_latch_out;
    wire [7:0] sw_449_module_data_in;
    wire [7:0] sw_449_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_449 (
        .clk_in          (sw_448_clk_out),
        .data_in         (sw_448_data_out),
        .scan_select_in  (sw_448_scan_out),
        .latch_enable_in (sw_448_latch_out),
        .clk_out         (sw_449_clk_out),
        .data_out        (sw_449_data_out),
        .scan_select_out (sw_449_scan_out),
        .latch_enable_out(sw_449_latch_out),
        .module_data_in  (sw_449_module_data_in),
        .module_data_out (sw_449_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_449 (
        .io_in  (sw_449_module_data_in),
        .io_out (sw_449_module_data_out)
    );

    // [450] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_450_clk_out, sw_450_data_out, sw_450_scan_out, sw_450_latch_out;
    wire [7:0] sw_450_module_data_in;
    wire [7:0] sw_450_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_450 (
        .clk_in          (sw_449_clk_out),
        .data_in         (sw_449_data_out),
        .scan_select_in  (sw_449_scan_out),
        .latch_enable_in (sw_449_latch_out),
        .clk_out         (sw_450_clk_out),
        .data_out        (sw_450_data_out),
        .scan_select_out (sw_450_scan_out),
        .latch_enable_out(sw_450_latch_out),
        .module_data_in  (sw_450_module_data_in),
        .module_data_out (sw_450_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_450 (
        .io_in  (sw_450_module_data_in),
        .io_out (sw_450_module_data_out)
    );

    // [451] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_451_clk_out, sw_451_data_out, sw_451_scan_out, sw_451_latch_out;
    wire [7:0] sw_451_module_data_in;
    wire [7:0] sw_451_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_451 (
        .clk_in          (sw_450_clk_out),
        .data_in         (sw_450_data_out),
        .scan_select_in  (sw_450_scan_out),
        .latch_enable_in (sw_450_latch_out),
        .clk_out         (sw_451_clk_out),
        .data_out        (sw_451_data_out),
        .scan_select_out (sw_451_scan_out),
        .latch_enable_out(sw_451_latch_out),
        .module_data_in  (sw_451_module_data_in),
        .module_data_out (sw_451_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_451 (
        .io_in  (sw_451_module_data_in),
        .io_out (sw_451_module_data_out)
    );

    // [452] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_452_clk_out, sw_452_data_out, sw_452_scan_out, sw_452_latch_out;
    wire [7:0] sw_452_module_data_in;
    wire [7:0] sw_452_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_452 (
        .clk_in          (sw_451_clk_out),
        .data_in         (sw_451_data_out),
        .scan_select_in  (sw_451_scan_out),
        .latch_enable_in (sw_451_latch_out),
        .clk_out         (sw_452_clk_out),
        .data_out        (sw_452_data_out),
        .scan_select_out (sw_452_scan_out),
        .latch_enable_out(sw_452_latch_out),
        .module_data_in  (sw_452_module_data_in),
        .module_data_out (sw_452_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_452 (
        .io_in  (sw_452_module_data_in),
        .io_out (sw_452_module_data_out)
    );

    // [453] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_453_clk_out, sw_453_data_out, sw_453_scan_out, sw_453_latch_out;
    wire [7:0] sw_453_module_data_in;
    wire [7:0] sw_453_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_453 (
        .clk_in          (sw_452_clk_out),
        .data_in         (sw_452_data_out),
        .scan_select_in  (sw_452_scan_out),
        .latch_enable_in (sw_452_latch_out),
        .clk_out         (sw_453_clk_out),
        .data_out        (sw_453_data_out),
        .scan_select_out (sw_453_scan_out),
        .latch_enable_out(sw_453_latch_out),
        .module_data_in  (sw_453_module_data_in),
        .module_data_out (sw_453_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_453 (
        .io_in  (sw_453_module_data_in),
        .io_out (sw_453_module_data_out)
    );

    // [454] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_454_clk_out, sw_454_data_out, sw_454_scan_out, sw_454_latch_out;
    wire [7:0] sw_454_module_data_in;
    wire [7:0] sw_454_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_454 (
        .clk_in          (sw_453_clk_out),
        .data_in         (sw_453_data_out),
        .scan_select_in  (sw_453_scan_out),
        .latch_enable_in (sw_453_latch_out),
        .clk_out         (sw_454_clk_out),
        .data_out        (sw_454_data_out),
        .scan_select_out (sw_454_scan_out),
        .latch_enable_out(sw_454_latch_out),
        .module_data_in  (sw_454_module_data_in),
        .module_data_out (sw_454_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_454 (
        .io_in  (sw_454_module_data_in),
        .io_out (sw_454_module_data_out)
    );

    // [455] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_455_clk_out, sw_455_data_out, sw_455_scan_out, sw_455_latch_out;
    wire [7:0] sw_455_module_data_in;
    wire [7:0] sw_455_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_455 (
        .clk_in          (sw_454_clk_out),
        .data_in         (sw_454_data_out),
        .scan_select_in  (sw_454_scan_out),
        .latch_enable_in (sw_454_latch_out),
        .clk_out         (sw_455_clk_out),
        .data_out        (sw_455_data_out),
        .scan_select_out (sw_455_scan_out),
        .latch_enable_out(sw_455_latch_out),
        .module_data_in  (sw_455_module_data_in),
        .module_data_out (sw_455_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_455 (
        .io_in  (sw_455_module_data_in),
        .io_out (sw_455_module_data_out)
    );

    // [456] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_456_clk_out, sw_456_data_out, sw_456_scan_out, sw_456_latch_out;
    wire [7:0] sw_456_module_data_in;
    wire [7:0] sw_456_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_456 (
        .clk_in          (sw_455_clk_out),
        .data_in         (sw_455_data_out),
        .scan_select_in  (sw_455_scan_out),
        .latch_enable_in (sw_455_latch_out),
        .clk_out         (sw_456_clk_out),
        .data_out        (sw_456_data_out),
        .scan_select_out (sw_456_scan_out),
        .latch_enable_out(sw_456_latch_out),
        .module_data_in  (sw_456_module_data_in),
        .module_data_out (sw_456_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_456 (
        .io_in  (sw_456_module_data_in),
        .io_out (sw_456_module_data_out)
    );

    // [457] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_457_clk_out, sw_457_data_out, sw_457_scan_out, sw_457_latch_out;
    wire [7:0] sw_457_module_data_in;
    wire [7:0] sw_457_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_457 (
        .clk_in          (sw_456_clk_out),
        .data_in         (sw_456_data_out),
        .scan_select_in  (sw_456_scan_out),
        .latch_enable_in (sw_456_latch_out),
        .clk_out         (sw_457_clk_out),
        .data_out        (sw_457_data_out),
        .scan_select_out (sw_457_scan_out),
        .latch_enable_out(sw_457_latch_out),
        .module_data_in  (sw_457_module_data_in),
        .module_data_out (sw_457_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_457 (
        .io_in  (sw_457_module_data_in),
        .io_out (sw_457_module_data_out)
    );

    // [458] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_458_clk_out, sw_458_data_out, sw_458_scan_out, sw_458_latch_out;
    wire [7:0] sw_458_module_data_in;
    wire [7:0] sw_458_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_458 (
        .clk_in          (sw_457_clk_out),
        .data_in         (sw_457_data_out),
        .scan_select_in  (sw_457_scan_out),
        .latch_enable_in (sw_457_latch_out),
        .clk_out         (sw_458_clk_out),
        .data_out        (sw_458_data_out),
        .scan_select_out (sw_458_scan_out),
        .latch_enable_out(sw_458_latch_out),
        .module_data_in  (sw_458_module_data_in),
        .module_data_out (sw_458_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_458 (
        .io_in  (sw_458_module_data_in),
        .io_out (sw_458_module_data_out)
    );

    // [459] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_459_clk_out, sw_459_data_out, sw_459_scan_out, sw_459_latch_out;
    wire [7:0] sw_459_module_data_in;
    wire [7:0] sw_459_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_459 (
        .clk_in          (sw_458_clk_out),
        .data_in         (sw_458_data_out),
        .scan_select_in  (sw_458_scan_out),
        .latch_enable_in (sw_458_latch_out),
        .clk_out         (sw_459_clk_out),
        .data_out        (sw_459_data_out),
        .scan_select_out (sw_459_scan_out),
        .latch_enable_out(sw_459_latch_out),
        .module_data_in  (sw_459_module_data_in),
        .module_data_out (sw_459_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_459 (
        .io_in  (sw_459_module_data_in),
        .io_out (sw_459_module_data_out)
    );

    // [460] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_460_clk_out, sw_460_data_out, sw_460_scan_out, sw_460_latch_out;
    wire [7:0] sw_460_module_data_in;
    wire [7:0] sw_460_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_460 (
        .clk_in          (sw_459_clk_out),
        .data_in         (sw_459_data_out),
        .scan_select_in  (sw_459_scan_out),
        .latch_enable_in (sw_459_latch_out),
        .clk_out         (sw_460_clk_out),
        .data_out        (sw_460_data_out),
        .scan_select_out (sw_460_scan_out),
        .latch_enable_out(sw_460_latch_out),
        .module_data_in  (sw_460_module_data_in),
        .module_data_out (sw_460_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_460 (
        .io_in  (sw_460_module_data_in),
        .io_out (sw_460_module_data_out)
    );

    // [461] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_461_clk_out, sw_461_data_out, sw_461_scan_out, sw_461_latch_out;
    wire [7:0] sw_461_module_data_in;
    wire [7:0] sw_461_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_461 (
        .clk_in          (sw_460_clk_out),
        .data_in         (sw_460_data_out),
        .scan_select_in  (sw_460_scan_out),
        .latch_enable_in (sw_460_latch_out),
        .clk_out         (sw_461_clk_out),
        .data_out        (sw_461_data_out),
        .scan_select_out (sw_461_scan_out),
        .latch_enable_out(sw_461_latch_out),
        .module_data_in  (sw_461_module_data_in),
        .module_data_out (sw_461_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_461 (
        .io_in  (sw_461_module_data_in),
        .io_out (sw_461_module_data_out)
    );

    // [462] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_462_clk_out, sw_462_data_out, sw_462_scan_out, sw_462_latch_out;
    wire [7:0] sw_462_module_data_in;
    wire [7:0] sw_462_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_462 (
        .clk_in          (sw_461_clk_out),
        .data_in         (sw_461_data_out),
        .scan_select_in  (sw_461_scan_out),
        .latch_enable_in (sw_461_latch_out),
        .clk_out         (sw_462_clk_out),
        .data_out        (sw_462_data_out),
        .scan_select_out (sw_462_scan_out),
        .latch_enable_out(sw_462_latch_out),
        .module_data_in  (sw_462_module_data_in),
        .module_data_out (sw_462_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_462 (
        .io_in  (sw_462_module_data_in),
        .io_out (sw_462_module_data_out)
    );

    // [463] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_463_clk_out, sw_463_data_out, sw_463_scan_out, sw_463_latch_out;
    wire [7:0] sw_463_module_data_in;
    wire [7:0] sw_463_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_463 (
        .clk_in          (sw_462_clk_out),
        .data_in         (sw_462_data_out),
        .scan_select_in  (sw_462_scan_out),
        .latch_enable_in (sw_462_latch_out),
        .clk_out         (sw_463_clk_out),
        .data_out        (sw_463_data_out),
        .scan_select_out (sw_463_scan_out),
        .latch_enable_out(sw_463_latch_out),
        .module_data_in  (sw_463_module_data_in),
        .module_data_out (sw_463_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_463 (
        .io_in  (sw_463_module_data_in),
        .io_out (sw_463_module_data_out)
    );

    // [464] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_464_clk_out, sw_464_data_out, sw_464_scan_out, sw_464_latch_out;
    wire [7:0] sw_464_module_data_in;
    wire [7:0] sw_464_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_464 (
        .clk_in          (sw_463_clk_out),
        .data_in         (sw_463_data_out),
        .scan_select_in  (sw_463_scan_out),
        .latch_enable_in (sw_463_latch_out),
        .clk_out         (sw_464_clk_out),
        .data_out        (sw_464_data_out),
        .scan_select_out (sw_464_scan_out),
        .latch_enable_out(sw_464_latch_out),
        .module_data_in  (sw_464_module_data_in),
        .module_data_out (sw_464_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_464 (
        .io_in  (sw_464_module_data_in),
        .io_out (sw_464_module_data_out)
    );

    // [465] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_465_clk_out, sw_465_data_out, sw_465_scan_out, sw_465_latch_out;
    wire [7:0] sw_465_module_data_in;
    wire [7:0] sw_465_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_465 (
        .clk_in          (sw_464_clk_out),
        .data_in         (sw_464_data_out),
        .scan_select_in  (sw_464_scan_out),
        .latch_enable_in (sw_464_latch_out),
        .clk_out         (sw_465_clk_out),
        .data_out        (sw_465_data_out),
        .scan_select_out (sw_465_scan_out),
        .latch_enable_out(sw_465_latch_out),
        .module_data_in  (sw_465_module_data_in),
        .module_data_out (sw_465_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_465 (
        .io_in  (sw_465_module_data_in),
        .io_out (sw_465_module_data_out)
    );

    // [466] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_466_clk_out, sw_466_data_out, sw_466_scan_out, sw_466_latch_out;
    wire [7:0] sw_466_module_data_in;
    wire [7:0] sw_466_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_466 (
        .clk_in          (sw_465_clk_out),
        .data_in         (sw_465_data_out),
        .scan_select_in  (sw_465_scan_out),
        .latch_enable_in (sw_465_latch_out),
        .clk_out         (sw_466_clk_out),
        .data_out        (sw_466_data_out),
        .scan_select_out (sw_466_scan_out),
        .latch_enable_out(sw_466_latch_out),
        .module_data_in  (sw_466_module_data_in),
        .module_data_out (sw_466_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_466 (
        .io_in  (sw_466_module_data_in),
        .io_out (sw_466_module_data_out)
    );

    // [467] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_467_clk_out, sw_467_data_out, sw_467_scan_out, sw_467_latch_out;
    wire [7:0] sw_467_module_data_in;
    wire [7:0] sw_467_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_467 (
        .clk_in          (sw_466_clk_out),
        .data_in         (sw_466_data_out),
        .scan_select_in  (sw_466_scan_out),
        .latch_enable_in (sw_466_latch_out),
        .clk_out         (sw_467_clk_out),
        .data_out        (sw_467_data_out),
        .scan_select_out (sw_467_scan_out),
        .latch_enable_out(sw_467_latch_out),
        .module_data_in  (sw_467_module_data_in),
        .module_data_out (sw_467_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_467 (
        .io_in  (sw_467_module_data_in),
        .io_out (sw_467_module_data_out)
    );

    // [468] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_468_clk_out, sw_468_data_out, sw_468_scan_out, sw_468_latch_out;
    wire [7:0] sw_468_module_data_in;
    wire [7:0] sw_468_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_468 (
        .clk_in          (sw_467_clk_out),
        .data_in         (sw_467_data_out),
        .scan_select_in  (sw_467_scan_out),
        .latch_enable_in (sw_467_latch_out),
        .clk_out         (sw_468_clk_out),
        .data_out        (sw_468_data_out),
        .scan_select_out (sw_468_scan_out),
        .latch_enable_out(sw_468_latch_out),
        .module_data_in  (sw_468_module_data_in),
        .module_data_out (sw_468_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_468 (
        .io_in  (sw_468_module_data_in),
        .io_out (sw_468_module_data_out)
    );

    // [469] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_469_clk_out, sw_469_data_out, sw_469_scan_out, sw_469_latch_out;
    wire [7:0] sw_469_module_data_in;
    wire [7:0] sw_469_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_469 (
        .clk_in          (sw_468_clk_out),
        .data_in         (sw_468_data_out),
        .scan_select_in  (sw_468_scan_out),
        .latch_enable_in (sw_468_latch_out),
        .clk_out         (sw_469_clk_out),
        .data_out        (sw_469_data_out),
        .scan_select_out (sw_469_scan_out),
        .latch_enable_out(sw_469_latch_out),
        .module_data_in  (sw_469_module_data_in),
        .module_data_out (sw_469_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_469 (
        .io_in  (sw_469_module_data_in),
        .io_out (sw_469_module_data_out)
    );

    // [470] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_470_clk_out, sw_470_data_out, sw_470_scan_out, sw_470_latch_out;
    wire [7:0] sw_470_module_data_in;
    wire [7:0] sw_470_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_470 (
        .clk_in          (sw_469_clk_out),
        .data_in         (sw_469_data_out),
        .scan_select_in  (sw_469_scan_out),
        .latch_enable_in (sw_469_latch_out),
        .clk_out         (sw_470_clk_out),
        .data_out        (sw_470_data_out),
        .scan_select_out (sw_470_scan_out),
        .latch_enable_out(sw_470_latch_out),
        .module_data_in  (sw_470_module_data_in),
        .module_data_out (sw_470_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_470 (
        .io_in  (sw_470_module_data_in),
        .io_out (sw_470_module_data_out)
    );

    // [471] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_471_clk_out, sw_471_data_out, sw_471_scan_out, sw_471_latch_out;
    wire [7:0] sw_471_module_data_in;
    wire [7:0] sw_471_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_471 (
        .clk_in          (sw_470_clk_out),
        .data_in         (sw_470_data_out),
        .scan_select_in  (sw_470_scan_out),
        .latch_enable_in (sw_470_latch_out),
        .clk_out         (sw_471_clk_out),
        .data_out        (sw_471_data_out),
        .scan_select_out (sw_471_scan_out),
        .latch_enable_out(sw_471_latch_out),
        .module_data_in  (sw_471_module_data_in),
        .module_data_out (sw_471_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_471 (
        .io_in  (sw_471_module_data_in),
        .io_out (sw_471_module_data_out)
    );

    // [472] https://github.com/TinyTapeout/tt02-test-straight
    wire sw_472_clk_out, sw_472_data_out, sw_472_scan_out, sw_472_latch_out;
    wire [7:0] sw_472_module_data_in;
    wire [7:0] sw_472_module_data_out;
    scanchain #(.NUM_IOS(8)) scanchain_472 (
        .clk_in          (sw_471_clk_out),
        .data_in         (sw_471_data_out),
        .scan_select_in  (sw_471_scan_out),
        .latch_enable_in (sw_471_latch_out),
        .clk_out         (sw_472_clk_out),
        .data_out        (sw_472_data_out),
        .scan_select_out (sw_472_scan_out),
        .latch_enable_out(sw_472_latch_out),
        .module_data_in  (sw_472_module_data_in),
        .module_data_out (sw_472_module_data_out)
    );

    user_module_339501025136214612 user_module_339501025136214612_472 (
        .io_in  (sw_472_module_data_in),
        .io_out (sw_472_module_data_out)
    );

    // Connect final signals back to the scan controller
    assign sc_clk_in  = sw_472_clk_out;
    assign sc_data_in = sw_472_data_out;

    // end of module instantiation

endmodule	// user_project_wrapper
`default_nettype wire
