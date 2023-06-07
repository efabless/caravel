repair_antennas "$::env(DIODE_CELL)" -iterations $::env(GRT_ANT_ITERS) -ratio_margin 25
check_placement

write