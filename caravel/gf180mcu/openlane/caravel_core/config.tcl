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

set ::env(STD_CELL_LIBRARY) "gf180mcu_fd_sc_mcu7t5v0"

set ::env(DESIGN_NAME) caravel_core
set ::env(ROUTING_CORES) 36
set ::env(DESIGN_IS_CORE) 1
set ::env(BASE_SDC_FILE) "$::env(DESIGN_DIR)/base.sdc"
set ::env(RCX_SDC_FILE) "$::env(DESIGN_DIR)/rcx.sdc"

set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/../../verilog/rtl/defines.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/user_defines.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/caravel_core.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/mgmt_protect.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/digital_pll.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/clock_div.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/caravel_clocking.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/gpio_control_block.v \
                        $::env(MCW_ROOT)/verilog/rtl/mgmt_core_wrapper.v \
                        $::env(MCW_ROOT)/verilog/rtl/mgmt_core.v \
                        $::env(MCW_ROOT)/verilog/rtl/sram.v \
                        $::env(MCW_ROOT)/verilog/rtl/GF180_RAM_512x32.v \
                        $::env(MCW_ROOT)/verilog/rtl/VexRiscv_MinDebugCache.v"
                    
set ::env(RUN_KLAYOUT) 0

# clock
set ::env(CLOCK_PORT) ""
set ::env(CLOCK_PERIOD) 30

# Synthesis
set ::env(SYNTH_STRATEGY) "DELAY 0"
set ::env(NO_SYNTH_CELL_LIST) $::env(DESIGN_DIR)/no_synth.cells
set ::env(DRC_EXCLUDE_CELL_LIST) $::env(DESIGN_DIR)/no_synth.cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_MAX_FANOUT) 22
# set ::env(SYNTH_USE_PG_PINS_DEFINES) ""
set ::env(SYNTH_BUFFERING) 0
set ::env(CLOCK_TREE_SYNTH) 1
set ::env(SYNTH_EXTRA_MAPPING_FILE) "$::env(DESIGN_DIR)/yosys_mapping.v"

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 3170 4360"
set ::env(CORE_AREA) "24 26 3145 4334"
set ::env(FP_DEF_TEMPLATE) $::env(DESIGN_DIR)/io.def

set ::env(FP_PDN_VERTICAL_HALO) "8"
set ::env(FP_PDN_HORIZONTAL_HALO) "-2"

set ::env(FP_IO_MIN_DISTANCE) 5

set ::env(FP_IO_VEXTEND) 2
set ::env(FP_IO_HEXTEND) 2

# set ::env(CELL_PAD) 0

## PDN 
set ::env(PDN_CFG) [glob $::env(DESIGN_DIR)/pdn.tcl]
set ::env(FP_PDN_CHECK_NODES) 0

set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_SKIPTRIM) 1

set ::env(VDD_NETS) "VDD"
set ::env(GND_NETS) "VSS"

