
#!/bin/bash

# run this script from caravel root

echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null
echo ${MCW_ROOT:=$(pwd)} > /dev/null

echo "Run this script from mgmt_core_wrapper root"
echo "generating gds for mgmt_core_wrapper from mag"
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
cd $MCW_ROOT/mag
drc off;
crashbackups stop;
addpath hexdigits;
addpath $MCW_ROOT/mag;
load mgmt_core_wrapper -dereference;
select top cell;
expand;
cif *hier write disable;
cif *array write disable;
gds write $MCW_ROOT/gds/mgmt_core_wrapper.gds;
quit -noprompt;
