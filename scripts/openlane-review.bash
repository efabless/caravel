#!/bin/env bash
set -xu

wns() { grep -oP "wns\b +\K.*" $1 ; }
decap() { grep -cP 'sky130_\S+_sc_hd__\S*(decap)\S+\b' $1 ; }
buf() { grep -cP 'sky130_\S+_sc_hd__\S*(buf|dly)\S+\b' $1 ; }
buf_1_2() { grep -cP 'sky130_\S+_sc_hd__\S*(buf|dly)\S*_(1|2)\b' $1 ; }
phys() { grep -cP 'sky130_\S+_sc_hd__\S*(diode|decap|tap|fill)\S+\b' $1 ; }
fillers() { grep -cP 'sky130_\S+_sc_hd__\S*(decap|fill)\S+\b' $1 ; }
cell() { grep -cP 'sky130_\S+_sc_hd__\S+\b' $1 ; }
# Design area 3610 u^2 90% utilization.
util() { grep -oPr 'Design area \S+ u\^2 \K.*' $1 ; }

case $1 in
    buf_1_2*)
        buf_1_2 $2
        ;;
    buf*)
        buf $2
        ;;
    fill*)
        fillers $2
        ;;
    phys*)
        phys $2
        ;;
    util)
        util $2
        ;;
    wns)
        wns $2
        ;;
    decap*)
         decap $2
        ;;
    cell*)
        cell $2
        ;;
    *)
        echo "dk dc"
        ;;
esac

