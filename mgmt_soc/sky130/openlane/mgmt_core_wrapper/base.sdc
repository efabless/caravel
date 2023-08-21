## MASTER CLOCKS
create_clock [get_ports $::env(CLOCK_PORT)]  -name $::env(CLOCK_PORT)  -period $::env(CLOCK_PERIOD)

## FALSE PATHS
set_false_path -from [get_port $::env(RESET_PORT)]

## INPUT/OUTPUT DELAYS
set input_delay_value 5
set output_delay_value 5
# set output_delay_value 20
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

## HK INPUTS 
set hk_min_input_delay 2 
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports user_irq[*]]
set_input_delay 5.60 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io0_di]
set_input_delay 5.80 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io1_di]
set_input_delay 5.60 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io2_di]
set_input_delay 5.60 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io3_di]
set_input_delay 1.1 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports hk_dat_i[*]]
set_input_delay 1.1 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports hk_ack_i]
set_input_delay 5.85 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports ser_tx]
set_input_delay 5.80 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports spi_sdi]
set_input_delay 5.60 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports debug_in]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports sram_ro_clk]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports sram_ro_csb]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports sram_ro_addr[*]]


## USER PROJECT WRAPPER INPUTS
set user_input_delay 3 
set_input_delay $user_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports la_input[*]]
set_input_delay $user_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports mprj_ack_i]
set_input_delay $user_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports mprj_dat_i[*]]

## PADFRAME INPUTS
set padframe_input_delay 4 
set_input_delay $padframe_input_delay  -clock [get_clocks $::env(CLOCK_PORT)] [get_ports gpio_in_pad]

## OUTPUT DELAYS
#set_output_delay $output_delay_value  -clock [get_clocks $::env(CLOCK_PORT)] [all_outputs]

set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {debug_mode}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {debug_oeb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {debug_out}]

set flash_output_delay 5 
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_clk}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_cs_n}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io0_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io0_oeb}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io1_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io1_oeb}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io2_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io2_oeb}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io3_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io3_oeb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_inenb_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_mode0_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_mode1_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_out_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_outenb_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {hk_cyc_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {hk_stb_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {la_iena[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {la_oenb[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {la_output[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mgmt_soc_dff_A[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mgmt_soc_dff_Di[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mgmt_soc_dff_EN}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mgmt_soc_dff_WE[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_adr_o[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_cyc_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_dat_o[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_sel_o[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_stb_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_wb_iena}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_we_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {qspi_enabled}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {serial_tx}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_clk}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_cs_n}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_enabled}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_mosi}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_sdoenb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_addr[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_clk}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_csb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_data[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {trap}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {uart_enabled}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {user_irq_ena[*]}]

## INPUT DRIVER
#set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load 0.15
puts "\[INFO\]: Setting load to: $cap_load"
set_load $cap_load [all_outputs]

set ::env(SYNTH_CLOCK_UNCERTAINITY) 0.3
puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks $::env(CLOCK_PORT)]

set ::env(SYNTH_CLOCK_TRANSITION) 0.5
puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks $::env(CLOCK_PORT)]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early 0.95
set_timing_derate -late 1.05
set_max_fanout 20 [current_design]

set_max_transition 0.75 [current_design]
set_max_transition 0.5 [get_clocks {core_clk}] -clock_path
# set clk_input [get_port $::env(CLOCK_PORT))]
# set clk_indx [lsearch [all_inputs] $clk_input]
# set all_inputs_wo_clk [lreplace [all_inputs] $clk_indx $clk_indx ""]

# set_input_transition 5.0 $all_inputs_wo_clk
