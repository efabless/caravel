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

## Config
set core_area_x 2920  
set core_area_y 3520

set analog_pin_size 25
lappend analog_pin_size 8.5

set clamp_pin_size 11
lappend clamp_pin_size 8.5

set power_pin_size 24
lappend power_pin_size 8.3

set pin_width 0.56
set pin_height 2.40
set pin_extension 4

set regular_pin_size $pin_width
lappend regular_pin_size [expr {$pin_height + $pin_extension}]

set power_pins {vdda1 vdda1_1 vdda1_2 vdda1_3 vdda2 vdda2_1 vssa1 vssa1_1 vssa1_2 vssa1_3 vssa2 vssa2_1 vccd1 vccd1_1 vccd2 vccd2_1 vssd1 vssd1_1 vssd2 vssd2_1}

## North Pins
set north_pins { io_analog[1] vssa1 vssa1_1 io_analog[2] io_analog[3] 
                 io_analog[4] io_clamp_high[0] io_clamp_low[0] io_analog_1_4 
                 io_analog[5] io_clamp_high[1] io_clamp_low[1] io_analog_1_5
                 io_analog[6] io_clamp_high[2] io_clamp_low[2] io_analog_1_6
                 io_analog[7] io_analog[8] io_analog[9] }

set offset_x 80.97
set min_distance 235
set clamp_min_distance 1.5
set io_5to4_distance 432
set io_4to3_distance 395.5

set spacing_list [list 0 235 235 202 1.5 1.5 1.5 182 1.5 1.5 1.5 $io_5to4_distance 1.5 1.5 1.5 $io_4to3_distance 235 201 26 206]

set i 0
foreach pin [lreverse $north_pins] {
    
    if  {[string match "io_clamp*" $pin]} {
        set pin_size $clamp_pin_size
    } elseif { $pin in $power_pins} { 
        set pin_size $power_pin_size
    } else {
        set pin_size $analog_pin_size
    }

    set loc_y [expr {$core_area_y - [lindex $pin_size 1] / 2.0}]

    if { $i==0 } { 
        set location [expr {$offset_x + [lindex $pin_size 0] / 2.0}]
    } else {
        set loc_x [expr {[lindex $prev_pin_size 0] / 2.0 + [lindex $pin_size 0] / 2.0 + [lindex $spacing_list $i] + [lindex $location 0]}]
        set location $loc_x
    }

    lappend location $loc_y
    puts $location
    place_pin -pin_name $pin -layer met3 -location $location -pin_size $pin_size
    set i [expr {$i + 1}]
    set prev_pin_size $pin_size
}

## East Pins
set east_pins { io_analog[0] 
                vccd1 vccd1_1
                io_oeb[13] io_out[13] io_in[13] io_in_3v3[13] gpio_noesd[6] gpio_analog[6] 
                vdda1_1 vdda1
                io_oeb[12] io_out[12] io_in[12] io_in_3v3[12] gpio_noesd[5] gpio_analog[5]  
                io_oeb[11] io_out[11] io_in[11] io_in_3v3[11] gpio_noesd[4] gpio_analog[4]  
                io_oeb[10] io_out[10] io_in[10] io_in_3v3[10] gpio_noesd[3] gpio_analog[3] 
                io_oeb[9]  io_out[9]  io_in[9]  io_in_3v3[9]  gpio_noesd[2] gpio_analog[2] 
                io_oeb[8]  io_out[8]  io_in[8]  io_in_3v3[8]  gpio_noesd[1] gpio_analog[1] 
                io_oeb[7]  io_out[7]  io_in[7]  io_in_3v3[7]  gpio_noesd[0] gpio_analog[0] 
                vdda1_2 vdda1_3
                vssd1   vssd1_1 
                vssa1_2 vssa1_3 
                io_oeb[6]  io_out[6]  io_in[6]  io_in_3v3[6]  
                io_oeb[5]  io_out[5]  io_in[5]  io_in_3v3[5]  
                io_oeb[4]  io_out[4]  io_in[4]  io_in_3v3[4]  
                io_oeb[3]  io_out[3]  io_in[3]  io_in_3v3[3]  
                io_oeb[2]  io_out[2]  io_in[2]  io_in_3v3[2]  
                io_oeb[1]  io_out[1]  io_in[1]  io_in_3v3[1] 
                io_oeb[0]  io_out[0]  io_in[0]  io_in_3v3[0]
}

