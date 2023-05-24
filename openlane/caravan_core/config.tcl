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

set ::env(DESIGN_NAME) caravan_core
set ::env(ROUTING_CORES) 36
set ::env(DESIGN_IS_CORE) 1
set ::env(BASE_SDC_FILE) "$::env(DESIGN_DIR)/sdc_files/base.sdc"
set ::env(RCX_SDC_FILE) "$::env(DESIGN_DIR)/sdc_files/rcx.sdc"

set ::env(VERILOG_FILES) "\
                        $::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
                        $::env(CARAVEL_ROOT)/verilog/rtl/user_defines.v \
                        $::env(CARAVEL_ROOT)/verilog/rtl/caravan_core.v \
                        $::env(CARAVEL_ROOT)/verilog/rtl/mgmt_protect.v \
                        $::env(CARAVEL_ROOT)/verilog/rtl/digital_pll.v \
                        $::env(CARAVEL_ROOT)/verilog/rtl/clock_div.v \
                        $::env(CARAVEL_ROOT)/verilog/rtl/gpio_control_block.v \
                        $::env(MCW_ROOT)/verilog/rtl/mgmt_core_wrapper.v \
                        $::env(MCW_ROOT)/verilog/rtl/mgmt_core.v \
                        $::env(MCW_ROOT)/verilog/rtl/ibex_all.v \
                        $::env(MCW_ROOT)/verilog/rtl/picorv32.v \
                        $::env(MCW_ROOT)/verilog/rtl/VexRiscv_MinDebugCache.v \
                        $::env(MCW_ROOT)/verilog/rtl/RAM256.v \
"
                    
set ::env(RUN_KLAYOUT) 0

# clock constraints
set ::env(CLOCK_PORT) "clock_core"
set ::env(CLOCK_NET) "caravel_clk"
set ::env(CLOCK_PERIOD) 25

# Synthesis
set ::env(SYNTH_STRATEGY) "DELAY 1"
set ::env(SYNTH_DEFINES) "PnR TOP_ROUTING"
set ::env(NO_SYNTH_CELL_LIST) $::env(DESIGN_DIR)/synth_configuration/no_synth.cells
set ::env(DRC_EXCLUDE_CELL_LIST) $::env(DESIGN_DIR)/synth_configuration/drc_exclude.cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
# set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"
set ::env(SYNTH_BUFFERING) 0
set ::env(SYNTH_EXTRA_MAPPING_FILE) "$::env(DESIGN_DIR)/synth_configuration/yosys_mapping.v"
set ::env(SYNTH_MAX_FANOUT) 12
set ::env(SYNTH_CAP_LOAD) 52
set ::env(SYNTH_CLOCK_TRANSITION) 0.6
set ::env(SYNTH_CLOCK_UNCERTAINTY) 0.25
set ::env(SYNTH_MAX_TRAN) 0.50
set ::env(QUIT_ON_SYNTH_CHECKS) 0

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 3165 4767"
set ::env(CORE_AREA) "10 10 3155 4757"

set ::env(FP_DEF_TEMPLATE) $::env(DESIGN_DIR)/floorplan_configuration/io.def

set ::env(FP_PDN_VERTICAL_HALO) "8"
set ::env(FP_PDN_HORIZONTAL_HALO) "1"

set ::env(FP_IO_MIN_DISTANCE) 5

set ::env(FP_IO_VEXTEND) 2
set ::env(FP_IO_HEXTEND) 2

set ::env(FP_TAPCELL_DIST) 10
set ::env(PL_MACRO_HALO) "1 1"
set ::env(GPL_CELL_PADDING) 0
set ::env(DPL_CELL_PADDING) 2

## PDN 
set ::env(VSRC_LOC) $::env(DESIGN_DIR)/floorplan_configuration/Vsrc.loc

set ::env(FP_PDN_ENABLE_MACROS_GRID) 1
set ::env(PDN_CFG) [glob $::env(DESIGN_DIR)/pdn_configuration/pdn.tcl]
set ::env(FP_PDN_CHECK_NODES) 0

set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_SKIPTRIM) 0

set ::env(VDD_NETS) "vccd vccd1 vccd2 vdda1 vdda2 vddio"
set ::env(GND_NETS) "vssd vssd1 vssd2 vssa1 vssa2 vssio"

