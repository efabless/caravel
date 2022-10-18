#!/bin/bash

# run this script from caravel root

echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

echo "Run this script from caravel root"
echo "Writing caravel_power_routing lef and mag view from gds"
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
gds read ./gds/caravel_power_routing.gds
load caravel_power_routing
select top cell
property FIXED_BBOX "0 0 717600 1037600"
save ./mag/caravel_power_routing.mag
lef write ./lef/caravel_power_routing.lef
EOF
exit 0
