
#!/bin/bash

# run this script from caravel root

echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

echo "Run this script from mgmt_core_wrapper root"
echo "Writing $1 lef, def and mag view from gds"
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
gds read gds/$1.gds
load $1
lef write lef/$1.lef
save mag/$1.mag
select top cell
extract no all
extract do local
extract all
def write def/$1.def
EOF
rm *.ext
exit 0
