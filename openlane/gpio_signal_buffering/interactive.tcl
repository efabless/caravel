# SPDX-FileCopyrightText: 2022 Efabless Corporation
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
prep -design $script_dir -tag gpio_signal_buffering_lvs -overwrite

verilog_elaborate -log $::env(synthesis_logs)/synthesis.log
#init_floorplan
#file copy -force $::env(CURRENT_DEF) $::env(TMP_DIR)/lvs.def
save_views -pnl_path $::env(CURRENT_NETLIST) -save_path $::env(CARAVEL_ROOT) 
exit
