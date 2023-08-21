# Power nets
if { [info exists ::env(FP_PDN_ENABLE_GLOBAL_CONNECTIONS)] } {
    if { $::env(FP_PDN_ENABLE_GLOBAL_CONNECTIONS) == 1 } {
        foreach power_pin $::env(STD_CELL_POWER_PINS) {
            add_global_connection \
                -net $::env(VDD_NET) \
                -inst_pattern .* \
                -pin_pattern $power_pin \
                -power
        }
        foreach ground_pin $::env(STD_CELL_GROUND_PINS) {
            add_global_connection \
                -net $::env(GND_NET) \
                -inst_pattern .* \
                -pin_pattern $ground_pin \
                -ground
        }
    }
}

if { $::env(FP_PDN_ENABLE_MACROS_GRID) == 1 &&
    [info exists ::env(FP_PDN_MACRO_HOOKS)]} {
    set pdn_hooks [split $::env(FP_PDN_MACRO_HOOKS) ","]
    foreach pdn_hook $pdn_hooks {
        set instance_name [lindex $pdn_hook 0]
        set power_net [lindex $pdn_hook 1]
        set ground_net [lindex $pdn_hook 2]
        set power_pin [lindex $pdn_hook 3]
        set ground_pin [lindex $pdn_hook 4]

        if { $power_pin == "" || $ground_pin == "" } {
            puts "FP_PDN_MACRO_HOOKS missing power and ground pin names"
            exit -1
        }

        add_global_connection \
            -net $power_net \
            -inst_pattern $instance_name \
            -pin_pattern $power_pin \
            -power

        add_global_connection \
            -net $ground_net \
            -inst_pattern $instance_name \
            -pin_pattern $ground_pin \
            -ground
    }
}

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

puts "set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET) \
    -secondary_power $secondary"
set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET) \
    -secondary_power $secondary


# Assesses whether the design is the core of the chip or not based on the
# value of $::env(DESIGN_IS_CORE) and uses the appropriate stdcell section
define_pdn_grid \
    -name stdcell_grid \
    -starts_with POWER \
    -voltage_domain CORE \
    -pins "Metal4 Metal5"

## standard cells stripes
add_pdn_stripe \
    -grid stdcell_grid \
    -layer Metal5 \
    -width $::env(FP_PDN_HWIDTH) \
    -pitch $::env(FP_PDN_HPITCH) \
    -offset $::env(FP_PDN_HOFFSET) \
    -spacing $::env(FP_PDN_HSPACING) \
    -number_of_straps 20 \
    -nets "VDD VSS" \
    -starts_with POWER -extend_to_core_ring

# add_pdn_stripe \
#     -grid stdcell_grid \
#     -layer Metal5 \
#     -width 4 \
#     -pitch 30 \
#     -offset 4390 \
#     -spacing 2 \
#     -number_of_straps 1 \
#     -nets "VDD VSS" \
#     -starts_with POWER -extend_to_core_ring

add_pdn_stripe \
    -grid stdcell_grid \
    -layer Metal4 \
    -width $::env(FP_PDN_VWIDTH) \
    -pitch $::env(FP_PDN_VPITCH) \
    -offset $::env(FP_PDN_HOFFSET) \
    -spacing $::env(FP_PDN_VSPACING) \
    -nets "VDD VSS" \
    -starts_with POWER -extend_to_core_ring

# add_pdn_stripe \
#     -grid stdcell_grid \
#     -layer Metal4 \
#     -width $::env(FP_PDN_VWIDTH) \
#     -pitch $::env(FP_PDN_VPITCH) \
#     -offset 100 \
#     -spacing $::env(FP_PDN_VSPACING) \
#     -number_of_straps 20 \
#     -nets "VDD VSS" \
#     -starts_with POWER -extend_to_core_ring

##RING
add_pdn_ring \
        -grid stdcell_grid \
        -layers "$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)" \
        -widths "$::env(FP_PDN_CORE_RING_VWIDTH) $::env(FP_PDN_CORE_RING_HWIDTH)" \
        -spacings "$::env(FP_PDN_CORE_RING_VSPACING) $::env(FP_PDN_CORE_RING_HSPACING)" \
        -core_offset "$::env(FP_PDN_CORE_RING_VOFFSET) $::env(FP_PDN_CORE_RING_HOFFSET)"
        
#connections
add_pdn_connect \
    -grid stdcell_grid \
    -layers "Metal4 Metal5"

add_pdn_stripe \
    -grid stdcell_grid \
    -layer $::env(FP_PDN_RAILS_LAYER) \
    -width $::env(FP_PDN_RAIL_WIDTH) \
    -followpins \
    -starts_with POWER

add_pdn_connect \
    -grid stdcell_grid \
    -layers "Metal1 Metal4"

# add_pdn_connect \
#     -grid stdcell_grid \
#     -layers "Metal1 Metal3"

# add_pdn_connect \
#     -grid stdcell_grid \
#     -layers "Metal3 Metal4"

# define_pdn_grid \
#     -macro \
#     -cells user_project_wrapper \
#     -name user_project \
#     -starts_with POWER \
#     -obstructions "Metal5" \
#     -halo "-8 10"

define_pdn_grid \
    -macro \
    -default \
    -name macro \
    -starts_with POWER \
    -halo "-10 10"

# define_pdn_grid \
#     -macro \
#     -name user_project_grid \
#     -starts_with POWER \
#     -voltage_domain CORE \
#     -cells user_project_wrapper \
#     -halo "$::env(FP_PDN_HORIZONTAL_HALO) $::env(FP_PDN_VERTICAL_HALO)"

# define_pdn_grid \
#     -name user_project_grid \
#     -starts_with POWER \
#     -voltage_domain CORE 

# add_pdn_ring \
#         -grid user_project_grid \
#         -layers "$::env(FP_PDN_LOWER_LAYER) $::env(FP_PDN_UPPER_LAYER)" \
#         -widths "$::env(FP_PDN_CORE_RING_VWIDTH) $::env(FP_PDN_CORE_RING_HWIDTH)" \
#         -spacings "$::env(FP_PDN_CORE_RING_VSPACING) $::env(FP_PDN_CORE_RING_HSPACING)" \
#         -core_offset "$::env(FP_PDN_CORE_RING_VOFFSET) $::env(FP_PDN_CORE_RING_HOFFSET)"

add_pdn_stripe \
    -grid stdcell_grid \
    -layer Metal5 \
    -width 3  \
    -pitch 66.64 \
    -offset 1254.85 \
    -number_of_straps 46 \
    -spacing 3 \
    -nets "VDD VSS" \
    -starts_with POWER -extend_to_boundary 

# add_pdn_connect \
#     -grid user_project_grid \
#     -layers "Metal3 Metal4"

# add_pdn_connect \
#     -grid user_project \
#     -layers "Metal3 Metal4"

add_pdn_connect \
    -grid macro \
    -layers "Metal3 Metal4"
