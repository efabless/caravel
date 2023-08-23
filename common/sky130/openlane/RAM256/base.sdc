create_clock [get_ports $::env(CLOCK_PORT)]  -name $::env(CLOCK_PORT)  -period $::env(CLOCK_PERIOD)
set_propagated_clock [get_clocks $::env(CLOCK_PORT)]
set_clock_transition 0.5 [get_clocks $::env(CLOCK_PORT)]
set_clock_uncertainty 0.3 [get_clocks $::env(CLOCK_PORT)]

set clk_input [get_port $::env(CLOCK_PORT)]
set clk_indx [lsearch [all_inputs] $clk_input]
set all_inputs_wo_clk [lreplace [all_inputs] $clk_indx $clk_indx ""]
set_input_transition 1 $all_inputs_wo_clk
set_input_delay 1.0 -clock [get_clocks $::env(CLOCK_PORT)] $all_inputs_wo_clk

## OUTPUT DELAY
set_output_delay 20.0 -clock [get_clocks $::env(CLOCK_PORT)] [all_outputs]

# TODO set this as parameter
set cap_load 0.075
puts "\[INFO\]: Setting load to: $cap_load"
set_load $cap_load [all_outputs]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early 0.95
set_timing_derate -late 1.05
