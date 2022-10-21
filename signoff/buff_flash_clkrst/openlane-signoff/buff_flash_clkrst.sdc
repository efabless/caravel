###############################################################################
# Created by write_sdc
# Thu Oct 13 17:28:51 2022
###############################################################################
current_design buff_flash_clkrst
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name __VIRTUAL_CLK__ -period 8.0000 
set_clock_uncertainty 0.2500 __VIRTUAL_CLK__
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[0]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[10]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[11]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[1]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[2]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[3]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[4]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[5]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[6]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[7]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[8]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_n[9]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_s[0]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_s[1]}]
set_input_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {in_s[2]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_n[0]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_n[1]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_n[2]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[0]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[10]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[11]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[1]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[2]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[3]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[4]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[5]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[6]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[7]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[8]}]
set_output_delay 1.6000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {out_s[9]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {out_n[2]}]
set_load -pin_load 0.0334 [get_ports {out_n[1]}]
set_load -pin_load 0.0334 [get_ports {out_n[0]}]
set_load -pin_load 0.0334 [get_ports {out_s[11]}]
set_load -pin_load 0.0334 [get_ports {out_s[10]}]
set_load -pin_load 0.0334 [get_ports {out_s[9]}]
set_load -pin_load 0.0334 [get_ports {out_s[8]}]
set_load -pin_load 0.0334 [get_ports {out_s[7]}]
set_load -pin_load 0.0334 [get_ports {out_s[6]}]
set_load -pin_load 0.0334 [get_ports {out_s[5]}]
set_load -pin_load 0.0334 [get_ports {out_s[4]}]
set_load -pin_load 0.0334 [get_ports {out_s[3]}]
set_load -pin_load 0.0334 [get_ports {out_s[2]}]
set_load -pin_load 0.0334 [get_ports {out_s[1]}]
set_load -pin_load 0.0334 [get_ports {out_s[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[11]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[10]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[9]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[8]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_n[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_s[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_s[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in_s[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
