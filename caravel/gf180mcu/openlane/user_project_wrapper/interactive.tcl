package require openlane
set script_dir [file dirname [file normalize [info script]]]
set save_path $script_dir/../..

# FOR LVS AND CREATING PORT LABELS

# ACTUAL CHIP INTEGRATION

prep -design $script_dir -tag user_project_wrapper_pdn -overwrite -ignore_mismatches --verbose 1
set_netlist $::env(DESIGN_DIR)/../../verilog/gl/__user_project_wrapper.v
set ::env(FP_PDN_SKIPTRIM) 1
init_floorplan
apply_def_template
run_power_grid_generation

run_magic
calc_total_runtime
save_final_views
save_final_views -save_path .. -tag user_project_wrapper_pdn