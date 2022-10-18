#!/bin/env bash

mag_path=$1
mags=$(find $mag_path -maxdepth 1 -type f -name '*.mag' )

for mag in $mags; do
    filename=$(basename $mag)
    sed -i -E 's#(use +sky130_\S+_sc_(\S+)__\S+ +\S+ +)\S+#\1$PDKPATH/libs.ref/sky130_fd_sc_\2/mag#' $filename
done
