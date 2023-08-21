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
set ::env(USE_GPIO_ROUTING_LEF) 0
prep -design $script_dir -tag chip_io_lvs -overwrite

set ::env(SYNTH_DEFINES) ""
verilog_elaborate
#init_floorplan
#file copy -force $::env(CURRENT_DEF) $::env(TMP_DIR)/lvs.def
save_views -pnl_path $::env(CURRENT_NETLIST) -save_path $::env(CARAVEL_ROOT) 
exit

# ACTUAL CHIP INTEGRATION
set ::env(USE_GPIO_ROUTING_LEF) 1
prep -design $script_dir -tag chip_io -overwrite

#file copy $script_dir/runs/chip_io_lvs/tmp/merged_unpadded.lef $::env(TMP_DIR)/lvs.lef
#file copy $script_dir/runs/chip_io_lvs/tmp/lvs.def $::env(TMP_DIR)/lvs.def
file copy $script_dir/runs/chip_io_lvs/tmp/lvs.v $::env(TMP_DIR)/lvs.v

set ::env(SYNTH_DEFINES) "TOP_ROUTING"
verilog_elaborate

init_floorplan

puts_info "Generating pad frame"
exec python3 $::env(SCRIPTS_DIR)/padringer.py\
	--def-netlist $::env(CURRENT_DEF)\
	--design $::env(DESIGN_NAME)\
	--lefs $::env(TECH_LEF) {*}$::env(GPIO_PADS_LEF)\
	-cfg $script_dir/padframe.cfg\
	--working-dir $::env(TMP_DIR)\
	-o $::env(RESULTS_DIR)/floorplan/padframe.def |& tee $::env(TERMINAL_OUTPUT) $::env(LOG_DIR)/padringer.log

puts_info "Generated pad frame"

set_def $::env(RESULTS_DIR)/floorplan/padframe.def

# modify to a different file
remove_pins -input $::env(CURRENT_DEF)
remove_empty_nets -input $::env(CURRENT_DEF)

set core_obs "
	met1 225 235 3365 4950, \
	met2 225 235 3365 4950, \
	met3 225 235 3365 4950, \
	met4 225 235 3365 4955, \ 
	met5 225 235 3365 4955
"
set gpio_m3_pins_north "met3 469.965 4972.585 3200.4450 4988.785"

set gpio_m3_pins_west_0 "met3 198.400 1002.125 215.185 2202.125"

set gpio_m3_pins_west_1 "met3 198.400 2726.820 215.185 4126.82"

set gpio_m3_pins_west_2 "met3 198.400 4641.655 215.185 4755.305"

set gpio_m3_pins_east "met3 3370.840 600.050 3387.01 4731.99"

#set vssa_m3_east "met3 3387.79500 2102.44500 3390.02500 2130.06500"

#set vssa_m2_east  "met2 3387.67500 2128.50000 3388.00500 2152.50000"

set ::env(GLB_RT_OBS) "$core_obs"

set ::env(GLB_RT_OBS) "\
	$core_obs, \ 
	$gpio_m3_pins_north, \
	$gpio_m3_pins_west_0, \
	$gpio_m3_pins_west_1, \
	$gpio_m3_pins_west_2, \
	$gpio_m3_pins_east
"

try_catch python3 $::env(SCRIPTS_DIR)/add_def_obstructions.py \
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
	-pad_pin_name "PAD"

run_magic

# run_magic_drc

run_magic_spice_export

save_views       -lef_path $::env(magic_result_file_tag).lef \
                 -def_path $::env(CURRENT_DEF) \
                 -gds_path $::env(magic_result_file_tag).gds \
                 -mag_path $::env(magic_result_file_tag).mag \
                 -maglef_path $::env(magic_result_file_tag).lef.mag \
				 -verilog_path $::env(TMP_DIR)/lvs.v \
				 -spice_path $::env(magic_result_file_tag).spice \
                 -save_path $save_path \
                 -tag $::env(RUN_TAG)

run_lvs $::env(magic_result_file_tag).spice $::env(TMP_DIR)/lvs.v
