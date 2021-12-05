#!/bin/sh
#
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

export NETGEN_COLUMNS=60
netgen -batch lvs "caravan.spice caravan" "../verilog/gl/caravan.v caravan" ./sky130A_setup.tcl comp.out
