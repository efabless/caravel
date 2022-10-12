###############################################################################
# Created by write_sdc
# Sat Oct  8 18:34:24 2022
###############################################################################
current_design constant_block
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name __VIRTUAL_CLK__ -period 10.0000 
set_clock_uncertainty 0.2500 __VIRTUAL_CLK__
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {one}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {zero}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {one}]
set_load -pin_load 0.0334 [get_ports {zero}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
