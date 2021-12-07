#!/bin/bash
#
if [ ! -f caravan.spice ]; then
magic -dnull -noconsole -rcfile /usr/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc << EOF
drc off
crashbackups stop
load caravan
select top cell
expand
extract do local
extract all
ext2spice lvs
ext2spice
EOF
rm *.ext
fi

export NETGEN_COLUMNS=60
netgen -batch lvs "caravan.spice chip_io_alt" "../verilog/gl/chip_io_alt.v chip_io_alt" ./sky130A_setup.tcl comp.out
