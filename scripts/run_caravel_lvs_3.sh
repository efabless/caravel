#!/bin/bash
#
# run_caravel_lvs_3.sh ---
#
# Run LVS on caravel.  Read GDS using the recipe developed for open_pdks.
# Read I/O cells from vendor GDS first so that they get replaced.
#
echo ${PDK_ROOT:=/usr/share/pdk} >/dev/null
echo ${PDK:=sky130A} >/dev/null
echo ${CARAVEL_ROOT:=/home/tim/gits/caravel} >/dev/null
echo ${LITEX_ROOT:=/home/tim/gits/caravel_mgmt_soc_litex} >/dev/null

# echo "Running LVS on caravel."
# if [ $# -eq 0 ]; then
#     echo "No arguments---running LVS on existing spice if it exists."
# elif [ $1 == "extract" ]; then
#     echo "Forced new extraction."
#     rm -f $CARAVEL_ROOT/spi/lvs/caravel.spice
# else
#     echo "Ending without running LVS."
#     exit 0
# fi

# if [ ! -f $CARAVEL_ROOT/spi/lvs/caravel.spice ]; then
magic -dnull -noconsole -rcfile $PDK_ROOT/$PDK/libs.tech/magic/$PDK.magicrc <<EOF
drc off
crashbackups stop

# ! This recipe taken from open_pdks/sky130/custom/scripts/gds_import_io.tcl
gds flatten true
gds flatglob *_cdns_*
gds flatglob *sky130_fd_pr__*_example_*

# ! flatten within the 120x2 ESD device
gds flatglob *sky130_fd_io__gnd2gnd_*

# The following cells have to be flattened for the gpiov2 pad to read in
# correctly, and produce a layout that can be extracted and generate an
# LVS clean netlist.

### flatten within the analog mux isolated P region
gds flatglob *sky130_fd_io__amx*
gds flatglob *sky130_fd_io__xor*
gds flatglob *sky130_fd_io__gpiov2_amx*
gds flatglob *sky130_fd_io__gpiov2_amux*

### flatten within the isolated VSSIO domain
gds flatglob *sky130_fd_io__feas_com_pupredrvr*
gds flatglob *sky130_fd_io__com_pupredrvr_strong_slowv2*
gds flatglob *sky130_fd_io__com_pdpredrvr_pbiasv2*
gds flatglob *sky130_fd_io__gpiov2_pdpredrvr_strong*

### flatten in opathv2
gds flatglob *sky130_fd_io__com_pudrvr_strong_slowv2*
gds flatglob *sky130_fd_io__com_pdpredrvr_strong_slowv2*
gds flatglob *sky130_fd_io__gpiov2_obpredrvr*
gds flatglob *sky130_fd_io__hvsbt_*

### flatten in ipath
gds flatglob *sky130_fd_io__gpiov2_ictl_logic*

### avoid splitting a netlist that passes in contorted ways through the
### layout hierarchy
gds flatglob *sky130_fd_io__gpio_pddrvr_strong_slowv2*
gds flatglob *sky130_fd_io__gpiov2_pddrvr_strong*

gds read $PDK_ROOT/$PDK/libs.ref/sky130_fd_io/gds/sky130_fd_io.gds
gds read $PDK_ROOT/$PDK/libs.ref/sky130_fd_io/gds/sky130_ef_io.gds

# Now assert that existing views must take precedence
gds noduplicates true

# GDS is still written in legacy mode
cif istyle sky130(legacy)

# And read in the full chip (except for cells already read)
gds read $CARAVEL_ROOT/gds/caravel.gds
load caravel
select top cell
expand
extract do local
extract no all
extract do aliases
extract unique
extract all
ext2spice lvs
ext2spice -o $CARAVEL_ROOT/spi/lvs/caravel.spice caravel.ext
EOF
rm *.ext
# fi

cat >netgenD.tcl <<EOF
set circuit1 [readnet spice $CARAVEL_ROOT/spi/lvs/caravel.spice]
set circuit2 [readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/spice/sky130_sram_2kbyte_1rw1r_32x512_8.spice]
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/spice/sky130_sram_1kbyte_1rw1r_32x256_8.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/spice/sky130_sram_1kbyte_1rw1r_8x1024_8.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/spice/sram_1rw1r_32_256_8_sky130.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_io/spice/sky130_ef_io.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_io/spice/sky130_fd_io.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_io/spice/sky130_ef_io__analog_pad.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_12.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_4.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_8.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_12.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fakediode_2.spice \$circuit2
readnet spice $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice \$circuit2
readnet spice $CARAVEL_ROOT/xschem/simple_por.spice \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/constant_block.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/gpio_defaults_block.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/xres_buf.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/empty_macro.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/manual_power_connections.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/spare_logic_block.v \$circuit2
readnet verilog $MCW_ROOT/verilog/gl/RAM128.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/gpio_logic_high.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/caravel_clocking.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/mprj_logic_high.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/housekeeping.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/mprj_io_buffer.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/mprj2_logic_high.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/mgmt_protect_hv.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/chip_io.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/open_source.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/caravel_core.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/caravel_motto.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/user_id_textblock.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/copyright_block.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/caravel_logo.v \$circuit2
readnet verilog $CARAVEL_ROOT/verilog/gl/caravel.v \$circuit2

# Cells in management core wrapper (layout) are prefixed with RL_ or KF_
set cells1 [cells list -all \$circuit1]
set cells2 [cells list -all \$circuit2]
foreach cell \$cells1 {
    if {[regexp ".._(.+)" \$cell match cellname]} {
        if {([lsearch \$cells2 \$cell] < 0) && ([lsearch \$cells2 \$cellname] >= 0) && ([lsearch \$cells1 \$cellname] < 0)} {
            equate classes "\$circuit1 \$cell" "\$circuit2 \$cellname"
            puts stdout "Matching pins of \$cell in circuit 1 and \$cellname in circuit 2"
            equate pins "\$circuit1 \$cell" "\$circuit2 \$cellname"
        }
    }
    # Ignore fill cells in standard cell sets that have two-letter prefixes.
    if {[regexp {.._sky130_fd_sc_[^_]+__fill_[[:digit:]]+} \$cell match]} {
	ignore class "\$circuit1 \$cell"
    }
}

# Run LVS
flatten class "\$circuit2 user_project_wrapper"
flatten class "\$circuit2 manual_power_connections"
flatten class "\$circuit2 empty_macro"
lvs "\$circuit1 caravel" "\$circuit2 caravel" $PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl caravel_3_comp.out -json
EOF

export NETGEN_COLUMNS=90
export MAGIC_EXT_USE_GDS=1
netgen -batch source netgenD.tcl 2>&1 | tee caravel_3_lvs.log
rm netgenD.tcl

exit 0
