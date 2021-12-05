current_design xres_buf
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name __VIRTUAL_CLK__ -period 10.0000 
set_clock_uncertainty 0.2500 __VIRTUAL_CLK__
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {X}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {X}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 5.0000 [current_design]
