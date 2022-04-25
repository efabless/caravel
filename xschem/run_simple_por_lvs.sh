#!/bin/bash
#---------------------------------------------------------------------------
#
# Run LVS on the simple_por.
#
#---------------------------------------------------------------------------
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

# Extract full layout netlist
cd ../mag
if [ ! -f simple_por.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
crashbackups stop
load simple_por
extract do local
extract all
ext2spice lvs
ext2spice
EOF
rm -f *.ext
fi
cd ../xschem

# Generate script for netgen
cat > netgen.tcl << EOF
# Load top level netlist
puts stdout "Reading layout netlist simple_por.spice"
set circuit1 [readnet spice ../mag/simple_por.spice]
puts stdout "Reading schematic netlist simple_por.spice"
set circuit2 [readnet spice simple_por.spice]
# Read additional subcircuits into the netlist of circuit2
puts stdout "Reading standard cell netlists"
readnet spice $PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice \$circuit2

# Run LVS
lvs "\$circuit1 simple_por" "\$circuit2 simple_por" $PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl simple_por_comp.out
EOF

export NETGEN_COLUMNS=60
netgen -batch source netgen.tcl
rm netgen.tcl

# mv simple_por_comp.out ../signoff/
exit 0
