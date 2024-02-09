#!/bin/bash
# Run top-level LVS on caravel.  The extraction in magic does not include the SoC,
# which is abstracted.
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

cd ../mag
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
crashbackups stop
load caravel
select top cell
expand
extract no all      ;# <-- large speed-up
extract do local
extract all
ext2spice lvs
ext2spice
EOF
rm -f *.ext

export NETGEN_COLUMNS=60
netgen -batch lvs "caravel.spice caravel" "../verilog/gl/caravel.v caravel" \
	$PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl caravel_comp.out

# mv caravel.spice ../spi/lvs/caravel_lvs.spice
mv caravel.spice ../spi/lvs/caravel.spice
mv caravel_comp.out ../signoff/
exit 0
