#!/bin/bash
#
# Run the caravel LVS using a script that pulls in the gate level netlists of sub-blocks
# so that all cells of interest (excluding I/O pads and the digital standard cells
# themselves) are compared.  Include the management core.
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
# echo ${MGMT_SOC:=../../caravel_mgmt_soc_litex} > /dev/null
echo ${MGMT_SOC:=../../caravel_pico} > /dev/null

if [ ! -f caravel.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc << EOF
drc off
crashbackups stop
load $MGMT_SOC/mag/DFFRAM
load $MGMT_SOC/mag/mgmt_core
load $MGMT_SOC/mag/mgmt_core_wrapper
load caravel
select top cell
expand
extract do local
extract all
ext2spice lvs
ext2spice
EOF
rm -f *.ext
fi

# Create script for netgen comparison
cat > netgen_input.tcl << EOF
## Do transistor level comparison by reading the standard cell netlist
set f [readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice]
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice \$f
## Read the SRAM netlist from open_pdks library sky130_sram_macros
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/spice/sky130_sram_2kbyte_1rw1r_32x512_8.spice \$f
## Read the components of the management SoC
readnet verilog $MGMT_SOC/verilog/gl/DFFRAM.v \$f
readnet verilog $MGMT_SOC/verilog/gl/mgmt_core.v \$f
## Read the management SoC wrapper
readnet verilog $MGMT_SOC/verilog/gl/mgmt_core_wrapper.v \$f
readnet verilog ../verilog/gl/digital_pll.v \$f
readnet verilog ../verilog/gl/caravel_clocking.v \$f
readnet verilog ../verilog/gl/chip_io.v \$f
readnet verilog ../verilog/gl/gpio_control_block.v \$f
readnet verilog ../verilog/gl/gpio_defaults_block.v \$f
readnet verilog ../verilog/gl/gpio_defaults_block_0403.v \$f
readnet verilog ../verilog/gl/gpio_defaults_block_1803.v \$f
readnet verilog ../verilog/gl/gpio_logic_high.v \$f
readnet verilog ../verilog/gl/mprj2_logic_high.v \$f
readnet verilog ../verilog/gl/mprj_logic_high.v \$f
readnet verilog ../verilog/gl/spare_logic_block.v \$f
readnet verilog ../verilog/gl/user_id_programming.v \$f
readnet verilog ../verilog/gl/xres_buf.v \$f
readnet verilog ../verilog/gl/mgmt_protect_hv.v \$f
readnet verilog ../verilog/gl/mgmt_protect.v \$f
readnet verilog ../verilog/gl/housekeeping.v \$f
readnet verilog ../verilog/gl/caravel.v \$f
set l [readnet spice caravel.spice] 
# debug on
lvs "\$l caravel" "\$f caravel" $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl comp.out
EOF

export NETGEN_COLUMNS=60
export MAGIC_EXT_USE_GDS=1
netgen -batch source netgen_input.tcl

rm -f netgen_input.tcl
rm -f blackbox.v
