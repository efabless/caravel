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

set ::env(MGMT_SOC_ROOT) $::env(DESIGN_DIR)/../..
#
set ::env(DESIGN_NAME) mgmt_core_wrapper

set ::env(CLOCK_PORT) "core_clk"
set ::env(CLOCK_NET) "core_clk"
set ::env(CLOCK_PERIOD) "25"

set ::env(RESET_PORT) "core_rstn"

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc 
set ::env(RUN_KLAYOUT) 0

## SYNTH
set ::env(SYNTH_STRATEGY) "DELAY 0"
set ::env(SYNTH_MAX_FANOUT) 12
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_BUFFERING) 0
set ::env(NO_SYNTH_CELL_LIST) [glob $::env(DESIGN_DIR)/no_synth.list]
# set ::env(DRC_EXCLUDE_CELL_LIST) [glob $::env(DESIGN_DIR)/drc_exclude.list]

## FP
set ::env(FP_DEF_TEMPLATE) $::env(DESIGN_DIR)/io.def
# set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2620 820"

set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro_placement.cfg
set ::env(PL_TIME_DRIVEN) 1
set ::env(DPL_CELL_PADDING) 2
set ::env(GPL_CELL_PADDING) 2

set ::env(LEFT_MARGIN_MULT) 22
set ::env(RIGHT_MARGIN_MULT) 22
set ::env(TOP_MARGIN_MULT) "5"
set ::env(BOTTOM_MARGIN_MULT) "5"

## PDN
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_VPITCH) 50
set ::env(FP_PDN_HPITCH) 50
set ::env(FP_PDN_VSPACING) 10
set ::env(FP_PDN_HSPACING) 10

set ::env(FP_PDN_VWIDTH) 1.6
set ::env(FP_PDN_CORE_RING_VWIDTH) 1.6

## CTS
# set ::env(CTS_CLK_BUFFER_LIST) "sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8 sky130_fd_sc_hd__clkbuf_16"
# set ::env(CTS_SINK_CLUSTERING_MAX_DIAMETER) 50
# set ::env(CTS_SINK_CLUSTERING_SIZE) 20

## Placement
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.1

set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 10
set ::env(PL_RESIZER_MAX_CAP_MARGIN) 10

## Routing
set ::env(GRT_ALLOW_CONGESTION) 1
set ::env(GRT_OVERFLOW_ITERS) 30

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.05
set ::env(GLB_RESIZER_SETUP_SLACK_MARGIN) 0.2

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) 3
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 500
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 500
set ::env(GRT_ANT_ITERS) 50
set ::env(GRT_MAX_DIODE_INS_ITERS) 50

## Internal Macros
set ::env(VERILOG_FILES_BLACKBOX) "$::env(MGMT_SOC_ROOT)/verilog/gl/RAM128.v $::env(MGMT_SOC_ROOT)/verilog/gl/RAM256.v"

set ::env(EXTRA_LEFS) "$::env(MGMT_SOC_ROOT)/lef/RAM128.lef $::env(MGMT_SOC_ROOT)/lef/RAM256.lef"

set ::env(EXTRA_GDS_FILES) "$::env(MGMT_SOC_ROOT)/gds/RAM128.gds $::env(MGMT_SOC_ROOT)/gds/RAM256.gds"

set ::env(EXTRA_LIBS) "$::env(MGMT_SOC_ROOT)/signoff/RAM256/primetime-signoff/lib/nom/RAM256.tt.lib \
        $::env(MGMT_SOC_ROOT)/signoff/RAM128/primetime-signoff/lib/nom/RAM128.tt.lib"

set ::env(VERILOG_FILES) "$::env(MGMT_SOC_ROOT)/verilog/rtl/defines.v \
        $::env(MGMT_SOC_ROOT)/verilog/rtl/ibex_all.v \
        $::env(MGMT_SOC_ROOT)/verilog/rtl/mgmt_core_wrapper.v \
        $::env(MGMT_SOC_ROOT)/verilog/rtl/mgmt_core.v \
        $::env(MGMT_SOC_ROOT)/verilog/rtl/picorv32.v \
        $::env(MGMT_SOC_ROOT)/verilog/rtl/VexRiscv_MinDebugCache.v"

set ::env(CTS_MAX_CAP) 0.25
## 
set ::env(ROUTING_CORES) 24
set ::env(QUIT_ON_MAGIC_DRC) 1
set ::env(QUIT_ON_TIMING_VIOLATIONS) 1
set ::env(QUIT_ON_LVS_ERROR) 1
set ::env(STA_REPORT_POWER) 0
set ::env(FP_PDN_CHECK_NODES) 0

set ::env(GRT_ADJUSTMENT) 0.22
set ::env(PL_TARGET_DENSITY) 0.28
set ::env(MAGIC_EXT_USE_GDS) 0

set ::env(FP_PDN_MACRO_HOOKS) "RAM256 VPWR VGND VPWR VGND, RAM128 VPWR VGND VPWR VGND"

#  set ::env(CTS_CLK_BUFFER_LIST) {sky130_fd_sc_hd__clkbuf_16 sky130_fd_sc_hd__clkbuf_8 sky130_fd_sc_hd__clkbuf_4}
# set ::env(CTS_ROOT_BUFFER) {sky130_fd_sc_hd__clkbuf_16}
# set ::env(CTS_CLK_MAX_WIRE_LENGTH) 300

set ::env(MAGIC_DEF_LABELS) 0
set ::env(RUN_IRDROP_REPORT) 0
set ::env(QUIT_ON_MAGIC_DRC) 0
set ::env(QUIT_ON_TR_DRC) 0