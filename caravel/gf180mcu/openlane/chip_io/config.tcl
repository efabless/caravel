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

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) chip_io

set verilog_root $::env(CARAVEL_ROOT)/verilog/


# Change if needed
set ::env(VERILOG_FILES) "\
    $verilog_root/rtl/user_defines.v \
    $verilog_root/rtl/defines.v \
    $verilog_root/rtl/chip_io.v \
"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1
# specific to gf180
set ::env(EXTRA_LIBS) "$::env(PDK_ROOT)/$::env(PDK)/libs.ref/gf180mcu_fd_io/liberty/gf180mcu_fd_io__tt_025C_3v30.lib"
