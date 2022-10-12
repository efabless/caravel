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


set ::env(DESIGN_NAME) chip_io
set ::env(DESIGN_IS_PADFRAME) 1


set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/pads.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/mprj_io.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/chip_io.v"

set ::env(VERILOG_FILES_BLACKBOX) "
    $::env(DESIGN_DIR)/../../verilog/gl/constant_block.v
"

set ::env(USE_GPIO_PADS) 1

# The removal of this line is pending the IO verilog files being parsable by yosys...
#set ::env(VERILOG_FILES_BLACKBOX) "\
#    $::env(DESIGN_DIR)/../../verilog/stubs/sky130_fd_io__top_xres4v2.v\
#    $::env(DESIGN_DIR)/../../verilog/stubs/sky130_fd_io__top_ground_lvc_wpad.v\
#    $::env(DESIGN_DIR)/../../verilog/stubs/sky130_fd_io__top_power_lvc_wpad.v"

set ::env(GPIO_PADS_VERILOG) "\
    $::env(DESIGN_DIR)/sky130_fd_io__top_xres4v2-stub.v
	$::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/verilog/sky130_ef_io.v"


## Synthesis
set ::env(SYNTH_FLAT_TOP) 1
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

## Floorplan
set ::env(FP_SIZING) absolute

set fd [open "$::env(DESIGN_DIR)/../chip_dimensions.txt" "r"]
set ::env(DIE_AREA) [read $fd]
close $fd

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) 0

## Routing
#set ::env(GLB_RT_MAXLAYER) 4
#set ::env(GLB_RT_UNIDIRECTIONAL) 0
#set ::env(GLB_RT_ALLOW_CONGESTION) 1
#set ::env(GLB_RT_OVERFLOW_ITERS) 150
#
## LVS
set ::env(LVS_CONNECT_BY_LABEL) 1

# "There are areas of ntap and ptap and/or low voltage and high voltage that magic can't parse properly from the GDS. \
   Those aren't parts of devices, so they don't affect the extraction, but they may raise overlap errors". Tim E. 
set ::env(QUIT_ON_ILLEGAL_OVERLAPS) 0
set ::env(MAGIC_WRITE_FULL_LEF) 1
