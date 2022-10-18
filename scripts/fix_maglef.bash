#!/bin/env bash

maglef_path=$1
maglefs=$(find $maglef_path -maxdepth 1 -type f -name '*.mag' )

for maglef in $maglefs; do
    filename=$(basename $maglef)
    filename_no_ext="${filename%%.*}"
    sed -i -E "s#string GDS_FILE.*#string GDS_FILE ../gds/$filename_no_ext.gds#" $maglef_path/$filename
done
