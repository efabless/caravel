### Housekeeping SDC Update
### Mod Rev 2 
### Date: 7/10/2022

set ::env(WB_CLK_PERIOD) 30
set ::env(SCK_CLK_PERIOD) 120
set ::env(RESET_PORT) "wb_rstn_i"

## MASTER CLOCKS
create_clock [get_ports {"wb_clk_i"} ] -name "wb_clk_i"  -period $::env(WB_CLK_PERIOD)
create_clock [get_ports {"user_clock"} ] -name "user_clock"  -period $::env(WB_CLK_PERIOD)
create_clock [get_ports {"mgmt_gpio_in[4]"} ] -name "sck"  -period $::env(SCK_CLK_PERIOD)
##
set_propagated_clock [get_clocks {wb_clk_i}]
set_propagated_clock [get_clocks {user_clock}]
set_propagated_clock [get_clocks {"sck"}]

## GENERATED CLOCKS
# NOTE: change the clock pins whenever the synthesis receipe changes 
set wbbd_sck_pin [get_pins -of_objects wbbd_sck -filter lib_pin_name==Q]

create_generated_clock -name "wbbd_sck" -source [get_ports {"wb_clk_i"} ] -divide_by 2 $wbbd_sck_pin

# paths between wb_clk_i and sck shouldn't be timed
set_clock_groups -logically_exclusive -group wb_clk_i -group sck 

set_propagated_clock [all_clocks]

## FALSE PATHS
set_false_path -from [get_ports $::env(RESET_PORT)]
set_false_path -from [get_ports "porb"]

## INPUT/OUTPUT DELAYS
set input_delay_value 5
set output_delay_value 5
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

## INPUT DELAYS
set_input_delay $input_delay_value -clock [get_clocks wb_clk_i] [all_inputs]
set_input_delay $input_delay_value -clock [get_clocks wb_clk_i] [get_port "mgmt_gpio_in[4]"]
set_input_delay $input_delay_value -clock [get_clocks wb_clk_i] [get_port "user_clock"]

## OUTPUT DELAYS

# WISHBONE DELAY
set_output_delay $output_delay_value -clock [get_clocks wb_clk_i] [get_ports wb_ack_o]
set_output_delay $output_delay_value -clock [get_clocks wb_clk_i] [get_ports wb_dat_o[*]]

# PLL DELAYS
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pll_ena]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pll_dco_ena]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pll_div[*]]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pll_sel[*]]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pll90_sel[*]]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pll_trim[*]]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pll_bypass]

# SOC DELAYS
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports ser_rx]

# SPI DELAYS
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spi_sdi]

# IRQ 
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports irq[*]]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports reset]

# GPIO 
# Specify serial_clock as a generated clock signal
#set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports serial_clock]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports serial_load]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports serial_resetn]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports serial_data_1]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports serial_data_2]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports mgmt_gpio_out[*]]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports mgmt_gpio_oeb[*]]

# FLASH 
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io0_di]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io1_di]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io2_di]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io3_di]

set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports debug_in]

set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_csb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_clk]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io0_do]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io1_do]

# SRAM
# set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports sram_ro_clk]
# set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports sram_ro_csb]
# set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports sram_ro_addr[*]]

## OUTPUT LOADS
set PT_cap_load 0.1
puts "\[INFO\]: Setting load to: $PT_cap_load"
set_load $PT_cap_load [all_outputs]

## TIMING DERATE
# set ::env(SYNTH_TIMING_DERATE) 0.05
# puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"
# set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
# set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]

## CLOCK UNCERTAINITY
set wb_clk_uncer 0.1
set sck_clk_uncer 0.1

puts "\[INFO\]: Setting WB clock uncertainity to: $wb_clk_uncer"
puts "\[INFO\]: Setting SCK clock uncertainity to: $sck_clk_uncer"
set_clock_uncertainty $wb_clk_uncer [get_clocks {wb_clk_i}]
set_clock_uncertainty $wb_clk_uncer [get_clocks {user_clock}]
set_clock_uncertainty $sck_clk_uncer [get_clocks {sck}]
set_clock_uncertainty $sck_clk_uncer [get_clocks {wbbd_sck}]

## CLOCK TRANSITION
set wb_clk_tran 2
set sck_clk_tran 2

# puts "\[INFO\]: Setting clock transition to: $wb_clk_tran"
# puts "\[INFO\]: Setting clock transition to: $sck_clk_tran"

# set_clock_transition $wb_clk_tran [get_clocks {wb_clk_i}]
# set_clock_transition $wb_clk_tran [get_clocks {user_clock}]
# set_clock_transition $sck_clk_tran [get_clocks {sck}]

# ## FANOUT
# set ::env(SYNTH_MAX_FANOUT) 20
# puts "\[INFO\]: Setting maximum fanout to: $::env(SYNTH_MAX_FANOUT)"
# set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

# ## MAX Transition
set_max_trans 4 [current_design]
set_max_cap 1 [current_design]

set_max_transition $wb_clk_tran [get_clocks {wb_clk_i}] -clock_path
set_max_transition $wb_clk_tran [get_clocks {user_clock}] -clock_path
set_max_transition $wb_clk_tran [get_clocks {sck}] -clock_path

set_max_transition $wb_clk_tran [get_ports {pad_flash_clk}] -clock_path
set_max_transition $wb_clk_tran [get_ports {mgmt_gpio_out[15]}] -clock_path
set_max_transition $wb_clk_tran [get_ports {mgmt_gpio_out[9]}] -clock_path
set_max_transition $wb_clk_tran [get_ports {mgmt_gpio_out[14]}] -clock_path
