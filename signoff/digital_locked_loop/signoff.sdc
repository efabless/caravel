
create_clock [get_pins {"ringosc_ibufp01/Y"} ] -name "dll_control_clock"  -period 4.67
create_clock -name VIRTUAL_CLK -period 20

set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {dll_control_clock}]\
   -group [get_clocks {VIRTUAL_CLK}]

set_propagated_clock [get_clocks {dll_control_clock}] 

set_input_delay 2  -clock [get_clocks VIRTUAL_CLK] [all_inputs]
set_output_delay 2  -clock [get_clocks VIRTUAL_CLK] [all_outputs]

set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin Y [all_inputs]
set_load  0.20 [all_outputs]

set_timing_derate -early [expr {1-0.05}]
set_timing_derate -late [expr {1+0.05}]

puts "\[INFO\]: Setting clock uncertainity to: 0.1"
set_clock_uncertainty 0.1 [get_clocks {dll_control_clock}]