set min_distance 5.35

set spacing_list " 0
                $min_distance $min_distance $min_distance $min_distance
                $min_distance $min_distance $min_distance $min_distance 
                $min_distance $min_distance $min_distance $min_distance 
                $min_distance $min_distance $min_distance $min_distance 
                $min_distance $min_distance $min_distance 114
                $min_distance $min_distance $min_distance 205 
                $min_distance $min_distance $min_distance 208 
                26 149 
                26 145 
                26 146 
                $min_distance $min_distance $min_distance $min_distance $min_distance 192 
                $min_distance $min_distance $min_distance $min_distance $min_distance 196
                $min_distance $min_distance $min_distance $min_distance $min_distance 202
                $min_distance $min_distance $min_distance $min_distance $min_distance 192
                $min_distance $min_distance $min_distance $min_distance $min_distance 192
                $min_distance $min_distance $min_distance $min_distance $min_distance 202 
                26 141
                $min_distance $min_distance $min_distance $min_distance $min_distance 201 
                26 167 "

set offset_y 8

set size $pin_height
lappend size $pin_width


set i 0
set location 0
lappend location $offset_y

foreach pin [lreverse $east_pins] {

    if  {[string match "io_analog*" $pin]} {
        set pin_size [lreverse $analog_pin_size]
        set loc_x [expr {$core_area_x - [lindex $pin_size 0] / 2.0 }]
    } elseif { $pin in $power_pins } {
        set pin_size [lreverse $power_pin_size]
        set loc_x [expr {$core_area_x - [lindex $pin_size 0] / 2.0 }]
    } else {
        set pin_size [lreverse $regular_pin_size]
        set loc_x [expr {$core_area_x - [lindex $pin_size 0] / 2.0 + $pin_extension}]
    }

    if {$i == 0} {
        set location $loc_x
        lappend location $offset_y
    } else {
        set loc_y [expr { [lindex $prev_pin_size 1] / 2.0 + [lindex $pin_size 1] / 2.0 + + [lindex $spacing_list $i] + [lindex $location 1]}]
        set location $loc_x
        lappend location $loc_y
    }
   
    place_pin -pin_name $pin -layer met3 -location $location -pin_size $pin_size
    set i [expr {$i + 1}]
    set prev_pin_size $pin_size    
}

## West Pins
set west_pins { 
    io_analog[10]
    vccd2 vccd2_1
    vssa2 vssa2_1
    gpio_analog[7]  gpio_noesd[7]  io_in_3v3[14] io_in[14] io_out[14] io_oeb[14] 
    gpio_analog[8]  gpio_noesd[8]  io_in_3v3[15] io_in[15] io_out[15] io_oeb[15] 
    gpio_analog[9]  gpio_noesd[9]  io_in_3v3[16] io_in[16] io_out[16] io_oeb[16] 
    gpio_analog[10] gpio_noesd[10] io_in_3v3[17] io_in[17] io_out[17] io_oeb[17] 
    gpio_analog[11] gpio_noesd[11] io_in_3v3[18] io_in[18] io_out[18] io_oeb[18] 
    gpio_analog[12] gpio_noesd[12] io_in_3v3[19] io_in[19] io_out[19] io_oeb[19] 
    gpio_analog[13] gpio_noesd[13] io_in_3v3[20] io_in[20] io_out[20] io_oeb[20] 
    vdda2_1 vdda2
    vssd2 vssd2_1
    gpio_analog[14] gpio_noesd[14] io_in_3v3[21] io_in[21] io_out[21] io_oeb[21] 
    gpio_analog[15] gpio_noesd[15] io_in_3v3[22] io_in[22] io_out[22] io_oeb[22]
    gpio_analog[16] gpio_noesd[16] io_in_3v3[23] io_in[23] io_out[23] io_oeb[23] 
    gpio_analog[17] gpio_noesd[17] io_in_3v3[24] io_in[24] io_out[24] io_oeb[24] 
                                   io_in_3v3[25] io_in[25] io_out[25] io_oeb[25] 
                                   io_in_3v3[26] io_in[26] io_out[26] io_oeb[26] 
}

set min_distance 5.35

