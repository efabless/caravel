#!/bin/bash
#

if [ -f  ./reports/gds-vs-cdl-${1%.gds}.out ]; then
\mv ./reports/gds-vs-cdl-${1%.gds}.out ./reports/gds-vs-cdl-${1%.gds}.out.last
fi
if [ -f  ./netlists/${1%.gds}-source.spice ]; then
\mv ./netlists/cdl-source-${1%.mag}.spice ./netlists/cdl-source-${1%.mag}.spice.last
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

path search [concat "../${MAGTYPE}" [path search]]
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
ext2spice -o ./netlists/gds-extracted-${1%.gds}.spice
EOF

\rm ../${MAGTYPE}/*.ext

########################################################
####### convert vlog to gate-level and include 
########################################################

./utils/vlog2Spice ../verilog/gl/${1%.gds}.v -o 	 	./netlists/cdl-source-${1%.gds}.spice \
-l ./pdk/sky130_fd_sc_hd.spice   -l ./pdk/sky130_fd_sc_hvl.spice \
-l ./pdk/sky130_ef_io.spice      -l ./pdk/sky130_ef_io.spice  -i 

########################################################
####### convert lines starting with +into a single line 
####### (netgen doesn't seem to like multiple spice lines 
####### starting with +)
########################################################

./utils/unfold ./netlists/cdl-source-${1%.gds}.spice >         	./netlists/cdl-source-${1%.gds}.spice.unfolded
\mv ./netlists/cdl-source-${1%.gds}.spice	       		./netlists/cdl-source-${1%.gds}.spice.folded
\mv ./netlists/cdl-source-${1%.gds}.spice.unfolded     		./netlists/cdl-source-${1%.gds}.spice
\rm ./netlists/cdl-source-${1%.gds}.spice.folded 

########################################################
####### running netgen
########################################################

export NETGEN_COLUMNS=60
export gdsIC_EXT_USE_GDS=1

netgen -batch lvs \
        "./netlists/gds-extracted-${1%.gds}.spice ${1%.gds}" \
		"./netlists/cdl-source-${1%.gds}.spice ${1%.gds}" \
			     ./pdk/sky130A_setup.tcl \
			         ./reports/gds-vs-cdl-${1%.gds}.out
				 
########################################################

########################################################
####### create another file with .cdl extention for Cal runs (netgen doesn't like .cdl input file ext)
########################################################

 \cp ./netlists/cdl-source-${1%.gds}.spice ./netlists/${1%.gds}.cdl

