current_design mgmt_protect_hv
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name __VIRTUAL_CLK__ -period 8.0000 
set_clock_uncertainty 0.2500 __VIRTUAL_CLK__