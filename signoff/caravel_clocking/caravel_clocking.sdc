### Caravel Clocking Signoff SDC
### Rev 2
### Date: 17/10/2022

set pll_clk_t 6.6666666666667
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name ext_clk -period 25.0000 [get_ports {ext_clk}]
set_clock_transition 0.1000 [get_clocks {ext_clk}]
set_clock_uncertainty 0.1000 ext_clk
set_propagated_clock [get_clocks {ext_clk}]

create_clock -name pll_clk -period $pll_clk_t [get_ports {pll_clk}]
set_clock_transition 0.1000 [get_clocks {pll_clk}]
set_clock_uncertainty 0.1000 pll_clk
set_propagated_clock [get_clocks {pll_clk}]

create_clock -name pll_clk90 -period $pll_clk_t [get_ports {pll_clk90}]
set_clock_transition 0.1000 [get_clocks {pll_clk90}]
set_clock_uncertainty 0.1000 pll_clk90
set_propagated_clock [get_clocks {pll_clk90}]

create_generated_clock -name core_clk -source [get_pins {_208_/X}] -divide_by 1 [get_ports {core_clk}]
set_clock_transition 0.1000 [get_clocks {core_clk}]
set_clock_uncertainty 0.1000 core_clk
set_propagated_clock [get_clocks {core_clk}]

set_clock_groups -name group1 -logically_exclusive \
 -group [get_clocks {ext_clk}]\
 -group [list [get_clocks {pll_clk}]\
           [get_clocks {pll_clk90}]]

set_input_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {ext_clk_sel}]
set_input_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[0]}]
set_input_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[1]}]
set_input_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[2]}]
set_input_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[0]}]
set_input_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[1]}]
set_input_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[2]}]
set_output_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {resetb_sync}]

###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.2000 [get_ports {core_clk}]
set_load -pin_load 0.2000 [get_ports {resetb_sync}]
set_load -pin_load 0.2000 [get_ports {user_clk}]

###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_input_transition 0.3 [all_inputs]

set_max_fanout 12 [current_design]
set derate 0.0375
puts "\[INFO\]: Setting timing derate to: [expr {$derate * 100}] %"
set_timing_derate -early [expr 1-$derate]
set_timing_derate -late [expr 1+$derate]