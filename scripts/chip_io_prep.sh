#!/bin/bash

#-------------------------------------------------------------------
# chip_io_prep.sh --
#
# Prepare the GDS, LEF, and DEF views of chip_io and chip_io_alt
# (the caravel and caravan padframes)
#
# Run this from the caravel/mag/ directory after modifying the
# magic layout.
#
# Written by Tim Edwards for MPW-7  10/11/2022
# Updated/fixed 11/08/2022
#-------------------------------------------------------------------

echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null

# Generate DEF of chip_io
echo "Generating DEF view of chip_io"
magic -dnull -noconsole -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
load chip_io
select top cell
expand
property flatten true
flatten -doproperty chip_io_flat
load chip_io_flat
cellname delete chip_io
cellname rename chip_io_flat chip_io
select top cell
extract do local
extract no all
extract all
# Declare all signals to be SPECIALNETS
set globals(vccd) 1
set globals(vssd) 1
set globals(vddio) 1
set globals(vssio) 1
set globals(vdda1) 1
set globals(vssa1) 1
set globals(vccd1) 1
set globals(vssd1) 1
set globals(vdda2) 1
set globals(vssa2) 1
set globals(vccd2) 1
set globals(vssd2) 1
def write chip_io -units 400
quit -noprompt
EOF

rm *.ext

# Generate DEF of chip_io_alt
echo "Generating DEF view of chip_io_alt"
magic -dnull -noconsole -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
load chip_io_alt
select top cell
expand
property flatten true
flatten -doproperty chip_io_alt_flat
load chip_io_alt_flat
cellname delete chip_io_alt
cellname rename chip_io_alt_flat chip_io_alt
select top cell
extract do local
extract no all
extract all
# Declare all signals to be SPECIALNETS
set globals(vccd) 1
set globals(vssd) 1
set globals(vddio) 1
set globals(vssio) 1
set globals(vdda1) 1
set globals(vssa1) 1
set globals(vccd1) 1
set globals(vssd1) 1
set globals(vdda2) 1
set globals(vssa2) 1
set globals(vccd2) 1
set globals(vssd2) 1
def write chip_io_alt -units 400
quit -noprompt
EOF

rm *.ext

# Generate GDS of chip_io
echo "Generating GDS view of chip_io"
magic -d OGL -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
load chip_io -dereference
gds compress 9
cif *hier write disable
cif *array write disable
gds write chip_io
quit -noprompt
EOF

# Generate GDS of chip_io_alt
echo "Generating GDS view of chip_io_alt"
magic -d OGL -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
load chip_io_alt -dereference
gds compress 9
cif *hier write disable
cif *array write disable
gds write chip_io_alt
quit -noprompt
EOF

# Generate LEF of chip_io
echo "Generating LEF view of chip_io"
export MAGTYPE=maglef
magic -d OGL -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
load chip_io -dereference
select top cell
lef write
quit -noprompt
EOF

# Generate LEF of chip_io_alt
echo "Generating LEF view of chip_io_alt"
export MAGTYPE=maglef
magic -d OGL -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
load chip_io_alt -dereference
select top cell
lef write
quit -noprompt
EOF

# Move all generated files to their proper locations

echo "Moving generated files to destination directories"
mv chip_io.lef ../lef
mv chip_io.def ../def
mv chip_io.gds.gz ../gds

mv chip_io_alt.lef ../lef
mv chip_io_alt.def ../def
mv chip_io_alt.gds.gz ../gds

echo "Done!"
