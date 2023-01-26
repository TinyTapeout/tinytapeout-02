# SDC file, in TCL
# declare clocks and relationships between them
# Create main clock of the scan controller, locally named the same clock
create_clock [get_ports $::env(CLOCK_PORT)]  -name $::env(CLOCK_PORT)  -period $::env(CLOCK_PERIOD)

# Create our generated clock that drives the scan chain
# derived from clk, present on edge 3 5 7 
# multicycle path, only data transition on falling edge of scan clock
create_generated_clock -edges {3 5 7} -source $::env(CLOCK_PORT) -name clk_scan_out [get_ports scan_clk_out]
set_multicycle_path -start -hold -from [get_clocks $::env(CLOCK_PORT)] -to [get_clocks clk_scan_out] 1

# Create feedback clock - scan_clk_in. we don't know what it will arrive, but we know the period 
create_clock [get_ports scan_clk_in] -name clk_scan_in -period [expr {$::env(CLOCK_PERIOD) * 2}]

# CDC
# receiving data into shift register and clocked by clk_scan_in
# constrain to a reasonable range
set_min_delay 0.25                              -from [get_clocks clk_scan_in] -to [get_clocks $::env(CLOCK_PORT)]
set_max_delay [expr {$::env(CLOCK_PERIOD) / 2}] -from [get_clocks clk_scan_in] -to [get_clocks $::env(CLOCK_PORT)]

# Input delays
# check is that the input stable windows, modified by the data and clock delays from the inputs up to the FFs, 
# will satisy the stable window required by the FFs (setup/hold).
# It will also use that as "guide" to actually make it work -
# shifting the input window forward/backward by adding delays on the clock/data lines

# Scan chain input  0.5 ns setup time, 0.5 ns hold time
set_input_delay  -min  0.5 -clock [get_clocks clk_scan_in]  [get_ports {scan_data_in}]
set_input_delay  -max  0.5 -clock [get_clocks clk_scan_in]  [get_ports {scan_data_in}]

# Output delays
# Scan chain output 1.5 ns setup time, 1.5 ns hold time
# scan_data_out cannot change in this window around clk_scan_out rising edge
# -min is negative because the values for set_output_delay are both defined as "times before the edge"
# so for some time after the edge, need a negative value
set_output_delay -min -1.5 -clock [get_clocks clk_scan_out] [get_ports {scan_data_out}]
set_output_delay -max  1.5 -clock [get_clocks clk_scan_out] [get_ports {scan_data_out}]

# Limit the max output delay on other outputs
# Probably not important, but useful because then these paths will be reported
set_output_delay -max  1.5 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports {scan_select scan_latch_en}]

# All the other IOs we consider asynchronous so ... no point in constraining
# https://open-source-silicon.slack.com/archives/C02K4RD241Y/p1661983399157329?thread_ts=1661978191.926169&cid=C02K4RD241Y
set_false_path -from [get_ports {active_select inputs set_clk_div la_* driver_sel}]


# Misc
# most copied from default OpenLane SDC 
set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL)] } {
    set ::env(SYNTH_CLK_DRIVING_CELL) $::env(SYNTH_DRIVING_CELL)
}

if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL_PIN)] } {
    set ::env(SYNTH_CLK_DRIVING_CELL_PIN) $::env(SYNTH_DRIVING_CELL_PIN)
}

set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [get_ports {scan_data_in}]
set_driving_cell -lib_cell $::env(SYNTH_CLK_DRIVING_CELL) -pin $::env(SYNTH_CLK_DRIVING_CELL_PIN) [get_ports "$::env(CLOCK_PORT) scan_clk_in"]

set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

# clock jitter
puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks "$::env(CLOCK_PORT) clk_scan_in clk_scan_out"]

# clock slew
puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks "$::env(CLOCK_PORT) clk_scan_in clk_scan_out"]

# make everything worse by SYNTH_TIMING_DERATE
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
