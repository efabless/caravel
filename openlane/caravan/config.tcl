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

# User config
set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) caravan

set ::env(STD_CELL_LIBRARY_OPT) "sky130_fd_sc_hd"

set verilog_root $::env(CARAVEL_ROOT)/verilog/
set lef_root $::env(CARAVEL_ROOT)/lef/
set gds_root $::env(CARAVEL_ROOT)/gds/

set mgmt_area_verilog_root $::env(MCW_ROOT)/verilog/
set mgmt_area_lef_root $::env(MCW_ROOT)/lef/
set mgmt_area_gds_root $::env(MCW_ROOT)/gds/

# Change if needed
set ::env(VERILOG_FILES) "\
	$verilog_root/rtl/user_defines.v
	$verilog_root/rtl/caravan.v"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1


# defines and pads need to be first
# order matters
set ::env(VERILOG_FILES_BLACKBOX) "\
	$verilog_root/rtl/defines.v
	$verilog_root/rtl/pads.v \
	$mgmt_area_verilog_root/rtl/mgmt_core_wrapper.v \
	$verilog_root/rtl/__user_analog_project_wrapper.v \
	$verilog_root/rtl/buff_flash_clkrst.v \
	$verilog_root/rtl/caravan_power_routing.v \
	$verilog_root/rtl/caravel_clocking.v \
	$verilog_root/rtl/caravan_signal_routing.v \
	$verilog_root/rtl/chip_io_alt.v \
	$verilog_root/rtl/digital_pll.v \
	$verilog_root/rtl/gpio_control_block.v \
	$verilog_root/rtl/gpio_defaults_block.v \
	$verilog_root/rtl/gpio_signal_buffering_alt.v \
	$verilog_root/rtl/housekeeping.v \
	$verilog_root/rtl/mgmt_protect.v \
	$verilog_root/rtl/simple_por.v\
	$verilog_root/rtl/spare_logic_block.v\
	$verilog_root/rtl/user_id_programming.v \
	$verilog_root/rtl/xres_buf.v \
	$verilog_root/rtl/caravan_logo.v \
	$verilog_root/rtl/caravan_motto.v \
	$verilog_root/rtl/copyright_block_a.v \
	$verilog_root/rtl/open_source.v \
	$verilog_root/rtl/user_id_textblock.v \
	"

set ::env(EXTRA_LEFS) "\
	$lef_root/caravan_signal_routing.lef \
	$lef_root/caravan_logo-stub.lef \
	$lef_root/caravan_motto-stub.lef \
	$lef_root/copyright_block_a-stub.lef \
	$lef_root/open_source-stub.lef \
	$lef_root/user_id_textblock-stub.lef \
	$lef_root/buff_flash_clkrst.lef\
	$lef_root/caravan_power_routing.lef\
	$lef_root/caravel_clocking.lef \
	$lef_root/chip_io_alt.lef \
	$lef_root/digital_pll.lef \
	$lef_root/gpio_control_block.lef \
	$lef_root/gpio_defaults_block.lef \
	$lef_root/gpio_signal_buffering_alt.lef\
	$lef_root/housekeeping.lef \
	$lef_root/mgmt_protect.lef \
	$lef_root/simple_por.lef\
	$lef_root/spare_logic_block.lef\
	$lef_root/user_analog_project_wrapper.lef \
	$lef_root/user_id_programming.lef \
	$lef_root/xres_buf.lef\
	$mgmt_area_lef_root/mgmt_core_wrapper.lef \
	"

set ::env(EXTRA_GDS_FILES) "\
	$gds_root/caravan_signal_routing.gds \
	$gds_root/caravan_logo.gds \
	$gds_root/caravan_motto.gds \
	$gds_root/copyright_block_a.gds \
	$gds_root/open_source.gds \
	$gds_root/user_id_textblock.gds \
	$gds_root/caravel_clocking.gds \
	$gds_root/chip_io_alt.gds \
	$gds_root/digital_pll.gds \
	$gds_root/gpio_control_block.gds \
	$gds_root/gpio_defaults_block.gds \
	$gds_root/housekeeping.gds \
	$gds_root/mgmt_protect.gds \
	$gds_root/simple_por.gds\
	$gds_root/user_analog_project_wrapper.gds \
	$gds_root/user_id_programming.gds \
	$gds_root/xres_buf.gds\
	$mgmt_area_gds_root/mgmt_core_wrapper.gds \
    $gds_root/buff_flash_clkrst.gds \
    $gds_root/gpio_signal_buffering_alt.gds \
	"

# # !!!
# if { [info exists ::env(LVS_RUN_DIR)] || [info exists ::env(CONNECTIVITY_RUN)] } {
# 	# if running to get a full floorplan, need the original pads due to
# 	# missing pins in the abstracted version
# 	set ::env(GPIO_PADS_LEF) [glob "$::env(PDK_ROOT)/$::env(PDK)/libs.ref/lef/s8iom0s8/*.lef"]
# }

set ::env(SYNTH_TOP_LEVEL) 1
set ::env(SYNTH_FLAT_TOP) 1
set ::env(LEC_ENABLE) 0

set ::env(FP_SIZING) absolute

set fd [open "$script_dir/../chip_dimensions.txt" "r"]
set ::env(DIE_AREA) [read $fd]
close $fd


set ::env(CELL_PAD) 0

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0

set ::env(DIODE_INSERTION_STRATEGY) 0

set ::env(GLB_RT_ALLOW_CONGESTION) 1
set ::env(GLB_RT_OVERFLOW_ITERS) 50
set ::env(GLB_RT_TILES) 30
set ::env(GLB_RT_MINLAYER) 2
set ::env(GLB_RT_MAXLAYER) 6

set ::env(GLB_RT_ADJUSTMENT) "0"
set ::env(GLB_RT_L1_ADJUSTMENT) "0.99"
set ::env(GLB_RT_L2_ADJUSTMENT) "0.15"
set ::env(GLB_RT_L3_ADJUSTMENT) "0.45"
set ::env(GLB_RT_L4_ADJUSTMENT) "0.45"
set ::env(GLB_RT_L5_ADJUSTMENT) "0.45"
set ::env(GLB_RT_L6_ADJUSTMENT) "0"

set ::env(TECH_LEF) $::env(DESIGN_DIR)/sky130_fd_sc_hd.tlef

# set ::env(ROUTING_OPT_ITERS) 7
# set ::env(GLB_RT_UNIDIRECTIONAL) 0

set ::env(FILL_INSERTION) 0

# DON'T PUT CELLS ON THE TOP LEVEL
set ::env(LVS_INSERT_POWER_PINS) 0

set ::env(MAGIC_GENERATE_LEF) 0

set ::env(QUIT_ON_ILLEGAL_OVERLAPS) 0
set ::env(QUIT_ON_TR_DRC) 0
set ::env(QUIT_ON_LVS_ERROR) 0
