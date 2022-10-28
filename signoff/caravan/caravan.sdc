### Caravan Signoff SDC
### Rev 1
### Date: 22/10/2022

## MASTER CLOCKS
create_clock -name clk -period 25 [get_ports {clock}] 

create_clock -name hkspi_clk -period 100 [get_pins {housekeeping/mgmt_gpio_in[4]} ] 
create_clock -name hk_serial_clk -period 50 [get_pins {housekeeping/serial_clock}]
create_clock -name hk_serial_load -period 1000 [get_pins {housekeeping/serial_load}]
# hk_serial_clk period is x2 core clock

set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {clk}]\
   -group [get_clocks {hk_serial_clk}]\
   -group [get_clocks {hk_serial_load}]\
   -group [get_clocks {hkspi_clk}]

# clock <-> hk_serial_clk/load no paths
# future note: CDC stuff
# clock <-> hkspi_clk no paths with careful methods (clock is off)

set_propagated_clock [get_clocks {clk}]
set_propagated_clock [get_clocks {hk_serial_clk}]
set_propagated_clock [get_clocks {hk_serial_load}]
set_propagated_clock [get_clocks {hkspi_clk}]

## INPUT/OUTPUT DELAYS
set input_delay_value 4
set output_delay_value 4
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {gpio}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[0]}]

#set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[1]}]

set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] -add_delay [get_ports {mprj_io[2]}]
set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] -add_delay [get_ports {mprj_io[3]}]

#set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[4]}]

set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[5]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[6]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[7]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[8]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[9]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[10]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[11]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[12]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[13]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[14]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[15]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[16]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[17]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[18]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[19]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[20]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[21]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[22]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[23]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[24]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[25]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[26]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[27]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[28]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[29]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[30]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[31]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[32]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[33]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[34]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[35]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[36]}]
set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[37]}]

set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {flash_csb}]
set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {flash_clk}]
set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {flash_io0}]
set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {flash_io1}]

# set_output_delay $output_delay_value  -clock [get_clocks {hkspi_clk}] -add_delay [get_ports {mprj_io[1]}]

set_max_fanout 12 [current_design]
# synthesis max fanout should be less than 12 (7 maybe)

## Set system monitoring mux select to zero so that the clock/user_clk monitoring is disabled 
set_case_analysis 0 [get_pins housekeeping/_3936_/S]
set_case_analysis 0 [get_pins housekeeping/_3937_/S]

# Add case analysis for pads DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0

set_case_analysis 1 [get_pins padframe/*_pad/DM[2]]
set_case_analysis 1 [get_pins padframe/*_pad/DM[1]]
set_case_analysis 0 [get_pins padframe/*_pad/DM[0]]
set_case_analysis 0 [get_pins padframe/*_pad/SLOW]
set_case_analysis 0 [get_pins padframe/*_pad/ANALOG_EN]

set_case_analysis 1 [get_pins padframe/*_io_pad*/DM[2]]
set_case_analysis 1 [get_pins padframe/*_io_pad*/DM[1]]
set_case_analysis 0 [get_pins padframe/*_io_pad*/DM[0]]
set_case_analysis 0 [get_pins padframe/*_io_pad*/SLOW]
set_case_analysis 0 [get_pins padframe/*_io_pad*/ANALOG_EN]

