source $::env(CARAVEL_ROOT)/env/common.tcl
source $::env(CORNER_ENV_FILE)

set libs [split [regexp -all -inline {\S+} $libs]]
set verilogs [split [regexp -all -inline {\S+} $verilogs]]

foreach liberty $libs {
    read_liberty $liberty
}

foreach verilog $verilogs {
    read_verilog $verilog
}

link_design caravel

foreach key [array names spef_mapping] {
    puts "read_spef -path $key $spef_mapping($key)"
    read_spef -path $key $spef_mapping($key)
}

puts "read_spef $spef"
read_spef $spef

read_sdc -echo $sdc

report_checks -path_delay min -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50
report_checks -path_delay max -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50
puts "Management Area Interface"
report_checks -to soc/core_clk -unconstrained -group_count 1
puts "User project Interface"
report_checks -to mprj/wb_clk_i -unconstrained -group_count 1
report_checks -to mprj/wb_rst_i -unconstrained -group_count 1
report_checks -to mprj/wbs_cyc_i -unconstrained -group_count 1
report_checks -to mprj/wbs_stb_i -unconstrained -group_count 1
report_checks -to mprj/wbs_we_i -unconstrained -group_count 1
report_checks -to mprj/wbs_sel_i[*] -unconstrained -group_count 4
report_checks -to mprj/wbs_adr_i[*] -unconstrained -group_count 32
report_checks -to mprj/io_in[*] -unconstrained -group_count 32
report_checks -to mprj/user_clock2 -unconstrained -group_count 32
report_checks -to mprj/user_irq[*] -unconstrained -group_count 32
report_checks -to mprj/la_data_in[*] -unconstrained -group_count 128
report_checks -to mprj/la_oenb[*] -unconstrained -group_count 128
puts "Flash output Interface"
report_checks -to flash_clk -group_count 1
report_checks -to flash_csb -group_count 1
report_checks -to flash_io0 -group_count 1

report_worst_slack -max 
report_worst_slack -min 
