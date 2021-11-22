#!/bin/sh
#
export NETGEN_COLUMNS=60
netgen -batch lvs "caravel.spice caravel" "../verilog/gl/caravel.v caravel" ./sky130A_setup.tcl comp.out
