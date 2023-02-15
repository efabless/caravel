### Caravel base SDC
### Rev 3
### Date: 3/12/2022

## MASTER CLOCKS
# create_clock -name clk -period 50 [get_ports {clock_core}] 
create_clock -name clk -period 30 [get_pins {clock_ctrl/core_clk}] 

create_clock -name hk_serial_clk -period 50 [get_pins {housekeeping/serial_clock}]
create_clock -name hk_serial_load -period 1000 [get_pins {housekeeping/serial_load}]
# hk_serial_clk period is x2 core clock

set_clock_uncertainty 0.1 [get_clocks {clk}] 
set_clock_uncertainty 0.1 [get_clocks {hk_serial_clk hk_serial_load}]

set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {clk}]\
   -group [get_clocks {hk_serial_clk}]\
   -group [get_clocks {hk_serial_load}]


set_propagated_clock [get_clocks {clk}]
set_propagated_clock [get_clocks {hk_serial_clk}]
set_propagated_clock [get_clocks {hk_serial_load}]

## INPUT/OUTPUT DELAYS
# set input_delay_value 10
# set output_delay_value 10
# puts "\[INFO\]: Setting output delay to: $output_delay_value"
# puts "\[INFO\]: Setting input delay to: $input_delay_value"
# set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [all_inputs]
# set_input_delay 0  -clock [get_clocks {clk}] [get_ports {mprj_io_in[35]}]
# set_input_delay 0  -clock [get_clocks {clk}] [get_ports {clock_core}]
# set_input_delay 1  -clock [get_clocks {clk}] [get_ports {flash_io0_di}]
# set_input_delay 1  -clock [get_clocks {clk}] [get_ports {flash_io1_di}]
# set_input_delay -8 -clock [get_clocks {debug_clk}] [get_ports {mgmt_io_in[0]}]
# 
# set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [all_outputs]
# set_output_delay 21 -clock [get_clocks {debug_clk}] [get_ports {mgmt_io_out[0]}]

## MAX FANOUT
set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

## FALSE PATHS (ASYNCHRONOUS INPUTS)
set_false_path -from [get_ports {rstb_h}]

# add loads for output ports (pads)
set min_cap 1
set max_cap 1.49
puts "\[INFO\]: Cap load range: $min_cap : $max_cap"
# set_load 10 [all_outputs]
set_load -min $min_cap [all_outputs] 
set_load -max $max_cap [all_outputs] 

set min_in_tran 1
set max_in_tran 1.49
puts "\[INFO\]: Input transition range: $min_in_tran : $max_in_tran"
set_input_transition -min $min_in_tran [all_inputs] 
set_input_transition -max $max_in_tran [all_inputs]

# derates
set derate 0.0375
puts "\[INFO\]: Setting derate factor to: [expr $derate * 100] %"
set_timing_derate -early [expr 1-$derate]
set_timing_derate -late [expr 1+$derate]

## MAX transition/cap
# set_max_trans 2 [current_design]
# set_max_cap 0.8 [current_design]