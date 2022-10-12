module user_project_wrapper (user_clock2,
    vccd1,
    vccd2,
    vdda1,
    vdda2,
    vssa1,
    vssa2,
    vssd1,
    vssd2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input vccd1;
 input vccd2;
 input vdda1;
 input vdda2;
 input vssa1;
 input vssa2;
 input vssd1;
 input vssd2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;

 wire sc_clk_in;
 wire sc_clk_out;
 wire sc_data_in;
 wire sc_data_out;
 wire sc_latch_out;
 wire sc_scan_out;
 wire sw_000_clk_out;
 wire sw_000_data_out;
 wire sw_000_latch_out;
 wire \sw_000_module_data_in[0] ;
 wire \sw_000_module_data_in[1] ;
 wire \sw_000_module_data_in[2] ;
 wire \sw_000_module_data_in[3] ;
 wire \sw_000_module_data_in[4] ;
 wire \sw_000_module_data_in[5] ;
 wire \sw_000_module_data_in[6] ;
 wire \sw_000_module_data_in[7] ;
 wire \sw_000_module_data_out[0] ;
 wire \sw_000_module_data_out[1] ;
 wire \sw_000_module_data_out[2] ;
 wire \sw_000_module_data_out[3] ;
 wire \sw_000_module_data_out[4] ;
 wire \sw_000_module_data_out[5] ;
 wire \sw_000_module_data_out[6] ;
 wire \sw_000_module_data_out[7] ;
 wire sw_000_scan_out;
 wire sw_001_clk_out;
 wire sw_001_data_out;
 wire sw_001_latch_out;
 wire \sw_001_module_data_in[0] ;
 wire \sw_001_module_data_in[1] ;
 wire \sw_001_module_data_in[2] ;
 wire \sw_001_module_data_in[3] ;
 wire \sw_001_module_data_in[4] ;
 wire \sw_001_module_data_in[5] ;
 wire \sw_001_module_data_in[6] ;
 wire \sw_001_module_data_in[7] ;
 wire \sw_001_module_data_out[0] ;
 wire \sw_001_module_data_out[1] ;
 wire \sw_001_module_data_out[2] ;
 wire \sw_001_module_data_out[3] ;
 wire \sw_001_module_data_out[4] ;
 wire \sw_001_module_data_out[5] ;
 wire \sw_001_module_data_out[6] ;
 wire \sw_001_module_data_out[7] ;
 wire sw_001_scan_out;
 wire sw_002_clk_out;
 wire sw_002_data_out;
 wire sw_002_latch_out;
 wire \sw_002_module_data_in[0] ;
 wire \sw_002_module_data_in[1] ;
 wire \sw_002_module_data_in[2] ;
 wire \sw_002_module_data_in[3] ;
 wire \sw_002_module_data_in[4] ;
 wire \sw_002_module_data_in[5] ;
 wire \sw_002_module_data_in[6] ;
 wire \sw_002_module_data_in[7] ;
 wire \sw_002_module_data_out[0] ;
 wire \sw_002_module_data_out[1] ;
 wire \sw_002_module_data_out[2] ;
 wire \sw_002_module_data_out[3] ;
 wire \sw_002_module_data_out[4] ;
 wire \sw_002_module_data_out[5] ;
 wire \sw_002_module_data_out[6] ;
 wire \sw_002_module_data_out[7] ;
 wire sw_002_scan_out;
 wire sw_003_clk_out;
 wire sw_003_data_out;
 wire sw_003_latch_out;
 wire \sw_003_module_data_in[0] ;
 wire \sw_003_module_data_in[1] ;
 wire \sw_003_module_data_in[2] ;
 wire \sw_003_module_data_in[3] ;
 wire \sw_003_module_data_in[4] ;
 wire \sw_003_module_data_in[5] ;
 wire \sw_003_module_data_in[6] ;
 wire \sw_003_module_data_in[7] ;
 wire \sw_003_module_data_out[0] ;
 wire \sw_003_module_data_out[1] ;
 wire \sw_003_module_data_out[2] ;
 wire \sw_003_module_data_out[3] ;
 wire \sw_003_module_data_out[4] ;
 wire \sw_003_module_data_out[5] ;
 wire \sw_003_module_data_out[6] ;
 wire \sw_003_module_data_out[7] ;
 wire sw_003_scan_out;
 wire sw_004_clk_out;
 wire sw_004_data_out;
 wire sw_004_latch_out;
 wire \sw_004_module_data_in[0] ;
 wire \sw_004_module_data_in[1] ;
 wire \sw_004_module_data_in[2] ;
 wire \sw_004_module_data_in[3] ;
 wire \sw_004_module_data_in[4] ;
 wire \sw_004_module_data_in[5] ;
 wire \sw_004_module_data_in[6] ;
 wire \sw_004_module_data_in[7] ;
 wire \sw_004_module_data_out[0] ;
 wire \sw_004_module_data_out[1] ;
 wire \sw_004_module_data_out[2] ;
 wire \sw_004_module_data_out[3] ;
 wire \sw_004_module_data_out[4] ;
 wire \sw_004_module_data_out[5] ;
 wire \sw_004_module_data_out[6] ;
 wire \sw_004_module_data_out[7] ;
 wire sw_004_scan_out;
 wire sw_005_clk_out;
 wire sw_005_data_out;
 wire sw_005_latch_out;
 wire \sw_005_module_data_in[0] ;
 wire \sw_005_module_data_in[1] ;
 wire \sw_005_module_data_in[2] ;
 wire \sw_005_module_data_in[3] ;
 wire \sw_005_module_data_in[4] ;
 wire \sw_005_module_data_in[5] ;
 wire \sw_005_module_data_in[6] ;
 wire \sw_005_module_data_in[7] ;
 wire \sw_005_module_data_out[0] ;
 wire \sw_005_module_data_out[1] ;
 wire \sw_005_module_data_out[2] ;
 wire \sw_005_module_data_out[3] ;
 wire \sw_005_module_data_out[4] ;
 wire \sw_005_module_data_out[5] ;
 wire \sw_005_module_data_out[6] ;
 wire \sw_005_module_data_out[7] ;
 wire sw_005_scan_out;
 wire sw_006_clk_out;
 wire sw_006_data_out;
 wire sw_006_latch_out;
 wire \sw_006_module_data_in[0] ;
 wire \sw_006_module_data_in[1] ;
 wire \sw_006_module_data_in[2] ;
 wire \sw_006_module_data_in[3] ;
 wire \sw_006_module_data_in[4] ;
 wire \sw_006_module_data_in[5] ;
 wire \sw_006_module_data_in[6] ;
 wire \sw_006_module_data_in[7] ;
 wire \sw_006_module_data_out[0] ;
 wire \sw_006_module_data_out[1] ;
 wire \sw_006_module_data_out[2] ;
 wire \sw_006_module_data_out[3] ;
 wire \sw_006_module_data_out[4] ;
 wire \sw_006_module_data_out[5] ;
 wire \sw_006_module_data_out[6] ;
 wire \sw_006_module_data_out[7] ;
 wire sw_006_scan_out;
 wire sw_007_clk_out;
 wire sw_007_data_out;
 wire sw_007_latch_out;
 wire \sw_007_module_data_in[0] ;
 wire \sw_007_module_data_in[1] ;
 wire \sw_007_module_data_in[2] ;
 wire \sw_007_module_data_in[3] ;
 wire \sw_007_module_data_in[4] ;
 wire \sw_007_module_data_in[5] ;
 wire \sw_007_module_data_in[6] ;
 wire \sw_007_module_data_in[7] ;
 wire \sw_007_module_data_out[0] ;
 wire \sw_007_module_data_out[1] ;
 wire \sw_007_module_data_out[2] ;
 wire \sw_007_module_data_out[3] ;
 wire \sw_007_module_data_out[4] ;
 wire \sw_007_module_data_out[5] ;
 wire \sw_007_module_data_out[6] ;
 wire \sw_007_module_data_out[7] ;
 wire sw_007_scan_out;
 wire sw_008_clk_out;
 wire sw_008_data_out;
 wire sw_008_latch_out;
 wire \sw_008_module_data_in[0] ;
 wire \sw_008_module_data_in[1] ;
 wire \sw_008_module_data_in[2] ;
 wire \sw_008_module_data_in[3] ;
 wire \sw_008_module_data_in[4] ;
 wire \sw_008_module_data_in[5] ;
 wire \sw_008_module_data_in[6] ;
 wire \sw_008_module_data_in[7] ;
 wire \sw_008_module_data_out[0] ;
 wire \sw_008_module_data_out[1] ;
 wire \sw_008_module_data_out[2] ;
 wire \sw_008_module_data_out[3] ;
 wire \sw_008_module_data_out[4] ;
 wire \sw_008_module_data_out[5] ;
 wire \sw_008_module_data_out[6] ;
 wire \sw_008_module_data_out[7] ;
 wire sw_008_scan_out;
 wire sw_009_clk_out;
 wire sw_009_data_out;
 wire sw_009_latch_out;
 wire \sw_009_module_data_in[0] ;
 wire \sw_009_module_data_in[1] ;
 wire \sw_009_module_data_in[2] ;
 wire \sw_009_module_data_in[3] ;
 wire \sw_009_module_data_in[4] ;
 wire \sw_009_module_data_in[5] ;
 wire \sw_009_module_data_in[6] ;
 wire \sw_009_module_data_in[7] ;
 wire \sw_009_module_data_out[0] ;
 wire \sw_009_module_data_out[1] ;
 wire \sw_009_module_data_out[2] ;
 wire \sw_009_module_data_out[3] ;
 wire \sw_009_module_data_out[4] ;
 wire \sw_009_module_data_out[5] ;
 wire \sw_009_module_data_out[6] ;
 wire \sw_009_module_data_out[7] ;
 wire sw_009_scan_out;
 wire sw_010_clk_out;
 wire sw_010_data_out;
 wire sw_010_latch_out;
 wire \sw_010_module_data_in[0] ;
 wire \sw_010_module_data_in[1] ;
 wire \sw_010_module_data_in[2] ;
 wire \sw_010_module_data_in[3] ;
 wire \sw_010_module_data_in[4] ;
 wire \sw_010_module_data_in[5] ;
 wire \sw_010_module_data_in[6] ;
 wire \sw_010_module_data_in[7] ;
 wire \sw_010_module_data_out[0] ;
 wire \sw_010_module_data_out[1] ;
 wire \sw_010_module_data_out[2] ;
 wire \sw_010_module_data_out[3] ;
 wire \sw_010_module_data_out[4] ;
 wire \sw_010_module_data_out[5] ;
 wire \sw_010_module_data_out[6] ;
 wire \sw_010_module_data_out[7] ;
 wire sw_010_scan_out;
 wire sw_011_clk_out;
 wire sw_011_data_out;
 wire sw_011_latch_out;
 wire \sw_011_module_data_in[0] ;
 wire \sw_011_module_data_in[1] ;
 wire \sw_011_module_data_in[2] ;
 wire \sw_011_module_data_in[3] ;
 wire \sw_011_module_data_in[4] ;
 wire \sw_011_module_data_in[5] ;
 wire \sw_011_module_data_in[6] ;
 wire \sw_011_module_data_in[7] ;
 wire \sw_011_module_data_out[0] ;
 wire \sw_011_module_data_out[1] ;
 wire \sw_011_module_data_out[2] ;
 wire \sw_011_module_data_out[3] ;
 wire \sw_011_module_data_out[4] ;
 wire \sw_011_module_data_out[5] ;
 wire \sw_011_module_data_out[6] ;
 wire \sw_011_module_data_out[7] ;
 wire sw_011_scan_out;
 wire sw_012_clk_out;
 wire sw_012_data_out;
 wire sw_012_latch_out;
 wire \sw_012_module_data_in[0] ;
 wire \sw_012_module_data_in[1] ;
 wire \sw_012_module_data_in[2] ;
 wire \sw_012_module_data_in[3] ;
 wire \sw_012_module_data_in[4] ;
 wire \sw_012_module_data_in[5] ;
 wire \sw_012_module_data_in[6] ;
 wire \sw_012_module_data_in[7] ;
 wire \sw_012_module_data_out[0] ;
 wire \sw_012_module_data_out[1] ;
 wire \sw_012_module_data_out[2] ;
 wire \sw_012_module_data_out[3] ;
 wire \sw_012_module_data_out[4] ;
 wire \sw_012_module_data_out[5] ;
 wire \sw_012_module_data_out[6] ;
 wire \sw_012_module_data_out[7] ;
 wire sw_012_scan_out;
 wire sw_013_clk_out;
 wire sw_013_data_out;
 wire sw_013_latch_out;
 wire \sw_013_module_data_in[0] ;
 wire \sw_013_module_data_in[1] ;
 wire \sw_013_module_data_in[2] ;
 wire \sw_013_module_data_in[3] ;
 wire \sw_013_module_data_in[4] ;
 wire \sw_013_module_data_in[5] ;
 wire \sw_013_module_data_in[6] ;
 wire \sw_013_module_data_in[7] ;
 wire \sw_013_module_data_out[0] ;
 wire \sw_013_module_data_out[1] ;
 wire \sw_013_module_data_out[2] ;
 wire \sw_013_module_data_out[3] ;
 wire \sw_013_module_data_out[4] ;
 wire \sw_013_module_data_out[5] ;
 wire \sw_013_module_data_out[6] ;
 wire \sw_013_module_data_out[7] ;
 wire sw_013_scan_out;
 wire sw_014_clk_out;
 wire sw_014_data_out;
 wire sw_014_latch_out;
 wire \sw_014_module_data_in[0] ;
 wire \sw_014_module_data_in[1] ;
 wire \sw_014_module_data_in[2] ;
 wire \sw_014_module_data_in[3] ;
 wire \sw_014_module_data_in[4] ;
 wire \sw_014_module_data_in[5] ;
 wire \sw_014_module_data_in[6] ;
 wire \sw_014_module_data_in[7] ;
 wire \sw_014_module_data_out[0] ;
 wire \sw_014_module_data_out[1] ;
 wire \sw_014_module_data_out[2] ;
 wire \sw_014_module_data_out[3] ;
 wire \sw_014_module_data_out[4] ;
 wire \sw_014_module_data_out[5] ;
 wire \sw_014_module_data_out[6] ;
 wire \sw_014_module_data_out[7] ;
 wire sw_014_scan_out;
 wire sw_015_clk_out;
 wire sw_015_data_out;
 wire sw_015_latch_out;
 wire \sw_015_module_data_in[0] ;
 wire \sw_015_module_data_in[1] ;
 wire \sw_015_module_data_in[2] ;
 wire \sw_015_module_data_in[3] ;
 wire \sw_015_module_data_in[4] ;
 wire \sw_015_module_data_in[5] ;
 wire \sw_015_module_data_in[6] ;
 wire \sw_015_module_data_in[7] ;
 wire \sw_015_module_data_out[0] ;
 wire \sw_015_module_data_out[1] ;
 wire \sw_015_module_data_out[2] ;
 wire \sw_015_module_data_out[3] ;
 wire \sw_015_module_data_out[4] ;
 wire \sw_015_module_data_out[5] ;
 wire \sw_015_module_data_out[6] ;
 wire \sw_015_module_data_out[7] ;
 wire sw_015_scan_out;
 wire sw_016_clk_out;
 wire sw_016_data_out;
 wire sw_016_latch_out;
 wire \sw_016_module_data_in[0] ;
 wire \sw_016_module_data_in[1] ;
 wire \sw_016_module_data_in[2] ;
 wire \sw_016_module_data_in[3] ;
 wire \sw_016_module_data_in[4] ;
 wire \sw_016_module_data_in[5] ;
 wire \sw_016_module_data_in[6] ;
 wire \sw_016_module_data_in[7] ;
 wire \sw_016_module_data_out[0] ;
 wire \sw_016_module_data_out[1] ;
 wire \sw_016_module_data_out[2] ;
 wire \sw_016_module_data_out[3] ;
 wire \sw_016_module_data_out[4] ;
 wire \sw_016_module_data_out[5] ;
 wire \sw_016_module_data_out[6] ;
 wire \sw_016_module_data_out[7] ;
 wire sw_016_scan_out;
 wire sw_017_clk_out;
 wire sw_017_data_out;
 wire sw_017_latch_out;
 wire \sw_017_module_data_in[0] ;
 wire \sw_017_module_data_in[1] ;
 wire \sw_017_module_data_in[2] ;
 wire \sw_017_module_data_in[3] ;
 wire \sw_017_module_data_in[4] ;
 wire \sw_017_module_data_in[5] ;
 wire \sw_017_module_data_in[6] ;
 wire \sw_017_module_data_in[7] ;
 wire \sw_017_module_data_out[0] ;
 wire \sw_017_module_data_out[1] ;
 wire \sw_017_module_data_out[2] ;
 wire \sw_017_module_data_out[3] ;
 wire \sw_017_module_data_out[4] ;
 wire \sw_017_module_data_out[5] ;
 wire \sw_017_module_data_out[6] ;
 wire \sw_017_module_data_out[7] ;
 wire sw_017_scan_out;
 wire sw_018_clk_out;
 wire sw_018_data_out;
 wire sw_018_latch_out;
 wire \sw_018_module_data_in[0] ;
 wire \sw_018_module_data_in[1] ;
 wire \sw_018_module_data_in[2] ;
 wire \sw_018_module_data_in[3] ;
 wire \sw_018_module_data_in[4] ;
 wire \sw_018_module_data_in[5] ;
 wire \sw_018_module_data_in[6] ;
 wire \sw_018_module_data_in[7] ;
 wire \sw_018_module_data_out[0] ;
 wire \sw_018_module_data_out[1] ;
 wire \sw_018_module_data_out[2] ;
 wire \sw_018_module_data_out[3] ;
 wire \sw_018_module_data_out[4] ;
 wire \sw_018_module_data_out[5] ;
 wire \sw_018_module_data_out[6] ;
 wire \sw_018_module_data_out[7] ;
 wire sw_018_scan_out;
 wire sw_019_clk_out;
 wire sw_019_data_out;
 wire sw_019_latch_out;
 wire \sw_019_module_data_in[0] ;
 wire \sw_019_module_data_in[1] ;
 wire \sw_019_module_data_in[2] ;
 wire \sw_019_module_data_in[3] ;
 wire \sw_019_module_data_in[4] ;
 wire \sw_019_module_data_in[5] ;
 wire \sw_019_module_data_in[6] ;
 wire \sw_019_module_data_in[7] ;
 wire \sw_019_module_data_out[0] ;
 wire \sw_019_module_data_out[1] ;
 wire \sw_019_module_data_out[2] ;
 wire \sw_019_module_data_out[3] ;
 wire \sw_019_module_data_out[4] ;
 wire \sw_019_module_data_out[5] ;
 wire \sw_019_module_data_out[6] ;
 wire \sw_019_module_data_out[7] ;
 wire sw_019_scan_out;
 wire sw_020_clk_out;
 wire sw_020_data_out;
 wire sw_020_latch_out;
 wire \sw_020_module_data_in[0] ;
 wire \sw_020_module_data_in[1] ;
 wire \sw_020_module_data_in[2] ;
 wire \sw_020_module_data_in[3] ;
 wire \sw_020_module_data_in[4] ;
 wire \sw_020_module_data_in[5] ;
 wire \sw_020_module_data_in[6] ;
 wire \sw_020_module_data_in[7] ;
 wire \sw_020_module_data_out[0] ;
 wire \sw_020_module_data_out[1] ;
 wire \sw_020_module_data_out[2] ;
 wire \sw_020_module_data_out[3] ;
 wire \sw_020_module_data_out[4] ;
 wire \sw_020_module_data_out[5] ;
 wire \sw_020_module_data_out[6] ;
 wire \sw_020_module_data_out[7] ;
 wire sw_020_scan_out;
 wire sw_021_clk_out;
 wire sw_021_data_out;
 wire sw_021_latch_out;
 wire \sw_021_module_data_in[0] ;
 wire \sw_021_module_data_in[1] ;
 wire \sw_021_module_data_in[2] ;
 wire \sw_021_module_data_in[3] ;
 wire \sw_021_module_data_in[4] ;
 wire \sw_021_module_data_in[5] ;
 wire \sw_021_module_data_in[6] ;
 wire \sw_021_module_data_in[7] ;
 wire \sw_021_module_data_out[0] ;
 wire \sw_021_module_data_out[1] ;
 wire \sw_021_module_data_out[2] ;
 wire \sw_021_module_data_out[3] ;
 wire \sw_021_module_data_out[4] ;
 wire \sw_021_module_data_out[5] ;
 wire \sw_021_module_data_out[6] ;
 wire \sw_021_module_data_out[7] ;
 wire sw_021_scan_out;
 wire sw_022_clk_out;
 wire sw_022_data_out;
 wire sw_022_latch_out;
 wire \sw_022_module_data_in[0] ;
 wire \sw_022_module_data_in[1] ;
 wire \sw_022_module_data_in[2] ;
 wire \sw_022_module_data_in[3] ;
 wire \sw_022_module_data_in[4] ;
 wire \sw_022_module_data_in[5] ;
 wire \sw_022_module_data_in[6] ;
 wire \sw_022_module_data_in[7] ;
 wire \sw_022_module_data_out[0] ;
 wire \sw_022_module_data_out[1] ;
 wire \sw_022_module_data_out[2] ;
 wire \sw_022_module_data_out[3] ;
 wire \sw_022_module_data_out[4] ;
 wire \sw_022_module_data_out[5] ;
 wire \sw_022_module_data_out[6] ;
 wire \sw_022_module_data_out[7] ;
 wire sw_022_scan_out;
 wire sw_023_clk_out;
 wire sw_023_data_out;
 wire sw_023_latch_out;
 wire \sw_023_module_data_in[0] ;
 wire \sw_023_module_data_in[1] ;
 wire \sw_023_module_data_in[2] ;
 wire \sw_023_module_data_in[3] ;
 wire \sw_023_module_data_in[4] ;
 wire \sw_023_module_data_in[5] ;
 wire \sw_023_module_data_in[6] ;
 wire \sw_023_module_data_in[7] ;
 wire \sw_023_module_data_out[0] ;
 wire \sw_023_module_data_out[1] ;
 wire \sw_023_module_data_out[2] ;
 wire \sw_023_module_data_out[3] ;
 wire \sw_023_module_data_out[4] ;
 wire \sw_023_module_data_out[5] ;
 wire \sw_023_module_data_out[6] ;
 wire \sw_023_module_data_out[7] ;
 wire sw_023_scan_out;
 wire sw_024_clk_out;
 wire sw_024_data_out;
 wire sw_024_latch_out;
 wire \sw_024_module_data_in[0] ;
 wire \sw_024_module_data_in[1] ;
 wire \sw_024_module_data_in[2] ;
 wire \sw_024_module_data_in[3] ;
 wire \sw_024_module_data_in[4] ;
 wire \sw_024_module_data_in[5] ;
 wire \sw_024_module_data_in[6] ;
 wire \sw_024_module_data_in[7] ;
 wire \sw_024_module_data_out[0] ;
 wire \sw_024_module_data_out[1] ;
 wire \sw_024_module_data_out[2] ;
 wire \sw_024_module_data_out[3] ;
 wire \sw_024_module_data_out[4] ;
 wire \sw_024_module_data_out[5] ;
 wire \sw_024_module_data_out[6] ;
 wire \sw_024_module_data_out[7] ;
 wire sw_024_scan_out;
 wire sw_025_clk_out;
 wire sw_025_data_out;
 wire sw_025_latch_out;
 wire \sw_025_module_data_in[0] ;
 wire \sw_025_module_data_in[1] ;
 wire \sw_025_module_data_in[2] ;
 wire \sw_025_module_data_in[3] ;
 wire \sw_025_module_data_in[4] ;
 wire \sw_025_module_data_in[5] ;
 wire \sw_025_module_data_in[6] ;
 wire \sw_025_module_data_in[7] ;
 wire \sw_025_module_data_out[0] ;
 wire \sw_025_module_data_out[1] ;
 wire \sw_025_module_data_out[2] ;
 wire \sw_025_module_data_out[3] ;
 wire \sw_025_module_data_out[4] ;
 wire \sw_025_module_data_out[5] ;
 wire \sw_025_module_data_out[6] ;
 wire \sw_025_module_data_out[7] ;
 wire sw_025_scan_out;
 wire sw_026_clk_out;
 wire sw_026_data_out;
 wire sw_026_latch_out;
 wire \sw_026_module_data_in[0] ;
 wire \sw_026_module_data_in[1] ;
 wire \sw_026_module_data_in[2] ;
 wire \sw_026_module_data_in[3] ;
 wire \sw_026_module_data_in[4] ;
 wire \sw_026_module_data_in[5] ;
 wire \sw_026_module_data_in[6] ;
 wire \sw_026_module_data_in[7] ;
 wire \sw_026_module_data_out[0] ;
 wire \sw_026_module_data_out[1] ;
 wire \sw_026_module_data_out[2] ;
 wire \sw_026_module_data_out[3] ;
 wire \sw_026_module_data_out[4] ;
 wire \sw_026_module_data_out[5] ;
 wire \sw_026_module_data_out[6] ;
 wire \sw_026_module_data_out[7] ;
 wire sw_026_scan_out;
 wire sw_027_clk_out;
 wire sw_027_data_out;
 wire sw_027_latch_out;
 wire \sw_027_module_data_in[0] ;
 wire \sw_027_module_data_in[1] ;
 wire \sw_027_module_data_in[2] ;
 wire \sw_027_module_data_in[3] ;
 wire \sw_027_module_data_in[4] ;
 wire \sw_027_module_data_in[5] ;
 wire \sw_027_module_data_in[6] ;
 wire \sw_027_module_data_in[7] ;
 wire \sw_027_module_data_out[0] ;
 wire \sw_027_module_data_out[1] ;
 wire \sw_027_module_data_out[2] ;
 wire \sw_027_module_data_out[3] ;
 wire \sw_027_module_data_out[4] ;
 wire \sw_027_module_data_out[5] ;
 wire \sw_027_module_data_out[6] ;
 wire \sw_027_module_data_out[7] ;
 wire sw_027_scan_out;
 wire sw_028_clk_out;
 wire sw_028_data_out;
 wire sw_028_latch_out;
 wire \sw_028_module_data_in[0] ;
 wire \sw_028_module_data_in[1] ;
 wire \sw_028_module_data_in[2] ;
 wire \sw_028_module_data_in[3] ;
 wire \sw_028_module_data_in[4] ;
 wire \sw_028_module_data_in[5] ;
 wire \sw_028_module_data_in[6] ;
 wire \sw_028_module_data_in[7] ;
 wire \sw_028_module_data_out[0] ;
 wire \sw_028_module_data_out[1] ;
 wire \sw_028_module_data_out[2] ;
 wire \sw_028_module_data_out[3] ;
 wire \sw_028_module_data_out[4] ;
 wire \sw_028_module_data_out[5] ;
 wire \sw_028_module_data_out[6] ;
 wire \sw_028_module_data_out[7] ;
 wire sw_028_scan_out;
 wire sw_029_latch_out;
 wire \sw_029_module_data_in[0] ;
 wire \sw_029_module_data_in[1] ;
 wire \sw_029_module_data_in[2] ;
 wire \sw_029_module_data_in[3] ;
 wire \sw_029_module_data_in[4] ;
 wire \sw_029_module_data_in[5] ;
 wire \sw_029_module_data_in[6] ;
 wire \sw_029_module_data_in[7] ;
 wire \sw_029_module_data_out[0] ;
 wire \sw_029_module_data_out[1] ;
 wire \sw_029_module_data_out[2] ;
 wire \sw_029_module_data_out[3] ;
 wire \sw_029_module_data_out[4] ;
 wire \sw_029_module_data_out[5] ;
 wire \sw_029_module_data_out[6] ;
 wire \sw_029_module_data_out[7] ;
 wire sw_029_scan_out;

 scan_controller scan_controller (.clk(wb_clk_i),
    .la_scan_clk_in(la_data_in[0]),
    .la_scan_data_in(la_data_in[1]),
    .la_scan_data_out(la_data_out[0]),
    .la_scan_latch_en(la_data_in[3]),
    .la_scan_select(la_data_in[2]),
    .ready(io_out[37]),
    .reset(wb_rst_i),
    .scan_clk_in(sc_clk_in),
    .scan_clk_out(sc_clk_out),
    .scan_data_in(sc_data_in),
    .scan_data_out(sc_data_out),
    .scan_latch_en(sc_latch_out),
    .scan_select(sc_scan_out),
    .set_clk_div(io_in[11]),
    .slow_clk(io_out[10]),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .active_select({io_in[20],
    io_in[19],
    io_in[18],
    io_in[17],
    io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12]}),
    .driver_sel({io_in[9],
    io_in[8]}),
    .inputs({io_in[28],
    io_in[27],
    io_in[26],
    io_in[25],
    io_in[24],
    io_in[23],
    io_in[22],
    io_in[21]}),
    .oeb({io_oeb[37],
    io_oeb[36],
    io_oeb[35],
    io_oeb[34],
    io_oeb[33],
    io_oeb[32],
    io_oeb[31],
    io_oeb[30],
    io_oeb[29],
    io_oeb[28],
    io_oeb[27],
    io_oeb[26],
    io_oeb[25],
    io_oeb[24],
    io_oeb[23],
    io_oeb[22],
    io_oeb[21],
    io_oeb[20],
    io_oeb[19],
    io_oeb[18],
    io_oeb[17],
    io_oeb[16],
    io_oeb[15],
    io_oeb[14],
    io_oeb[13],
    io_oeb[12],
    io_oeb[11],
    io_oeb[10],
    io_oeb[9],
    io_oeb[8],
    io_oeb[7],
    io_oeb[6],
    io_oeb[5],
    io_oeb[4],
    io_oeb[3],
    io_oeb[2],
    io_oeb[1],
    io_oeb[0]}),
    .outputs({io_out[36],
    io_out[35],
    io_out[34],
    io_out[33],
    io_out[32],
    io_out[31],
    io_out[30],
    io_out[29]}));
 scanchain scanchain_0 (.clk_in(sc_clk_out),
    .clk_out(sw_000_clk_out),
    .data_in(sc_data_out),
    .data_out(sw_000_data_out),
    .latch_enable_in(sc_latch_out),
    .latch_enable_out(sw_000_latch_out),
    .scan_select_in(sc_scan_out),
    .scan_select_out(sw_000_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_000_module_data_in[7] ,
    \sw_000_module_data_in[6] ,
    \sw_000_module_data_in[5] ,
    \sw_000_module_data_in[4] ,
    \sw_000_module_data_in[3] ,
    \sw_000_module_data_in[2] ,
    \sw_000_module_data_in[1] ,
    \sw_000_module_data_in[0] }),
    .module_data_out({\sw_000_module_data_out[7] ,
    \sw_000_module_data_out[6] ,
    \sw_000_module_data_out[5] ,
    \sw_000_module_data_out[4] ,
    \sw_000_module_data_out[3] ,
    \sw_000_module_data_out[2] ,
    \sw_000_module_data_out[1] ,
    \sw_000_module_data_out[0] }));
 scanchain scanchain_1 (.clk_in(sw_000_clk_out),
    .clk_out(sw_001_clk_out),
    .data_in(sw_000_data_out),
    .data_out(sw_001_data_out),
    .latch_enable_in(sw_000_latch_out),
    .latch_enable_out(sw_001_latch_out),
    .scan_select_in(sw_000_scan_out),
    .scan_select_out(sw_001_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_001_module_data_in[7] ,
    \sw_001_module_data_in[6] ,
    \sw_001_module_data_in[5] ,
    \sw_001_module_data_in[4] ,
    \sw_001_module_data_in[3] ,
    \sw_001_module_data_in[2] ,
    \sw_001_module_data_in[1] ,
    \sw_001_module_data_in[0] }),
    .module_data_out({\sw_001_module_data_out[7] ,
    \sw_001_module_data_out[6] ,
    \sw_001_module_data_out[5] ,
    \sw_001_module_data_out[4] ,
    \sw_001_module_data_out[3] ,
    \sw_001_module_data_out[2] ,
    \sw_001_module_data_out[1] ,
    \sw_001_module_data_out[0] }));
 scanchain scanchain_10 (.clk_in(sw_009_clk_out),
    .clk_out(sw_010_clk_out),
    .data_in(sw_009_data_out),
    .data_out(sw_010_data_out),
    .latch_enable_in(sw_009_latch_out),
    .latch_enable_out(sw_010_latch_out),
    .scan_select_in(sw_009_scan_out),
    .scan_select_out(sw_010_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_010_module_data_in[7] ,
    \sw_010_module_data_in[6] ,
    \sw_010_module_data_in[5] ,
    \sw_010_module_data_in[4] ,
    \sw_010_module_data_in[3] ,
    \sw_010_module_data_in[2] ,
    \sw_010_module_data_in[1] ,
    \sw_010_module_data_in[0] }),
    .module_data_out({\sw_010_module_data_out[7] ,
    \sw_010_module_data_out[6] ,
    \sw_010_module_data_out[5] ,
    \sw_010_module_data_out[4] ,
    \sw_010_module_data_out[3] ,
    \sw_010_module_data_out[2] ,
    \sw_010_module_data_out[1] ,
    \sw_010_module_data_out[0] }));
 scanchain scanchain_11 (.clk_in(sw_010_clk_out),
    .clk_out(sw_011_clk_out),
    .data_in(sw_010_data_out),
    .data_out(sw_011_data_out),
    .latch_enable_in(sw_010_latch_out),
    .latch_enable_out(sw_011_latch_out),
    .scan_select_in(sw_010_scan_out),
    .scan_select_out(sw_011_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_011_module_data_in[7] ,
    \sw_011_module_data_in[6] ,
    \sw_011_module_data_in[5] ,
    \sw_011_module_data_in[4] ,
    \sw_011_module_data_in[3] ,
    \sw_011_module_data_in[2] ,
    \sw_011_module_data_in[1] ,
    \sw_011_module_data_in[0] }),
    .module_data_out({\sw_011_module_data_out[7] ,
    \sw_011_module_data_out[6] ,
    \sw_011_module_data_out[5] ,
    \sw_011_module_data_out[4] ,
    \sw_011_module_data_out[3] ,
    \sw_011_module_data_out[2] ,
    \sw_011_module_data_out[1] ,
    \sw_011_module_data_out[0] }));
 scanchain scanchain_12 (.clk_in(sw_011_clk_out),
    .clk_out(sw_012_clk_out),
    .data_in(sw_011_data_out),
    .data_out(sw_012_data_out),
    .latch_enable_in(sw_011_latch_out),
    .latch_enable_out(sw_012_latch_out),
    .scan_select_in(sw_011_scan_out),
    .scan_select_out(sw_012_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_012_module_data_in[7] ,
    \sw_012_module_data_in[6] ,
    \sw_012_module_data_in[5] ,
    \sw_012_module_data_in[4] ,
    \sw_012_module_data_in[3] ,
    \sw_012_module_data_in[2] ,
    \sw_012_module_data_in[1] ,
    \sw_012_module_data_in[0] }),
    .module_data_out({\sw_012_module_data_out[7] ,
    \sw_012_module_data_out[6] ,
    \sw_012_module_data_out[5] ,
    \sw_012_module_data_out[4] ,
    \sw_012_module_data_out[3] ,
    \sw_012_module_data_out[2] ,
    \sw_012_module_data_out[1] ,
    \sw_012_module_data_out[0] }));
 scanchain scanchain_13 (.clk_in(sw_012_clk_out),
    .clk_out(sw_013_clk_out),
    .data_in(sw_012_data_out),
    .data_out(sw_013_data_out),
    .latch_enable_in(sw_012_latch_out),
    .latch_enable_out(sw_013_latch_out),
    .scan_select_in(sw_012_scan_out),
    .scan_select_out(sw_013_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_013_module_data_in[7] ,
    \sw_013_module_data_in[6] ,
    \sw_013_module_data_in[5] ,
    \sw_013_module_data_in[4] ,
    \sw_013_module_data_in[3] ,
    \sw_013_module_data_in[2] ,
    \sw_013_module_data_in[1] ,
    \sw_013_module_data_in[0] }),
    .module_data_out({\sw_013_module_data_out[7] ,
    \sw_013_module_data_out[6] ,
    \sw_013_module_data_out[5] ,
    \sw_013_module_data_out[4] ,
    \sw_013_module_data_out[3] ,
    \sw_013_module_data_out[2] ,
    \sw_013_module_data_out[1] ,
    \sw_013_module_data_out[0] }));
 scanchain scanchain_14 (.clk_in(sw_013_clk_out),
    .clk_out(sw_014_clk_out),
    .data_in(sw_013_data_out),
    .data_out(sw_014_data_out),
    .latch_enable_in(sw_013_latch_out),
    .latch_enable_out(sw_014_latch_out),
    .scan_select_in(sw_013_scan_out),
    .scan_select_out(sw_014_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_014_module_data_in[7] ,
    \sw_014_module_data_in[6] ,
    \sw_014_module_data_in[5] ,
    \sw_014_module_data_in[4] ,
    \sw_014_module_data_in[3] ,
    \sw_014_module_data_in[2] ,
    \sw_014_module_data_in[1] ,
    \sw_014_module_data_in[0] }),
    .module_data_out({\sw_014_module_data_out[7] ,
    \sw_014_module_data_out[6] ,
    \sw_014_module_data_out[5] ,
    \sw_014_module_data_out[4] ,
    \sw_014_module_data_out[3] ,
    \sw_014_module_data_out[2] ,
    \sw_014_module_data_out[1] ,
    \sw_014_module_data_out[0] }));
 scanchain scanchain_15 (.clk_in(sw_014_clk_out),
    .clk_out(sw_015_clk_out),
    .data_in(sw_014_data_out),
    .data_out(sw_015_data_out),
    .latch_enable_in(sw_014_latch_out),
    .latch_enable_out(sw_015_latch_out),
    .scan_select_in(sw_014_scan_out),
    .scan_select_out(sw_015_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_015_module_data_in[7] ,
    \sw_015_module_data_in[6] ,
    \sw_015_module_data_in[5] ,
    \sw_015_module_data_in[4] ,
    \sw_015_module_data_in[3] ,
    \sw_015_module_data_in[2] ,
    \sw_015_module_data_in[1] ,
    \sw_015_module_data_in[0] }),
    .module_data_out({\sw_015_module_data_out[7] ,
    \sw_015_module_data_out[6] ,
    \sw_015_module_data_out[5] ,
    \sw_015_module_data_out[4] ,
    \sw_015_module_data_out[3] ,
    \sw_015_module_data_out[2] ,
    \sw_015_module_data_out[1] ,
    \sw_015_module_data_out[0] }));
 scanchain scanchain_16 (.clk_in(sw_015_clk_out),
    .clk_out(sw_016_clk_out),
    .data_in(sw_015_data_out),
    .data_out(sw_016_data_out),
    .latch_enable_in(sw_015_latch_out),
    .latch_enable_out(sw_016_latch_out),
    .scan_select_in(sw_015_scan_out),
    .scan_select_out(sw_016_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_016_module_data_in[7] ,
    \sw_016_module_data_in[6] ,
    \sw_016_module_data_in[5] ,
    \sw_016_module_data_in[4] ,
    \sw_016_module_data_in[3] ,
    \sw_016_module_data_in[2] ,
    \sw_016_module_data_in[1] ,
    \sw_016_module_data_in[0] }),
    .module_data_out({\sw_016_module_data_out[7] ,
    \sw_016_module_data_out[6] ,
    \sw_016_module_data_out[5] ,
    \sw_016_module_data_out[4] ,
    \sw_016_module_data_out[3] ,
    \sw_016_module_data_out[2] ,
    \sw_016_module_data_out[1] ,
    \sw_016_module_data_out[0] }));
 scanchain scanchain_17 (.clk_in(sw_016_clk_out),
    .clk_out(sw_017_clk_out),
    .data_in(sw_016_data_out),
    .data_out(sw_017_data_out),
    .latch_enable_in(sw_016_latch_out),
    .latch_enable_out(sw_017_latch_out),
    .scan_select_in(sw_016_scan_out),
    .scan_select_out(sw_017_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_017_module_data_in[7] ,
    \sw_017_module_data_in[6] ,
    \sw_017_module_data_in[5] ,
    \sw_017_module_data_in[4] ,
    \sw_017_module_data_in[3] ,
    \sw_017_module_data_in[2] ,
    \sw_017_module_data_in[1] ,
    \sw_017_module_data_in[0] }),
    .module_data_out({\sw_017_module_data_out[7] ,
    \sw_017_module_data_out[6] ,
    \sw_017_module_data_out[5] ,
    \sw_017_module_data_out[4] ,
    \sw_017_module_data_out[3] ,
    \sw_017_module_data_out[2] ,
    \sw_017_module_data_out[1] ,
    \sw_017_module_data_out[0] }));
 scanchain scanchain_18 (.clk_in(sw_017_clk_out),
    .clk_out(sw_018_clk_out),
    .data_in(sw_017_data_out),
    .data_out(sw_018_data_out),
    .latch_enable_in(sw_017_latch_out),
    .latch_enable_out(sw_018_latch_out),
    .scan_select_in(sw_017_scan_out),
    .scan_select_out(sw_018_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_018_module_data_in[7] ,
    \sw_018_module_data_in[6] ,
    \sw_018_module_data_in[5] ,
    \sw_018_module_data_in[4] ,
    \sw_018_module_data_in[3] ,
    \sw_018_module_data_in[2] ,
    \sw_018_module_data_in[1] ,
    \sw_018_module_data_in[0] }),
    .module_data_out({\sw_018_module_data_out[7] ,
    \sw_018_module_data_out[6] ,
    \sw_018_module_data_out[5] ,
    \sw_018_module_data_out[4] ,
    \sw_018_module_data_out[3] ,
    \sw_018_module_data_out[2] ,
    \sw_018_module_data_out[1] ,
    \sw_018_module_data_out[0] }));
 scanchain scanchain_19 (.clk_in(sw_018_clk_out),
    .clk_out(sw_019_clk_out),
    .data_in(sw_018_data_out),
    .data_out(sw_019_data_out),
    .latch_enable_in(sw_018_latch_out),
    .latch_enable_out(sw_019_latch_out),
    .scan_select_in(sw_018_scan_out),
    .scan_select_out(sw_019_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_019_module_data_in[7] ,
    \sw_019_module_data_in[6] ,
    \sw_019_module_data_in[5] ,
    \sw_019_module_data_in[4] ,
    \sw_019_module_data_in[3] ,
    \sw_019_module_data_in[2] ,
    \sw_019_module_data_in[1] ,
    \sw_019_module_data_in[0] }),
    .module_data_out({\sw_019_module_data_out[7] ,
    \sw_019_module_data_out[6] ,
    \sw_019_module_data_out[5] ,
    \sw_019_module_data_out[4] ,
    \sw_019_module_data_out[3] ,
    \sw_019_module_data_out[2] ,
    \sw_019_module_data_out[1] ,
    \sw_019_module_data_out[0] }));
 scanchain scanchain_2 (.clk_in(sw_001_clk_out),
    .clk_out(sw_002_clk_out),
    .data_in(sw_001_data_out),
    .data_out(sw_002_data_out),
    .latch_enable_in(sw_001_latch_out),
    .latch_enable_out(sw_002_latch_out),
    .scan_select_in(sw_001_scan_out),
    .scan_select_out(sw_002_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_002_module_data_in[7] ,
    \sw_002_module_data_in[6] ,
    \sw_002_module_data_in[5] ,
    \sw_002_module_data_in[4] ,
    \sw_002_module_data_in[3] ,
    \sw_002_module_data_in[2] ,
    \sw_002_module_data_in[1] ,
    \sw_002_module_data_in[0] }),
    .module_data_out({\sw_002_module_data_out[7] ,
    \sw_002_module_data_out[6] ,
    \sw_002_module_data_out[5] ,
    \sw_002_module_data_out[4] ,
    \sw_002_module_data_out[3] ,
    \sw_002_module_data_out[2] ,
    \sw_002_module_data_out[1] ,
    \sw_002_module_data_out[0] }));
 scanchain scanchain_20 (.clk_in(sw_019_clk_out),
    .clk_out(sw_020_clk_out),
    .data_in(sw_019_data_out),
    .data_out(sw_020_data_out),
    .latch_enable_in(sw_019_latch_out),
    .latch_enable_out(sw_020_latch_out),
    .scan_select_in(sw_019_scan_out),
    .scan_select_out(sw_020_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_020_module_data_in[7] ,
    \sw_020_module_data_in[6] ,
    \sw_020_module_data_in[5] ,
    \sw_020_module_data_in[4] ,
    \sw_020_module_data_in[3] ,
    \sw_020_module_data_in[2] ,
    \sw_020_module_data_in[1] ,
    \sw_020_module_data_in[0] }),
    .module_data_out({\sw_020_module_data_out[7] ,
    \sw_020_module_data_out[6] ,
    \sw_020_module_data_out[5] ,
    \sw_020_module_data_out[4] ,
    \sw_020_module_data_out[3] ,
    \sw_020_module_data_out[2] ,
    \sw_020_module_data_out[1] ,
    \sw_020_module_data_out[0] }));
 scanchain scanchain_21 (.clk_in(sw_020_clk_out),
    .clk_out(sw_021_clk_out),
    .data_in(sw_020_data_out),
    .data_out(sw_021_data_out),
    .latch_enable_in(sw_020_latch_out),
    .latch_enable_out(sw_021_latch_out),
    .scan_select_in(sw_020_scan_out),
    .scan_select_out(sw_021_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_021_module_data_in[7] ,
    \sw_021_module_data_in[6] ,
    \sw_021_module_data_in[5] ,
    \sw_021_module_data_in[4] ,
    \sw_021_module_data_in[3] ,
    \sw_021_module_data_in[2] ,
    \sw_021_module_data_in[1] ,
    \sw_021_module_data_in[0] }),
    .module_data_out({\sw_021_module_data_out[7] ,
    \sw_021_module_data_out[6] ,
    \sw_021_module_data_out[5] ,
    \sw_021_module_data_out[4] ,
    \sw_021_module_data_out[3] ,
    \sw_021_module_data_out[2] ,
    \sw_021_module_data_out[1] ,
    \sw_021_module_data_out[0] }));
 scanchain scanchain_22 (.clk_in(sw_021_clk_out),
    .clk_out(sw_022_clk_out),
    .data_in(sw_021_data_out),
    .data_out(sw_022_data_out),
    .latch_enable_in(sw_021_latch_out),
    .latch_enable_out(sw_022_latch_out),
    .scan_select_in(sw_021_scan_out),
    .scan_select_out(sw_022_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_022_module_data_in[7] ,
    \sw_022_module_data_in[6] ,
    \sw_022_module_data_in[5] ,
    \sw_022_module_data_in[4] ,
    \sw_022_module_data_in[3] ,
    \sw_022_module_data_in[2] ,
    \sw_022_module_data_in[1] ,
    \sw_022_module_data_in[0] }),
    .module_data_out({\sw_022_module_data_out[7] ,
    \sw_022_module_data_out[6] ,
    \sw_022_module_data_out[5] ,
    \sw_022_module_data_out[4] ,
    \sw_022_module_data_out[3] ,
    \sw_022_module_data_out[2] ,
    \sw_022_module_data_out[1] ,
    \sw_022_module_data_out[0] }));
 scanchain scanchain_23 (.clk_in(sw_022_clk_out),
    .clk_out(sw_023_clk_out),
    .data_in(sw_022_data_out),
    .data_out(sw_023_data_out),
    .latch_enable_in(sw_022_latch_out),
    .latch_enable_out(sw_023_latch_out),
    .scan_select_in(sw_022_scan_out),
    .scan_select_out(sw_023_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_023_module_data_in[7] ,
    \sw_023_module_data_in[6] ,
    \sw_023_module_data_in[5] ,
    \sw_023_module_data_in[4] ,
    \sw_023_module_data_in[3] ,
    \sw_023_module_data_in[2] ,
    \sw_023_module_data_in[1] ,
    \sw_023_module_data_in[0] }),
    .module_data_out({\sw_023_module_data_out[7] ,
    \sw_023_module_data_out[6] ,
    \sw_023_module_data_out[5] ,
    \sw_023_module_data_out[4] ,
    \sw_023_module_data_out[3] ,
    \sw_023_module_data_out[2] ,
    \sw_023_module_data_out[1] ,
    \sw_023_module_data_out[0] }));
 scanchain scanchain_24 (.clk_in(sw_023_clk_out),
    .clk_out(sw_024_clk_out),
    .data_in(sw_023_data_out),
    .data_out(sw_024_data_out),
    .latch_enable_in(sw_023_latch_out),
    .latch_enable_out(sw_024_latch_out),
    .scan_select_in(sw_023_scan_out),
    .scan_select_out(sw_024_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_024_module_data_in[7] ,
    \sw_024_module_data_in[6] ,
    \sw_024_module_data_in[5] ,
    \sw_024_module_data_in[4] ,
    \sw_024_module_data_in[3] ,
    \sw_024_module_data_in[2] ,
    \sw_024_module_data_in[1] ,
    \sw_024_module_data_in[0] }),
    .module_data_out({\sw_024_module_data_out[7] ,
    \sw_024_module_data_out[6] ,
    \sw_024_module_data_out[5] ,
    \sw_024_module_data_out[4] ,
    \sw_024_module_data_out[3] ,
    \sw_024_module_data_out[2] ,
    \sw_024_module_data_out[1] ,
    \sw_024_module_data_out[0] }));
 scanchain scanchain_25 (.clk_in(sw_024_clk_out),
    .clk_out(sw_025_clk_out),
    .data_in(sw_024_data_out),
    .data_out(sw_025_data_out),
    .latch_enable_in(sw_024_latch_out),
    .latch_enable_out(sw_025_latch_out),
    .scan_select_in(sw_024_scan_out),
    .scan_select_out(sw_025_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_025_module_data_in[7] ,
    \sw_025_module_data_in[6] ,
    \sw_025_module_data_in[5] ,
    \sw_025_module_data_in[4] ,
    \sw_025_module_data_in[3] ,
    \sw_025_module_data_in[2] ,
    \sw_025_module_data_in[1] ,
    \sw_025_module_data_in[0] }),
    .module_data_out({\sw_025_module_data_out[7] ,
    \sw_025_module_data_out[6] ,
    \sw_025_module_data_out[5] ,
    \sw_025_module_data_out[4] ,
    \sw_025_module_data_out[3] ,
    \sw_025_module_data_out[2] ,
    \sw_025_module_data_out[1] ,
    \sw_025_module_data_out[0] }));
 scanchain scanchain_26 (.clk_in(sw_025_clk_out),
    .clk_out(sw_026_clk_out),
    .data_in(sw_025_data_out),
    .data_out(sw_026_data_out),
    .latch_enable_in(sw_025_latch_out),
    .latch_enable_out(sw_026_latch_out),
    .scan_select_in(sw_025_scan_out),
    .scan_select_out(sw_026_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_026_module_data_in[7] ,
    \sw_026_module_data_in[6] ,
    \sw_026_module_data_in[5] ,
    \sw_026_module_data_in[4] ,
    \sw_026_module_data_in[3] ,
    \sw_026_module_data_in[2] ,
    \sw_026_module_data_in[1] ,
    \sw_026_module_data_in[0] }),
    .module_data_out({\sw_026_module_data_out[7] ,
    \sw_026_module_data_out[6] ,
    \sw_026_module_data_out[5] ,
    \sw_026_module_data_out[4] ,
    \sw_026_module_data_out[3] ,
    \sw_026_module_data_out[2] ,
    \sw_026_module_data_out[1] ,
    \sw_026_module_data_out[0] }));
 scanchain scanchain_27 (.clk_in(sw_026_clk_out),
    .clk_out(sw_027_clk_out),
    .data_in(sw_026_data_out),
    .data_out(sw_027_data_out),
    .latch_enable_in(sw_026_latch_out),
    .latch_enable_out(sw_027_latch_out),
    .scan_select_in(sw_026_scan_out),
    .scan_select_out(sw_027_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_027_module_data_in[7] ,
    \sw_027_module_data_in[6] ,
    \sw_027_module_data_in[5] ,
    \sw_027_module_data_in[4] ,
    \sw_027_module_data_in[3] ,
    \sw_027_module_data_in[2] ,
    \sw_027_module_data_in[1] ,
    \sw_027_module_data_in[0] }),
    .module_data_out({\sw_027_module_data_out[7] ,
    \sw_027_module_data_out[6] ,
    \sw_027_module_data_out[5] ,
    \sw_027_module_data_out[4] ,
    \sw_027_module_data_out[3] ,
    \sw_027_module_data_out[2] ,
    \sw_027_module_data_out[1] ,
    \sw_027_module_data_out[0] }));
 scanchain scanchain_28 (.clk_in(sw_027_clk_out),
    .clk_out(sw_028_clk_out),
    .data_in(sw_027_data_out),
    .data_out(sw_028_data_out),
    .latch_enable_in(sw_027_latch_out),
    .latch_enable_out(sw_028_latch_out),
    .scan_select_in(sw_027_scan_out),
    .scan_select_out(sw_028_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_028_module_data_in[7] ,
    \sw_028_module_data_in[6] ,
    \sw_028_module_data_in[5] ,
    \sw_028_module_data_in[4] ,
    \sw_028_module_data_in[3] ,
    \sw_028_module_data_in[2] ,
    \sw_028_module_data_in[1] ,
    \sw_028_module_data_in[0] }),
    .module_data_out({\sw_028_module_data_out[7] ,
    \sw_028_module_data_out[6] ,
    \sw_028_module_data_out[5] ,
    \sw_028_module_data_out[4] ,
    \sw_028_module_data_out[3] ,
    \sw_028_module_data_out[2] ,
    \sw_028_module_data_out[1] ,
    \sw_028_module_data_out[0] }));
 scanchain scanchain_29 (.clk_in(sw_028_clk_out),
    .clk_out(sc_clk_in),
    .data_in(sw_028_data_out),
    .data_out(sc_data_in),
    .latch_enable_in(sw_028_latch_out),
    .latch_enable_out(sw_029_latch_out),
    .scan_select_in(sw_028_scan_out),
    .scan_select_out(sw_029_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_029_module_data_in[7] ,
    \sw_029_module_data_in[6] ,
    \sw_029_module_data_in[5] ,
    \sw_029_module_data_in[4] ,
    \sw_029_module_data_in[3] ,
    \sw_029_module_data_in[2] ,
    \sw_029_module_data_in[1] ,
    \sw_029_module_data_in[0] }),
    .module_data_out({\sw_029_module_data_out[7] ,
    \sw_029_module_data_out[6] ,
    \sw_029_module_data_out[5] ,
    \sw_029_module_data_out[4] ,
    \sw_029_module_data_out[3] ,
    \sw_029_module_data_out[2] ,
    \sw_029_module_data_out[1] ,
    \sw_029_module_data_out[0] }));
 scanchain scanchain_3 (.clk_in(sw_002_clk_out),
    .clk_out(sw_003_clk_out),
    .data_in(sw_002_data_out),
    .data_out(sw_003_data_out),
    .latch_enable_in(sw_002_latch_out),
    .latch_enable_out(sw_003_latch_out),
    .scan_select_in(sw_002_scan_out),
    .scan_select_out(sw_003_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_003_module_data_in[7] ,
    \sw_003_module_data_in[6] ,
    \sw_003_module_data_in[5] ,
    \sw_003_module_data_in[4] ,
    \sw_003_module_data_in[3] ,
    \sw_003_module_data_in[2] ,
    \sw_003_module_data_in[1] ,
    \sw_003_module_data_in[0] }),
    .module_data_out({\sw_003_module_data_out[7] ,
    \sw_003_module_data_out[6] ,
    \sw_003_module_data_out[5] ,
    \sw_003_module_data_out[4] ,
    \sw_003_module_data_out[3] ,
    \sw_003_module_data_out[2] ,
    \sw_003_module_data_out[1] ,
    \sw_003_module_data_out[0] }));
 scanchain scanchain_4 (.clk_in(sw_003_clk_out),
    .clk_out(sw_004_clk_out),
    .data_in(sw_003_data_out),
    .data_out(sw_004_data_out),
    .latch_enable_in(sw_003_latch_out),
    .latch_enable_out(sw_004_latch_out),
    .scan_select_in(sw_003_scan_out),
    .scan_select_out(sw_004_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_004_module_data_in[7] ,
    \sw_004_module_data_in[6] ,
    \sw_004_module_data_in[5] ,
    \sw_004_module_data_in[4] ,
    \sw_004_module_data_in[3] ,
    \sw_004_module_data_in[2] ,
    \sw_004_module_data_in[1] ,
    \sw_004_module_data_in[0] }),
    .module_data_out({\sw_004_module_data_out[7] ,
    \sw_004_module_data_out[6] ,
    \sw_004_module_data_out[5] ,
    \sw_004_module_data_out[4] ,
    \sw_004_module_data_out[3] ,
    \sw_004_module_data_out[2] ,
    \sw_004_module_data_out[1] ,
    \sw_004_module_data_out[0] }));
 scanchain scanchain_5 (.clk_in(sw_004_clk_out),
    .clk_out(sw_005_clk_out),
    .data_in(sw_004_data_out),
    .data_out(sw_005_data_out),
    .latch_enable_in(sw_004_latch_out),
    .latch_enable_out(sw_005_latch_out),
    .scan_select_in(sw_004_scan_out),
    .scan_select_out(sw_005_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_005_module_data_in[7] ,
    \sw_005_module_data_in[6] ,
    \sw_005_module_data_in[5] ,
    \sw_005_module_data_in[4] ,
    \sw_005_module_data_in[3] ,
    \sw_005_module_data_in[2] ,
    \sw_005_module_data_in[1] ,
    \sw_005_module_data_in[0] }),
    .module_data_out({\sw_005_module_data_out[7] ,
    \sw_005_module_data_out[6] ,
    \sw_005_module_data_out[5] ,
    \sw_005_module_data_out[4] ,
    \sw_005_module_data_out[3] ,
    \sw_005_module_data_out[2] ,
    \sw_005_module_data_out[1] ,
    \sw_005_module_data_out[0] }));
 scanchain scanchain_6 (.clk_in(sw_005_clk_out),
    .clk_out(sw_006_clk_out),
    .data_in(sw_005_data_out),
    .data_out(sw_006_data_out),
    .latch_enable_in(sw_005_latch_out),
    .latch_enable_out(sw_006_latch_out),
    .scan_select_in(sw_005_scan_out),
    .scan_select_out(sw_006_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_006_module_data_in[7] ,
    \sw_006_module_data_in[6] ,
    \sw_006_module_data_in[5] ,
    \sw_006_module_data_in[4] ,
    \sw_006_module_data_in[3] ,
    \sw_006_module_data_in[2] ,
    \sw_006_module_data_in[1] ,
    \sw_006_module_data_in[0] }),
    .module_data_out({\sw_006_module_data_out[7] ,
    \sw_006_module_data_out[6] ,
    \sw_006_module_data_out[5] ,
    \sw_006_module_data_out[4] ,
    \sw_006_module_data_out[3] ,
    \sw_006_module_data_out[2] ,
    \sw_006_module_data_out[1] ,
    \sw_006_module_data_out[0] }));
 scanchain scanchain_7 (.clk_in(sw_006_clk_out),
    .clk_out(sw_007_clk_out),
    .data_in(sw_006_data_out),
    .data_out(sw_007_data_out),
    .latch_enable_in(sw_006_latch_out),
    .latch_enable_out(sw_007_latch_out),
    .scan_select_in(sw_006_scan_out),
    .scan_select_out(sw_007_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_007_module_data_in[7] ,
    \sw_007_module_data_in[6] ,
    \sw_007_module_data_in[5] ,
    \sw_007_module_data_in[4] ,
    \sw_007_module_data_in[3] ,
    \sw_007_module_data_in[2] ,
    \sw_007_module_data_in[1] ,
    \sw_007_module_data_in[0] }),
    .module_data_out({\sw_007_module_data_out[7] ,
    \sw_007_module_data_out[6] ,
    \sw_007_module_data_out[5] ,
    \sw_007_module_data_out[4] ,
    \sw_007_module_data_out[3] ,
    \sw_007_module_data_out[2] ,
    \sw_007_module_data_out[1] ,
    \sw_007_module_data_out[0] }));
 scanchain scanchain_8 (.clk_in(sw_007_clk_out),
    .clk_out(sw_008_clk_out),
    .data_in(sw_007_data_out),
    .data_out(sw_008_data_out),
    .latch_enable_in(sw_007_latch_out),
    .latch_enable_out(sw_008_latch_out),
    .scan_select_in(sw_007_scan_out),
    .scan_select_out(sw_008_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_008_module_data_in[7] ,
    \sw_008_module_data_in[6] ,
    \sw_008_module_data_in[5] ,
    \sw_008_module_data_in[4] ,
    \sw_008_module_data_in[3] ,
    \sw_008_module_data_in[2] ,
    \sw_008_module_data_in[1] ,
    \sw_008_module_data_in[0] }),
    .module_data_out({\sw_008_module_data_out[7] ,
    \sw_008_module_data_out[6] ,
    \sw_008_module_data_out[5] ,
    \sw_008_module_data_out[4] ,
    \sw_008_module_data_out[3] ,
    \sw_008_module_data_out[2] ,
    \sw_008_module_data_out[1] ,
    \sw_008_module_data_out[0] }));
 scanchain scanchain_9 (.clk_in(sw_008_clk_out),
    .clk_out(sw_009_clk_out),
    .data_in(sw_008_data_out),
    .data_out(sw_009_data_out),
    .latch_enable_in(sw_008_latch_out),
    .latch_enable_out(sw_009_latch_out),
    .scan_select_in(sw_008_scan_out),
    .scan_select_out(sw_009_scan_out),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .module_data_in({\sw_009_module_data_in[7] ,
    \sw_009_module_data_in[6] ,
    \sw_009_module_data_in[5] ,
    \sw_009_module_data_in[4] ,
    \sw_009_module_data_in[3] ,
    \sw_009_module_data_in[2] ,
    \sw_009_module_data_in[1] ,
    \sw_009_module_data_in[0] }),
    .module_data_out({\sw_009_module_data_out[7] ,
    \sw_009_module_data_out[6] ,
    \sw_009_module_data_out[5] ,
    \sw_009_module_data_out[4] ,
    \sw_009_module_data_out[3] ,
    \sw_009_module_data_out[2] ,
    \sw_009_module_data_out[1] ,
    \sw_009_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_0 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_000_module_data_in[7] ,
    \sw_000_module_data_in[6] ,
    \sw_000_module_data_in[5] ,
    \sw_000_module_data_in[4] ,
    \sw_000_module_data_in[3] ,
    \sw_000_module_data_in[2] ,
    \sw_000_module_data_in[1] ,
    \sw_000_module_data_in[0] }),
    .io_out({\sw_000_module_data_out[7] ,
    \sw_000_module_data_out[6] ,
    \sw_000_module_data_out[5] ,
    \sw_000_module_data_out[4] ,
    \sw_000_module_data_out[3] ,
    \sw_000_module_data_out[2] ,
    \sw_000_module_data_out[1] ,
    \sw_000_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_1 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_001_module_data_in[7] ,
    \sw_001_module_data_in[6] ,
    \sw_001_module_data_in[5] ,
    \sw_001_module_data_in[4] ,
    \sw_001_module_data_in[3] ,
    \sw_001_module_data_in[2] ,
    \sw_001_module_data_in[1] ,
    \sw_001_module_data_in[0] }),
    .io_out({\sw_001_module_data_out[7] ,
    \sw_001_module_data_out[6] ,
    \sw_001_module_data_out[5] ,
    \sw_001_module_data_out[4] ,
    \sw_001_module_data_out[3] ,
    \sw_001_module_data_out[2] ,
    \sw_001_module_data_out[1] ,
    \sw_001_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_10 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_010_module_data_in[7] ,
    \sw_010_module_data_in[6] ,
    \sw_010_module_data_in[5] ,
    \sw_010_module_data_in[4] ,
    \sw_010_module_data_in[3] ,
    \sw_010_module_data_in[2] ,
    \sw_010_module_data_in[1] ,
    \sw_010_module_data_in[0] }),
    .io_out({\sw_010_module_data_out[7] ,
    \sw_010_module_data_out[6] ,
    \sw_010_module_data_out[5] ,
    \sw_010_module_data_out[4] ,
    \sw_010_module_data_out[3] ,
    \sw_010_module_data_out[2] ,
    \sw_010_module_data_out[1] ,
    \sw_010_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_11 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_011_module_data_in[7] ,
    \sw_011_module_data_in[6] ,
    \sw_011_module_data_in[5] ,
    \sw_011_module_data_in[4] ,
    \sw_011_module_data_in[3] ,
    \sw_011_module_data_in[2] ,
    \sw_011_module_data_in[1] ,
    \sw_011_module_data_in[0] }),
    .io_out({\sw_011_module_data_out[7] ,
    \sw_011_module_data_out[6] ,
    \sw_011_module_data_out[5] ,
    \sw_011_module_data_out[4] ,
    \sw_011_module_data_out[3] ,
    \sw_011_module_data_out[2] ,
    \sw_011_module_data_out[1] ,
    \sw_011_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_12 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_012_module_data_in[7] ,
    \sw_012_module_data_in[6] ,
    \sw_012_module_data_in[5] ,
    \sw_012_module_data_in[4] ,
    \sw_012_module_data_in[3] ,
    \sw_012_module_data_in[2] ,
    \sw_012_module_data_in[1] ,
    \sw_012_module_data_in[0] }),
    .io_out({\sw_012_module_data_out[7] ,
    \sw_012_module_data_out[6] ,
    \sw_012_module_data_out[5] ,
    \sw_012_module_data_out[4] ,
    \sw_012_module_data_out[3] ,
    \sw_012_module_data_out[2] ,
    \sw_012_module_data_out[1] ,
    \sw_012_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_13 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_013_module_data_in[7] ,
    \sw_013_module_data_in[6] ,
    \sw_013_module_data_in[5] ,
    \sw_013_module_data_in[4] ,
    \sw_013_module_data_in[3] ,
    \sw_013_module_data_in[2] ,
    \sw_013_module_data_in[1] ,
    \sw_013_module_data_in[0] }),
    .io_out({\sw_013_module_data_out[7] ,
    \sw_013_module_data_out[6] ,
    \sw_013_module_data_out[5] ,
    \sw_013_module_data_out[4] ,
    \sw_013_module_data_out[3] ,
    \sw_013_module_data_out[2] ,
    \sw_013_module_data_out[1] ,
    \sw_013_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_14 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_014_module_data_in[7] ,
    \sw_014_module_data_in[6] ,
    \sw_014_module_data_in[5] ,
    \sw_014_module_data_in[4] ,
    \sw_014_module_data_in[3] ,
    \sw_014_module_data_in[2] ,
    \sw_014_module_data_in[1] ,
    \sw_014_module_data_in[0] }),
    .io_out({\sw_014_module_data_out[7] ,
    \sw_014_module_data_out[6] ,
    \sw_014_module_data_out[5] ,
    \sw_014_module_data_out[4] ,
    \sw_014_module_data_out[3] ,
    \sw_014_module_data_out[2] ,
    \sw_014_module_data_out[1] ,
    \sw_014_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_15 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_015_module_data_in[7] ,
    \sw_015_module_data_in[6] ,
    \sw_015_module_data_in[5] ,
    \sw_015_module_data_in[4] ,
    \sw_015_module_data_in[3] ,
    \sw_015_module_data_in[2] ,
    \sw_015_module_data_in[1] ,
    \sw_015_module_data_in[0] }),
    .io_out({\sw_015_module_data_out[7] ,
    \sw_015_module_data_out[6] ,
    \sw_015_module_data_out[5] ,
    \sw_015_module_data_out[4] ,
    \sw_015_module_data_out[3] ,
    \sw_015_module_data_out[2] ,
    \sw_015_module_data_out[1] ,
    \sw_015_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_16 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_016_module_data_in[7] ,
    \sw_016_module_data_in[6] ,
    \sw_016_module_data_in[5] ,
    \sw_016_module_data_in[4] ,
    \sw_016_module_data_in[3] ,
    \sw_016_module_data_in[2] ,
    \sw_016_module_data_in[1] ,
    \sw_016_module_data_in[0] }),
    .io_out({\sw_016_module_data_out[7] ,
    \sw_016_module_data_out[6] ,
    \sw_016_module_data_out[5] ,
    \sw_016_module_data_out[4] ,
    \sw_016_module_data_out[3] ,
    \sw_016_module_data_out[2] ,
    \sw_016_module_data_out[1] ,
    \sw_016_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_17 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_017_module_data_in[7] ,
    \sw_017_module_data_in[6] ,
    \sw_017_module_data_in[5] ,
    \sw_017_module_data_in[4] ,
    \sw_017_module_data_in[3] ,
    \sw_017_module_data_in[2] ,
    \sw_017_module_data_in[1] ,
    \sw_017_module_data_in[0] }),
    .io_out({\sw_017_module_data_out[7] ,
    \sw_017_module_data_out[6] ,
    \sw_017_module_data_out[5] ,
    \sw_017_module_data_out[4] ,
    \sw_017_module_data_out[3] ,
    \sw_017_module_data_out[2] ,
    \sw_017_module_data_out[1] ,
    \sw_017_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_18 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_018_module_data_in[7] ,
    \sw_018_module_data_in[6] ,
    \sw_018_module_data_in[5] ,
    \sw_018_module_data_in[4] ,
    \sw_018_module_data_in[3] ,
    \sw_018_module_data_in[2] ,
    \sw_018_module_data_in[1] ,
    \sw_018_module_data_in[0] }),
    .io_out({\sw_018_module_data_out[7] ,
    \sw_018_module_data_out[6] ,
    \sw_018_module_data_out[5] ,
    \sw_018_module_data_out[4] ,
    \sw_018_module_data_out[3] ,
    \sw_018_module_data_out[2] ,
    \sw_018_module_data_out[1] ,
    \sw_018_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_19 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_019_module_data_in[7] ,
    \sw_019_module_data_in[6] ,
    \sw_019_module_data_in[5] ,
    \sw_019_module_data_in[4] ,
    \sw_019_module_data_in[3] ,
    \sw_019_module_data_in[2] ,
    \sw_019_module_data_in[1] ,
    \sw_019_module_data_in[0] }),
    .io_out({\sw_019_module_data_out[7] ,
    \sw_019_module_data_out[6] ,
    \sw_019_module_data_out[5] ,
    \sw_019_module_data_out[4] ,
    \sw_019_module_data_out[3] ,
    \sw_019_module_data_out[2] ,
    \sw_019_module_data_out[1] ,
    \sw_019_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_2 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_002_module_data_in[7] ,
    \sw_002_module_data_in[6] ,
    \sw_002_module_data_in[5] ,
    \sw_002_module_data_in[4] ,
    \sw_002_module_data_in[3] ,
    \sw_002_module_data_in[2] ,
    \sw_002_module_data_in[1] ,
    \sw_002_module_data_in[0] }),
    .io_out({\sw_002_module_data_out[7] ,
    \sw_002_module_data_out[6] ,
    \sw_002_module_data_out[5] ,
    \sw_002_module_data_out[4] ,
    \sw_002_module_data_out[3] ,
    \sw_002_module_data_out[2] ,
    \sw_002_module_data_out[1] ,
    \sw_002_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_20 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_020_module_data_in[7] ,
    \sw_020_module_data_in[6] ,
    \sw_020_module_data_in[5] ,
    \sw_020_module_data_in[4] ,
    \sw_020_module_data_in[3] ,
    \sw_020_module_data_in[2] ,
    \sw_020_module_data_in[1] ,
    \sw_020_module_data_in[0] }),
    .io_out({\sw_020_module_data_out[7] ,
    \sw_020_module_data_out[6] ,
    \sw_020_module_data_out[5] ,
    \sw_020_module_data_out[4] ,
    \sw_020_module_data_out[3] ,
    \sw_020_module_data_out[2] ,
    \sw_020_module_data_out[1] ,
    \sw_020_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_21 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_021_module_data_in[7] ,
    \sw_021_module_data_in[6] ,
    \sw_021_module_data_in[5] ,
    \sw_021_module_data_in[4] ,
    \sw_021_module_data_in[3] ,
    \sw_021_module_data_in[2] ,
    \sw_021_module_data_in[1] ,
    \sw_021_module_data_in[0] }),
    .io_out({\sw_021_module_data_out[7] ,
    \sw_021_module_data_out[6] ,
    \sw_021_module_data_out[5] ,
    \sw_021_module_data_out[4] ,
    \sw_021_module_data_out[3] ,
    \sw_021_module_data_out[2] ,
    \sw_021_module_data_out[1] ,
    \sw_021_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_22 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_022_module_data_in[7] ,
    \sw_022_module_data_in[6] ,
    \sw_022_module_data_in[5] ,
    \sw_022_module_data_in[4] ,
    \sw_022_module_data_in[3] ,
    \sw_022_module_data_in[2] ,
    \sw_022_module_data_in[1] ,
    \sw_022_module_data_in[0] }),
    .io_out({\sw_022_module_data_out[7] ,
    \sw_022_module_data_out[6] ,
    \sw_022_module_data_out[5] ,
    \sw_022_module_data_out[4] ,
    \sw_022_module_data_out[3] ,
    \sw_022_module_data_out[2] ,
    \sw_022_module_data_out[1] ,
    \sw_022_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_23 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_023_module_data_in[7] ,
    \sw_023_module_data_in[6] ,
    \sw_023_module_data_in[5] ,
    \sw_023_module_data_in[4] ,
    \sw_023_module_data_in[3] ,
    \sw_023_module_data_in[2] ,
    \sw_023_module_data_in[1] ,
    \sw_023_module_data_in[0] }),
    .io_out({\sw_023_module_data_out[7] ,
    \sw_023_module_data_out[6] ,
    \sw_023_module_data_out[5] ,
    \sw_023_module_data_out[4] ,
    \sw_023_module_data_out[3] ,
    \sw_023_module_data_out[2] ,
    \sw_023_module_data_out[1] ,
    \sw_023_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_24 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_024_module_data_in[7] ,
    \sw_024_module_data_in[6] ,
    \sw_024_module_data_in[5] ,
    \sw_024_module_data_in[4] ,
    \sw_024_module_data_in[3] ,
    \sw_024_module_data_in[2] ,
    \sw_024_module_data_in[1] ,
    \sw_024_module_data_in[0] }),
    .io_out({\sw_024_module_data_out[7] ,
    \sw_024_module_data_out[6] ,
    \sw_024_module_data_out[5] ,
    \sw_024_module_data_out[4] ,
    \sw_024_module_data_out[3] ,
    \sw_024_module_data_out[2] ,
    \sw_024_module_data_out[1] ,
    \sw_024_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_25 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_025_module_data_in[7] ,
    \sw_025_module_data_in[6] ,
    \sw_025_module_data_in[5] ,
    \sw_025_module_data_in[4] ,
    \sw_025_module_data_in[3] ,
    \sw_025_module_data_in[2] ,
    \sw_025_module_data_in[1] ,
    \sw_025_module_data_in[0] }),
    .io_out({\sw_025_module_data_out[7] ,
    \sw_025_module_data_out[6] ,
    \sw_025_module_data_out[5] ,
    \sw_025_module_data_out[4] ,
    \sw_025_module_data_out[3] ,
    \sw_025_module_data_out[2] ,
    \sw_025_module_data_out[1] ,
    \sw_025_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_26 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_026_module_data_in[7] ,
    \sw_026_module_data_in[6] ,
    \sw_026_module_data_in[5] ,
    \sw_026_module_data_in[4] ,
    \sw_026_module_data_in[3] ,
    \sw_026_module_data_in[2] ,
    \sw_026_module_data_in[1] ,
    \sw_026_module_data_in[0] }),
    .io_out({\sw_026_module_data_out[7] ,
    \sw_026_module_data_out[6] ,
    \sw_026_module_data_out[5] ,
    \sw_026_module_data_out[4] ,
    \sw_026_module_data_out[3] ,
    \sw_026_module_data_out[2] ,
    \sw_026_module_data_out[1] ,
    \sw_026_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_27 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_027_module_data_in[7] ,
    \sw_027_module_data_in[6] ,
    \sw_027_module_data_in[5] ,
    \sw_027_module_data_in[4] ,
    \sw_027_module_data_in[3] ,
    \sw_027_module_data_in[2] ,
    \sw_027_module_data_in[1] ,
    \sw_027_module_data_in[0] }),
    .io_out({\sw_027_module_data_out[7] ,
    \sw_027_module_data_out[6] ,
    \sw_027_module_data_out[5] ,
    \sw_027_module_data_out[4] ,
    \sw_027_module_data_out[3] ,
    \sw_027_module_data_out[2] ,
    \sw_027_module_data_out[1] ,
    \sw_027_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_28 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_028_module_data_in[7] ,
    \sw_028_module_data_in[6] ,
    \sw_028_module_data_in[5] ,
    \sw_028_module_data_in[4] ,
    \sw_028_module_data_in[3] ,
    \sw_028_module_data_in[2] ,
    \sw_028_module_data_in[1] ,
    \sw_028_module_data_in[0] }),
    .io_out({\sw_028_module_data_out[7] ,
    \sw_028_module_data_out[6] ,
    \sw_028_module_data_out[5] ,
    \sw_028_module_data_out[4] ,
    \sw_028_module_data_out[3] ,
    \sw_028_module_data_out[2] ,
    \sw_028_module_data_out[1] ,
    \sw_028_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_29 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_029_module_data_in[7] ,
    \sw_029_module_data_in[6] ,
    \sw_029_module_data_in[5] ,
    \sw_029_module_data_in[4] ,
    \sw_029_module_data_in[3] ,
    \sw_029_module_data_in[2] ,
    \sw_029_module_data_in[1] ,
    \sw_029_module_data_in[0] }),
    .io_out({\sw_029_module_data_out[7] ,
    \sw_029_module_data_out[6] ,
    \sw_029_module_data_out[5] ,
    \sw_029_module_data_out[4] ,
    \sw_029_module_data_out[3] ,
    \sw_029_module_data_out[2] ,
    \sw_029_module_data_out[1] ,
    \sw_029_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_3 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_003_module_data_in[7] ,
    \sw_003_module_data_in[6] ,
    \sw_003_module_data_in[5] ,
    \sw_003_module_data_in[4] ,
    \sw_003_module_data_in[3] ,
    \sw_003_module_data_in[2] ,
    \sw_003_module_data_in[1] ,
    \sw_003_module_data_in[0] }),
    .io_out({\sw_003_module_data_out[7] ,
    \sw_003_module_data_out[6] ,
    \sw_003_module_data_out[5] ,
    \sw_003_module_data_out[4] ,
    \sw_003_module_data_out[3] ,
    \sw_003_module_data_out[2] ,
    \sw_003_module_data_out[1] ,
    \sw_003_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_4 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_004_module_data_in[7] ,
    \sw_004_module_data_in[6] ,
    \sw_004_module_data_in[5] ,
    \sw_004_module_data_in[4] ,
    \sw_004_module_data_in[3] ,
    \sw_004_module_data_in[2] ,
    \sw_004_module_data_in[1] ,
    \sw_004_module_data_in[0] }),
    .io_out({\sw_004_module_data_out[7] ,
    \sw_004_module_data_out[6] ,
    \sw_004_module_data_out[5] ,
    \sw_004_module_data_out[4] ,
    \sw_004_module_data_out[3] ,
    \sw_004_module_data_out[2] ,
    \sw_004_module_data_out[1] ,
    \sw_004_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_5 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_005_module_data_in[7] ,
    \sw_005_module_data_in[6] ,
    \sw_005_module_data_in[5] ,
    \sw_005_module_data_in[4] ,
    \sw_005_module_data_in[3] ,
    \sw_005_module_data_in[2] ,
    \sw_005_module_data_in[1] ,
    \sw_005_module_data_in[0] }),
    .io_out({\sw_005_module_data_out[7] ,
    \sw_005_module_data_out[6] ,
    \sw_005_module_data_out[5] ,
    \sw_005_module_data_out[4] ,
    \sw_005_module_data_out[3] ,
    \sw_005_module_data_out[2] ,
    \sw_005_module_data_out[1] ,
    \sw_005_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_6 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_006_module_data_in[7] ,
    \sw_006_module_data_in[6] ,
    \sw_006_module_data_in[5] ,
    \sw_006_module_data_in[4] ,
    \sw_006_module_data_in[3] ,
    \sw_006_module_data_in[2] ,
    \sw_006_module_data_in[1] ,
    \sw_006_module_data_in[0] }),
    .io_out({\sw_006_module_data_out[7] ,
    \sw_006_module_data_out[6] ,
    \sw_006_module_data_out[5] ,
    \sw_006_module_data_out[4] ,
    \sw_006_module_data_out[3] ,
    \sw_006_module_data_out[2] ,
    \sw_006_module_data_out[1] ,
    \sw_006_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_7 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_007_module_data_in[7] ,
    \sw_007_module_data_in[6] ,
    \sw_007_module_data_in[5] ,
    \sw_007_module_data_in[4] ,
    \sw_007_module_data_in[3] ,
    \sw_007_module_data_in[2] ,
    \sw_007_module_data_in[1] ,
    \sw_007_module_data_in[0] }),
    .io_out({\sw_007_module_data_out[7] ,
    \sw_007_module_data_out[6] ,
    \sw_007_module_data_out[5] ,
    \sw_007_module_data_out[4] ,
    \sw_007_module_data_out[3] ,
    \sw_007_module_data_out[2] ,
    \sw_007_module_data_out[1] ,
    \sw_007_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_8 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_008_module_data_in[7] ,
    \sw_008_module_data_in[6] ,
    \sw_008_module_data_in[5] ,
    \sw_008_module_data_in[4] ,
    \sw_008_module_data_in[3] ,
    \sw_008_module_data_in[2] ,
    \sw_008_module_data_in[1] ,
    \sw_008_module_data_in[0] }),
    .io_out({\sw_008_module_data_out[7] ,
    \sw_008_module_data_out[6] ,
    \sw_008_module_data_out[5] ,
    \sw_008_module_data_out[4] ,
    \sw_008_module_data_out[3] ,
    \sw_008_module_data_out[2] ,
    \sw_008_module_data_out[1] ,
    \sw_008_module_data_out[0] }));
 user_module_341535056611770964 user_module_341535056611770964_9 (.vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({\sw_009_module_data_in[7] ,
    \sw_009_module_data_in[6] ,
    \sw_009_module_data_in[5] ,
    \sw_009_module_data_in[4] ,
    \sw_009_module_data_in[3] ,
    \sw_009_module_data_in[2] ,
    \sw_009_module_data_in[1] ,
    \sw_009_module_data_in[0] }),
    .io_out({\sw_009_module_data_out[7] ,
    \sw_009_module_data_out[6] ,
    \sw_009_module_data_out[5] ,
    \sw_009_module_data_out[4] ,
    \sw_009_module_data_out[3] ,
    \sw_009_module_data_out[2] ,
    \sw_009_module_data_out[1] ,
    \sw_009_module_data_out[0] }));
endmodule
