#!/bin/bash
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null

if [ ! -f caravel.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK_VARIENT/libs.tech/magic/$PDK_VARIENT.magicrc << EOF
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
netgen -batch lvs "caravel.spice chip_io" "../verilog/gl/chip_io.v chip_io" $PDK_ROOT/$PDK_VARIENT/libs.tech/netgen/$PDK_VARIENT_setup.tcl comp.out
