# input clock pins 
create_clock [get_ports {"ext_clk"} ] -name "ext_clk"  -period 25
create_clock [get_ports {"pll_clk"} ] -name "pll_clk"  -period 6.6666666666667 
create_clock [get_ports {"pll_clk90"} ] -name "pll_clk90"  -period 6.6666666666667 

# divided PLL clocks
create_generated_clock -name pll_clk_divided -source [get_ports pll_clk] -divide_by 2 [get_pins _351_/Y] 
create_generated_clock -name pll_clk90_divided -source [get_ports pll_clk90] -divide_by 2 [get_pins _354_/Y] 

# output clock pins, mux selected
create_generated_clock -name core_ext_clk -source [get_ports ext_clk] -divide_by 1 [get_pins _412_/X] 
create_generated_clock -name core_ext_clk_pll -source [get_ports pll_clk] -divide_by 1 [get_pins _412_/X] 

create_generated_clock -name core_clk -source [get_pins _412_/X]  -divide_by 1 [get_pins _393_/X] 
create_generated_clock -name core_clk_pll -source [get_pins _351_/Y]   -divide_by 1 [get_pins _393_/X] 

create_generated_clock -name user_clk -source [get_pins _412_/X]  -divide_by 1 [get_pins _394_/X] 
create_generated_clock -name user_clk_pll -source [get_pins _354_/Y]   -divide_by 1 [get_pins _394_/X] 

# logically exclusive clocks, the generated pll clocks and the ext core clk
set_clock_groups -logically_exclusive -group core_ext_clk -group core_ext_clk_pll
set_clock_groups -logically_exclusive -group core_clk -group core_clk_pll
set_clock_groups -logically_exclusive -group user_clk -group user_clk_pll

set ext_clk_input_delay_value [expr 25 * $::env(IO_PCT)]
set ext_clk_output_delay_value [expr 25 * $::env(IO_PCT)]
set pll_clk_input_delay_value [expr 6.6666666666667  * $::env(IO_PCT)]
set pll_clk_output_delay_value [expr 6.6666666666667  * $::env(IO_PCT)]
puts "\[INFO\]: Setting output delay to: $ext_clk_output_delay_value"
puts "\[INFO\]: Setting input delay to: $ext_clk_input_delay_value"

set_input_delay $ext_clk_input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {ext_clk_sel}]

#set_input_delay $input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {resetb}]
set_input_delay $ext_clk_input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[0]}]
set_input_delay $ext_clk_input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[1]}]
set_input_delay $ext_clk_input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[2]}]
set_input_delay $ext_clk_input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[0]}]
set_input_delay $ext_clk_input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[1]}]
set_input_delay $ext_clk_input_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[2]}]
#set_output_delay $output_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {core_clk}]
set_output_delay $ext_clk_output_delay_value  -clock [get_clocks {ext_clk}] -add_delay [get_ports {resetb_sync}]
#set_output_delay $output_delay_value -clock [get_clocks {ext_clk}] -add_delay [get_ports {user_clk}]

set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

# TODO set this as parameter
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]

puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {ext_clk}]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {pll_clk}]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {pll_clk90}]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {core_clk}]

puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {ext_clk}]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {pll_clk}]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {pll_clk90}]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {core_clk}]