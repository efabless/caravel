###############################################################################
# Created by write_sdc
# Thu Mar 17 11:21:00 2022
###############################################################################
current_design gpio_control_block
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name serial_clock -period 50.0000 [get_ports {serial_clock}]
set_clock_transition 0.1500 [get_clocks {serial_clock}]
set_clock_uncertainty 0.4000 serial_clock
set_propagated_clock [get_clocks {serial_clock}]
create_clock -name serial_load -period 50.0000 [get_ports {serial_load}]
set_clock_transition 0.1500 [get_clocks {serial_load}]
set_clock_uncertainty 0.4000 serial_load
set_propagated_clock [get_clocks {serial_load}]

set_max_transition 1.25 [current_design]
set clk_input [get_port serial_clock)]
set clk_indx [lsearch [all_inputs] $clk_input]
set all_inputs_wo_clk [lreplace [all_inputs] $clk_indx $clk_indx ""]

set_input_transition 5.0 $all_inputs_wo_clk
#set_driving_cell -lib_cell sky130_fd_sc_hd__buf_1 -pin {X} -input_transition_rise 1.0000 -input_transition_fall 1.0000 [all_inputs]

set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
set_max_fanout 7.0000 [current_design]
#
set_output_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [all_outputs]
set_load -pin_load 0.25 [all_outputs] 
#
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[0]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[10]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[11]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[12]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[1]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[2]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[3]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[4]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[5]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[6]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[7]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[8]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {gpio_defaults[9]}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {mgmt_gpio_oeb}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {mgmt_gpio_out}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {pad_gpio_in}]
#set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {resetn}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {serial_data_in}]
#set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {serial_load}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {user_gpio_oeb}]
set_input_delay 10.0000 -clock [get_clocks {serial_clock}] -add_delay [get_ports {user_gpio_out}]
