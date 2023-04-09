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


set ::env(DESIGN_NAME) caravel
set ::env(DESIGN_IS_PADFRAME) 1

set verilog_root $::env(CARAVEL_ROOT)/verilog/
set mgmt_area_verilog_root $::env(MCW_ROOT)/verilog/
set lef_root $::env(CARAVEL_ROOT)/lef/
set mgmt_area_lef_root $::env(MCW_ROOT)/lef/
set gds_root $::env(CARAVEL_ROOT)/gds/
set mgmt_area_gds_root $::env(MCW_ROOT)/gds/

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/user_defines.v
	$::env(DESIGN_DIR)/../../verilog/rtl/caravel.v
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/pads.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/mprj_io.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/chip_io.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
	$verilog_root/rtl/defines.v \
	$verilog_root/rtl/pads.v \
    $::env(DESIGN_DIR)/../../verilog/gl/constant_block.v \
	$verilog_root/rtl/__user_project_wrapper.v \
	$verilog_root/rtl/mgmt_protect.v \
	$verilog_root/rtl/gpio_defaults_block.v \
	$verilog_root/rtl/gpio_control_block.v \
	$verilog_root/rtl/user_id_programming.v \
	$verilog_root/rtl/housekeeping.v \
	$verilog_root/rtl/digital_pll.v \
	$verilog_root/rtl/caravel_clocking.v \
	$verilog_root/rtl/simple_por.v\
	$verilog_root/rtl/spare_logic_block.v\
	$verilog_root/rtl/xres_buf.v \
	$verilog_root/rtl/caravel_power_routing.v \
	$verilog_root/rtl/buff_flash_clkrst.v \
	$verilog_root/rtl/gpio_signal_buffering.v \
	$verilog_root/rtl/caravel_logo.v \
	$verilog_root/rtl/caravel_motto.v \
	$verilog_root/rtl/copyright_block.v \
	$verilog_root/rtl/open_source.v \
	$verilog_root/rtl/user_id_textblock.v \
	$mgmt_area_verilog_root/rtl/mgmt_core_wrapper.v \
	"

set ::env(EXTRA_LEFS) "\
	$lef_root/constant_block.lef 
	$lef_root/caravel_logo-stub.lef \
	$lef_root/caravel_motto-stub.lef \
	$lef_root/copyright_block-stub.lef \
	$lef_root/open_source-stub.lef \
	$lef_root/user_id_textblock-stub.lef \
	$lef_root/caravel_power_routing.lef \
	$lef_root/user_project_wrapper.lef \
	$lef_root/mgmt_protect.lef \
	$lef_root/gpio_control_block.lef \
	$lef_root/gpio_defaults_block.lef \
	$lef_root/user_id_programming.lef \
	$lef_root/housekeeping.lef \
	$lef_root/digital_pll.lef \
	$lef_root/caravel_clocking.lef \
	$lef_root/simple_por.lef\
	$lef_root/xres_buf.lef\
	$lef_root/spare_logic_block.lef\
	$lef_root/buff_flash_clkrst.lef\
	$lef_root/gpio_signal_buffering.lef\
	$mgmt_area_lef_root/mgmt_core_wrapper.lef \
	"


set ::env(EXTRA_GDS_FILES) "\
    $gds_root/copyright_block.gds \
    $gds_root/open_source.gds \
    $gds_root/user_id_textblock.gds \
    $gds_root/caravel_logo.gds \
    $gds_root/caravel_motto.gds \
    $gds_root/caravel_power_routing.gds \
    $gds_root/buff_flash_clkrst.gds \
    $gds_root/gpio_signal_buffering.gds \
	$gds_root/user_project_wrapper.gds \
	$gds_root/mgmt_protect.gds \
	$gds_root/gpio_control_block.gds \
	$gds_root/housekeeping.gds \
	$gds_root/digital_pll.gds \
	$gds_root/caravel_clocking.gds \
	$gds_root/simple_por.gds\
	$gds_root/xres_buf.gds\
    $::env(CARAVEL_ROOT)/gds/constant_block.gds
    [glob $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/gds/*.gds]
	$mgmt_area_gds_root/mgmt_core_wrapper.gds \
	"

set ::env(FP_PADFRAME_CFG) $::env(DESIGN_DIR)/padframe.cfg

set ::env(MAGIC_GDS_ALLOW_ABSTRACT) 1

set ::env(USE_GPIO_PADS) 1

set ::env(MAGIC_GDS_POLYGON_SUBCELLS) 1

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
set ::env(CORE_AREA) "210 210 [expr 3588 - 210] [expr 5188 - 210]"
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
#set ::env(MAGIC_WRITE_FULL_LEF) 1
