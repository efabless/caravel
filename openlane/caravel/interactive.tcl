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

package require openlane
set script_dir [file dirname [file normalize [info script]]]
set save_path $script_dir/../..

# FOR LVS AND CREATING PORT LABELS
prep -design $script_dir -tag caravel_lvs -overwrite --verbose 2

set ::env(SYNTH_DEFINES) "USE_POWER_PINS"
verilog_elaborate
set ::env(CURRENT_SDC) $::env(BASE_SDC_FILE)
init_floorplan
file copy -force $::env(CURRENT_DEF) $::env(TMP_DIR)/lvs.def
file copy -force $::env(CURRENT_NETLIST) $::env(TMP_DIR)/lvs.v

# ACTUAL CHIP INTEGRATION
prep -design $script_dir -tag caravel -overwrite 

file copy $script_dir/runs/caravel_lvs/tmp/merged_unpadded.lef $::env(TMP_DIR)/lvs.lef
file copy $script_dir/runs/caravel_lvs/tmp/lvs.def $::env(TMP_DIR)/lvs.def
file copy $script_dir/runs/caravel_lvs/tmp/lvs.v $::env(TMP_DIR)/lvs.v

set ::env(SYNTH_DEFINES) "TOP_ROUTING"
verilog_elaborate
#logic_equiv_check -lhs $top_rtl -rhs $::env(yosys_result_file_tag).v

init_floorplan

set mprj_x 326.540
set mprj_y 1393.590

set soc_x 260.170
set soc_y 265.010
add_macro_placement padframe 0 0 N
add_macro_placement soc $soc_x $soc_y N
add_macro_placement housekeeping 3032.170 500.010 N
add_macro_placement mprj $mprj_x $mprj_y N
add_macro_placement mgmt_buffers 960.900 1160.180 N
# add_macro_placement mgmt_buffers 1060.850 1234.090 N
add_macro_placement rstb_level 708.550 235.440 S
add_macro_placement user_id_value 3283.120 440.630 N
add_macro_placement por 3250.730 234.721 MX
add_macro_placement pll 3140.730 404.721 N
add_macro_placement spare_logic\\\[0\\\] 443.16 1162.64 N
add_macro_placement spare_logic\\\[1\\\] 843.16 1162.64 N
add_macro_placement spare_logic\\\[2\\\] 3204.37 1102.96 N
add_macro_placement spare_logic\\\[3\\\] 2143.16 1162.64 N

add_macro_placement clocking 3133.820 316.420 N
#add_macro_placement clocking 1028.730 27.440 N
# west
set west_x 38.155
add_macro_placement "gpio_control_bidir_2\\\[2\\\]" $west_x 1013.000 R0
add_macro_placement "gpio_defaults_block_37" [expr $west_x + 3.6815559] [expr 1013.000 + 65] R0

add_macro_placement "gpio_control_bidir_2\\\[1\\\]" $west_x 1229.000 R0
add_macro_placement "gpio_defaults_block_36" [expr $west_x + 3.6815559] [expr 1229.000 + 65] R0

add_macro_placement "gpio_control_bidir_2\\\[0\\\]" $west_x 1445.000 R0
add_macro_placement "gpio_defaults_block_35" [expr $west_x + 3.6815559] [expr 1445.000 + 65] R0

add_macro_placement "gpio_control_in_2\\\[15\\\]" $west_x 1661.000 R0
add_macro_placement "gpio_defaults_block_34" [expr $west_x + 3.6815559] [expr 1661.000 + 65] R0

add_macro_placement "gpio_control_in_2\\\[14\\\]" $west_x 1877.000 R0
add_macro_placement "gpio_defaults_block_33" [expr $west_x + 3.6815559] [expr 1877.000 + 65] R0

add_macro_placement "gpio_control_in_2\\\[13\\\]" $west_x 2093.000 R0
add_macro_placement "gpio_defaults_block_32" [expr $west_x + 3.6815559] [expr 2093.000 + 65] R0

add_macro_placement "gpio_control_in_2\\\[12\\\]" $west_x 2731.000 R0
add_macro_placement "gpio_defaults_block_31" [expr $west_x + 3.6815559] [expr 2731.000 + 65] R0

