###############################################################################
# Created by write_sdc
# Thu Dec  2 18:44:19 2021
###############################################################################
current_design caravel_clocking
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name ext_clk -period 25.0000 [get_ports {ext_clk}]
set_clock_transition 0.1500 [get_clocks {ext_clk}]
set_clock_uncertainty 0.2500 ext_clk
set_propagated_clock [get_clocks {ext_clk}]
create_clock -name pll_clk -period 6.6667 [get_ports {pll_clk}]
set_clock_transition 0.1500 [get_clocks {pll_clk}]
set_clock_uncertainty 0.2500 pll_clk
set_propagated_clock [get_clocks {pll_clk}]
create_clock -name pll_clk90 -period 6.6667 [get_ports {pll_clk90}]
set_clock_transition 0.1500 [get_clocks {pll_clk90}]
set_clock_uncertainty 0.2500 pll_clk90
set_propagated_clock [get_clocks {pll_clk90}]
create_generated_clock -name pll_clk_divided -source [get_ports {pll_clk}] -divide_by 2 [get_pins {_351_/Y}]
set_propagated_clock [get_clocks {pll_clk_divided}]
create_generated_clock -name pll_clk90_divided -source [get_ports {pll_clk90}] -divide_by 2 [get_pins {_354_/Y}]
set_propagated_clock [get_clocks {pll_clk90_divided}]
create_generated_clock -name core_ext_clk_syncd -source [get_pins {_426_/Q}] -divide_by 1 [get_pins {_412_/X}]
set_propagated_clock [get_clocks {core_ext_clk_syncd}]
create_generated_clock -name core_clk_pll -source [get_pins {_351_/Y}] -divide_by 1 [get_pins {_393_/X}]
set_propagated_clock [get_clocks {core_clk_pll}]
create_generated_clock -name user_clk_pll -source [get_pins {_354_/Y}] -divide_by 1 [get_pins {_394_/X}]
set_propagated_clock [get_clocks {user_clk_pll}]
set_clock_groups -name group1 -logically_exclusive \
 -group [get_clocks {core_ext_clk_syncd}]
set_clock_groups -name group2 -logically_exclusive \
 -group [get_clocks {core_clk_pll}]
set_clock_groups -name group3 -logically_exclusive \
 -group [get_clocks {user_clk_pll}]
set_clock_groups -name group4 -logically_exclusive \
 -group [get_clocks {ext_clk}]\
 -group [list [get_clocks {pll_clk}]\
           [get_clocks {pll_clk90}]\
           [get_clocks {pll_clk90_divided}]\
           [get_clocks {pll_clk_divided}]]
set_input_delay 1.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {ext_clk_sel}]
set_input_delay 1.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[0]}]
set_input_delay 1.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[1]}]
set_input_delay 1.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel2[2]}]
set_input_delay 1.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[0]}]
set_input_delay 1.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[1]}]
set_input_delay 1.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {sel[2]}]
set_output_delay 5.0000 -clock [get_clocks {ext_clk}] -add_delay [get_ports {resetb_sync}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {core_clk}]
set_load -pin_load 0.0334 [get_ports {resetb_sync}]
set_load -pin_load 0.0334 [get_ports {user_clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {ext_clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {ext_clk_sel}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {ext_reset}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {pll_clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {pll_clk90}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {resetb}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel2[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel2[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_1 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel2[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 5.0000 [current_design]
