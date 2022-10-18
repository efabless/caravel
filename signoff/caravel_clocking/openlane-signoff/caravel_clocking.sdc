###############################################################################
# Created by write_sdc
# Tue Oct 18 12:56:03 2022
###############################################################################
current_design caravel_clocking
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name ext_clk -period 25.0000 [get_ports {ext_clk}]
set_clock_transition 0.1500 [get_clocks {ext_clk}]
set_clock_uncertainty 0.2000 ext_clk
set_propagated_clock [get_clocks {ext_clk}]
create_clock -name pll_clk -period 6.6667 [get_ports {pll_clk}]
set_clock_transition 0.1000 [get_clocks {pll_clk}]
set_clock_uncertainty 0.2000 pll_clk
set_propagated_clock [get_clocks {pll_clk}]
create_clock -name pll_clk90 -period 6.6667 [get_ports {pll_clk90}]
set_clock_transition 0.1000 [get_clocks {pll_clk90}]
set_clock_uncertainty 0.2000 pll_clk90
set_propagated_clock [get_clocks {pll_clk90}]
create_generated_clock -name core_clk -source [get_pins {_206_/X}] -divide_by 1 [get_ports {core_clk}]
set_clock_transition 0.1000 [get_clocks {core_clk}]
set_clock_uncertainty 0.2000 core_clk
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
set_input_transition 5.0000 [get_ports {ext_clk}]
set_input_transition 5.0000 [get_ports {ext_clk_sel}]
set_input_transition 5.0000 [get_ports {ext_reset}]
set_input_transition 5.0000 [get_ports {pll_clk}]
set_input_transition 5.0000 [get_ports {pll_clk90}]
set_input_transition 5.0000 [get_ports {resetb}]
set_input_transition 5.0000 [get_ports {sel[2]}]
set_input_transition 5.0000 [get_ports {sel[1]}]
set_input_transition 5.0000 [get_ports {sel[0]}]
set_input_transition 5.0000 [get_ports {sel2[2]}]
set_input_transition 5.0000 [get_ports {sel2[1]}]
set_input_transition 5.0000 [get_ports {sel2[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_transition -clock_path 0.5000 [get_clocks {core_clk}]
set_max_transition -clock_path 0.5000 [get_clocks {ext_clk}]
set_max_transition -clock_path 0.5000 [get_clocks {pll_clk}]
set_max_transition -clock_path 0.5000 [get_clocks {pll_clk90}]
set_max_fanout 12.0000 [current_design]
