#!/bin/sh
#
#-------------------------------------------------------------------
# add_isosub_layers.sh --
#
# This script adds isolated substrate layers to two circuits
# gpio_control_block and mgmt_protect that require it.
#
# This annotation is easy to do by hand.  However, the script
# formalizes the procedure and serves as a reminder that it needs
# to be done because the synthesis tools have no way to understand
# when the substrate has implied separate regions, or what to do
# about it.  Without the isolated substrate region markers, the
# layout extraction will merge the ground domains and the design
# will fail LVS.
#
# NOTE:  This script is specific to the existing caravel chip
# layout for MPW-7.  If either block is resynthesized, the positions
# of the isolated ground areas need to be determined and this script
# needs to be updated to match.
#
# Written by Tim Edwards for MPW-7  10/17/2022
#-------------------------------------------------------------------

echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

echo "Annotating gpio_control_block layout with isolated substrate"
magic -dnull -noconsole -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
drc off
snap internal
load gpio_control_block
tech unlock *
box values 1096 1592 2678 4514
paint isosub
writeall force gpio_control_block
quit -noprompt
EOF

echo "Annotating mgmt_protect layout with isolated substrate"
magic -dnull -noconsole -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
drc off
snap internal
load mgmt_protect
tech unlock *
box values 65700 6898 86564 9130
paint isosub
box values 136230 10086 205344 13664
paint isosub
writeall force mgmt_protect
quit -noprompt
EOF

