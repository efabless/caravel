#!/bin/bash
#---------------------------------------------------------------------------
#
# Run full LVS on caravan:  This does not include verification of underlying
# library components such as the I/O cells, standard cells, and SRAM, but
# does include all sub-blocks of caravan.
#
#---------------------------------------------------------------------------
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

# Extract full layout netlist
cd ../mag
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
crashbackups stop
load caravan
# Replace the management core wrapper abstract view with the full view
cellname filepath mgmt_core_wrapper ../../caravel_mgmt_soc_litex/mag
flush mgmt_core_wrapper
select top cell
expand
# Replace the SRAM full view with the abstract view.
cellname filepath sky130_sram_2kbyte_1rw1r_32x512_8 $PDK_ROOT/$PDK/libs.ref/sky130_sram_macros/maglef
flush sky130_sram_2kbyte_1rw1r_32x512_8
extract do local
extract all
ext2spice lvs
ext2spice
EOF
rm -f *.ext

# Generate black-box verilog entry for the conb cell.  Otherwise, the verilog tends to
# have only one of the pins listed which will result in an incorrect pin match.
# Also set the USE_POWER_PINS definition, which is not set anywhere else.
cat > conb.v << EOF
\`define USE_POWER_PINS 1

/* Black-box entry for conb_1 module */
module sky130_fd_sc_hd__conb_1 (HI, LO, VPWR, VGND, VPB, VNB);
    output HI;
    output LO;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;
endmodule

/* Black-box entry for conb_1 module */
module sky130_fd_sc_hvl__conb_1 (HI, LO, VPWR, VGND, VPB, VNB);
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
puts stdout "Reading netlist caravan.spice"
set circuit1 [readnet spice caravan.spice]
puts stdout "Reading gate-level netlist caravan.v"
set circuit2 [readnet verilog ../verilog/rtl/defines.v]
# Read additional subcircuits into the netlist of circuit2
puts stdout "Reading black-box modules"
readnet verilog conb.v \$circuit2
puts stdout "Reading all gate-level verilog modules"
#
# NOTE: Cannot use __user_analog_project_wrapper module because it does
# not correspond to the empty analog wrapper layout.
# readnet verilog ../verilog/gl/__user_analog_project_wrapper.v \$circuit2
readnet verilog ../verilog/gl/caravel_clocking.v \$circuit2
readnet verilog ../verilog/gl/chip_io_alt.v \$circuit2
readnet verilog ../verilog/gl/digital_pll.v \$circuit2
readnet verilog ../verilog/gl/gpio_control_block.v \$circuit2
readnet verilog ../verilog/gl/gpio_defaults_block.v \$circuit2
readnet verilog ../verilog/gl/gpio_defaults_block_1803.v \$circuit2
readnet verilog ../verilog/gl/gpio_defaults_block_0c01.v \$circuit2
readnet verilog ../verilog/gl/gpio_defaults_block_0403.v \$circuit2
readnet verilog ../verilog/gl/gpio_logic_high.v \$circuit2
readnet verilog ../verilog/gl/housekeeping.v \$circuit2
readnet verilog ../verilog/gl/mgmt_protect_hv.v \$circuit2
readnet verilog ../verilog/gl/mgmt_protect.v \$circuit2
readnet verilog ../verilog/gl/mprj2_logic_high.v \$circuit2
readnet verilog ../verilog/gl/mprj_logic_high.v \$circuit2
readnet verilog ../verilog/gl/spare_logic_block.v \$circuit2
readnet verilog ../verilog/gl/user_id_programming.v \$circuit2
readnet verilog ../verilog/gl/xres_buf.v \$circuit2
readnet verilog ../../caravel_mgmt_soc_litex/verilog/gl/DFFRAM.v \$circuit2
readnet verilog ../../caravel_mgmt_soc_litex/verilog/gl/mgmt_core.v \$circuit2
readnet verilog ../../caravel_mgmt_soc_litex/verilog/gl/mgmt_core_wrapper.v \$circuit2
readnet verilog ../verilog/gl/caravan.v \$circuit2

# Run LVS
lvs "\$circuit1 caravan" "\$circuit2 caravan" $PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl caravan_full_comp.out
EOF

export NETGEN_COLUMNS=60
export MAGIC_EXT_USE_GDS=1
netgen -batch source netgen.tcl
rm conb.v
rm netgen.tcl

mv caravan.spice ../spi/lvs/caraven_lvs_full.spice
mv caravan_full_comp.out ../signoff/
exit 0
