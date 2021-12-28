#!/bin/bash
#



if [ -f  ./reports/${MAGTYPE}-vs-verilog-${1%.mag}.out ]; then
\mv ./reports/${MAGTYPE}-vs-verilog-${1%.mag}.out ./reports/${MAGTYPE}-vs-verilog-${1%.mag}.out.last
fi
if [ -f  ../netlists/${1%.mag}-$MAGTYPE-extracted.spice ]; then
\mv ./netlists/${1%.mag}-$MAGTYPE-extracted.spice ./netlists/${1%.mag}-$MAGTYPE-extracted.spice.last
fi
if [ -f  core ]; then
\rm core
fi


export MAGIC=magic
export PDKPATH=$PDK_ROOT/sky130A ; 
export MAGTYPE=$2

$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  << EOF


path search [concat "../$MAGTYPE" [path search]]
addpath ${PDKPATH}/libs.ref/sky130_ml_xx_hd/mag
addpath ../mag/hexdigits
###addpath ../mag/

path

drc off
load $1  
cellname list filepath ${1%.mag} ../mag 
flush ${1%.mag}
		
select top cell
expand

extract do local
extract all			    
ext2spice lvs			    
ext2spice -o ./netlists/$MAGTYPE-extracted-${1%.mag}.spice

#########
EOF

\rm ../${MAGTYPE}/*.ext

export NETGEN_COLUMNS=60

netgen -batch lvs \
"./netlists/$MAGTYPE-extracted-${1%.mag}.spice  ${1%.mag}" \
 "../verilog/gl/${1%.mag}.v ${1%.mag}" \
./pdk/sky130A_setup.tcl \
./reports/${MAGTYPE}-vs-verilog-${1%.mag}.out