set ::env(FP_PDN_MACRO_HOOKS) {
    user_id_value vccd vssd VPWR VGND,\
    housekeeping_alt vccd vssd VPWR VGND,\
    mprj vccd1 vssd1 vccd1 vssd1,\
    mprj vccd2 vssd2 vccd2 vssd2,\
    mprj vdda1 vssa1 vdda1 vssa1,\
    mprj vdda2 vssa2 vdda2 vssa2,\
    soc.core.RAM256.BANK128\\\\\\[0\\\\\\].RAM128 vccd vssd VPWR VGND,\
    soc.core.RAM256.BANK128\\\\\\[1\\\\\\].RAM128 vccd vssd VPWR VGND,\
    soc.core.RAM128 vccd vssd vccd1 vssd1,\
    mgmt_buffers.mprj_logic_high_inst vccd1 vssd1 vccd1 vssd1,\
    mgmt_buffers.mprj2_logic_high_inst vccd2 vssd2 vccd2 vssd2,\
    mgmt_buffers.powergood_check vccd vssd vccd vssd,\
    mgmt_buffers.powergood_check vdda1 vssa1 vdda1 vssa1,\
    mgmt_buffers.powergood_check vdda2 vssa2 vdda2 vssa2,\
    gpio_control_bidir_1\\\\\\[0\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_bidir_1\\\\\\[1\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1a\\\\\\[0\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1a\\\\\\[1\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1a\\\\\\[2\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1a\\\\\\[3\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1a\\\\\\[4\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1a\\\\\\[5\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1\\\\\\[0\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1\\\\\\[1\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1\\\\\\[2\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1\\\\\\[3\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1\\\\\\[4\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_1\\\\\\[5\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[0\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[1\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[2\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[3\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[4\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[5\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[6\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[7\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[8\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_in_2\\\\\\[9\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_bidir_2\\\\\\[0\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_bidir_2\\\\\\[1\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    gpio_control_bidir_2\\\\\\[2\\\\\\].gpio_logic_high vccd1 vssd1 vccd1 vssd1,\
    spare_logic\\\\\\[0\\\\\\] vccd vssd vccd vssd,\
    spare_logic\\\\\\[1\\\\\\] vccd vssd vccd vssd,\
    spare_logic\\\\\\[2\\\\\\] vccd vssd vccd vssd,\
    spare_logic\\\\\\[3\\\\\\] vccd vssd vccd vssd,\
    clock_ctrl vccd vssd VPWR VGND,\
    por vddio vssio vdd3v3 vss3v3,\
    por vccd vssd vdd1v8 vss1v8,\
    rstb_level vddio vssio VPWR VGND,\
    rstb_level vccd vssd LVPWR LVGND\
}

set ::env(FP_PDN_CORE_RING_VWIDTH) 10
set ::env(FP_PDN_CORE_RING_HWIDTH) 10
set ::env(FP_PDN_CORE_RING_VSPACING) 2
set ::env(FP_PDN_CORE_RING_VOFFSET) 1
set ::env(FP_PDN_CORE_RING_HSPACING) 2
set ::env(FP_PDN_CORE_RING_VOFFSET) 0
set ::env(FP_PDN_CORE_RING_HOFFSET) 0
set ::env(FP_PDN_VPITCH) 264
set ::env(FP_PDN_HPITCH) 360
set ::env(FP_PDN_VSPACING) 19
set ::env(FP_PDN_HSPACING) 27
set ::env(FP_PDN_VWIDTH) 3
set ::env(FP_PDN_HWIDTH) 3
set ::env(FP_PDN_HOFFSET) 30.65
set ::env(FP_PDN_VOFFSET) 3.5

##CTS
set ::env(CLOCK_TREE_SYNTH) 1
set ::env(CTS_MAX_CAP) 0.25
set ::env(CTS_SINK_CLUSTERING_SIZE) 12
set ::env(CTS_SINK_CLUSTERING_MAX_DIAMETER) 30
set ::env(CTS_CLK_BUFFER_LIST) {sky130_fd_sc_hd__clkbuf_8 sky130_fd_sc_hd__clkbuf_4}
set ::env(CTS_CLK_MAX_WIRE_LENGTH) 1000

##PLACEMENT
set ::env(PL_ROUTABILITY_DRIVEN) 1
set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_WIRELENGTH_COEF) 0.01
set ::env(PL_TARGET_DENSITY) 0.24

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.08
set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 0
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 1000
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 50
set ::env(PL_RESIZER_MAX_CAP_MARGIN) 50

##ROUTING
set ::env(GRT_ALLOW_CONGESTION) 1

set ::env(GRT_ADJUSTMENT) 0.08
##                                li1 ,met1,met2,met3,met4,met5
# set ::env(GRT_LAYER_ADJUSTMENTS) "0.99,0.10,0.05,0.10,0.05,0.00"
# set ::env(GRT_LAYER_ADJUSTMENTS) "0.99,0.20,0.10,0.20,0.05,0.00"
# set ::env(GRT_OVERFLOW_ITERS) 60

set ::env(GRT_ESTIMATE_PARASITICS) 1

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.08
set ::env(GLB_RESIZER_SETUP_SLACK_MARGIN) 1
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 600
set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) 30
set ::env(GLB_RESIZER_MAX_CAP_MARGIN) 30

## Antenna
set ::env(GRT_REPAIR_ANTENNAS) 1
set ::env(RUN_HEURISTIC_DIODE_INSERTION) 1
set ::env(HEURISTIC_ANTENNA_THRESHOLD) 80
set ::env(DIODE_ON_PORTS) "none"
set ::env(GRT_ANT_MARGIN) 10
set ::env(GRT_ANT_ITERS) 12
set ::env(GRT_MAX_DIODE_INS_ITERS) 4
set ::env(DIODE_PADDING) 0

## MACROS
set ::env(MACRO_PLACEMENT_CFG) [glob $::env(DESIGN_DIR)/floorplan_configuration//macro_placement.cfg]

set ::env(VERILOG_FILES_BLACKBOX) "\
    $::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
    $::env(CARAVEL_ROOT)/verilog/rtl/user_id_programming.v \
    $::env(CARAVEL_ROOT)/verilog/rtl/__user_analog_project_wrapper.v \
    $::env(CARAVEL_ROOT)/verilog/gl/housekeeping_alt.v \
    $::env(CARAVEL_ROOT)/verilog/rtl/simple_por.v \
    $::env(CARAVEL_ROOT)/verilog/gl/xres_buf.v \
    $::env(CARAVEL_ROOT)/verilog/gl/spare_logic_block.v \
    $::env(CARAVEL_ROOT)/verilog/rtl/gpio_defaults_block.v \
    $::env(CARAVEL_ROOT)/verilog/gl/mprj_logic_high.v \
	$::env(CARAVEL_ROOT)/verilog/gl/mprj2_logic_high.v \
	$::env(CARAVEL_ROOT)/verilog/gl/mgmt_protect_hv.v \
    $::env(CARAVEL_ROOT)/verilog/gl/gpio_logic_high.v \
    $::env(CARAVEL_ROOT)/verilog/gl/empty_macro.v \
    $::env(CARAVEL_ROOT)/verilog/gl/empty_macro_1.v \
    $::env(CARAVEL_ROOT)/verilog/gl/caravel_clocking.v \
    $::env(CARAVEL_ROOT)/verilog/gl/caravan_signal_routing.v \
    $::env(MCW_ROOT)/verilog/gl/RAM128.v \
"

set ::env(EXTRA_LEFS) "\
    $::env(CARAVEL_ROOT)/lef/user_id_programming.lef \
    $::env(CARAVEL_ROOT)/lef/user_analog_project_wrapper_empty.lef \
    $::env(CARAVEL_ROOT)/lef/housekeeping_alt.lef \
    $::env(CARAVEL_ROOT)/lef/simple_por.lef \
    $::env(CARAVEL_ROOT)/lef/xres_buf.lef \
    $::env(CARAVEL_ROOT)/lef/spare_logic_block.lef \
    $::env(CARAVEL_ROOT)/lef/gpio_defaults_block.lef \
    $::env(CARAVEL_ROOT)/lef/mprj_logic_high.lef \
    $::env(CARAVEL_ROOT)/lef/mprj2_logic_high.lef \
    $::env(CARAVEL_ROOT)/lef/mgmt_protect_hv.lef \
    $::env(CARAVEL_ROOT)/lef/gpio_logic_high.lef \
    $::env(CARAVEL_ROOT)/lef/empty_macro.lef \
    $::env(CARAVEL_ROOT)/lef/empty_macro_1.lef \
    $::env(CARAVEL_ROOT)/lef/caravel_clocking.lef \
    $::env(CARAVEL_ROOT)/lef/caravan_signal_routing.lef \
    $::env(MCW_ROOT)/lef/RAM128.lef \
"

set ::env(EXTRA_GDS_FILES) "\
    $::env(CARAVEL_ROOT)/gds/user_id_programming.gds \
    $::env(CARAVEL_ROOT)/gds/user_analog_project_wrapper_empty.gds \
    $::env(CARAVEL_ROOT)/gds/housekeeping_alt.gds \
    $::env(CARAVEL_ROOT)/gds/simple_por.gds \
    $::env(CARAVEL_ROOT)/gds/xres_buf.gds \
    $::env(CARAVEL_ROOT)/gds/spare_logic_block.gds \
    $::env(CARAVEL_ROOT)/gds/gpio_defaults_block.gds \
    $::env(CARAVEL_ROOT)/gds/mprj_logic_high.gds \
    $::env(CARAVEL_ROOT)/gds/mprj2_logic_high.gds \
    $::env(CARAVEL_ROOT)/gds/mgmt_protect_hv.gds \
    $::env(CARAVEL_ROOT)/gds/gpio_logic_high.gds \
    $::env(CARAVEL_ROOT)/gds/empty_macro.gds \
    $::env(CARAVEL_ROOT)/gds/empty_macro_1.gds \
    $::env(CARAVEL_ROOT)/gds/caravel_clocking.gds \
    $::env(CARAVEL_ROOT)/gds/caravan_signal_routing.gds \
    $::env(MCW_ROOT)/gds/RAM128.gds \
"

set ::env(EXTRA_LIBS) "\
    $::env(CARAVEL_ROOT)/lib/housekeeping_alt.lib \
    $::env(CARAVEL_ROOT)/lib/gpio_defaults_block.lib \
    $::env(CARAVEL_ROOT)/lib/gpio_logic_high.lib \
    $::env(CARAVEL_ROOT)/lib/user_analog_project_wrapper.lib \
    $::env(CARAVEL_ROOT)/lib/caravel_clocking.lib \
    $::env(MCW_ROOT)/signoff/RAM128/primetime/lib/ff/RAM128.nom.lib \
"

# set ::env(EXTRA_SPEFS) "RAM128 \
#     $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.min.spef \
#     $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.nom.spef \
#     $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.max.spef \
#     housekeeping_alt \
#     $::env(CARAVEL_ROOT)/signoff/housekeeping_alt/openlane-signoff/spef/housekeeping_alt.min.spef \
#     $::env(CARAVEL_ROOT)/signoff/housekeeping_alt/openlane-signoff/spef/housekeeping_alt.nom.spef \
#     $::env(CARAVEL_ROOT)/signoff/housekeeping_alt/openlane-signoff/spef/housekeeping_alt.max.spef \
#     caravel_clocking \
#     $::env(CARAVEL_ROOT)/signoff/caravel_clocking/openlane-signoff/spef/caravel_clocking.min.spef \
#     $::env(CARAVEL_ROOT)/signoff/caravel_clocking/openlane-signoff/spef/caravel_clocking.nom.spef \
#     $::env(CARAVEL_ROOT)/signoff/caravel_clocking/openlane-signoff/spef/caravel_clocking.max.spef"

set ::env(STA_WRITE_LIB) 0

## For faster development
set ::env(QUIT_ON_TR_DRC) 1
set ::env(QUIT_ON_LVS_ERROR) 0
set ::env(QUIT_ON_MAGIC_DRC) 0

set ::env(MAGIC_DEF_LABELS) 0
set ::env(MAGIC_EXT_USE_GDS) 1

set ::env(RSZ_DONT_TOUCH_RX) "rstb_h|porb_h|serial_clock_out|serial_load_out|ringosc|mgmt_buffers.la_data_out_core|mprj_ack_i_user|mprj_dat_i_user|user_irq_core|io_in_3v3|gpio_noesd|gpio_analog|io_analog\\\[.*\\\]|io_clamp_high|io_clamp_low"