set ::env(FP_PDN_MACRO_HOOKS) "mprj VDD VSS vdd vss \
                                housekeeping VDD VSS VDD VSS \
                                soc.core.sram.ram512x32.RAM00 VDD VSS VDD VSS \
                                soc.core.sram.ram512x32.RAM01 VDD VSS VDD VSS \
                                soc.core.sram.ram512x32.RAM02 VDD VSS VDD VSS \
                                soc.core.sram.ram512x32.RAM03 VDD VSS VDD VSS \
                                por_inst VDD VSS VDD VSS \
                                user_id_value VDD VSS VDD VSS \
                                gpio_buf VDD VSS VDD VSS \
                                gpio_defaults_block_0 VDD VSS VDD VSS \
                                gpio_defaults_block_1 VDD VSS VDD VSS \
                                gpio_defaults_block_2 VDD VSS VDD VSS \
                                gpio_defaults_block_3 VDD VSS VDD VSS \
                                gpio_defaults_block_4 VDD VSS VDD VSS \
                                gpio_defaults_block_5 VDD VSS VDD VSS \
                                gpio_defaults_block_6 VDD VSS VDD VSS \
                                gpio_defaults_block_7 VDD VSS VDD VSS \
                                gpio_defaults_block_8 VDD VSS VDD VSS \
                                gpio_defaults_block_9 VDD VSS VDD VSS \
                                gpio_defaults_block_10 VDD VSS VDD VSS \
                                gpio_defaults_block_11 VDD VSS VDD VSS \
                                gpio_defaults_block_12 VDD VSS VDD VSS \
                                gpio_defaults_block_13 VDD VSS VDD VSS \
                                gpio_defaults_block_14 VDD VSS VDD VSS \
                                gpio_defaults_block_15 VDD VSS VDD VSS \
                                gpio_defaults_block_16 VDD VSS VDD VSS \
                                gpio_defaults_block_17 VDD VSS VDD VSS \
                                gpio_defaults_block_18 VDD VSS VDD VSS \
                                gpio_defaults_block_19 VDD VSS VDD VSS \
                                gpio_defaults_block_20 VDD VSS VDD VSS \
                                gpio_defaults_block_21 VDD VSS VDD VSS \
                                gpio_defaults_block_22 VDD VSS VDD VSS \
                                gpio_defaults_block_23 VDD VSS VDD VSS \
                                gpio_defaults_block_24 VDD VSS VDD VSS \
                                gpio_defaults_block_25 VDD VSS VDD VSS \
                                gpio_defaults_block_26 VDD VSS VDD VSS \
                                gpio_defaults_block_27 VDD VSS VDD VSS \
                                gpio_defaults_block_28 VDD VSS VDD VSS \
                                gpio_defaults_block_29 VDD VSS VDD VSS \
                                gpio_defaults_block_30 VDD VSS VDD VSS \
                                gpio_defaults_block_31 VDD VSS VDD VSS \
                                gpio_defaults_block_32 VDD VSS VDD VSS \
                                gpio_defaults_block_33 VDD VSS VDD VSS \
                                gpio_defaults_block_34 VDD VSS VDD VSS \
                                gpio_defaults_block_35 VDD VSS VDD VSS \
                                gpio_defaults_block_36 VDD VSS VDD VSS \
                                gpio_defaults_block_37 VDD VSS VDD VSS \
                                spare_logic\[0\] VDD VSS VDD VSS \
                                spare_logic\[1\] VDD VSS VDD VSS \
                                spare_logic\[2\] VDD VSS VDD VSS \
                                spare_logic\[3\] VDD VSS VDD VSS"

set ::env(FP_PDN_CORE_RING_VWIDTH) 10
set ::env(FP_PDN_CORE_RING_HWIDTH) 10
set ::env(FP_PDN_CORE_RING_VSPACING) 2
set ::env(FP_PDN_CORE_RING_HSPACING) 2
set ::env(FP_PDN_CORE_RING_VOFFSET) 0
set ::env(FP_PDN_CORE_RING_HOFFSET) 0
set ::env(FP_PDN_VPITCH) 80
set ::env(FP_PDN_HPITCH) 60
set ::env(FP_PDN_VSPACING) 19
set ::env(FP_PDN_HSPACING) 27
set ::env(FP_PDN_VWIDTH) 3
set ::env(FP_PDN_HWIDTH) 3
set ::env(FP_PDN_HOFFSET) 30.65
set ::env(FP_PDN_VOFFSET) 3.5

##CTS
set ::env(CTS_MAX_CAP) 0.1
set ::env(CTS_REPORT_TIMING) 0
set ::env(CTS_TOLERANCE) 10
set ::env(CTS_SINK_CLUSTERING_SIZE) 12
set ::env(CTS_SINK_CLUSTERING_MAX_DIAMETER) 30
set ::env(CTS_ROOT_BUFFER) "$::env(STD_CELL_LIBRARY)__clkbuf_20"

##PLACEMENT
set ::env(PL_ROUTABILITY_DRIVEN) 1
set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_TARGET_DENSITY) 0.55

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.15
set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 0
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 1
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 800
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 20
set ::env(PL_RESIZER_CAP_SLEW_MARGIN) 20

##ROUTING
set ::env(GRT_ALLOW_CONGESTION) 1
set ::env(GRT_OBS) "\
    Metal3 0 55 25 150,\
    Metal3 0 266 25 358,\
    Metal3 0 1698 25 1799,\
    Metal3 0 1911 25 1994,\
    Metal3 0 3544 25 4061,\
    Metal3 3144 1579 3167 1683,\
    Metal2 3144 1797 3167 1895,\
    Metal3 3144 1797 3167 1895,\
    Metal3 3144 2010 3167 2111,\
    Metal3 3144 3516 3167 3616,\
    Metal3 3144 3950 3167 4044"

