#!/bin/bash
#
# Run the caravel LVS using a script that pulls in the gate level netlists of sub-blocks
# so that all cells of interest (excluding I/O pads and the digital standard cells
# themselves) are compared.
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null

if [ ! -f caravel.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc << EOF
drc off
crashbackups stop
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

# Create a black-box definition for the conb_1 cell, because the
# verilog generally does not declare both outputs if only one of
# them is used.  Note:  Could load the whole digital standard
# cell verilog library, but this is simpler.

cat > blackbox.v << EOF
module sky130_fd_sc_hd__conb_1 (
   output HI,
   output LO,
   input VPWR,
   input VGND,
   input VPB,
   input VNB
);
endmodule
EOF

# Create script for netgen comparison
cat > netgen_input.tcl << EOF
set f [readnet verilog blackbox.v]
readnet verilog ../verilog/gl/digital_pll.v \$f
readnet verilog ../verilog/gl/caravel_clocking.v \$f
readnet verilog ../verilog/gl/chip_io.v \$f
readnet verilog ../verilog/gl/gpio_control_block.v \$f
# readnet verilog ../verilog/gl/gpio_defaults_block.v \$f
readnet verilog ../verilog/gl/gpio_defaults_block_0403.v \$f
readnet verilog ../verilog/gl/gpio_defaults_block_1803.v \$f
readnet verilog ../verilog/gl/gpio_logic_high.v \$f
readnet verilog ../verilog/gl/mprj2_logic_high.v \$f
readnet verilog ../verilog/gl/mprj_logic_high.v \$f
# readnet verilog ../verilog/gl/spare_logic_block.v \$f
readnet verilog ../verilog/gl/user_id_programming.v \$f
readnet verilog ../verilog/gl/xres_buf.v \$f
readnet verilog ../verilog/gl/mgmt_protect_hv.v \$f
readnet verilog ../verilog/gl/mgmt_protect.v \$f
# readnet verilog ../verilog/gl/housekeeping.v \$f
readnet verilog ../verilog/gl/caravel.v \$f
set l [readnet spice caravel.spice] 
lvs "\$l caravel" "\$f caravel" $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl comp.out
EOF

export NETGEN_COLUMNS=60
export MAGIC_EXT_USE_GDS=1
netgen -batch source netgen_input.tcl

##rm -f netgen_input.tcl
##rm -f blackbox.v
