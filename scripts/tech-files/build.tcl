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

cd $::env(CARAVEL_ROOT)/mag
random seed `$::env(CARAVEL_ROOT)/scripts/set_user_id.py -report`;
drc off;
crashbackups stop;
addpath hexdigits;
addpath $::env(CARAVEL_ROOT)/mag;
addpath $::env(MCW_ROOT)/mag;
load RAM128;
load RAM256;
load mgmt_core_wrapper -dereference;
property LEFview true;
property GDS_FILE $::env(MCW_ROOT)/gds/mgmt_core_wrapper.gds;
property GDS_START 0;
gds read $::env(CARAVEL_ROOT)/gds/caravel_power_routing.gds;
load user_project_wrapper;
load user_id_programming;
load user_id_textblock;
load $::env(CARAVEL_ROOT)/maglef/simple_por;
load caravel -dereference;
select top cell;
expand;
cif *hier write disable;
cif *array write disable;
gds write $::env(CARAVEL_ROOT)/gds/caravel.gds;
quit -noprompt;
