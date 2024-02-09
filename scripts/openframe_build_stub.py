#!/usr/bin/env python3

# Generate the SPICE netlist stub entry for the openframe chip_io, to be
# used to annotate the layout.  The generated file is only needed for
# annotation and may be removed afterwards.  The script is maintained to
# regenerate the stub file on demand.

with open('chip_io_openframe.spice', 'w') as ofile:
    print('* Subcircuit pin order definition for chip_io_openframe', file=ofile)
    print('.subckt chip_io_openframe', file=ofile)
    print('+ vddio_pad', file=ofile)
    print('+ vddio_pad2', file=ofile)
    print('+ vssio_pad', file=ofile)
    print('+ vssio_pad2', file=ofile)
    print('+ vccd_pad', file=ofile)
    print('+ vssd_pad', file=ofile)
    print('+ vdda_pad', file=ofile)
    print('+ vssa_pad', file=ofile)
    print('+ vdda1_pad', file=ofile)
    print('+ vdda1_pad2', file=ofile)
    print('+ vssa1_pad', file=ofile)
    print('+ vssa1_pad2', file=ofile)
    print('+ vssa2_pad', file=ofile)
    print('+ vccd1_pad', file=ofile)
    print('+ vccd2_pad', file=ofile)
    print('+ vssd1_pad', file=ofile)
    print('+ vssd2_pad', file=ofile)

    print('+ vddio', file=ofile)
    print('+ vssio', file=ofile)
    print('+ vccd', file=ofile)
    print('+ vssd', file=ofile)
    print('+ vdda', file=ofile)
    print('+ vssa', file=ofile)
    print('+ vdda1', file=ofile)
    print('+ vdda2', file=ofile)
    print('+ vssa1', file=ofile)
    print('+ vssa2', file=ofile)
    print('+ vccd1', file=ofile)
    print('+ vccd2', file=ofile)
    print('+ vssd1', file=ofile)
    print('+ vssd2', file=ofile)

    print('+ resetb_pad', file=ofile)

    print('+ porb_h', file=ofile)
    print('+ porb_l', file=ofile)
    print('+ por_l', file=ofile)
    print('+ resetb_h', file=ofile)
    print('+ resetb_l', file=ofile)

    for i in range(31, -1, -1):
        print('+ mask_rev[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_out[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_oeb[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_inp_dis[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_ib_mode_sel[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_vtrip_sel[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_slow_sel[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_holdover[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_analog_en[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_analog_sel[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_analog_pol[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_dm0[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_dm1[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_dm2[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_in[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_in_h[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_loopback_zero[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ gpio_loopback_one[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ analog_io[' + str(i) + ']', file=ofile)

    for i in range(43, -1, -1):
        print('+ analog_noesd_io[' + str(i) + ']', file=ofile)

    print('* No contents---stub for ordering pins in layout.', file=ofile)
    print('.ends', file=ofile)
