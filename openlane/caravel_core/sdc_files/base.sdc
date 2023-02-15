### Caravel Signoff SDC
### Rev 3
### Date: 28/10/2022

## MASTER CLOCKS
create_clock -name clk -period 25 [get_pins {clock_ctrl/core_clk}] 
# create_clock -name clk -period 25 [get_ports {clock_core}] 

set_clock_uncertainty 0.5 [get_clocks {clk}] 

set_propagated_clock [get_clocks {clk}]

## INPUT/OUTPUT DELAYS
set input_delay_value 4
set output_delay_value 20
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [all_inputs]
set_input_delay 0  -clock [get_clocks {clk}] [get_ports {clock_core}]
set_input_delay 1  -clock [get_clocks {clk}] [get_ports {flash_io0_di}]
set_input_delay 1  -clock [get_clocks {clk}] [get_ports {flash_io1_di}]

set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [all_outputs]

## MAX FANOUT
set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

## FALSE PATHS (ASYNCHRONOUS INPUTS)
set_false_path -from [get_ports {rstb_h}]

# add loads for output ports (pads)
set min_cap 5
set max_cap 10
puts "\[INFO\]: Cap load range: $min_cap : $max_cap"
# set_load 10 [all_outputs]
set_load -min $min_cap [all_outputs] 
set_load -max $max_cap [all_outputs] 

set min_in_tran 1
set max_in_tran 4.5
puts "\[INFO\]: Input transition range: $min_in_tran : $max_in_tran"
set_input_transition -min $min_in_tran [all_inputs] 
set_input_transition -max $max_in_tran [all_inputs]

# derates
set derate 0.09
puts "\[INFO\]: Setting derate factor to: [expr $derate * 100] %"
set_timing_derate -early [expr 1-$derate]
set_timing_derate -late [expr 1+$derate]

## MAX transition/cap
set_max_trans 1.25 [current_design]
# set_max_cap 0.5 [current_design]

# group_path -weight 100 -through [get_pins mprj/la_data_out[0]] -name mprj_floating