# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License"),
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
prep -design $script_dir -tag caravan_lvs -overwrite

set ::env(SYNTH_DEFINES) "USE_POWER_PINS"
verilog_elaborate
init_floorplan
file copy -force $::env(CURRENT_DEF) $::env(TMP_DIR)/lvs.def
file copy -force $::env(CURRENT_NETLIST) $::env(TMP_DIR)/lvs.v

# ACTUAL CHIP INTEGRATION
set date [exec date "+%d_%m_%y_%H_%M"]
set tag caravan_${date}
prep -design $script_dir -tag $tag -overwrite
exec rm -rf $script_dir/runs/final
exec ln -sf $script_dir/runs/$tag $script_dir/runs/final

file copy $script_dir/runs/caravan_lvs/tmp/merged_unpadded.lef $::env(TMP_DIR)/lvs.lef
file copy $script_dir/runs/caravan_lvs/tmp/lvs.def $::env(TMP_DIR)/lvs.def
file copy $script_dir/runs/caravan_lvs/tmp/lvs.v $::env(TMP_DIR)/lvs.v

set ::env(SYNTH_DEFINES) "TOP_ROUTING"
verilog_elaborate
#logic_equiv_check -lhs $top_rtl -rhs $::env(yosys_result_file_tag).v

init_floorplan

set mprj_x 326.540
set mprj_y 1393.590


set soc_x 260.170
set soc_y 265.010

add_macro_placement caravan_power_routing 0 0 N
add_macro_placement sigbuf 0 0 N
#add_macro_placement flash_clkrst_buffers 2292 238 N
add_macro_placement padframe 0 0 N
add_macro_placement soc $soc_x $soc_y N
add_macro_placement housekeeping 2962.17 500.010 N
add_macro_placement mprj $mprj_x $mprj_y N
add_macro_placement mgmt_buffers 640.900 1160.180 N
# add_macro_placement mgmt_buffers 1060.850 1234.090 N
add_macro_placement rstb_level 708.550 235.440 S
add_macro_placement user_id_value 3283.120 440.630 N
add_macro_placement por 3250.730 234.721 MX
add_macro_placement pll 3140.730 404.721 N

add_macro_placement clock_ctrl 3133.820 276.420 N

add_macro_placement spare_logic\\\[0\\\] 443.16 1162.64 N
add_macro_placement spare_logic\\\[1\\\] 543.16 1162.64 N
add_macro_placement spare_logic\\\[2\\\] 3204.37 1102.96 N
add_macro_placement spare_logic\\\[3\\\] 2893.16 1162.64 N


# west
set west_x 38.155
add_macro_placement "gpio_defaults_block_37" [expr $west_x + 3.6815559] [expr 1013.000 + 65] R0
add_macro_placement "gpio_control_bidir_2\\\[2\\\]" $west_x 1013.000 R0

add_macro_placement "gpio_defaults_block_36" [expr $west_x + 3.6815559] [expr 1229.000 + 65] R0
add_macro_placement "gpio_control_bidir_2\\\[1\\\]" $west_x 1229.000 R0

add_macro_placement "gpio_defaults_block_35" [expr $west_x + 3.6815559] [expr 1445.000 + 65] R0
add_macro_placement "gpio_control_bidir_2\\\[0\\\]" $west_x 1445.000 R0