set ::env(GRT_ADJUSTMENT) 0.4
# ##                                met1,met2,met3,met4,met5
# set ::env(GRT_LAYER_ADJUSTMENTS) "0.25,0.30,0.22,0.40,0.22"
set ::env(GRT_OVERFLOW_ITERS) 50
set ::evn(DRT_OPT_ITERS) 12
set ::env(GRT_ESTIMATE_PARASITICS) 1

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.05
set ::env(GLB_RESIZER_SETUP_SLACK_MARGIN) 1
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 800
set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) 20
set ::env(GLB_RESIZER_CAP_SLEW_MARGIN) 20

## Antenna
set ::env(DIODE_INSERTION_STRATEGY) 3
set ::env(GRT_ANT_ITERS) 100
set ::env(GRT_MAX_DIODE_INS_ITERS) 40
set ::env(DIODE_PADDING) 0

## MACROS
set ::env(MACRO_PLACEMENT_CFG) [glob $::env(DESIGN_DIR)/macro_placement.cfg]

set ::env(VERILOG_FILES_BLACKBOX) "\
    $::env(DESIGN_DIR)/../../verilog/gl/__user_project_wrapper.v \
    $::env(DESIGN_DIR)/../../verilog/gl/housekeeping.v \
    $::env(DESIGN_DIR)/../../verilog/rtl/simple_por.v \
    $::env(DESIGN_DIR)/../../verilog/rtl/user_id_programming.v \
    $::env(DESIGN_DIR)/../../verilog/gl/spare_logic_block.v \
    $::env(DESIGN_DIR)/../../verilog/gl/mprj_io_buffer.v \
    $::env(DESIGN_DIR)/../../verilog/rtl/gpio_defaults_block.v \
    $::env(MCW_ROOT)/verilog/gl/gf180_ram_512x8_wrapper.v"

set ::env(EXTRA_LEFS) "\
    $::env(DESIGN_DIR)/../../lef/user_project_wrapper_PnR.lef \
    $::env(DESIGN_DIR)/../../lef/housekeeping.lef \
    $::env(DESIGN_DIR)/../../macros/simple_por/lef/simple_por.lef \
    $::env(DESIGN_DIR)/../../lef/user_id_programming.lef \
    $::env(DESIGN_DIR)/../../lef/spare_logic_block.lef \
    $::env(DESIGN_DIR)/../../lef/mprj_io_buffer.lef \
    $::env(DESIGN_DIR)/../../lef/gpio_defaults_block.lef \
    $::env(MCW_ROOT)/lef/gf180_ram_512x8_wrapper.lef"

set ::env(EXTRA_GDS_FILES) "\
    $::env(DESIGN_DIR)/../../gds/user_project_wrapper.gds \
    $::env(DESIGN_DIR)/../../gds/housekeeping.gds \
    $::env(DESIGN_DIR)/../../macros/simple_por/gds/simple_por.gds \
    $::env(DESIGN_DIR)/../../gds/user_id_programming.gds \
    $::env(DESIGN_DIR)/../../gds/spare_logic_block.gds \
    $::env(DESIGN_DIR)/../../gds/mprj_io_buffer.gds \
    $::env(DESIGN_DIR)/../../gds/gpio_defaults_block.gds \
    $::env(MCW_ROOT)/gds/gf180_ram_512x8_wrapper.gds"

set ::env(EXTRA_LIBS) "\
    $::env(DESIGN_DIR)/gf180_ram_512x8_wrapper.lib \
    $::env(DESIGN_DIR)/../../signoff/housekeeping/primetime-signoff/lib/tt/housekeeping.nom.lib \
    $::env(DESIGN_DIR)/../../signoff/mprj_io_buffer/primetime-signoff/lib/tt/mprj_io_buffer.nom.lib"

set ::env(STA_WRITE_LIB) 0

## For faster development
set ::env(QUIT_ON_TR_DRC) 1
set ::env(QUIT_ON_LVS_ERROR) 0
set ::env(QUIT_ON_MAGIC_DRC) 0

set ::env(MAGIC_DEF_LABELS) 0
set ::env(MAGIC_EXT_USE_GDS) 0

set ::env(RSZ_DONT_TOUCH_RX) "serial_clock_out|serial_load_out|ringosc"