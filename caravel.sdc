set ::env(IO_PCT) "0.2"
set ::env(SYNTH_MAX_FANOUT) "12"

## MASTER CLOCKS
create_clock -name "clock" -period 25 [get_ports {"clock"}] 

create_clock -name "hkspi_clk" -period 100 [get_pins {housekeeping/mgmt_gpio_in[4]} ] 
# sky130_fd_sc_hd__mux2_1 _8819_ (.A0(serial_clock_pre),
#    .A1(serial_bb_clock),
#    .S(serial_bb_enable),
#    .VGND(VGND),
#    .VNB(VGND),
#    .VPB(VPWR),
#    .VPWR(VPWR),
#    .X(net306));

create_clock -name hk_serial_clk -period 1000 [get_pins {housekeeping/_8819_/X}]

create_clock -name hk_serial_load -period 1000 [get_pins {housekeeping/serial_load}]

set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {clock}]\
   -group [get_clocks {hk_serial_clk}]\
   -group [get_clocks {hk_serial_load}]\
   -group [get_clocks {hkspi_clk}]

set_propagated_clock [get_clocks {"clock"}]
set_propagated_clock [get_clocks {hk_serial_clk}]
set_propagated_clock [get_clocks {hk_serial_load}]
set_propagated_clock [get_clocks {hkspi_clk}]

## INPUT/OUTPUT DELAYS
set input_delay_value 4
set output_delay_value 4
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {gpio}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[0]}]

#set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[1]}]

set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] -add_delay [get_ports {mprj_io[2]}]
set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] -add_delay [get_ports {mprj_io[3]}]

#set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[4]}]

set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[5]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[6]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[7]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[8]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[9]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[10]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[11]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[12]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[13]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[14]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[15]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[16]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[17]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[18]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[19]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[20]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[21]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[22]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[23]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[24]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[25]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[26]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[27]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[28]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[29]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[30]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[31]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[32]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[33]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[34]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[35]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[36]}]
set_input_delay $input_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {mprj_io[37]}]

set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_csb}]
set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_clk}]
set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_io0}]
set_output_delay $output_delay_value  -clock [get_clocks {clock}] -add_delay [get_ports {flash_io1}]

# set_output_delay $output_delay_value  -clock [get_clocks {hkspi_clk}] -add_delay [get_ports {mprj_io[1]}]

set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

## Set system monitoring mux select to zero so that the clock/user_clk monitoring is disabled 
set_case_analysis 0 [get_pins housekeeping/_4449_/S]
set_case_analysis 0 [get_pins housekeeping/_4450_/S]

## FALSE PATHS (ASYNCHRONOUS INPUTS)
set_false_path -from [get_ports {resetb}]
set_false_path -from [get_ports mprj_io[*]]
set_false_path -from [get_ports gpio]
#set_false_path -through [get_nets mprj_io_inp_dis[*]]
set_timing_derate -early 1
set_timing_derate -late 1

# TODO set this as parameter
set cap_load 10
puts "\[INFO\]: Setting load to: $cap_load"
set_load $cap_load [all_outputs]

