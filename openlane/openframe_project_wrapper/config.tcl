# SPDX-FileCopyrightText: 2023 Efabless Corporation
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


set ::env(DESIGN_NAME) openframe_project_wrapper

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
    $::env(DESIGN_DIR)/../../verilog/rtl/__openframe_project_wrapper.v
"

set ::env(VERILOG_FILES_BLACKBOX) "
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v
	$::env(DESIGN_DIR)/openframe_example-bbox.v
"
set ::env(SYNTH_DEFINES) "USE_POWER_PINS OPENFRAME_TESTING"
