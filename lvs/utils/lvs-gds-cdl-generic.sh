#!/bin/bash
#

if [ -f  ./gds-vs-spice-${1%.gds}.out ]; then
\mv ./gds-vs-spice-${1%.gds}.out ./gds-vs-spice-${1%.gds}.out.last
fi
if [ -f  ./${1%.gds}-source.spice ]; then
\mv ./netlists/cdl-source-${1%.mag}.spice ./cdl-source-${1%.mag}.spice.last
fi
if [ -f  ${1%.gds}-gds-extracted.spice ]; then
\mv ./netlists/gds-extracted-${1%.gds}.spice ./netlists/$gds-extracted-${1%.gds}.spice.last
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

path search [concat "../$MAGTYPE" [path search]]
crashbackups stop
drc off
gds readonly true
gds flatten true
gds rescale false
tech unlock *
cif istyle sky130(vendor)
gds read $1
load ${1%.gds} -dereference
select top cell
#lef read  $PDK_ROOT/openlane/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
#readspice $PDK_ROOT/openlane/sky130A/libs.ref/sky130_fd_sc_hd/cdl/sky130_fd_sc_hd.cdl}
#extract no all
extract do local
extract all
ext2spice lvs
ext2spice -o ./gds-extracted-${1%.gds}.spice
EOF

\rm ./*.ext

########################################################
####### running netgen
########################################################

export NETGEN_COLUMNS=60
export IC_EXT_USE_GDS=1

netgen -batch lvs \
        "./gds-extracted-${1%.gds}.spice ${1%.gds}" \
		"./${1%.gds}.cdl ${1%.gds}" \
			     ./pdk/sky130A_setup.tcl \
			         ./gds-vs-cdl-${1%.gds}.out
				 
########################################################
