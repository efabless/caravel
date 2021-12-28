set f [readnet verilog blackbox.v]
readnet verilog ../verilog/gl/digital_pll.v $f
readnet verilog ../verilog/gl/caravel_clocking.v $f
readnet verilog ../verilog/gl/chip_io.v $f
readnet verilog ../verilog/gl/gpio_control_block.v $f
# readnet verilog ../verilog/gl/gpio_defaults_block.v $f
readnet verilog ../verilog/gl/gpio_defaults_block_0403.v $f
readnet verilog ../verilog/gl/gpio_defaults_block_1803.v $f
readnet verilog ../verilog/gl/gpio_logic_high.v $f
readnet verilog ../verilog/gl/mprj2_logic_high.v $f
readnet verilog ../verilog/gl/mprj_logic_high.v $f
# readnet verilog ../verilog/gl/spare_logic_block.v $f
readnet verilog ../verilog/gl/user_id_programming.v $f
readnet verilog ../verilog/gl/xres_buf.v $f
readnet verilog ../verilog/gl/mgmt_protect_hv.v $f
readnet verilog ../verilog/gl/mgmt_protect.v $f
# readnet verilog ../verilog/gl/housekeeping.v $f
readnet verilog ../verilog/gl/caravel.v $f
set l [readnet spice caravel.spice] 
lvs "$l caravel" "$f caravel" /ciic/pdks/sky130A/libs.tech/netgen/sky130A_setup.tcl comp.out