set spacing_list " 0
                $min_distance $min_distance $min_distance $min_distance
                $min_distance $min_distance $min_distance $min_distance
                $min_distance $min_distance $min_distance $min_distance $min_distance 77
                $min_distance $min_distance $min_distance $min_distance $min_distance 186
                $min_distance $min_distance $min_distance $min_distance $min_distance 186
                $min_distance $min_distance $min_distance $min_distance $min_distance 190
                26 136
                26 134 
                $min_distance $min_distance $min_distance $min_distance $min_distance 185
                $min_distance $min_distance $min_distance $min_distance $min_distance 186
                $min_distance $min_distance $min_distance $min_distance $min_distance 186
                $min_distance $min_distance $min_distance $min_distance $min_distance 186
                $min_distance $min_distance $min_distance $min_distance $min_distance 186
                $min_distance $min_distance $min_distance $min_distance $min_distance 186
                $min_distance $min_distance $min_distance $min_distance $min_distance 189
                26 348
                26 158"

set offset_y 8
set size $pin_height
lappend size $pin_width


set i 0
foreach pin [lreverse $west_pins] {

    if  {[string match "io_analog*" $pin]} {
        set pin_size [lreverse $analog_pin_size]
        set loc_x [expr {[ lindex $pin_size 0] / 2.0 }]
    } elseif { $pin in $power_pins } {
        set pin_size [lreverse $power_pin_size]
        set loc_x [expr {[ lindex $pin_size 0] / 2.0 }]
    } else {
        set pin_size [lreverse $regular_pin_size]
        set loc_x [expr {[lindex $pin_size 0] / 2.0 - $pin_extension}]
    }

    if {$i == 0} {
        set location $loc_x
        lappend location $offset_y
    } else {
        set loc_y [expr { [lindex $prev_pin_size 1] / 2.0 + [lindex $pin_size 1] / 2.0 + [lindex $spacing_list $i] + [lindex $location 1]}]
        set location $loc_x
        lappend location $loc_y
    }
   
    place_pin -pin_name $pin -layer met3 -location $location -pin_size $pin_size
    set i [expr {$i + 1}]
    set prev_pin_size $pin_size   
}


