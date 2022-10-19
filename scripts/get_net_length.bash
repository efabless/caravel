#!/bin/env bash

# usage get_net_length.bash merged.lef design.def wire_length.txt
set -u
{
    openroad -exit -no_splash <<EOF
read_lef $1
read_def $2
variable odb_block [[[::ord::get_db] getChip] getBlock]
set odb_nets [odb::dbBlock_getNets \$::odb_block]
set fp [open "$3" w]
foreach net \$odb_nets {
    set net_name [odb::dbNet_getName \$net]
    set wire [odb::dbNet_getWire \$net]
    if {\$wire != "NULL"} {
        set wire_length [odb::dbWire_getLength \$wire]
        set wire_length [expr \$wire_length / 1000.0]
        puts \$fp "\$net_name \$wire_length"
    }
}
close \$fp
EOF
} > $(dirname $3)/get_net_length-openroad.log

filename=$(basename $3)
filename_no_ext="${filename%%.*}"
sort_file_path="$(dirname $3)/${filename_no_ext}-sorted.txt"
cat $3 | sort -k 2 -n | column -t > $sort_file_path
echo "wrote to $sort_file_path"
