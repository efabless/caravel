#!/bin/bash
#
# create_top_pins.sh ---
#
# Generate the top level pins for caravel and caravan.
# Most of the work is done by importing the LEF file for caravel (which has the
# same content as caravan), then formatting the labels.
#
# Run this script from the mag/ directory
#
# This script may be run on a layout that already has pins without affecting the
# layout.

echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

magic -dnull -noconsole -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
drc off
set pins {resetb clock flash_clk flash_csb flash_io0 flash_io1 gpio \
	mprj_io\[0\] mprj_io\[1\] mprj_io\[2\] mprj_io\[3\] mprj_io\[4\] \
	mprj_io\[5\] mprj_io\[6\] mprj_io\[7\] mprj_io\[8\] mprj_io\[9\] \
	mprj_io\[10\] mprj_io\[11\] mprj_io\[12\] mprj_io\[13\] mprj_io\[14\] \
	mprj_io\[15\] mprj_io\[16\] mprj_io\[17\] mprj_io\[18\] mprj_io\[19\] \
	mprj_io\[20\] mprj_io\[21\] mprj_io\[22\] mprj_io\[23\] mprj_io\[24\] \
	mprj_io\[25\] mprj_io\[26\] mprj_io\[27\] mprj_io\[28\] mprj_io\[29\] \
	mprj_io\[30\] mprj_io\[31\] mprj_io\[32\] mprj_io\[33\] mprj_io\[34\] \
	mprj_io\[35\] mprj_io\[36\] mprj_io\[37\] \
	vccd vccd1 vccd2 vdda vdda1 vdda1_2 vdda2 vddio vddio_2 \
	vssa vssa1 vssa1_2 vssa2 vssd vssd1 vssd2 vssio vssio_2}
load caravel
select top cell
expand
lef read ../lef/caravel.lef -annotate
foreach pin \$pins {
    goto \$pin
    select area label
    setlabel font FreeSans
    setlabel size 10um
    setlabel just c
}
writeall force caravel

load caravan
select top cell
expand
# Use caravel.lef to annotate caravan top level
lef read ../lef/caravel.lef -annotate
foreach pin \$pins {
    goto \$pin
    select area label
    setlabel font FreeSans
    setlabel size 10um
    setlabel just c
}
writeall force caravan

quit -noprompt
EOF

