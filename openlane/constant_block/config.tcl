set ::env(DESIGN_NAME) constant_block
set ::env(ROUTING_CORES) 2
set ::env(DESIGN_IS_CORE) 0
set ::env(PDK) "sky130A"

set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/../../rtl/constant_block.v]

set ::env(RUN_KLAYOUT) 0
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(CLOCK_PORT) ""

set ::env(VDD_PIN) {vccd}
set ::env(VDD_NET) {vccd}
set ::env(GND_PIN) {vssd}
set ::env(GND_NET) {vssd}

# Synthesis
set ::env(SYNTH_STRATEGY) "AREA 0"
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"
set ::env(SYNTH_BUFFERING) 0
set ::env(DRC_EXCLUDE_CELL_LIST) [glob $::env(DESIGN_DIR)/drc_exclude.list] 

set ::env(CLOCK_TREE_SYNTH) 0

## Floorplan
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0.0 0.0 14 13"
set ::env(CELL_PAD) 0
set ::env(FP_PDN_LOWER_LAYER) {met4}
set ::env(FP_PDN_UPPER_LAYER) {met3}
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
set ::env(FP_ENDCAP_CELL) "sky130_fd_sc_hd__decap_3"
set ::env(DECAP_CELL) {sky130_fd_sc_hd__decap_3}
set ::env(DIODE_PADDING) 0
set ::env(TAP_DECAP_INSERTION) {1}
set ::env(FILL_INSERTION) 1
set ::env(BOTTOM_MARGIN_MULT) 0.2
set ::env(TOP_MARGIN_MULT) 0.2
set ::env(LEFT_MARGIN_MULT) 1
set ::env(RIGHT_MARGIN_MULT) 1

## PDN
set ::env(FP_PDN_AUTO_ADJUST) {0}
set ::env(FP_PDN_CHECK_NODES) {0}
set ::env(FP_PDN_CORE_RING) {0}
set ::env(FP_PDN_VWIDTH) {0.9}
set ::env(FP_PDN_VOFFSET) 1
set ::env(FP_PDN_VPITCH) 5
set ::env(FP_PDN_VSPACING) 1.6
set ::env(FP_TAPCELL_DIST) 12
# set ::env(PDN_CFG) [glob $::env(DESIGN_DIR)/pdn.tcl]

## Placement 
set ::env(PL_RANDOM_GLB_PLACEMENT) 1
set ::env(PL_TARGET_DENSITY) 0.95
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0

## Routing 
set ::env(RT_MIN_LAYER) "met1"
set ::env(RT_MAX_LAYER) "met3"

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0

## Antenna 
set ::env(DIODE_INSERTION_STRATEGY) 3