add_macro_placement "gpio_defaults_block_34" [expr $west_x + 3.6815559] [expr 1661.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[9\\\]" $west_x 1661.000 R0

add_macro_placement "gpio_defaults_block_33" [expr $west_x + 3.6815559] [expr 1877.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[8\\\]" $west_x 1877.000 R0

add_macro_placement "gpio_defaults_block_32" [expr $west_x + 3.6815559] [expr 2093.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[7\\\]" $west_x 2093.000 R0

add_macro_placement "gpio_defaults_block_31" [expr $west_x + 3.6815559] [expr 2731.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[6\\\]" $west_x 2731.000 R0

add_macro_placement "gpio_defaults_block_30" [expr $west_x + 3.6815559] [expr 2947.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[5\\\]" $west_x 2947.000 R0

add_macro_placement "gpio_defaults_block_29" [expr $west_x + 3.6815559] [expr 3163.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[4\\\]" $west_x 3163.000 R0

add_macro_placement "gpio_defaults_block_28" [expr $west_x + 3.6815559] [expr 3379.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[3\\\]" $west_x 3379.000 R0

add_macro_placement "gpio_defaults_block_27" [expr $west_x + 3.6815559] [expr 3595.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[2\\\]" $west_x 3595.000 R0

add_macro_placement "gpio_defaults_block_26" [expr $west_x + 3.6815559] [expr 3811.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[1\\\]" $west_x 3811.000 R0

add_macro_placement "gpio_defaults_block_25" [expr $west_x + 3.6815559] [expr 4027.000 + 65] R0
add_macro_placement "gpio_control_in_2\\\[0\\\]" $west_x 4027.000 R0

# east
set east_x 3381.015

add_macro_placement "gpio_defaults_block_0" [expr $east_x+136.320042674] [expr 605 + 65] FN
add_macro_placement "gpio_control_bidir_1\\\[0\\\]" $east_x 605.000 MY

add_macro_placement "gpio_defaults_block_1" [expr $east_x+136.320042674] [expr 831 + 65] FN
add_macro_placement "gpio_control_bidir_1\\\[1\\\]" $east_x 831.000 MY

add_macro_placement "gpio_defaults_block_2" [expr $east_x+136.320042674] [expr 1056 + 65] FN
add_macro_placement "gpio_control_in_1a\\\[0\\\]" $east_x 1056.000 MY

add_macro_placement "gpio_defaults_block_3" [expr $east_x+136.320042674] [expr 1282 + 65] FN
add_macro_placement "gpio_control_in_1a\\\[1\\\]" $east_x 1282.000 MY

add_macro_placement "gpio_defaults_block_4" [expr $east_x+136.320042674] [expr 1507 + 65] FN
add_macro_placement "gpio_control_in_1a\\\[2\\\]" $east_x 1507.000 MY

add_macro_placement "gpio_defaults_block_5" [expr $east_x+136.320042674] [expr 1732 + 65] FN
add_macro_placement "gpio_control_in_1a\\\[3\\\]" $east_x 1732.000 MY

add_macro_placement "gpio_defaults_block_6" [expr $east_x+136.320042674] [expr 1958 + 65] FN
add_macro_placement "gpio_control_in_1a\\\[4\\\]" $east_x 1958.000 MY

add_macro_placement "gpio_defaults_block_7" [expr $east_x+136.320042674] [expr 2399 + 65] FN
add_macro_placement "gpio_control_in_1a\\\[5\\\]" $east_x 2399.000 MY

add_macro_placement "gpio_defaults_block_8" [expr $east_x+136.320042674] [expr 2619 + 65] FN
add_macro_placement "gpio_control_in_1\\\[0\\\]" $east_x 2619.000 MY

add_macro_placement "gpio_defaults_block_9" [expr $east_x+136.320042674] [expr 2844 + 65] FN
add_macro_placement "gpio_control_in_1\\\[1\\\]" $east_x 2844.000 MY

add_macro_placement "gpio_defaults_block_10" [expr $east_x+136.320042674] [expr 3070 + 65] FN
add_macro_placement "gpio_control_in_1\\\[2\\\]" $east_x 3070.000 MY

add_macro_placement "gpio_defaults_block_11" [expr $east_x+136.320042674] [expr 3295 + 65] FN
add_macro_placement "gpio_control_in_1\\\[3\\\]" $east_x 3295.000 MY

add_macro_placement "gpio_defaults_block_12" [expr $east_x+136.320042674] [expr 3521 + 65] FN
add_macro_placement "gpio_control_in_1\\\[4\\\]" $east_x 3521.000 MY

add_macro_placement "gpio_defaults_block_13" [expr $east_x+136.320042674] [expr 4424.000 +  65] FN
add_macro_placement "gpio_control_in_1\\\[5\\\]" $east_x 4424.000 MY

manual_macro_placement f

# modify to a different file
remove_pins -input $::env(CURRENT_DEF)
remove_empty_nets -input $::env(CURRENT_DEF)

set wrapper_obs "
	met1 326.540 1393.590 3246.54 4913.59, \
	met2 326.540 1393.590 3246.54 4913.59, \
	met3 326.540 1393.590 3246.54 4913.59, \
	met4 326.540 1393.590 3246.54 4913.59, \
	met5 326.540 1393.590 3246.54 4913.59"

set vssd_south_obs "
	met3 1193.19500 198.81000 1281.85000 270.56500, \
	met4 1193.19500 198.81000 1281.85000 270.56500"

set m4_south_obs " 
	met4 934.51500 203.43000 3370.33500 271.49000, \
	met4 721.82000 264.80000 950.71500 1226.04000"

set vssa1_p2_east_obs "
	met4 3262.79500	2076.55000 3262.79500 2151.63000, \
	met3 3262.79500	2076.55000 3262.79500 2151.63000"

set vssd1_east_obs "
	met3 3269.73000	2281.14500 3269.73000 2379.18000, \
	met4 3269.73000	2281.14500 3269.73000 2379.18000"


# add routing obstructions on the management area 
set mgmt_area_obs [list $soc_x $soc_y [expr $soc_x+2620] [expr $soc_y+820]]

set ::env(GLB_RT_OBS) "\
	met4 $mgmt_area_obs,\
	met5 $mgmt_area_obs,\
	$wrapper_obs"

try_catch openroad -python $::env(SCRIPTS_DIR)/add_def_obstructions.py \
	--input-def $::env(CURRENT_DEF) \
	--lef $::env(MERGED_LEF) \
	--obstructions $::env(GLB_RT_OBS) \
	--output [file rootname $::env(CURRENT_DEF)].obs.def |& tee $::env(TERMINAL_OUTPUT) $::env(LOG_DIR)/obs.log

set_def [file rootname $::env(CURRENT_DEF)].obs.def

li1_hack_start
global_routing
detailed_routing
li1_hack_end

label_macro_pins\
	-lef $::env(TMP_DIR)/lvs.lef\
	-netlist_def $::env(TMP_DIR)/lvs.def\
	-extra_args {-v\
	--map padframe vddio_pad vddio INOUT\
	--map padframe vssio_pad vssio INOUT\
	--map padframe vssa_pad vssa INOUT\
	--map padframe vccd_pad vccd INOUT\
	--map padframe vssd_pad vssd INOUT}

run_magic

save_views\
    -def_path $::env(tritonRoute_result_file_tag).def \
    -gds_path $::env(magic_result_file_tag).gds \
    -mag_path $::env(magic_result_file_tag).mag \
    -verilog_path $::env(TMP_DIR)/lvs.v \
    -save_path $save_path \
    -tag caravan

exit

