#!/bin/bash
#
# Run the caravel LVS including the transistor level of all I/O plus the
# transistor level of the simple POR circuit.
#
echo ${PDK_ROOT:=/usr/share/pdk} > /dev/null

if [ ! -f caravel.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc << EOF
drc off
crashbackups stop
load caravel
cellname filepath simple_por default
select top cell
expand
cellname filepath sky130_ef_io__corner_pad default
cellname filepath sky130_ef_io__com_bus_slice_20um default
cellname filepath sky130_ef_io__connect_vcchib_vccd_and_vswitch_vddio_slice_20um default
cellname filepath sky130_ef_io__com_bus_slice_1um default
cellname filepath sky130_ef_io__com_bus_slice_5um default
cellname filepath sky130_ef_io__com_bus_slice_10um default
cellname filepath sky130_ef_io__vssa_hvc_clamped_pad default
cellname filepath sky130_fd_io__top_xres4v2 default
cellname filepath sky130_ef_io__gpiov2_pad_wrapped default
cellname filepath sky130_ef_io__vssd_lvc_clamped_pad default
cellname filepath sky130_ef_io__vssio_hvc_clamped_pad default
cellname filepath sky130_ef_io__vdda_hvc_clamped_pad default
cellname filepath sky130_ef_io__vccd_lvc_clamped_pad default
cellname filepath sky130_ef_io__disconnect_vdda_slice_5um default
cellname filepath sky130_ef_io__vddio_hvc_clamped_pad default
cellname filepath sky130_ef_io__vssd_lvc_clamped3_pad default
cellname filepath sky130_ef_io__vccd_lvc_clamped3_pad default
suspendall
flush sky130_ef_io__corner_pad
flush sky130_ef_io__com_bus_slice_20um
flush sky130_ef_io__connect_vcchib_vccd_and_vswitch_vddio_slice_20um
flush sky130_ef_io__com_bus_slice_1um
flush sky130_ef_io__com_bus_slice_5um
flush sky130_ef_io__com_bus_slice_10um
flush sky130_ef_io__vssa_hvc_clamped_pad
flush sky130_fd_io__top_xres4v2
flush sky130_ef_io__gpiov2_pad_wrapped
flush sky130_ef_io__vssd_lvc_clamped_pad
flush sky130_ef_io__vssio_hvc_clamped_pad
flush sky130_ef_io__vdda_hvc_clamped_pad
flush sky130_ef_io__vccd_lvc_clamped_pad
flush sky130_ef_io__disconnect_vdda_slice_5um
flush sky130_ef_io__vddio_hvc_clamped_pad
flush sky130_ef_io__vssd_lvc_clamped3_pad
flush sky130_ef_io__vccd_lvc_clamped3_pad
resumeall
extract do local
extract all
ext2spice lvs
ext2spice
EOF
rm -f *.ext
fi

# Create script for netgen comparison
cat > netgen_input.tcl << EOF
## Do transistor level comparison by reading the standard cell netlist
set f [readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice]
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice \$f
## Read the I/O netlists
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_io/spice/sky130_fd_io.spice \$f
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_io/spice/sky130_ef_io.spice \$f
## NOTE: Ignoring most of the subcells here;  just concentrating on I/O LVS.
readnet verilog ../verilog/gl/chip_io.v \$f
## Read the top level
readnet verilog ../verilog/gl/caravel.v \$f
set l [readnet spice caravel.spice]
# debug on
lvs "\$l caravel" "\$f caravel" $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl comp.out
EOF

export NETGEN_COLUMNS=60
export MAGIC_EXT_USE_GDS=1
netgen -batch source netgen_input.tcl

rm -f netgen_input.tcl
