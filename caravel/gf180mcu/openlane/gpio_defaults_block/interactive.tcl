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
set save_path $::env(CARAVEL_ROOT)

# FOR LVS AND CREATING PORT LABELS
#
prep -design $script_dir -tag $::env(OPENLANE_RUN_TAG) -overwrite
set ::env(SYNTH_DEFINES) "USE_POWER_PINS"
verilog_elaborate

exec rm -rf $script_dir/runs/final
exec ln -sf $script_dir/runs/$::env(OPENLANE_RUN_TAG) $script_dir/runs/final

save_views \
    -pnl_path $script_dir/runs/$::env(RUN_TAG)/results/synthesis/gpio_defaults_block.v \
    -save_path $save_path

