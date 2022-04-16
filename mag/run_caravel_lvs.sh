#!/bin/bash
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

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

export NETGEN_COLUMNS=60
netgen -batch lvs "caravel.spice caravel" "../verilog/gl/caravel.v caravel" $PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl comp.out
