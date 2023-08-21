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
prep -design $script_dir -tag chip_io_alt_lvs -overwrite

# Needed for the sky130_ef_io__analog_pad verilog views
set ::env(SYNTH_DEFINES) "USE_POWER_PINS"
verilog_elaborate
#init_floorplan
#file copy -force $::env(CURRENT_DEF) $::env(TMP_DIR)/lvs.def
#file copy -force $::env(CURRENT_NETLIST) $::env(TMP_DIR)/lvs.v

# ACTUAL CHIP INTEGRATION
set ::env(USE_GPIO_ROUTING_LEF) 1
prep -design $script_dir -tag chip_io_alt -overwrite

# file copy $script_dir/runs/chip_io_alt_lvs/tmp/merged_unpadded.lef $::env(TMP_DIR)/lvs.lef
# file copy $script_dir/runs/chip_io_alt_lvs/tmp/lvs.def $::env(TMP_DIR)/lvs.def
# file copy $script_dir/runs/chip_io_alt_lvs/tmp/lvs.v $::env(TMP_DIR)/lvs.v

set ::env(SYNTH_DEFINES) "TOP_ROUTING USE_POWER_PINS"
verilog_elaborate

#init_floorplan

puts_info "Generating pad frame"
exec python3 $::env(SCRIPTS_DIR)/padringer.py\
	--def-netlist $::env(CURRENT_DEF)\
	--design $::env(DESIGN_NAME)\
	--lefs $::env(TECH_LEF) {*}$::env(GPIO_PADS_LEF)\
	-cfg $script_dir/padframe.cfg\
	--working-dir $::env(TMP_DIR)\
	-o $::env(RESULTS_DIR)/floorplan/padframe.def   2>&1
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

set gpio_m3_pins_west_0 "met3 198.400 1002.125 215.185 2202.125"

set gpio_m3_pins_west_1 "met3 198.400 2726.820 215.185 4126.82"

set gpio_m3_pins_west_2 "met3 198.400 4641.655 215.185 4755.305"

set gpio_m3_pins_east "met3 3370.840 600.050 3387.01 4731.99"

# South Power Pads
set vssa_south_obs "
	met3 393.99000 198.45500 468.60000 222.76000"

set vssd_south_obs "
	met3 1205.66500 196.21000 1280.500 276.98500"

set vssio_south_obs "
	met3 2845.04000 198.49500 2919.58500 230.61000"

# East Power Pads
set vssa1_p2_east_obs "
	met3 3317.33500 2040.81500 3389.89500 2117.49500"

set vssd1_east_obs "
	met3 3316.26500 2285.19500 3379.17500 2385.12500, \
	met4 3316.26500 2285.19500 3379.17500 2385.12500"

set vdda1_p2_east_obs "
	met3 3338.51500 2474.03500 3389.27500 2550.56000, \
	met4 3338.51500 2474.03500 3389.27500 2550.5600"

set vdda1_east_obs "
	met3 3340.13500 4017.53500 3385.45000 4094.53500"


set ::env(GLB_RT_OBS) "
	$core_obs, \ 
	$gpio_m3_pins_west_0, \
	$gpio_m3_pins_west_1, \
	$gpio_m3_pins_west_2, \
	$gpio_m3_pins_east, \
	$vssd_south_obs, \
	$vssio_south_obs, \
	$vssd1_east_obs, \
	$vdda1_p2_east_obs, \
	$vdda1_east_obs
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

calc_total_runtime
generate_final_summary_report