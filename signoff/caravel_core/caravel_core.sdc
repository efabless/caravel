### Caravel Core Signoff SDC
### Rev 1
### Date: 12/2/2023


## MASTER CLOCKS
set clk_period 25
create_clock -name clk -period $clk_period [get_ports {clock_core}] 
puts "\[INFO\]: Systemn clock period: $clk_period"

create_clock -name hk_serial_clk -period 100 [get_pins {housekeeping/serial_clock}]
create_clock -name hk_serial_load -period 1000 [get_pins {housekeeping/serial_load}]
set_clock_uncertainty 0.1000 [get_clocks {clk hk_serial_clk hk_serial_load}]
set_propagated_clock [get_clocks {clk hk_serial_clk hk_serial_load}]

# ## INPUT/OUTPUT DELAYS
set input_delay_value 4
set output_delay_value 4
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"
set_input_delay $input_delay_value -clock [get_clocks {clk}] [all_inputs]
set_input_delay 0 [get_ports {clock_core}]
set_output_delay $output_delay_value -clock [get_clocks {clk}] [all_outputs]

# deassert hkspi_disable
set_case_analysis 0 [get_pins {housekeeping/_6817_/Q}]
create_clock -name hkspi_clk -period 100 [get_ports {mprj_io_in[4]}] 
set_input_delay 0 [get_ports {mprj_io_in[4]}]
set_clock_uncertainty 0.1000 [get_clocks {hkspi_clk}]
set_propagated_clock [get_clocks {hkspi_clk}]
set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {clk}]\
   -group [get_clocks {hk_serial_clk}]\
   -group [get_clocks {hk_serial_load}]\
   -group [get_clocks {hkspi_clk}]

set_max_fanout 18 [current_design]
# synthesis max fanout is 18 

## FALSE PATHS (ASYNCHRONOUS INPUTS)
set_false_path -from [get_ports {rstb_h}]

set_false_path -from [get_ports {gpio_in_core}]

# add loads for output ports (pads)
# pad input pin cap 0.036793 (pin OUT of pad sky130_ef_io__gpiov2_pad_wrapped)
set out_cap 0.036793
puts "\[INFO\]: Cap load range: $out_cap"
set_load $out_cap [all_outputs]

#add input transition for the inputs ports (pads)
# pad output pin transition range is 0.08:1.5 (pin IN of pad sky130_ef_io__gpiov2_pad_wrapped)
set min_in_tran 0.08
set max_in_tran 1.5
puts "\[INFO\]: Input transition range: $min_in_tran : $max_in_tran"
set_input_transition -min $min_in_tran [all_inputs] 
set_input_transition -min 0 [get_ports v*]
set_input_transition -min 0 [get_ports {clock_core}]
set_input_transition -max $max_in_tran [all_inputs]
set_input_transition -max 0 [get_ports v*]
set_input_transition -max 0 [get_ports {clock_core}]

# check ocv table (not provided) 
set derate 0.0375
puts "\[INFO\]: Setting derate factor to: [expr $derate * 100] %"
set_timing_derate -early [expr 1-$derate]
set_timing_derate -late [expr 1+$derate]
