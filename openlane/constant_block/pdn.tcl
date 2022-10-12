puts "set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET)"
set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET)

# Assesses whether the design is the core of the chip or not based on the
# value of $::env(DESIGN_IS_CORE) and uses the appropriate stdcell section
define_pdn_grid \
    -name stdcell_grid \
    -starts_with POWER \
    -voltage_domain CORE \
    -pins "met4"

##vertical
add_pdn_stripe \
    -grid stdcell_grid \
    -layer met4 \
    -width 1.6 \
    -pitch 75.25 \
    -offset 2 \
    -spacing 5 \
    -nets "VPWR VGND" \
    -starts_with POWER -extend_to_core_ring

add_pdn_connect \
    -grid stdcell_grid \
    -layers "met1 met4"