## South Pins
set south_pins { wb_clk_i wb_rst_i wbs_ack_o wbs_cyc_i wbs_stb_i wbs_we_i wbs_adr_i[0] wbs_dat_i[0] wbs_dat_o[0] wbs_sel_i[0]  wbs_adr_i[1] wbs_dat_i[1] wbs_dat_o[1] wbs_sel_i[1] wbs_adr_i[2] wbs_dat_i[2] wbs_dat_o[2] wbs_sel_i[2] wbs_adr_i[3] wbs_dat_i[3] wbs_dat_o[3] wbs_sel_i[3] wbs_adr_i[4] wbs_dat_i[4] wbs_dat_o[4] wbs_adr_i[5] wbs_dat_i[5] wbs_dat_o[5] wbs_adr_i[6] wbs_dat_i[6] wbs_dat_o[6] wbs_adr_i[7] wbs_dat_i[7] wbs_dat_o[7] wbs_adr_i[8] wbs_dat_i[8] wbs_dat_o[8] wbs_adr_i[9] wbs_dat_i[9] wbs_dat_o[9] wbs_adr_i[10] wbs_dat_i[10] wbs_dat_o[10] wbs_adr_i[11] wbs_dat_i[11] wbs_dat_o[11] wbs_adr_i[12] wbs_dat_i[12] wbs_dat_o[12] wbs_adr_i[13] wbs_dat_i[13] wbs_dat_o[13] wbs_adr_i[14] wbs_dat_i[14] wbs_dat_o[14] wbs_adr_i[15] wbs_dat_i[15] wbs_dat_o[15] wbs_adr_i[16] wbs_dat_i[16] wbs_dat_o[16] wbs_adr_i[17] wbs_dat_i[17] wbs_dat_o[17] wbs_adr_i[18] wbs_dat_i[18] wbs_dat_o[18] wbs_adr_i[19] wbs_dat_i[19] wbs_dat_o[19] wbs_adr_i[20] wbs_dat_i[20] wbs_dat_o[20] wbs_adr_i[21] wbs_dat_i[21] wbs_dat_o[21] wbs_adr_i[22] wbs_dat_i[22] wbs_dat_o[22] wbs_adr_i[23] wbs_dat_i[23] wbs_dat_o[23] wbs_adr_i[24] wbs_dat_i[24] wbs_dat_o[24] wbs_adr_i[25] wbs_dat_i[25] wbs_dat_o[25] wbs_adr_i[26] wbs_dat_i[26] wbs_dat_o[26] wbs_adr_i[27] wbs_dat_i[27] wbs_dat_o[27] wbs_adr_i[28] wbs_dat_i[28] wbs_dat_o[28] wbs_adr_i[29] wbs_dat_i[29] wbs_dat_o[29] wbs_adr_i[30] wbs_dat_i[30] wbs_dat_o[30] wbs_adr_i[31] wbs_dat_i[31] wbs_dat_o[31] la_data_in[0] la_data_out[0] la_oenb[0] la_data_in[1] la_data_out[1] la_oenb[1] la_data_in[2] la_data_out[2] la_oenb[2] la_data_in[3] la_data_out[3] la_oenb[3] la_data_in[4] la_data_out[4] la_oenb[4] la_data_in[5] la_data_out[5] la_oenb[5] la_data_in[6] la_data_out[6] la_oenb[6] la_data_in[7] la_data_out[7] la_oenb[7] la_data_in[8] la_data_out[8] la_oenb[8] la_data_in[9] la_data_out[9] la_oenb[9] la_data_in[10] la_data_out[10] la_oenb[10] la_data_in[11] la_data_out[11] la_oenb[11] la_data_in[12] la_data_out[12] la_oenb[12] la_data_in[13] la_data_out[13] la_oenb[13] la_data_in[14] la_data_out[14] la_oenb[14] la_data_in[15] la_data_out[15] la_oenb[15] la_data_in[16] la_data_out[16] la_oenb[16] la_data_in[17] la_data_out[17] la_oenb[17] la_data_in[18] la_data_out[18] la_oenb[18] la_data_in[19] la_data_out[19] la_oenb[19] la_data_in[20] la_data_out[20] la_oenb[20] la_data_in[21] la_data_out[21] la_oenb[21] la_data_in[22] la_data_out[22] la_oenb[22] la_data_in[23] la_data_out[23] la_oenb[23] la_data_in[24] la_data_out[24] la_oenb[24] la_data_in[25] la_data_out[25] la_oenb[25] la_data_in[26] la_data_out[26] la_oenb[26] la_data_in[27] la_data_out[27] la_oenb[27] la_data_in[28] la_data_out[28] la_oenb[28] la_data_in[29] la_data_out[29] la_oenb[29] la_data_in[30] la_data_out[30] la_oenb[30] la_data_in[31] la_data_out[31] la_oenb[31] la_data_in[32] la_data_out[32] la_oenb[32] la_data_in[33] la_data_out[33] la_oenb[33] la_data_in[34] la_data_out[34] la_oenb[34] la_data_in[35] la_data_out[35] la_oenb[35] la_data_in[36] la_data_out[36] la_oenb[36] la_data_in[37] la_data_out[37] la_oenb[37] la_data_in[38] la_data_out[38] la_oenb[38] la_data_in[39] la_data_out[39] la_oenb[39] la_data_in[40] la_data_out[40] la_oenb[40] la_data_in[41] la_data_out[41] la_oenb[41] la_data_in[42] la_data_out[42] la_oenb[42] la_data_in[43] la_data_out[43] la_oenb[43] la_data_in[44] la_data_out[44] la_oenb[44] la_data_in[45] la_data_out[45] la_oenb[45] la_data_in[46] la_data_out[46] la_oenb[46] la_data_in[47] la_data_out[47] la_oenb[47] la_data_in[48] la_data_out[48] la_oenb[48] la_data_in[49] la_data_out[49] la_oenb[49] la_data_in[50] la_data_out[50] la_oenb[50] la_data_in[51] la_data_out[51] la_oenb[51] la_data_in[52] la_data_out[52] la_oenb[52] la_data_in[53] la_data_out[53] la_oenb[53] la_data_in[54] la_data_out[54] la_oenb[54] la_data_in[55] la_data_out[55] la_oenb[55] la_data_in[56] la_data_out[56] la_oenb[56] la_data_in[57] la_data_out[57] la_oenb[57] la_data_in[58] la_data_out[58] la_oenb[58] la_data_in[59] la_data_out[59] la_oenb[59] la_data_in[60] la_data_out[60] la_oenb[60] la_data_in[61] la_data_out[61] la_oenb[61] la_data_in[62] la_data_out[62] la_oenb[62] la_data_in[63] la_data_out[63] la_oenb[63] la_data_in[64] la_data_out[64] la_oenb[64] la_data_in[65] la_data_out[65] la_oenb[65] la_data_in[66] la_data_out[66] la_oenb[66] la_data_in[67] la_data_out[67] la_oenb[67] la_data_in[68] la_data_out[68] la_oenb[68] la_data_in[69] la_data_out[69] la_oenb[69] la_data_in[70] la_data_out[70] la_oenb[70] la_data_in[71] la_data_out[71] la_oenb[71] la_data_in[72] la_data_out[72] la_oenb[72] la_data_in[73] la_data_out[73] la_oenb[73] la_data_in[74] la_data_out[74] la_oenb[74] la_data_in[75] la_data_out[75] la_oenb[75] la_data_in[76] la_data_out[76] la_oenb[76] la_data_in[77] la_data_out[77] la_oenb[77] la_data_in[78] la_data_out[78] la_oenb[78] la_data_in[79] la_data_out[79] la_oenb[79] la_data_in[80] la_data_out[80] la_oenb[80] la_data_in[81] la_data_out[81] la_oenb[81] la_data_in[82] la_data_out[82] la_oenb[82] la_data_in[83] la_data_out[83] la_oenb[83] la_data_in[84] la_data_out[84] la_oenb[84] la_data_in[85] la_data_out[85] la_oenb[85] la_data_in[86] la_data_out[86] la_oenb[86] la_data_in[87] la_data_out[87] la_oenb[87] la_data_in[88] la_data_out[88] la_oenb[88] la_data_in[89] la_data_out[89] la_oenb[89] la_data_in[90] la_data_out[90] la_oenb[90] la_data_in[91] la_data_out[91] la_oenb[91] la_data_in[92] la_data_out[92] la_oenb[92] la_data_in[93] la_data_out[93] la_oenb[93] la_data_in[94] la_data_out[94] la_oenb[94] la_data_in[95] la_data_out[95] la_oenb[95] la_data_in[96] la_data_out[96] la_oenb[96] la_data_in[97] la_data_out[97] la_oenb[97] la_data_in[98] la_data_out[98] la_oenb[98] la_data_in[99] la_data_out[99] la_oenb[99] la_data_in[100] la_data_out[100] la_oenb[100] la_data_in[101] la_data_out[101] la_oenb[101] la_data_in[102] la_data_out[102] la_oenb[102] la_data_in[103] la_data_out[103] la_oenb[103] la_data_in[104] la_data_out[104] la_oenb[104] la_data_in[105] la_data_out[105] la_oenb[105] la_data_in[106] la_data_out[106] la_oenb[106] la_data_in[107] la_data_out[107] la_oenb[107] la_data_in[108] la_data_out[108] la_oenb[108] la_data_in[109] la_data_out[109] la_oenb[109] la_data_in[110] la_data_out[110] la_oenb[110] la_data_in[111] la_data_out[111] la_oenb[111] la_data_in[112] la_data_out[112] la_oenb[112] la_data_in[113] la_data_out[113] la_oenb[113] la_data_in[114] la_data_out[114] la_oenb[114] la_data_in[115] la_data_out[115] la_oenb[115] la_data_in[116] la_data_out[116] la_oenb[116] la_data_in[117] la_data_out[117] la_oenb[117] la_data_in[118] la_data_out[118] la_oenb[118] la_data_in[119] la_data_out[119] la_oenb[119] la_data_in[120] la_data_out[120] la_oenb[120] la_data_in[121] la_data_out[121] la_oenb[121] la_data_in[122] la_data_out[122] la_oenb[122] la_data_in[123] la_data_out[123] la_oenb[123] la_data_in[124] la_data_out[124] la_oenb[124] la_data_in[125] la_data_out[125] la_oenb[125] la_data_in[126] la_data_out[126] la_oenb[126] la_data_in[127] la_data_out[127] la_oenb[127] user_clock2 user_irq[0] user_irq[1] user_irq[2] }
set min_distance 5.35
set offset_x 2.9

set size $pin_width
lappend size [expr {$pin_height + $pin_extension}]

set i 0
foreach pin $south_pins {
    if {$i == 0} {
        set location $offset_x
    } else {
        set location [expr {[lindex $location 0] + $min_distance + $pin_width}]
    }
    lappend location [expr {$pin_height / 2.0 - $pin_extension / 2.0}]
    puts $location
    place_pin -pin_name $pin -layer met2 -location $location -pin_size $size
    set i [expr {$i + 1}]
}

write_def $::env(SAVE_DEF)