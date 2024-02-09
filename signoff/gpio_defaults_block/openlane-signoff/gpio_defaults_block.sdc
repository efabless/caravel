###############################################################################
# Created by write_sdc
# Fri Nov  5 21:10:28 2021
###############################################################################
current_design gpio_defaults_block
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name __VIRTUAL_CLK__ -period 10.0000 
set_clock_uncertainty 0.2500 __VIRTUAL_CLK__
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[0]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[10]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[11]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[12]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[1]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[2]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[3]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[4]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[5]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[6]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[7]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[8]}]
set_output_delay 2.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {gpio_defaults[9]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {gpio_defaults[12]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[11]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[10]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[9]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[8]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[7]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[6]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[5]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[4]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[3]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[2]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[1]}]
set_load -pin_load 0.0334 [get_ports {gpio_defaults[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 5.0000 [current_design]
