# User config
set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) scanchain

# save some time
set ::env(RUN_KLAYOUT_XOR) 0
set ::env(RUN_KLAYOUT_DRC) 0

# don't put clock buffers on the outputs
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

# allow use of specific sky130 cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# read all verilog files
set ::env(VERILOG_FILES) "$script_dir/../../verilog/rtl/scanchain/scanchain.v" 

# put all the io pins on the right, and scan chain on the left
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

# reduce wasted space
set ::env(TOP_MARGIN_MULT) 2
set ::env(BOTTOM_MARGIN_MULT) 2

# absolute die size
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 30 120"
set ::env(FP_CORE_UTIL) 45
set ::env(PL_BASIC_PLACEMENT) {1}

set ::env(FP_IO_HLENGTH) 2

# use alternative efabless decap cells to solve LI density issue
set ::env(DECAP_CELL) "\
    sky130_fd_sc_hd__decap_3 \
    sky130_fd_sc_hd__decap_4 \
    sky130_fd_sc_hd__decap_6 \
    sky130_fd_sc_hd__decap_8 \
    sky130_ef_sc_hd__decap_12"

# clock
set ::env(CLOCK_PERIOD) "5"
set ::env(CLOCK_PORT) ""

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc

set ::env(SYNTH_CLOCK_UNCERTAINITY) 0.20
set ::env(SYNTH_CLOCK_TRANSITION)   0.15

# don't use power rings or met5
set ::env(DESIGN_IS_CORE) 0
set ::env(RT_MAX_LAYER) {met4}

# connect to first digital rails
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]
