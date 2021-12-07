#!/bin/bash
#
PDK_ROOT ?= /usr/share/pdk

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
fi

export NETGEN_COLUMNS=60
netgen -batch lvs "caravel.spice chip_io" "../verilog/gl/chip_io.v chip_io" ./sky130A_setup.tcl comp.out
