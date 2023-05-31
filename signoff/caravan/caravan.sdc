### Caravan new Signoff SDC
### Rev 1
### Date: 25/5/2023

### Caravel new Signoff SDC
### Rev 1
### Date: 12/2/2023

# IO 4 mode is either SCK or GPIO (hkspi)
set io_4_mode SCK

puts "\[INFO\]: IO[4] is set as: $io_4_mode"
# IOs mode is either OUT or IN (GPIOs)
set ios_mode OUT
puts "\[INFO\]: GPIOs mode is set as: $ios_mode"

# IO ports to user's project wrapper are assumed to be asynchronous. If they're synchronous to the clock, update the variable IO_SYNC to 1
set ::env(IO_SYNC) 0

## MASTER CLOCKS
set clk_period 25
create_clock -name clk -period $clk_period [get_ports {clock}] 
puts "\[INFO\]: System clock period: $clk_period"

create_clock -name hk_serial_clk -period 100 [get_pins {chip_core/housekeeping_alt/serial_clock}]
create_clock -name hk_serial_load -period 1000 [get_pins {chip_core/housekeeping_alt/serial_load}]
set_clock_uncertainty 0.1000 [get_clocks {clk hk_serial_clk hk_serial_load}]
set_propagated_clock [get_clocks {clk hk_serial_clk hk_serial_load}]

set min_clk_tran 1
set max_clk_tran 1.5
puts "\[INFO\]: Clock transition range: $min_clk_tran : $max_clk_tran"

# Add clock transition
set_input_transition -min $min_clk_tran [get_ports {clock}] 
set_input_transition -max $max_clk_tran [get_ports {clock}] 

if {$io_4_mode == "SCK"} {
   # deassert hkspi_disable
   set_case_analysis 0 [get_pins {chip_core/housekeeping_alt/_7257_/Q}]
   # dessert CSB
   set_case_analysis 0 [get_ports {mprj_io[3]} ] 

   create_clock -name hkspi_clk -period 100 [get_ports {mprj_io[4]} ] 
   set_clock_uncertainty 0.1000 [get_clocks {hkspi_clk}]
   set_propagated_clock [get_clocks {hkspi_clk}]
   set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {clk}]\
   -group [get_clocks {hk_serial_clk}]\
   -group [get_clocks {hk_serial_load}]\
   -group [get_clocks {hkspi_clk}]
} elseif {$io_4_mode == "GPIO"} {
   # assert hkspi_disable
   set_case_analysis 1 [get_pins {chip_core/housekeeping_alt/_7257_/Q}]

   set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {clk}]\
   -group [get_clocks {hk_serial_clk}]\
   -group [get_clocks {hk_serial_load}]\
} 
# Add case analysis for clock pad DM[2]==1'b0 & DM[1]==1'b0 & DM[0]==1'b1 to be input
set_case_analysis 0 [get_pins padframe/clock_pad/DM[2]]
set_case_analysis 0 [get_pins padframe/clock_pad/DM[1]]
set_case_analysis 1 [get_pins padframe/clock_pad/DM[0]]
set_case_analysis 0 [get_pins padframe/clock_pad/INP_DIS]
# hk_serial_clk period is x2 core clock
# clock <-> hk_serial_clk/load no paths
# future note: CDC stuff
# clock <-> hkspi_clk no paths with careful methods (clock is off)

# Set system monitoring mux select to zero so that the clock/user_clk monitoring is disabled 
set_case_analysis 0 [get_pins chip_core/housekeeping_alt/_4161_/S]
set_case_analysis 0 [get_pins chip_core/housekeeping_alt/_4162_/S]

set input_delay_value 4
set output_delay_value 4
puts "\[INFO\]: Setting input delay to: $input_delay_value"
puts "\[INFO\]: Setting output delay to: $output_delay_value"

set min_in_tran 1
set max_in_tran 4
puts "\[INFO\]: Input transition range: $min_in_tran : $max_in_tran"

# 10 too high --> 4:7
set min_cap 4
set max_cap 7
puts "\[INFO\]: Cap load range: $min_cap : $max_cap"

