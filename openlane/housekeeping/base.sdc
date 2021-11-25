set ::env(WB_CLK_PERIOD) 25 
set ::env(SCK_CLK_PERIOD) 100
set ::env(RESET_PORT) "wb_rstn_i"

## MASTER CLOCKS
create_clock [get_ports {"wb_clk_i"} ] -name "wb_clk_i"  -period $::env(WB_CLK_PERIOD)
create_clock [get_ports {"mgmt_gpio_in[4]"} ] -name "mgmt_gpio_in"  -period $::env(SCK_CLK_PERIOD)

## GENERATED CLOCKS
# NOTE: change the clock pins whenever the synthesis receipe changes 
create_generated_clock -name "wbbd_sck" -source [get_ports {"wb_clk_i"} ] -divide_by 1 [get_pins {"_9640_/Q"} ] 
create_generated_clock -name "csclk_fast" -source [get_pins {"_9640_/Q"}]  -divide_by 1 [get_pins {"_8847_/X"} ] 
create_generated_clock -name "csclk_slow" -source [get_ports {"mgmt_gpio_in[4]"} ] -divide_by 1 [get_pins {"_8847_/X"} ] 

# paths between wb_clk_i and mgmt_gpio_in shouldn't be timed
set_clock_groups -logically_exclusive -group wb_clk_i -group mgmt_gpio_in 
# mux output is logically exclusive 
set_clock_groups -logically_exclusive -group csclk_fast -group csclk_slow

## FALSE PATHS
set_false_path -from [get_ports $::env(RESET_PORT)]
set_false_path -from [get_ports "porb"]

## INPUT/OUTPUT DELAYS
set input_delay_value [expr $::env(WB_CLK_PERIOD) * $::env(IO_PCT)]
set output_delay_value [expr $::env(WB_CLK_PERIOD) * $::env(IO_PCT)]
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

set sck_clk_indx [lsearch [all_inputs] [get_port "mgmt_gpio_in[4]"]]
#set rst_indx [lsearch [all_inputs] [get_port resetn]]
set all_inputs_wo_clk [lreplace [all_inputs] $sck_clk_indx $sck_clk_indx]
#set all_inputs_wo_clk_rst [lreplace $all_inputs_wo_clk $rst_indx $rst_indx]
set all_inputs_wo_clk_rst $all_inputs_wo_clk

set_input_delay $input_delay_value  -clock [get_clocks $::env(CLOCK_PORT)] $all_inputs_wo_clk
set_output_delay $output_delay_value  -clock [get_clocks $::env(CLOCK_PORT)] [all_outputs]

# TODO set this as parameter
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

## TIMING DERATE
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]

## CLOCK UNCERTAINITY
puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {wb_clk_i}]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {mgmt_gpio_in}]

## CLOCK TRANSITION
puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {wb_clk_i}]
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {mgmt_gpio_in}]

## FANOUT
set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]