#!/bin/bash
#---------------------------------------------------------------------------
# Run full LVS on caravel:  This does not include verification of underlying
# library components such as the I/O cells and standard cells, but does
# include all sub-blocks of caravel.
#
# NOTE: The netlist caravel.spice is only regenerated if it does not exist.
# To run a full extraction and LVS, remove any existing caravel.spice file
# first.
#
#---------------------------------------------------------------------------
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

# Extract full layout netlist
if [ ! -f caravel.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
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

# Generate black-box verilog entry for the conb cell.  Otherwise, the verilog tends to
# have only one of the pins listed which will result in an incorrect pin match.
cat > conb.v << EOF
/* Black-box entry for conb_1 module */
module sky130_fd_sc_hd__conb_1 (HI, LO, VPWR, VGND, VPB, VNB);
    output HI;
    output LO;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;
endmodule
EOF

# Generate script for netgen
cat > netgen.tcl << EOF
# Load top level netlists
puts stdout "Reading netlist caravel.spice"
set circuit1 [readnet spice caravel.spice]
puts stdout "Reading gate-level netlist caravel.v"
set circuit2 [readnet verilog ../verilog/gl/caravel.v]
# Read additional subcircuits into the netlist of circuit2
puts stdout "Reading black-box modules"
readnet verilog conb.v \$circuit2
puts stdout "Reading all gate-level verilog modules"
readnet verilog ../verilog/gl/caravel_clocking.v \$circuit2
readnet verilog ../verilog/gl/chip_io.v \$circuit2
readnet verilog ../verilog/gl/digital_pll.v \$circuit2
readnet verilog ../verilog/gl/gpio_control_block.v \$circuit2
readnet verilog ../verilog/gl/gpio_defaults_block.v \$circuit2
readnet verilog ../verilog/gl/gpio_defaults_block_1803.v \$circuit2
readnet verilog ../verilog/gl/gpio_defaults_block_0403.v \$circuit2
readnet verilog ../verilog/gl/gpio_logic_high.v \$circuit2
readnet verilog ../verilog/gl/housekeeping.v \$circuit2
readnet verilog ../verilog/gl/mgmt_protect.v \$circuit2
readnet verilog ../verilog/gl/mgmt_protect_hv.v \$circuit2
readnet verilog ../verilog/gl/mprj2_logic_high.v \$circuit2
readnet verilog ../verilog/gl/mprj_logic_high.v \$circuit2
readnet verilog ../verilog/gl/spare_logic_block.v \$circuit2
readnet verilog ../verilog/gl/user_id_programming.v \$circuit2
readnet verilog ../verilog/gl/xres_buf.v \$circuit2

# To do:  Add simple_por from ../spi/lvs
# Run LVS
lvs "\$circuit1 caravel" "\$circuit2 caravel" $PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl comp.out
EOF

export NETGEN_COLUMNS=60
export MAGIC_EXT_USE_GDS=1
netgen -batch source netgen.tcl
# rm conb.v
# rm netgen.tcl