if {$ios_mode == "IN"} {
   # Add case analysis for pads DM[2]==1'b0 & DM[1]==1'b0 & DM[0]==1'b1 to be inputs
   set_case_analysis 0 [get_pins padframe/*mprj*/DM[2]]
   set_case_analysis 0 [get_pins padframe/*mprj*/DM[1]]
   set_case_analysis 1 [get_pins padframe/*mprj*/DM[0]]
   set_case_analysis 0 [get_pins padframe/*mprj*/INP_DIS]

   # Add input transition
   set_input_transition -min $min_in_tran [get_ports {mprj_io[*]}] 
   set_input_transition -max $max_in_tran [get_ports {mprj_io[*]}] 

   ## INPUT DELAYS
   set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[0]}]
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
   
   if {$io_4_mode == "SCK"} {
      # Add clock transition
      set_input_transition -min $min_clk_tran [get_ports {mprj_io[4]}] 
      set_input_transition -max $max_clk_tran [get_ports {mprj_io[4]}] 
      # SDO output
      set_case_analysis 1 [get_pins padframe/\mprj_pads.area1_io_pad[1]/DM[2]]
      set_case_analysis 1 [get_pins padframe/\mprj_pads.area1_io_pad[1]/DM[1]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[1]/DM[0]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[1]/OE_N]
      set_output_delay $output_delay_value  -clock [get_clocks {hkspi_clk}] [get_ports {mprj_io[1]}]
      set_load -min $min_cap [get_ports {mprj_io[1]}] 
      set_load -max $max_cap [get_ports {mprj_io[1]}]  
      set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] [get_ports {mprj_io[2]}]
      set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] [get_ports {mprj_io[3]}]

      if { $::env(IO_SYNC) } {
         set_false_path -from [get_ports mprj_io[*]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_out[*]]
         set_false_path -from [get_ports mprj_io[*]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_oeb[*]]
         set_false_path -from [get_ports mprj_io[0]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[0]]
         set_false_path -from [get_ports mprj_io[5]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[5]]
         set_false_path -from [get_ports mprj_io[6]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[6]]
         set_false_path -from [get_ports mprj_io[7]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[7]]
         set_false_path -from [get_ports mprj_io[8]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[8]]
         set_false_path -from [get_ports mprj_io[9]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[9]]
         set_false_path -from [get_ports mprj_io[10]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[10]]
         set_false_path -from [get_ports mprj_io[11]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[11]]
         set_false_path -from [get_ports mprj_io[12]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[12]]
         set_false_path -from [get_ports mprj_io[13]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[13]]
         set_false_path -from [get_ports mprj_io[14]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[14]]
         set_false_path -from [get_ports mprj_io[15]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[15]]
         set_false_path -from [get_ports mprj_io[16]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[16]]
         set_false_path -from [get_ports mprj_io[17]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[17]]
         set_false_path -from [get_ports mprj_io[18]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[18]]
         set_false_path -from [get_ports mprj_io[19]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[19]]
         set_false_path -from [get_ports mprj_io[20]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[20]]
         set_false_path -from [get_ports mprj_io[21]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[21]]
         set_false_path -from [get_ports mprj_io[22]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[22]]
         set_false_path -from [get_ports mprj_io[23]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[23]]
         set_false_path -from [get_ports mprj_io[24]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[24]]
         set_false_path -from [get_ports mprj_io[25]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[25]]
         set_false_path -from [get_ports mprj_io[26]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[26]]
         set_false_path -from [get_ports mprj_io[27]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[27]]
         set_false_path -from [get_ports mprj_io[28]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[28]]
         set_false_path -from [get_ports mprj_io[29]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[29]]
         set_false_path -from [get_ports mprj_io[30]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[30]]
         set_false_path -from [get_ports mprj_io[31]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[31]]
         set_false_path -from [get_ports mprj_io[32]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[32]]
         set_false_path -from [get_ports mprj_io[33]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[33]]
         set_false_path -from [get_ports mprj_io[34]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[34]]
         set_false_path -from [get_ports mprj_io[35]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[35]]
         set_false_path -from [get_ports mprj_io[36]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[36]]
         set_false_path -from [get_ports mprj_io[37]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[37]]
      } else {
         set_false_path -from [get_ports mprj_io[0]]
         set_false_path -from [get_ports mprj_io[5]]
         set_false_path -from [get_ports mprj_io[6]]
         set_false_path -from [get_ports mprj_io[7]]
         set_false_path -from [get_ports mprj_io[8]]
         set_false_path -from [get_ports mprj_io[9]]
         set_false_path -from [get_ports mprj_io[10]]
         set_false_path -from [get_ports mprj_io[11]]
         set_false_path -from [get_ports mprj_io[12]]
         set_false_path -from [get_ports mprj_io[13]]
         set_false_path -from [get_ports mprj_io[14]]
         set_false_path -from [get_ports mprj_io[15]]
         set_false_path -from [get_ports mprj_io[16]]
         set_false_path -from [get_ports mprj_io[17]]
         set_false_path -from [get_ports mprj_io[18]]
         set_false_path -from [get_ports mprj_io[19]]
         set_false_path -from [get_ports mprj_io[20]]
         set_false_path -from [get_ports mprj_io[21]]
         set_false_path -from [get_ports mprj_io[22]]
         set_false_path -from [get_ports mprj_io[23]]
         set_false_path -from [get_ports mprj_io[24]]
         set_false_path -from [get_ports mprj_io[25]]
         set_false_path -from [get_ports mprj_io[26]]
         set_false_path -from [get_ports mprj_io[27]]
         set_false_path -from [get_ports mprj_io[28]]
         set_false_path -from [get_ports mprj_io[29]]
         set_false_path -from [get_ports mprj_io[30]]
         set_false_path -from [get_ports mprj_io[31]]
         set_false_path -from [get_ports mprj_io[32]]
         set_false_path -from [get_ports mprj_io[33]]
         set_false_path -from [get_ports mprj_io[34]]
         set_false_path -from [get_ports mprj_io[35]]
         set_false_path -from [get_ports mprj_io[36]]
         set_false_path -from [get_ports mprj_io[37]]
      }  

   } elseif {$io_4_mode == "GPIO"} {
      set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[1]}]
      set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[2]}]
      set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[3]}]
      set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[4]}]   
      
      if { $::env(IO_SYNC) } {
         set_false_path -from [get_ports mprj_io[*]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_out[*]]
         set_false_path -from [get_ports mprj_io[*]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_oeb[*]]
         set_false_path -from [get_ports mprj_io[*]] -through [get_pins chip_core/housekeeping_alt/mgmt_gpio_in[*]]
      } else {
         # set_false_path -from [get_ports mprj_io[*]] 
      }  
   }
} elseif {$ios_mode == "OUT"} {
   # Add case analysis for pads DM[2]==1'b1 & DM[1]==1'b1 & DM[0]==1'b0 to be outputs
   set_case_analysis 1 [get_pins padframe/*mprj*/DM[2]]
   set_case_analysis 1 [get_pins padframe/*mprj*/DM[1]]
   set_case_analysis 0 [get_pins padframe/*mprj*/DM[0]]
   set_case_analysis 0 [get_pins padframe/*mprj*/OE_N]

   # add loads for output ports (pads)
   set_load -min $min_cap [get_ports {mprj_io[*]}] 
   set_load -max $max_cap [get_ports {mprj_io[*]}]  

   ## OUTPUT DELAYS
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[0]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[5]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[6]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[7]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[8]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[9]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[10]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[11]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[12]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[13]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[14]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[15]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[16]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[17]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[18]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[19]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[20]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[21]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[22]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[23]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[24]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[25]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[26]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[27]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[28]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[29]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[30]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[31]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[32]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[33]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[34]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[35]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[36]}]
   set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[37]}]
   if {$io_4_mode == "SCK"} {
      # SCK, CSB, SDI are inputs
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[4]/DM[2]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[4]/DM[1]]
      set_case_analysis 1 [get_pins padframe/\mprj_pads.area1_io_pad[4]/DM[0]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[4]/INP_DIS]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[3]/DM[2]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[3]/DM[1]]
      set_case_analysis 1 [get_pins padframe/\mprj_pads.area1_io_pad[3]/DM[0]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[3]/INP_DIS]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[2]/DM[2]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[2]/DM[1]]
      set_case_analysis 1 [get_pins padframe/\mprj_pads.area1_io_pad[2]/DM[0]]
      set_case_analysis 0 [get_pins padframe/\mprj_pads.area1_io_pad[2]/INP_DIS]
      set_output_delay $output_delay_value  -clock [get_clocks {hkspi_clk}] [get_ports {mprj_io[1]}]
      set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] [get_ports {mprj_io[2]}]
      set_input_delay $input_delay_value  -clock [get_clocks {hkspi_clk}] [get_ports {mprj_io[3]}]
      set_input_transition -min $min_in_tran [get_ports {mprj_io[2] mprj_io[2]}] 
      set_input_transition -max $max_in_tran [get_ports {mprj_io[3] mprj_io[3]}] 
      if { !($::env(IO_SYNC)) } {
         set_false_path -to [get_ports mprj_io[0]]
         set_false_path -to [get_ports mprj_io[5]]
         set_false_path -to [get_ports mprj_io[6]]
         set_false_path -to [get_ports mprj_io[7]]
         set_false_path -to [get_ports mprj_io[8]]
         set_false_path -to [get_ports mprj_io[9]]
         set_false_path -to [get_ports mprj_io[10]]
         set_false_path -to [get_ports mprj_io[11]]
         set_false_path -to [get_ports mprj_io[12]]
         set_false_path -to [get_ports mprj_io[13]]
         set_false_path -to [get_ports mprj_io[14]]
         set_false_path -to [get_ports mprj_io[15]]
         set_false_path -to [get_ports mprj_io[16]]
         set_false_path -to [get_ports mprj_io[17]]
         set_false_path -to [get_ports mprj_io[18]]
         set_false_path -to [get_ports mprj_io[19]]
         set_false_path -to [get_ports mprj_io[20]]
         set_false_path -to [get_ports mprj_io[21]]
         set_false_path -to [get_ports mprj_io[22]]
         set_false_path -to [get_ports mprj_io[23]]
         set_false_path -to [get_ports mprj_io[24]]
         set_false_path -to [get_ports mprj_io[25]]
         set_false_path -to [get_ports mprj_io[26]]
         set_false_path -to [get_ports mprj_io[27]]
         set_false_path -to [get_ports mprj_io[28]]
         set_false_path -to [get_ports mprj_io[29]]
         set_false_path -to [get_ports mprj_io[30]]
         set_false_path -to [get_ports mprj_io[31]]
         set_false_path -to [get_ports mprj_io[32]]
         set_false_path -to [get_ports mprj_io[33]]
         set_false_path -to [get_ports mprj_io[34]]
         set_false_path -to [get_ports mprj_io[35]]
         set_false_path -to [get_ports mprj_io[36]]
         set_false_path -to [get_ports mprj_io[37]]
      } 
   } elseif {$io_4_mode == "GPIO"} {
      set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[1]}]
      set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[2]}]
      set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[3]}]
      set_output_delay $output_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {mprj_io[4]}] 
      if { !($::env(IO_SYNC)) } {
         set_false_path -to [get_ports mprj_io[*]] 
      }      
   }
}