set_case_analysis 0 [get_pins padframe/*area1_io_pad[4]/DM[2]]
set_case_analysis 0 [get_pins padframe/*area1_io_pad[4]/DM[1]]
set_case_analysis 1 [get_pins padframe/*area1_io_pad[4]/DM[0]]

set_case_analysis 0 [get_pins padframe/*area1_io_pad[2]/DM[2]]
set_case_analysis 0 [get_pins padframe/*area1_io_pad[2]/DM[1]]
set_case_analysis 1 [get_pins padframe/*area1_io_pad[2]/DM[0]]


set_case_analysis 0 [get_pins padframe/clock_pad/DM[2]]
set_case_analysis 0 [get_pins padframe/clock_pad/DM[1]]
set_case_analysis 1 [get_pins padframe/clock_pad/DM[0]]

## FALSE PATHS (ASYNCHRONOUS INPUTS)
set_false_path -from [get_ports {resetb}]

set_false_path -from [get_ports mprj_io[0]] -through [get_pins housekeeping/mgmt_gpio_in[0]]
set_false_path -from [get_ports mprj_io[1]] -through [get_pins housekeeping/mgmt_gpio_in[1]]
set_false_path -from [get_ports mprj_io[3]] -through [get_pins housekeeping/mgmt_gpio_in[3]]
set_false_path -from [get_ports mprj_io[5]] -through [get_pins housekeeping/mgmt_gpio_in[5]]
set_false_path -from [get_ports mprj_io[6]] -through [get_pins housekeeping/mgmt_gpio_in[6]]
set_false_path -from [get_ports mprj_io[7]] -through [get_pins housekeeping/mgmt_gpio_in[7]]
set_false_path -from [get_ports mprj_io[8]] -through [get_pins housekeeping/mgmt_gpio_in[8]]
set_false_path -from [get_ports mprj_io[9]] -through [get_pins housekeeping/mgmt_gpio_in[9]]
set_false_path -from [get_ports mprj_io[10]] -through [get_pins housekeeping/mgmt_gpio_in[10]]
set_false_path -from [get_ports mprj_io[11]] -through [get_pins housekeeping/mgmt_gpio_in[11]]
set_false_path -from [get_ports mprj_io[12]] -through [get_pins housekeeping/mgmt_gpio_in[12]]
set_false_path -from [get_ports mprj_io[13]] -through [get_pins housekeeping/mgmt_gpio_in[13]]
set_false_path -from [get_ports mprj_io[14]] -through [get_pins housekeeping/mgmt_gpio_in[14]]
set_false_path -from [get_ports mprj_io[15]] -through [get_pins housekeeping/mgmt_gpio_in[15]]
set_false_path -from [get_ports mprj_io[16]] -through [get_pins housekeeping/mgmt_gpio_in[16]]
set_false_path -from [get_ports mprj_io[17]] -through [get_pins housekeeping/mgmt_gpio_in[17]]
set_false_path -from [get_ports mprj_io[18]] -through [get_pins housekeeping/mgmt_gpio_in[18]]
set_false_path -from [get_ports mprj_io[19]] -through [get_pins housekeeping/mgmt_gpio_in[19]]
set_false_path -from [get_ports mprj_io[20]] -through [get_pins housekeeping/mgmt_gpio_in[20]]
set_false_path -from [get_ports mprj_io[21]] -through [get_pins housekeeping/mgmt_gpio_in[21]]
set_false_path -from [get_ports mprj_io[22]] -through [get_pins housekeeping/mgmt_gpio_in[22]]
set_false_path -from [get_ports mprj_io[23]] -through [get_pins housekeeping/mgmt_gpio_in[23]]
set_false_path -from [get_ports mprj_io[24]] -through [get_pins housekeeping/mgmt_gpio_in[24]]
set_false_path -from [get_ports mprj_io[25]] -through [get_pins housekeeping/mgmt_gpio_in[25]]
set_false_path -from [get_ports mprj_io[26]] -through [get_pins housekeeping/mgmt_gpio_in[26]]
set_false_path -from [get_ports mprj_io[27]] -through [get_pins housekeeping/mgmt_gpio_in[27]]
set_false_path -from [get_ports mprj_io[28]] -through [get_pins housekeeping/mgmt_gpio_in[28]]
set_false_path -from [get_ports mprj_io[29]] -through [get_pins housekeeping/mgmt_gpio_in[29]]
set_false_path -from [get_ports mprj_io[30]] -through [get_pins housekeeping/mgmt_gpio_in[30]]
set_false_path -from [get_ports mprj_io[31]] -through [get_pins housekeeping/mgmt_gpio_in[31]]
set_false_path -from [get_ports mprj_io[32]] -through [get_pins housekeeping/mgmt_gpio_in[32]]
set_false_path -from [get_ports mprj_io[33]] -through [get_pins housekeeping/mgmt_gpio_in[33]]
set_false_path -from [get_ports mprj_io[34]] -through [get_pins housekeeping/mgmt_gpio_in[34]]
set_false_path -from [get_ports mprj_io[35]] -through [get_pins housekeeping/mgmt_gpio_in[35]]
set_false_path -from [get_ports mprj_io[36]] -through [get_pins housekeeping/mgmt_gpio_in[36]]
set_false_path -from [get_ports mprj_io[37]] -through [get_pins housekeeping/mgmt_gpio_in[37]]

set_false_path -from [get_ports mprj_io[*]] -through [get_pins housekeeping/mgmt_gpio_out[*]]
set_false_path -from [get_ports mprj_io[*]] -through [get_pins housekeeping/mgmt_gpio_oeb[*]]

# reset_path -from [get_ports mprj_io[4]] 
# reset_path -from [get_ports mprj_io[2]] 

set_false_path -from [get_ports gpio]
#set_false_path -through [get_nets mprj_io_inp_dis[*]]
# set_timing_derate -early 1
# set_timing_derate -late 1

set cap_load 10
puts "\[INFO\]: Setting load to: $cap_load"
set_load $cap_load [all_outputs]

#add input transition for the inputs pins
set_input_transition 2 [all_inputs]
