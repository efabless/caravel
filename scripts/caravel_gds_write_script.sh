#!/bin/bash

#-------------------------------------------------------------------
# caravel_gds_write_script --
#
# Generate GDS of the caravel top level.  Run this script in the
# caravel/mag directory.  Output is file caravel.gds.gz.
#
# Set as needed in the environment:
#
# MGMT_WRAPPER_PATH	(default /home/tim/gits/caravel_mgmt_soc_litex)
# PDK_ROOT		(default /usr/share/pdk)
# PDK			(default sky130A)
#
# NOTE:  This script is not a subsitute for the official assembly
# method!  It does not set the user ID or set GPIO defaults blocks
# or integrate a user project wrapper (other than the default).
#
#-------------------------------------------------------------------

echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null
echo ${PDK:=sky130A} > /dev/null
echo ${MGMT_WRAPPER_PATH:=/home/tim/gits/caravel_mgmt_soc_litex} > /dev/null

# NOTE:  Use "keep" option so the original compressed file isn't deleted.
gunzip -k ${MGMT_WRAPPER_PATH}/mag/mgmt_core_wrapper.mag.gz

export MAGPATH=mag

echo "Generating GDS of caravel"
magic -dnull -noconsole -rcfile ${PDK_ROOT}/${PDK}/libs.tech/magic/${PDK}.magicrc << EOF
drc off
load ${MGMT_WRAPPER_PATH}/mag/RAM128 -dereference
select top cell
expand
load ${MGMT_WRAPPER_PATH}/mag/RAM256 -dereference
select top cell
expand
load ${MGMT_WRAPPER_PATH}/mag/mgmt_core_wrapper -dereference
select top cell
expand
addpath hexdigits
addpath primitives
load caravel -dereference
select top cell
expand
gds compress 9
cif *hier write disable
cif *array write disable
gds write caravel
quit -noprompt
EOF

# Remove the uncompressed version of the management core wrapper layout
rm ${MGMT_WRAPPER_PATH}/mag/mgmt_core_wrapper.mag
echo "Done!"