# flash_* are output except for io1
set_case_analysis 1 [get_pins padframe/flash_*pad/DM[2]]
set_case_analysis 1 [get_pins padframe/flash_*pad/DM[1]]
set_case_analysis 0 [get_pins padframe/flash_*pad/DM[0]]
set_case_analysis 0 [get_pins padframe/flash_*pad/INP_DIS]
set_case_analysis 0 [get_pins padframe/flash_io1_pad/DM[2]]
set_case_analysis 0 [get_pins padframe/flash_io1_pad/DM[1]]
set_case_analysis 1 [get_pins padframe/flash_io1_pad/DM[0]]
set_case_analysis 0 [get_pins padframe/flash_io1_pad/OE_N]

#flash interface input transition from the datasheet
set flash_min_tran 4
set flash_max_tran 6
puts "\[INFO\]: Flash interface transition range: $flash_min_tran : $flash_max_tran"
set_input_transition -min $flash_min_tran [get_ports {flash_io1}] 
set_input_transition -max $flash_max_tran [get_ports {flash_io1}] 

set flash_min_cap 6
set flash_max_cap 8
puts "\[INFO\]: Flash interface cap load range: $flash_min_cap : $flash_max_cap"
set_load -min $min_cap [get_ports {flash_csb flash_clk flash_io0}] 
set_load -max $max_cap [get_ports {flash_csb flash_clk flash_io0}]  

