#!/bin/bash
#

if [ -f  ./reports/${1%.gds}-gds-vs-verilog.out ]; then
\mv ./reports/${1%.gds}-gds-vs-verilog.out ./reports/${1%.gds}-gds-vs-verilog.out.last
fi
if [ -f  ./netlists/${1%.gds}-source.spice ]; then
\mv ./netlists/${1%.gds}-source.spice ./netlists/${1%.gds}-source.spice.last
fi
if [ -f  ./netlists/${1%.gds}-gds-extracted.spice ]; then
\mv ./netlists/${1%.gds}-gds-extracted.spice ./netlists/${1%.gds}-gds-extracted.spice.last
fi
if [ -f  core ]; then
\rm core
fi

########################################################
###### Magic netlist extraction
########################################################

export MAGIC=magic
export PDKPATH=$PDK_ROOT/sky130A ; 
export MAGTYPE=mag

MAGTYPE=$MAGTYPE $MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  << EOF

#path search [concat "../$MAGTYPE" [path search]]
crashbackups stop
drc off
gds readonly true
gds flatten true
gds rescale false
tech unlock *
cif istyle sky130(vendor)
gds read ../gds/$1
load ${1%.gds} -dereference
select top cell
#lef read  $PDK_ROOT/openlane/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
#readspice $PDK_ROOT/openlane/sky130A/libs.ref/sky130_fd_sc_hd/cdl/sky130_fd_sc_hd.cdl}
#extract no all
extract do local
extract all
ext2spice lvs
ext2spice -o ./netlists/${1%.gds}-gds-extracted.spice
EOF

\rm ./*.ext

#
########################################################
####### running netgen
########################################################

export NETGEN_COLUMNS=60
export MAGIC_EXT_USE_GDS=1

netgen -batch lvs \
        "./netlists/${1%.gds}-gds-extracted.spice ${1%.gds}" \
		"../verilog/gl/${1%.gds}.v ${1%.gds}" \
			     ./pdk/sky130A_setup.tcl \
			         ./reports/${1%.gds}-gds-vs-verilog.out
				 
########################################################

				 
				 
