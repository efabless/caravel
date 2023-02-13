# Copyright 2020-2022 Efabless Corporation
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

source $::env(SCRIPTS_DIR)/openroad/common/set_global_connections.tcl
set_global_connections

set secondary []
foreach vdd $::env(VDD_NETS) gnd $::env(GND_NETS) {
    if { $vdd != $::env(VDD_NET)} {
        lappend secondary $vdd

        set db_net [[ord::get_db_block] findNet $vdd]
        if {$db_net == "NULL"} {
            set net [odb::dbNet_create [ord::get_db_block] $vdd]
            $net setSpecial
            $net setSigType "POWER"
        }
    }

    if { $gnd != $::env(GND_NET)} {
        lappend secondary $gnd

        set db_net [[ord::get_db_block] findNet $gnd]
        if {$db_net == "NULL"} {
            set net [odb::dbNet_create [ord::get_db_block] $gnd]
            $net setSpecial
            $net setSigType "GROUND"
        }
    }
}

set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET) \
    -secondary_power $secondary

    define_pdn_grid \
        -name stdcell_grid \
        -starts_with POWER \
        -voltage_domain CORE \
        -pins "$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)"

####  core ring   ####
add_pdn_stripe \
    -grid stdcell_grid \
    -layer met4 \
    -width 5 \
    -pitch 120 \
    -offset 3.3 \
    -spacing 1 \
    -number_of_straps 1 \
    -nets "vccd vssd vccd1 vssd1 vssa2 vdda2 vssa1 vdda1 vssd2 vccd2" \
    -starts_with POWER -extend_to_boundary
add_pdn_stripe \
    -grid stdcell_grid \
    -layer met4 \
    -width 5 \
    -pitch 120 \
    -offset 3085.56 \
    -spacing 1 \
    -number_of_straps 1 \
    -nets "vccd2 vssd2 vdda1 vssa1 vdda2 vssa2 vssd1 vccd1 vssd vccd" \
    -starts_with POWER -extend_to_boundary
add_pdn_stripe \
    -grid stdcell_grid \
    -layer met5 \
    -width 10 \
    -pitch 120 \
    -offset 5 \
    -spacing 1.6 \
    -number_of_straps 1 \
    -nets "vccd vssd vccd1 vssd1 vssa2 vdda2 vssa1 vdda1 vssd2 vccd2" \
    -starts_with POWER -extend_to_boundary
add_pdn_stripe \
    -grid stdcell_grid \
    -layer met5 \
    -width 10 \
    -pitch 120 \
    -offset 4629.28 \
    -spacing 1.6 \
    -number_of_straps 1 \
    -nets "vccd2 vssd2 vdda1 vssa1 vdda2 vssa2 vssd1 vccd1 vssd vccd" \
    -starts_with POWER -extend_to_boundary

add_pdn_stripe \
    -grid stdcell_grid \
    -layer met4 \
    -width 2 \
    -pitch 120 \
    -offset 62.395 \
    -spacing 1 \
    -number_of_straps 1 \
    -nets "vccd vssd" \
    -starts_with POWER
add_pdn_stripe \
    -grid stdcell_grid \
    -layer met4 \
    -width 2 \
    -pitch 120 \
    -offset 3077.465 \
    -spacing 1 \
    -number_of_straps 1 \
    -nets "vccd vssd" \
    -starts_with POWER

####  std cells stripes  ####    
    #Metal4
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met4 \
        -width 3.2 \
        -pitch 100 \
        -offset 117 \
        -spacing 6.4 \
        -nets "vccd vssd" \
        -starts_with POWER

    #Metal5
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met5 \
        -width 3.2 \
        -pitch 120 \
        -offset 181 \
        -spacing 6.4 \
        -nets "vccd vssd" \
        -starts_with POWER
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met5 \
        -width 4.8 \
        -pitch 120 \
        -offset 239 \
        -spacing 6.4 \
        -number_of_straps 4 \
        -nets "vccd vssd" \
        -starts_with POWER

####  mgmt_protect macros stripes  ####
    #Metal5
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met5 \
        -width 4.8 \
        -pitch 120 \
        -offset 807 \
        -spacing 3.2 \
        -number_of_straps 1 \
        -nets "vccd1 vssd1 vccd2 vssd2 vdda1 vssa1 vdda2 vssa2" \
        -starts_with POWER
    #Metal4
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met4 \
        -width 4.8 \
        -pitch 50 \
        -offset 843 \
        -spacing 3.2 \
        -number_of_straps 2 \
        -nets "vccd2 vssd2" \
        -starts_with POWER
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met4 \
        -width 4.8 \
        -pitch 100 \
        -offset 1268 \
        -spacing 3.2 \
        -number_of_straps 3 \
        -nets "vccd1 vssd1" \
        -starts_with POWER
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met4 \
        -width 4.8 \
        -pitch 40 \
        -offset 1836 \
        -spacing 3.2 \
        -number_of_straps 2 \
        -nets "vdda1 vssa1 vdda2 vssa2" \
        -starts_with POWER

####  uppder gpio_high macros stripes  ####
    #Metal4
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met4 \
        -width 1.6 \
        -pitch 300 \
        -offset 249.12 \
        -spacing 2.2 \
        -number_of_straps 9 \
        -nets "vssd1 vccd1" \
        -starts_with POWER
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met4 \
        -width 1.6 \
        -pitch 300 \
        -offset 949.12 \
        -spacing 2.2 \
        -number_of_straps 1 \
        -nets "vssd1 vccd1" \
        -starts_with POWER
    #Metal5
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer met5 \
        -width 3.2 \
        -pitch 300 \
        -offset 4594.76 \
        -spacing 2.24 \
        -number_of_straps 1 \
        -nets "vssd1 vccd1" \
        -starts_with POWER

add_pdn_connect \
    -grid stdcell_grid \
    -layers "$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)"

# Adds the standard cell rails if enabled.
if { $::env(FP_PDN_ENABLE_RAILS) == 1 } {
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(FP_PDN_RAILS_LAYER) \
        -width $::env(FP_PDN_RAIL_WIDTH) \
        -followpins \
        -starts_with POWER

    add_pdn_connect \
        -grid stdcell_grid \
        -layers "$::env(FP_PDN_RAILS_LAYER) $::env(FP_PDN_LOWER_LAYER)"
}

define_pdn_grid \
    -macro \
    -default \
    -name macro \
    -starts_with POWER \
    -halo "$::env(FP_PDN_HORIZONTAL_HALO) $::env(FP_PDN_VERTICAL_HALO)"

add_pdn_connect \
    -grid macro \
    -layers "met3 met4"

add_pdn_connect \
    -grid macro \
    -layers "met4 met5"

