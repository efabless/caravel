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
# User config
set ::env(DESIGN_NAME) gf180_ram_512x8_wrapper
set ::env(DESIGN_IS_CORE) 1

set ::env(PDK) "gf180mcuC"
set ::env(STD_CELL_LIBRARY) "gf180mcu_fd_sc_mcu7t5v0"

set ::env(ROUTING_CORES) 8
set ::env(RUN_KLAYOUT) 0

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 444.86 495.88"
set ::env(DIE_AREA) "0 0 444.86 495.88"
set ::env(FP_DEF_TEMPLATE) $::env(DESIGN_DIR)/io.def

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

# Change if needed
set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/gf180_ram_512x8_wrapper.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram512x8m8wm1.v"

set ::env(EXTRA_LEFS) "\
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/gf180mcu_fd_ip_sram/lef/gf180mcu_fd_ip_sram__sram512x8m8wm1.lef"

set ::env(EXTRA_GDS_FILES) "\
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/gf180mcu_fd_ip_sram/gds/gf180mcu_fd_ip_sram__sram512x8m8wm1.gds"

set ::env(EXTRA_LIBS) "\
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/gf180mcu_fd_ip_sram/liberty/gf180mcu_fd_ip_sram__sram512x8m8wm1__tt_025C_5v00.lib "

set ::env(CLOCK_PERIOD) "25"
set ::env(CLOCK_PORT) "CLK"


## Routing
set ::env(RT_MIN_LAYER) {Metal2}
set ::env(RT_MAX_LAYER) {Metal5}

## Internal Macros
set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro_placement.cfg

## PDN
set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl
set ::env(FP_PDN_CORE_RING) 0
set ::env(FP_PDN_CHECK_NODES) 0
# set ::env(FP_PDN_UPPER_LAYER) {Metal5}
# set ::env(FP_PDN_LOWER_LAYER) {Metal1}
set ::env(FP_PDN_ENABLE_GLOBAL_CONNECTIONS) 1

# ir_drop_analyser can't find Metal3 resistance
set ::env(FP_PDN_IRDROP) 0

# Disable everything
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(RUN_FILL_INSERTION) 0
set ::env(RUN_TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(SYNTH_BUFFERING) 0

# Skip steps due to incomplete pdk
set ::env(QUIT_ON_TIMING_VIOLATIONS) 0
set ::env(RUN_SPEF_EXTRACTION) 0
set ::env(QUIT_ON_LVS_ERROR) 0
set ::env(QUIT_ON_MAGIC_DRC) 0
set ::env(MAGIC_EXT_USE_GDS) 1