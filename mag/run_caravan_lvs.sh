#!/bin/sh
#
export NETGEN_COLUMNS=60
netgen -batch lvs "caravan.spice caravan" "../verilog/gl/caravan.v caravan" ./sky130A_setup.tcl comp.out
