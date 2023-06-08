#!/bin/bash
#
# Run LVS on the Openframe layout and verilog.
# If the layout netlist does not exist, then generate it from the
# extracted .mag layout of the caravel_openframe top level.  The
# LVS script for netgen will read both top level netlists and then
# compare the padframe cell.
#
# Run this script in the mag/ directory.
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

if [ ! -f caravel_openframe.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
crashbackups stop
load caravel_openframe
select top cell
expand
extract do local
# Maybe not do parasitic extraction for LVS??
extract no all
extract all
ext2spice lvs
ext2spice
EOF
rm -f *.ext
fi

# Set the USE_POWER_PINS definition, which is not set anywhere else.
cat > local_defs.v << EOF
\`define USE_POWER_PINS 1
EOF

# Generate script for netgen

cat > netgen.tcl << EOF

# Load top level netlists

puts stdout "Reading layout netlist:"
set circuit1 [readnet spice caravel_openframe.spice]
puts stdout "Reading verilog and schematic netlists:"
puts stdout "Reading SPICE netlists of I/O:"
set circuit2 [readnet spice $PDK_ROOT/$PDK/libs.ref/sky130_fd_io/spice/sky130_fd_io.spice]
readnet spice $PDK_ROOT/$PDK/libs.ref/sky130_fd_io/spice/sky130_ef_io.spice \$circuit2
readnet spice $PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice \$circuit2
readnet spice $PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_12.spice \$circuit2
readnet spice $PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice \$circuit2
readnet spice ../xschem/simple_por.spice \$circuit2
puts stdout "Reading all gate-level verilog submodules:"
readnet verilog local_defs.v \$circuit2
readnet verilog ../verilog/rtl/defines.v \$circuit2
readnet verilog ../verilog/rtl/pads.v \$circuit2

# NOTE:  __openframe_project_wrapper.v is empty.
readnet verilog ../verilog/rtl/__openframe_project_wrapper.v \$circuit2
readnet verilog ../verilog/gl/user_id_programming.v \$circuit2
readnet verilog ../verilog/gl/constant_block.v \$circuit2
readnet verilog ../verilog/gl/xres_buf.v \$circuit2

# ALSO NOTE:  Top-level modules are in the RTL directory but are purely gate level.
readnet verilog ../verilog/rtl/chip_io_openframe.v \$circuit2
readnet verilog ../verilog/rtl/caravel_openframe.v \$circuit2
puts stdout "Done reading netlists."

# Temporary:  Flatten the user project wrapper in the verilog netlist (better solution is to
# abstract the user project wrapper in the layout and re-extract).
flatten class "\$circuit2 openframe_project_wrapper"

# Run LVS on the chip_io_openframe cells in layout and verilog.

lvs "\$circuit1 caravel_openframe" "\$circuit2 caravel_openframe" \
	$PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl \
	caravel_openframe_comp.out
EOF


export NETGEN_COLUMNS=60
netgen -batch source netgen.tcl
rm local_defs.v
rm netgen.tcl
