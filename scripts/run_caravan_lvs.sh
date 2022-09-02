#!/bin/bash
#
# Run top-level LVS on caravan.  The extraction in magic does not include the SoC,
# which is abstracted.
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

cd ../mag
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
crashbackups stop
load caravan
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
netgen -batch lvs "caravan.spice caravan" "../verilog/gl/caravan.v caravan" \
	$PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl caravan_comp.out

# mv caravan.spice ../spi/lvs/caravan_lvs.spice
mv caravan.spice ../spi/lvs/caravan.spice
mv caravan_comp.out ../signoff/
exit 0
