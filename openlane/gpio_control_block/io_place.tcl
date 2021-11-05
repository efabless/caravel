# Copyright 2020 Efabless Corporation
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

## Needs OpenRoad Commit: 29db63fdda643f01d5a7705606a96681ab855a68

if {[catch {read_lef $::env(MERGED_LEF)} errmsg]} {
    puts stderr $errmsg
    exit 1
}

if {[catch {read_def $::env(CURRENT_DEF)} errmsg]} {
    puts stderr $errmsg
	exit 1
}

ppl::set_hor_length $::env(FP_IO_HLENGTH)
ppl::set_ver_length $::env(FP_IO_VLENGTH)
ppl::set_hor_length_extend $::env(FP_IO_VEXTEND)
ppl::set_ver_length_extend $::env(FP_IO_HEXTEND)
ppl::set_ver_thick_multiplier $::env(FP_IO_VTHICKNESS_MULT)
ppl::set_hor_thick_multiplier $::env(FP_IO_HTHICKNESS_MULT)

set tech [[ord::get_db] getTech]
set HMETAL [[$tech findRoutingLayer $::env(FP_IO_HMETAL)] getName]
set VMETAL [[$tech findRoutingLayer $::env(FP_IO_VMETAL)] getName]

# East pins
set_io_pin_constraint -pin_names {user_gpio_out} -region right:60-62
set_io_pin_constraint -pin_names {user_gpio_oeb} -region right:58-60
set_io_pin_constraint -pin_names {user_gpio_in} -region right:56-58
set_io_pin_constraint -pin_names {serial_load_out} -region right:54-56
set_io_pin_constraint -pin_names {serial_load} -region right:52-54
set_io_pin_constraint -pin_names {serial_data_out} -region right:50-52
set_io_pin_constraint -pin_names {serial_data_in} -region right:48-50
set_io_pin_constraint -pin_names {serial_clock_out} -region right:46-48
set_io_pin_constraint -pin_names {serial_clock} -region right:44-46
set_io_pin_constraint -pin_names {resetn_out} -region right:42-44
set_io_pin_constraint -pin_names {resetn} -region right:40-42
set_io_pin_constraint -pin_names {pad_gpio_vtrip_sel} -region right:38-40
set_io_pin_constraint -pin_names {pad_gpio_slow_sel} -region right:36-38
set_io_pin_constraint -pin_names {pad_gpio_outenb} -region right:34-36
set_io_pin_constraint -pin_names {pad_gpio_out} -region right:32-34
set_io_pin_constraint -pin_names {pad_gpio_inenb} -region right:30-32
set_io_pin_constraint -pin_names {pad_gpio_in} -region right:28-30
set_io_pin_constraint -pin_names {pad_gpio_ib_mode_sel} -region right:26-28
set_io_pin_constraint -pin_names {pad_gpio_holdover} -region right:24-26
set_io_pin_constraint -pin_names {pad_gpio_dm[2]} -region right:22-24
set_io_pin_constraint -pin_names {pad_gpio_dm[1]} -region right:20-22
set_io_pin_constraint -pin_names {pad_gpio_dm[0]} -region right:18-20
set_io_pin_constraint -pin_names {pad_gpio_ana_sel} -region right:16-18
set_io_pin_constraint -pin_names {pad_gpio_ana_pol} -region right:14-16
set_io_pin_constraint -pin_names {pad_gpio_ana_en} -region right:12-14
set_io_pin_constraint -pin_names {mgmt_gpio_out} -region right:10-12
set_io_pin_constraint -pin_names {mgmt_gpio_oeb} -region right:8-10
set_io_pin_constraint -pin_names {mgmt_gpio_in} -region right:6-8
set_io_pin_constraint -pin_names {one} -region right:4-6
set_io_pin_constraint -pin_names {zero} -region right:2-4

# North pins
set_io_pin_constraint -pin_names {gpio_defaults[0]} -region top:4-6
set_io_pin_constraint -pin_names {gpio_defaults[1]} -region top:6-8
set_io_pin_constraint -pin_names {gpio_defaults[2]} -region top:8-10
set_io_pin_constraint -pin_names {gpio_defaults[3]} -region top:10-12
set_io_pin_constraint -pin_names {gpio_defaults[4]} -region top:12-15
set_io_pin_constraint -pin_names {gpio_defaults[5]} -region top:15-17
set_io_pin_constraint -pin_names {gpio_defaults[6]} -region top:17-19
set_io_pin_constraint -pin_names {gpio_defaults[7]} -region top:19-21
set_io_pin_constraint -pin_names {gpio_defaults[8]} -region top:21-24
set_io_pin_constraint -pin_names {gpio_defaults[9]} -region top:24-26
set_io_pin_constraint -pin_names {gpio_defaults[10]} -region top:26-28
set_io_pin_constraint -pin_names {gpio_defaults[11]} -region top:28-31
set_io_pin_constraint -pin_names {gpio_defaults[12]} -region top:31-33

place_pins -min_distance 2 -hor_layers $HMETAL -ver_layers $VMETAL -exclude left:* -exclude bottom:* 


write_def $::env(SAVE_DEF)