set flash_in_delay 4
set flash_out_delay 4
puts "\[INFO\]: Flash interface delay: input $flash_in_delay output $flash_out_delay"
set_output_delay $flash_out_delay  -clock [get_clocks {clk}] -add_delay [get_ports {flash_csb}]
set_output_delay $flash_out_delay  -clock [get_clocks {clk}] -add_delay [get_ports {flash_clk}]
set_output_delay $flash_out_delay  -clock [get_clocks {clk}] -add_delay [get_ports {flash_io0}]
set_input_delay $flash_in_delay -clock [get_clocks {clk}] -add_delay [get_ports {flash_io1}]

# gpio_pad is set as input pad
set_case_analysis 0 [get_pins padframe/gpio_pad/DM[2]]
set_case_analysis 0 [get_pins padframe/gpio_pad/DM[1]]
set_case_analysis 1 [get_pins padframe/gpio_pad/DM[0]]
set_case_analysis 0 [get_pins padframe/gpio_pad/INP_DIS]
set_input_transition -min $min_in_tran [get_ports {gpio}] 
set_input_transition -max $max_in_tran [get_ports {gpio}] 

set_input_delay $input_delay_value  -clock [get_clocks {clk}] -add_delay [get_ports {gpio}]

# Maximum Fanout soft constraint
set_max_fanout 18 [current_design]
# synthesis max fanout is 18

## FALSE PATHS (ASYNCHRONOUS I/Os)
set_false_path -from [get_ports resetb]
set_false_path -from [get_ports gpio]

# check ocv table (not provided)  
set derate 0.0375
puts "\[INFO\]: Setting derate factor to: [expr $derate * 100] %"
set_timing_derate -early [expr 1-$derate]
set_timing_derate -late [expr 1+$derate]
