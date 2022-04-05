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

# Assesses whether the deisgn is the core of the chip or not based on the 
# value of $::env(DESIGN_IS_CORE) and uses the appropriate stdcell section
define_pdn_grid \
    -name stdcell_grid \
    -starts_with POWER \
    -voltage_domain CORE \
    -pins [subst {$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)}]
add_pdn_stripe \
    -grid stdcell_grid \
    -layer $::env(FP_PDN_LOWER_LAYER) \
    -width $::env(FP_PDN_VWIDTH) \
    -pitch $::env(FP_PDN_VPITCH) \
    -offset $::env(FP_PDN_VOFFSET) \
    -starts_with POWER
add_pdn_stripe \
    -grid stdcell_grid \
    -layer $::env(FP_PDN_UPPER_LAYER) \
    -width $::env(FP_PDN_HWIDTH) \
    -pitch $::env(FP_PDN_HPITCH) \
    -offset $::env(FP_PDN_HOFFSET) \
    -starts_with POWER
add_pdn_connect \
    -grid stdcell_grid \
    -layers [subst {$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)}]

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
}

if { $::env(VDD_NET) == "vccd1" } {
    add_global_connection -net vccd1 -inst_pattern gpio_logic_high -pin_pattern vccd1
    add_global_connection -net vssd1 -inst_pattern gpio_logic_high -pin_pattern vssd1
    define_pdn_grid \
        -macro \
        -orient {R0 R180 MX MY R90 R270 MXR90 MYR90} 
    add_pdn_connect \
        -layers { met4_PIN_ver met5 }
#	set macro {
#		orient {R0 R180 MX MY R90 R270 MXR90 MYR90}
#		power_pins "vccd1"
#		ground_pins "vssd1"
#		blockages "met1 met2 met3 met4 met5"
#		straps {
#		}
#		connect {{$::env(FP_PDN_LOWER_LAYER)_PIN_ver $::env(FP_PDN_UPPER_LAYER)}}
#	}
#    pdngen::specify_grid macro [subst $macro]
	set ::halo [list $::env(FP_PDN_HORIZONTAL_HALO) $::env(FP_PDN_VERTICAL_HALO)]
} else {
#	set macro {
#		orient {R0 R180 MX MY R90 R270 MXR90 MYR90}
#		power_pins "vccd1"
#		ground_pins "vssd1"
#		blockages "met1 met2 met3 met4 met5"
#		straps {
#		}
#	}
#    pdngen::specify_grid macro [subst $macro]
    define_pdn_grid \
        -macro \
        -orient {R0 R180 MX MY R90 R270 MXR90 MYR90} 
	set ::halo [list $::env(FP_PDN_HORIZONTAL_HALO) $::env(FP_PDN_VERTICAL_HALO)]
}

# POWER or GROUND #Std. cell rails starting with power or ground rails at the bottom of the core area
set ::rails_start_with "POWER" ;

# POWER or GROUND #Upper metal stripes starting with power or ground rails at the left/bottom of the core area
set ::stripes_start_with "POWER" ;
