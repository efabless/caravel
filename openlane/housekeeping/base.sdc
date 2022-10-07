### Housekeeping SDC Update
### Mod Rev 2 
### Date: 28/9/2022

set ::env(WB_CLK_PERIOD) 25 
set ::env(SCK_CLK_PERIOD) 100
set ::env(RESET_PORT) "wb_rstn_i"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

## MASTER CLOCKS
create_clock [get_ports {"wb_clk_i"} ] -name "wb_clk_i"  -period $::env(WB_CLK_PERIOD)
create_clock [get_ports {"user_clock"} ] -name "user_clock"  -period $::env(WB_CLK_PERIOD)
create_clock [get_ports {"mgmt_gpio_in[4]"} ] -name "sck"  -period $::env(SCK_CLK_PERIOD)

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
set input_delay_value 10
set output_delay_value 5
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

## Filter clocks from the all inputs
set sck_clk_indx [lsearch [all_inputs] [get_port "mgmt_gpio_in[4]"]]
set all_inputs_wo_sckclk [lreplace [all_inputs] $sck_clk_indx $sck_clk_indx]
set wb_clk_indx [lsearch $all_inputs_wo_sckclk [get_port "wb_clk_i"]]
set all_inputs_wo_2clks [lreplace $all_inputs_wo_sckclk $wb_clk_indx $wb_clk_indx]
set usr_clk_indx [lsearch $all_inputs_wo_2clks [get_port "user_clock"]]
set all_inputs_wo_clk [lreplace $all_inputs_wo_2clks $usr_clk_indx $usr_clk_indx]

set_input_delay $input_delay_value -clock [get_clocks wb_clk_i] $all_inputs_wo_clk

## OUTPUT DELAYS

# WISHBONE DELAY

set wb_output_delay 5
set_output_delay $wb_output_delay -clock [get_clocks wb_clk_i] [get_ports wb_ack_o]
set_output_delay $wb_output_delay -clock [get_clocks wb_clk_i] [get_ports wb_dat_o[*]]

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
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pwr_ctrl_out[*]]

# FLASH 
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io0_di]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io1_di]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io2_di]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports spimemio_flash_io3_di]

set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports debug_in]

set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_csb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_csb_oeb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_clk]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_clk_oeb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io0_oeb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io1_oeb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io0_ieb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io1_ieb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io0_do]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io1_do]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports pad_flash_io0_ieb]

# SRAM
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports sram_ro_clk]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports sram_ro_csb]
set_output_delay $output_delay_value  -clock [get_clocks wb_clk_i] [get_ports sram_ro_addr[*]]

## OUTPUT LOADS
set PT_cap_load 0.21
puts "\[INFO\]: Setting load to: $PT_cap_load"
set_load $PT_cap_load [all_outputs]

## TIMING DERATE
set ::env(SYNTH_TIMING_DERATE) 0.05
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]

## CLOCK UNCERTAINITY
set wb_clk_uncer [expr $::env(WB_CLK_PERIOD)*0.05]
set sck_clk_uncer [expr $::env(SCK_CLK_PERIOD)*0.05]

puts "\[INFO\]: Setting WB clock uncertainity to: $wb_clk_uncer"
puts "\[INFO\]: Setting SCK clock uncertainity to: $sck_clk_uncer"
set_clock_uncertainty $wb_clk_uncer [get_clocks {wb_clk_i}]
set_clock_uncertainty $wb_clk_uncer [get_clocks {user_clock}]
set_clock_uncertainty $sck_clk_uncer [get_clocks {sck}]

## CLOCK TRANSITION
set wb_clk_tran [expr $::env(WB_CLK_PERIOD)*0.01]
set sck_clk_tran [expr $::env(SCK_CLK_PERIOD)*0.01]

puts "\[INFO\]: Setting clock transition to: $wb_clk_tran"
puts "\[INFO\]: Setting clock transition to: $sck_clk_tran"

set_clock_transition $wb_clk_tran [get_clocks {wb_clk_i}]
set_clock_transition $wb_clk_tran [get_clocks {user_clock}]
set_clock_transition $sck_clk_tran [get_clocks {sck}]

## FANOUT
set ::env(SYNTH_MAX_FANOUT) 7
puts "\[INFO\]: Setting maximum fanout to: $::env(SYNTH_MAX_FANOUT)"
set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]
