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
# Power nets

if { ! [info exists ::env(VDD_NET)] } {
	set ::env(VDD_NET) $::env(VDD_PIN)
}

if { ! [info exists ::env(GND_NET)] } {
	set ::env(GND_NET) $::env(GND_PIN)
}

set ::power_nets $::env(VDD_NET)
set ::ground_nets $::env(GND_NET)

if { [info exists ::env(FP_PDN_ENABLE_GLOBAL_CONNECTIONS)] } {
    if { $::env(FP_PDN_ENABLE_GLOBAL_CONNECTIONS) == 1 } {
        foreach power_pin $::env(STD_CELL_POWER_PINS) {
            add_global_connection -net $::env(VDD_NET) -inst_pattern .* -pin_pattern $power_pin -power
        }
        foreach ground_pin $::env(STD_CELL_GROUND_PINS) {
            add_global_connection -net $::env(GND_NET) -inst_pattern .* -pin_pattern $ground_pin -ground
        }
    }
}

set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET)


if { $::env(VDD_NET) == "vdda1" } {
    define_pdn_grid -name stdcell_grid -starts_with POWER -voltage_domain CORE -pins [subst {$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)}]
    add_pdn_stripe -grid stdcell_grid -layer $::env(FP_PDN_LOWER_LAYER) -width $::env(FP_PDN_VWIDTH) -pitch $::env(FP_PDN_VPITCH) -offset 929 -starts_with POWER
} elseif {$::env(VDD_NET) == "vdda2"} {
    define_pdn_grid -name stdcell_grid -starts_with POWER -voltage_domain CORE -pins [subst {$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)}]
    add_pdn_stripe -grid stdcell_grid -layer $::env(FP_PDN_LOWER_LAYER) -width $::env(FP_PDN_VWIDTH) -pitch $::env(FP_PDN_VPITCH) -offset 932 -starts_with POWER
} else {
    define_pdn_grid -name stdcell_grid -starts_with POWER -voltage_domain CORE -pins [subst {$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)}]
    add_pdn_stripe -grid stdcell_grid -layer $::env(FP_PDN_LOWER_LAYER) -width $::env(FP_PDN_VWIDTH) -pitch $::env(FP_PDN_VPITCH) -offset $::env(FP_PDN_VOFFSET) -starts_with POWER
}

# Adds the standard cell rails if enabled.
if { $::env(FP_PDN_ENABLE_RAILS) == 1 } {
    add_pdn_stripe -grid stdcell_grid -layer $::env(FP_PDN_RAILS_LAYER) -width $::env(FP_PDN_RAIL_WIDTH) -followpins -starts_with POWER
    add_pdn_connect -grid stdcell_grid -layers [subst {$::env(FP_PDN_RAILS_LAYER) $::env(FP_PDN_LOWER_LAYER)}]
} 

# Adds the core ring if enabled.
if { $::env(FP_PDN_CORE_RING) == 1 } {
    add_pdn_ring -grid stdcell_grid -layer [subst {$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)}] \
                 -widths [subst {$::env(FP_PDN_CORE_RING_VWIDTH) $::env(FP_PDN_CORE_RING_HWIDTH)}] \
                 -spacings [subst {$::env(FP_PDN_CORE_RING_VSPACING) $::env(FP_PDN_CORE_RING_HSPACING)}] \
                 -core_offset [subst {$::env(FP_PDN_CORE_RING_VOFFSET) $::env(FP_PDN_CORE_RING_HOFFSET)}]
    add_pdn_connect -grid stdcell_grid -layers [subst {$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)}]
}

set ::halo [expr min($::env(FP_HORIZONTAL_HALO), $::env(FP_VERTICAL_HALO))]

# A general macro that follows the premise of the set heirarchy. You may want to modify this or add other macro configs
if { $::env(VDD_NET) == "vccd1" } {
    set mprj_logic_high_macro {
        macro mprj_logic_high
        power_pins $::env(VDD_NET)
        ground_pins $::env(GND_NET)
        blockages "met3"
        straps {
        }
        connect {{$::env(FP_PDN_UPPER_LAYER)_PIN_hor $::env(FP_PDN_LOWER_LAYER)}}
    }
    pdngen::specify_grid macro [subst $mprj_logic_high_macro]

    define_pdn_grid -macro -orient {R0 R180 MX MY R90 R270 MXR90 MYR90} -grid_over_pg_pins -starts_with POWER -halo [subst {$::env(FP_HORIZONTAL_HALO) $::env(FP_VERTICAL_HALO)}]
} 

if { $::env(VDD_NET) == "vccd2" } {
    set mprj2_logic_high_macro {
        macro mprj2_logic_high
        power_pins $::env(VDD_NET)
        ground_pins $::env(GND_NET)
        blockages "met3"
        straps {
        }
        connect {{$::env(FP_PDN_UPPER_LAYER)_PIN_hor $::env(FP_PDN_LOWER_LAYER)}}
    }
    pdngen::specify_grid macro [subst $mprj2_logic_high_macro]

    define_pdn_grid -macro -cells "mprj_logic_high mgmt_protect_hv" -grid_over_pg_pins -starts_with POWER -halo [subst {$::env(FP_HORIZONTAL_HALO) $::env(FP_VERTICAL_HALO)}]
}

if { $::env(VDD_NET) == "vccd" || $::env(VDD_NET) == "vdda2" || $::env(VDD_NET) == "vdda1" } {
   
    set mgmt_protect_hv_macro {
        macro mgmt_protect_hv
        power_pins $::env(VDD_NET)
        ground_pins $::env(GND_NET)
        blockages "met3"
        straps {
        }
        connect {{$::env(FP_PDN_UPPER_LAYER)_PIN_hor $::env(FP_PDN_LOWER_LAYER)}}
    }
    pdngen::specify_grid macro [subst $mgmt_protect_hv_macro]
    
    define_pdn_grid -macro -cells "mprj_logic_high mprj2_logic_high"  -grid_over_pg_pins -starts_with POWER -halo [subst {$::env(FP_HORIZONTAL_HALO) $::env(FP_VERTICAL_HALO)}]
}

# POWER or GROUND #Std. cell rails starting with power or ground rails at the bottom of the core area
set ::rails_start_with "POWER" ;

# POWER or GROUND #Upper metal stripes starting with power or ground rails at the left/bottom of the core area
set ::stripes_start_with "POWER" ;