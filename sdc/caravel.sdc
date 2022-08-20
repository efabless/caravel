set ::env(IO_PCT) "0.2"
set ::env(SYNTH_MAX_FANOUT) "5"
#set ::env(SYNTH_CAP_LOAD) "33"
set ::env(SYNTH_TIMING_DERATE) 2.5
set ::env(SYNTH_CLOCK_UNCERTAINITY) 0.15
set ::env(SYNTH_CLOCK_TRANSITION) 0.10

## MASTER CLOCKS
create_clock [get_ports {"clock"} ] -name "clock"  -period 25
# create_clock -name hk_spi_clk -period 100.0000 [get_ports {mprj_io[4]}]
# \gpio_control_bidir_1[0] 

create_generated_clock -name hk_serial_clk \
    -source [get_ports {"clock"}] \
    -divide_by 5 \
    [get_pins {housekeeping/serial_clock}]

create_generated_clock -name hk_serial_load \
    -source [get_ports {"clock"}] \
    -divide_by 5 \
    [get_pins {housekeeping/serial_load}]

set_propagated_clock [get_clocks {"clock"}]
# set_propagated_clock [get_clocks {hk_spi_clk}]
set_propagated_clock [get_clocks {hk_serial_clk}]
set_propagated_clock [get_clocks {hk_serial_load}]

# create_generated_clock -name wbbd_sck -source [get_ports {housekeeping/wb_clk_i}] -divide_by 1 [get_pins {housekeeping/_9640_/Q}]
# set_propagated_clock [get_clocks {wbbd_sck}]
# create_generated_clock -name csclk_slow -source [get_ports {housekeeping/mgmt_gpio_in[4]}] -divide_by 1 [get_pins {housekeeping/_8847_/X}]
# set_propagated_clock [get_clocks {csclk_slow}]
# create_generated_clock -name serial_clock_pre -source [get_ports {housekeeping/wb_clk_i}] -multiply_by 2 [get_pins {housekeeping/_9239_/Q}]
# set_propagated_clock [get_clocks {serial_clock_pre}]
# create_generated_clock -name serial_bb_clock -source [get_pins {housekeeping/_8847_/X}] -multiply_by 2 [get_pins {housekeeping/_9772_/Q}]
# set_propagated_clock [get_clocks {serial_bb_clock}]
# create_generated_clock -name serial_clock_bb -source [get_pins {housekeeping/_9772_/Q}] -multiply_by 2 [get_pins {housekeeping/_8819_/X}]
# set_propagated_clock [get_clocks {serial_clock_bb}]

## INPUT/OUTPUT DELAYS
set input_delay_value 1
set output_delay_value [expr 25 * $::env(IO_PCT)]
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {gpio}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[0]}]
#set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[1]}]
# set_input_delay $input_delay_value  -clock [get_clocks {hk_spi_clk}] -add_delay [get_ports {mprj_io[2]}]
# set_input_delay $input_delay_value  -clock [get_clocks {hk_spi_clk}] -add_delay [get_ports {mprj_io[3]}]
#set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[4]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[5]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[6]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[7]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[8]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[9]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[10]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[11]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[12]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[13]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[14]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[15]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[16]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[17]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[18]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[19]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[20]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[21]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[22]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[23]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[24]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[25]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[26]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[27]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[28]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[29]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[30]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[31]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[32]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[33]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[34]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[35]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[36]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[37]}]

set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_csb}]
set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_clk}]
set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_io0}]
set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_io1}]

# set_output_delay $output_delay_value  -clock [get_clocks {hk_spi_clk}] -add_delay [get_ports {mprj_io[1]}]

set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

## Set system monitoring mux select to zero so that the clock/user_clk monitoring is disabled 
set_case_analysis 0 [get_pins housekeeping/_4449_/S]
set_case_analysis 0 [get_pins housekeeping/_4450_/S]

## FALSE PATHS (ASYNCHRONOUS INPUTS)
set_false_path -from [get_ports {resetb}]
set_false_path -from [get_ports mprj_io[*]]
set_false_path -from [get_ports gpio]

# TODO set this as parameter
#set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
set cap_load 25
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]

puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {clock}]
# set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {hk_spi_clk}]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {hk_serial_clk}]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {hk_serial_load}]

puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
# set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {hk_spi_clk}]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {clock}]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {hk_serial_clk}]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {hk_serial_load}]
