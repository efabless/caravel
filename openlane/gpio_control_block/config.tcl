# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) gpio_control_block

set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v\
	$script_dir/../../verilog/rtl/gpio_control_block.v"


set ::env(CLOCK_PORT) "serial_clock"

# This needs to be half the mgmt_core clock frequency
set ::env(CLOCK_PERIOD) "50"

set ::env(VDD_NETS) "vccd vccd1"
set ::env(GND_NETS) "vssd vssd1"

set ::env(BASE_SDC_FILE) $script_dir/base.sdc

## Synthesis
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 170 65"

set ::env(FP_IO_VEXTEND) 0
set ::env(FP_IO_HEXTEND) 0
set ::env(FP_IO_HLENGTH) 100
set ::env(FP_IO_VLENGTH) 4

set ::env(RIGHT_MARGIN_MULT) 262
set ::env(LEFT_MARGIN_MULT) 10
set ::env(TOP_MARGIN_MULT) 2
set ::env(BOTTOM_MARGIN_MULT) 2

set ::env(CELL_PAD) 0

## PDN
set ::env(PDN_CFG) $script_dir/pdn.tcl 
set ::env(FP_PDN_AUTO_ADJUST) 0

set ::env(FP_PDN_VWIDTH) 1.6
set ::env(FP_PDN_HWIDTH) 1.6

set ::env(FP_HORIZONTAL_HALO) 2
set ::env(FP_VERTICAL_HALO) 2

set ::env(FP_PDN_HOFFSET) 1.5
set ::env(FP_PDN_VOFFSET) 9.0

set ::env(FP_PDN_HPITCH) 16.9
set ::env(FP_PDN_VPITCH) 25

set ::env(FP_PDN_VSPACING) 3.4
set ::env(FP_PDN_HSPACING) 3.4

## Placement 
set ::env(PL_TARGET_DENSITY) 0.91
# for some reason resizer is leaving a floating net after running repair_tie_fanout command
set ::env(PL_RESZIER_REPIAR_TIE_FANOUT) 0

# mgmt_gpio_in is driven by a tristate cell
set ::env(DONT_BUFFER_PORTS) "mgmt_gpio_in"

## Routing
set ::env(GLB_RT_MINLAYER) 2
set ::env(GLB_RT_MAXLAYER) 4
set ::env(GLB_RT_ADJUSTMENT) 0.05

# Add obstructions on the areas that will lie underneath the padframe 
set ::env(GLB_RT_OBS) "\ 
	li1 0 0 16.79500 30.02500,
	li1 0 29.96500 4.26500 65.07000,
	li1 4.21500 57.40500 49.81500 64.93000,
	li1 16.83000 0 49.41000 5.24000,
	li1 49.000 0 169.81000 64.84500,
	met5 67 0 170 65,
	met4 67 0 170 65,
	met2 120 0 170 65,
	met1 120 0 170 65"

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) "3"

## Internal macros
set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro_placement.cfg

set ::env(VERILOG_FILES_BLACKBOX) "\
	$script_dir/../../verilog/rtl/gpio_logic_high.v"

set ::env(EXTRA_LEFS) "\
	$script_dir/../../lef/gpio_logic_high.lef"

set ::env(EXTRA_GDS_FILES) "\
	$script_dir/../../gds/gpio_logic_high.gds"