add_macro_placement "gpio_control_in_2\\\[11\\\]" $west_x 2947.000 R0
add_macro_placement "gpio_defaults_block_30" [expr $west_x + 3.6815559] [expr 2947.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[10\\\]" $west_x 3163.000 R0
add_macro_placement "gpio_defaults_block_29" [expr $west_x + 3.6815559] [expr 3163.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[9\\\]" $west_x 3379.000 R0
add_macro_placement "gpio_defaults_block_28" [expr $west_x + 3.6815559] [expr 3379.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[8\\\]" $west_x 3595.000 R0
add_macro_placement "gpio_defaults_block_27" [expr $west_x + 3.6815559] [expr 3595.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[7\\\]" $west_x 3811.000 R0
add_macro_placement "gpio_defaults_block_26" [expr $west_x + 3.6815559] [expr 3811.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[6\\\]" $west_x 4027.000 R0
add_macro_placement "gpio_defaults_block_25" [expr $west_x + 3.6815559] [expr 4027.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[5\\\]" $west_x 4656.000 R0
add_macro_placement "gpio_defaults_block_24" [expr $west_x + 3.6815559] [expr 4656.000 + 65] R0

# north
set north_y 4980.385
add_macro_placement "gpio_control_in_2\\\[4\\\]" 486.000 $north_y R270
add_macro_placement "gpio_defaults_block_23" [expr 486.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_2\\\[3\\\]" 743.000 $north_y R270
add_macro_placement "gpio_defaults_block_22" [expr 743.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_2\\\[2\\\]" 1000.000 $north_y R270
add_macro_placement "gpio_defaults_block_21" [expr 1000.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_2\\\[1\\\]" 1257.000 $north_y R270
add_macro_placement "gpio_defaults_block_20" [expr 1257.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_2\\\[0\\\]" 1515.000 $north_y R270
add_macro_placement "gpio_defaults_block_19" [expr 1515.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_1\\\[10\\\]" 1767.000 $north_y R270
add_macro_placement "gpio_defaults_block_18" [expr 1767.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_1\\\[9\\\]" 2104.000 $north_y R270
add_macro_placement "gpio_defaults_block_17" [expr 2104.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_1\\\[8\\\]" 2489.000 $north_y R270
add_macro_placement "gpio_defaults_block_16" [expr 2489.00 + 64.968717] [expr $north_y + 136.3215974] R270
add_macro_placement "gpio_control_in_1\\\[7\\\]" 2746.000 $north_y R270
add_macro_placement "gpio_defaults_block_15" [expr 2746.00 + 64.968717] [expr $north_y + 136.3215974] R270

# east
set east_x 3381.015
add_macro_placement "gpio_defaults_block_0\\\[0\\\]" [expr $east_x+136.320042674] 670.000 FN
add_macro_placement "gpio_control_bidir_1\\\[0\\\]" $east_x 605.000 MY
add_macro_placement "gpio_defaults_block_0\\\[1\\\]" [expr $east_x+136.320042674] 896.000 FN
add_macro_placement "gpio_control_bidir_1\\\[1\\\]" $east_x 831.000 MY
add_macro_placement "gpio_defaults_block_2\\\[0\\\]" [expr $east_x+136.320042674] 1121.000 FN
add_macro_placement "gpio_control_in_1a\\\[0\\\]" $east_x 1056.000 MY
add_macro_placement "gpio_defaults_block_2\\\[1\\\]" [expr $east_x+136.320042674] 1347.000 FN
add_macro_placement "gpio_control_in_1a\\\[1\\\]" $east_x 1282.000 MY
add_macro_placement "gpio_defaults_block_2\\\[2\\\]" [expr $east_x+136.320042674] 1572.000 FN
add_macro_placement "gpio_control_in_1a\\\[2\\\]" $east_x 1507.000 MY
add_macro_placement "gpio_defaults_block_5" [expr $east_x+136.320042674] 1797.000 FN
add_macro_placement "gpio_control_in_1a\\\[3\\\]" $east_x 1732.000 MY
add_macro_placement "gpio_defaults_block_6" [expr $east_x+136.320042674] 2023.000 FN
add_macro_placement "gpio_control_in_1a\\\[4\\\]" $east_x 1958.000 MY
add_macro_placement "gpio_defaults_block_7" [expr $east_x+136.320042674] 2464.000 FN
add_macro_placement "gpio_control_in_1a\\\[5\\\]" $east_x 2399.000 MY
add_macro_placement "gpio_defaults_block_8" [expr $east_x+136.320042674] 2684.000 FN
add_macro_placement "gpio_control_in_1\\\[0\\\]" $east_x 2619.000 MY
add_macro_placement "gpio_defaults_block_9" [expr $east_x+136.320042674] 2909.000 FN
add_macro_placement "gpio_control_in_1\\\[1\\\]" $east_x 2844.000 MY
add_macro_placement "gpio_defaults_block_10" [expr $east_x+136.320042674] 3135.000 FN
add_macro_placement "gpio_control_in_1\\\[2\\\]" $east_x 3070.000 MY
add_macro_placement "gpio_defaults_block_11" [expr $east_x+136.320042674] [expr 3295.000+65] FN
add_macro_placement "gpio_control_in_1\\\[3\\\]" $east_x 3295.000 MY
add_macro_placement "gpio_defaults_block_12" [expr $east_x+136.320042674] [expr 3521.000+65] FN
add_macro_placement "gpio_control_in_1\\\[4\\\]" $east_x 3521.000 MY
add_macro_placement "gpio_defaults_block_13" [expr $east_x+136.320042674] [expr 3746.000+65] FN
add_macro_placement "gpio_control_in_1\\\[5\\\]" $east_x 3746.000 MY
add_macro_placement "gpio_defaults_block_14" [expr $east_x+136.320042674] [expr 4638.000+65] FN
add_macro_placement "gpio_control_in_1\\\[6\\\]" $east_x 4638.000 MY

manual_macro_placement f

# modify to a different file
remove_pins -input $::env(CURRENT_DEF)
remove_empty_nets -input $::env(CURRENT_DEF)

# add routing obstruction around the user_project_wrapper to prevent 
# having shorts with the core ring or signal routing inside the wrapper 
set gap 0.4 
set user_project_wrapper_obs [list [expr $mprj_x-$gap] [expr $mprj_y-$gap] [expr $mprj_x+$gap+2920] [expr $mprj_y+$gap+3520]]
set user_project_wrapper_core_ring_obs [list [expr $mprj_x-43.63] [expr $mprj_y-38.34] [expr $mprj_x+2963.25] [expr $mprj_y+$gap+3557.96]]

# add routing obstructions on the management area 
set mgmt_area_obs [list $soc_x $soc_y [expr $soc_x+2620] [expr $soc_y+820]]

set routing_vio_obs [list 106.26803 2098.54857 108.85254 2096.63000]

set ::env(GLB_RT_OBS)  " 
	met1 $user_project_wrapper_obs,\
	met2 $user_project_wrapper_obs,\
	met3 $user_project_wrapper_obs,\
	met4 $user_project_wrapper_core_ring_obs,\
	met4 $mgmt_area_obs,\
	met5 $user_project_wrapper_core_ring_obs,\
	met5 $mgmt_area_obs,\
    met3 $routing_vio_obs"

try_catch openroad -python $::env(SCRIPTS_DIR)/add_def_obstructions.py \
	--input-def $::env(CURRENT_DEF) \
	--lef $::env(MERGED_LEF) \
	--obstructions $::env(GLB_RT_OBS) \
	--output [file rootname $::env(CURRENT_DEF)].obs.def |& tee $::env(TERMINAL_OUTPUT) $::env(LOG_DIR)/obs.log

set_def [file rootname $::env(CURRENT_DEF)].obs.def

# add_macro_obs \
# 	-defFile $::env(CURRENT_DEF) \
# 	-lefFile $::env(MERGED_LEF_UNPADDED) \
# 	-obstruction vddio_obs \
# 	-placementX 103.400 \
# 	-placementY 607.150 \
# 	-sizeWidth 94.500 \
# 	-sizeHeight 30 \
# 	-fixed 1 \
# 	-layerNames "met2 met4"

# add_macro_obs \
# 	-defFile $::env(CURRENT_DEF) \
# 	-lefFile $::env(MERGED_LEF_UNPADDED) \
# 	-obstruction vddio_pad_obs \
# 	-placementX 33.375 \
# 	-placementY 557.100 \
# 	-sizeWidth 62.615 \
# 	-sizeHeight 62.700 \
# 	-fixed 1 \
# 	-layerNames "li1 met1 met2 met3 met4 met5"

li1_hack_start
save_state
puts "WARNING: Patching the def file $::env(CURRENT_DEF) with $script_dir/power_routing_def.patch"
puts "WARNING: this is a workaround that should be properly handled in the future"
puts "WARNING: this is for very specific versions"
exec patch $::env(CURRENT_DEF) < $script_dir/power_routing_def.patch
global_routing
detailed_routing
li1_hack_end

label_macro_pins\
	-lef $::env(TMP_DIR)/lvs.lef\
	-netlist_def $::env(TMP_DIR)/lvs.def
	# -extra_args {-v\
	# --map padframe vddio vddio INOUT\
	# --map padframe vssio vssio INOUT\
	# --map padframe vssa vssa INOUT\
	# --map padframe vccd vccd INOUT\
	# --map padframe vssd vssd INOUT}

run_magic

run_magic_spice_export

save_views       -lef_path $::env(magic_result_file_tag).lef \
                 -def_path $::env(tritonRoute_result_file_tag).def \
                 -gds_path $::env(magic_result_file_tag).gds \
                 -mag_path $::env(magic_result_file_tag).mag \
				 -verilog_path $::env(TMP_DIR)/lvs.v \
				 -spice_path $::env(magic_result_file_tag).spice \
                 -save_path $save_path \
                 -tag $::env(RUN_TAG)

run_lvs $::env(magic_result_file_tag).spice $::env(TMP_DIR)/lvs.v
