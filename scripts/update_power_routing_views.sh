#!/bin/bash


echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc << EOF
drc off
gds read ../gds/caravel_power_routing
load caravel_power_routing
select top cell
expand
save ../mag/caravel_power_routing.mag
lef write ../lef/caravel_power_routing.lef
EOF
exit 0
