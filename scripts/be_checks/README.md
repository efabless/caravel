# extra_be_checks
Scripts to run additional back-end checks on gds files.

INSTALLATION:
Requires:
- magic 3.8.413  https://github.com/RTimothyEdwards/magic.git
- netgen 1.5.255  https://github.com/RTimothyEdwards/netgen.git
- cvc 1.1.4  https://github.com/d-m-bailey/cvc.git

git clone -b precheck https://github.com/d-m-bailey/extra_be_checks.git
export LVS_ROOT=$PWD/extra_be_checks

In your `caravel_user_project` or `caravel_user_project_analog` directory,
create an LVS configuration file based on `extra_be_checks/tech/$PDK/lvs_config.<cellname>.json`.
`mpw_precheck` expects this file to be in `lvs/<cellname>/lvs_config.json`.

Environment variables.
These checks will use the following environment variables'
`LVS_ROOT`: path to the extra_be_checks directory. No default. Must be set.
`WORK_ROOT`: path to temporary work directory. Defaults to $PWD/work/$top_source
`LOG_ROOT`: path to runtime logs. Defaults to $PWD/logs/$top_source
`SIGNOFF_ROOT`: path to results. Defaults to $PWD/signoff/$top_source


```
$LVS_ROOT/run_be_checks [--noextract] [--nooeb] lvs/<cellname>/lvs_config.json
```
This command will run the following checks.
```
run_hier_check: Checks layout hierarchy against verilog hierarchy
run_scheck: Soft connection check
run_full_lvs: Device level LVS
run_cvc: ERC checks
run_oeb_check: Check oeb connections
```

1. Check design hierarchies. A fast check for digital designs to ensure that design hierarchies match.

   Usage: `run_hier_check top_source verilog_files top_layout layout_file [primitive_prefix [layout_prefix]]`

   Requires:
   - klayout:

   Arguments:
   - `top_source`: Top cell name from verilog
   - `verilog_files`: Verilog files (only cells in the listed verilog files will be checked)
   - `top_layout`: Top cell name in the layout
   - `layout_file`: gds/oasis/text file (gzip compression allowed).
   - `primitive_prefix`: If given, prefix is removed from both source and layout before comparison.
   - `layout_prefix`: If given, prefix is removed from layout cell names before comparison.

   Input:
   - `verilog_files`: List of referenced verilog files. Should have child modules listed before parents.

   Output:
   - `$WORK_ROOT/verilog.hier`: The netlist hierarchy.
   - `$WORK_ROOT/layout.txt.gz`: If input is gds/oas, the layout hierarchy converted to text.
   - `$WORK_ROOT/layout.hier`: The layout hierarchy.
   - `$SIGNOFF_ROOT/hier.csv`: Comparison results.

   Algorithm:
   - Convert gds/oasis to gds text file.
   - Extract netlist hierarchy.
   - Extract layout hierarchy.
   - Compare.

2. Soft connection check: find high resistance connections (i.e. soft connections) through n/pwell.

   Usage:
   `run_softcheck [--noextract] [<config_file> [<top_layout> [<gds_file>]]]`

   Requires:
   - magic 3.8.413
   - netgen 1.5.255

   Arguments:
   - `--noextract`: Use previous extraction results.
   - `config_file`: Configuration file. For details, see sample in repo.
   - `top_layout`: Top layout name. Overrides config_file setting.
   - `gds_file`: gds file (gzip compression allowed). Overrides config_file setting.

   References: (created from config_file)
   - `$WORK_ROOT/flatglob`: cells to be flattened before extraction.
   - `$WORK_ROOT/abstract.glob`: cells to be abstracted during extraction.

   Output:
   - `$WORK_ROOT/ext/*`: Extraction results with well connectivity.
   - `$LOG_ROOT/ext.log`: Well connectivity extraction log.
   - `$WORK_ROOT/nowell.ext/*`: Extraction results without well connectivity.
   - `$LOG_ROOT/nowell.ext.log`: No well connectivity extraction log.
   - `$LOG_ROOT/soft.log`: Soft connection check LVS log.
   - `$SIGNOFF_ROOT/soft.report`: Comparison results.

   Algorithm:
   - Create 2 versions of the extracted netlist.
   - Version 1 extracts well connectivity.
     - Remove well connections and disconnected signals.
   - Version 2 does not extract well connectivity.
     - Remove disconnected signals.
   - Compare with LVS.

   Analysis:
   - Any discrepancies should be the result of well/substrate taps not connected to the correct power net.
   - Use the `$SIGNOFF_ROOT/soft.report` file to find problem nets.
   - Use the problem nets to find a connected device in the `$WORK_ROOT/nowell.ext/<top_layout>.gds.nowell.spice` file.
   - Use the corresponding `$WORK_ROOT/nowell.ext/*.ext` file to find the coordinates of error devices. (divide by 200 to get coordinates in um).

3. Full device level LVS

   Usage: `run_full_lvs [--noextract] [<config_file> [<top_source> [<top_layout> [layout_file]]]]

   Requires:
   - magic 3.8.413
   - netgen 1.5.255

   Arguments:
   - `--noextract`: Use previous extraction results.
   - `config_file`: Configuration file. For details, see sample in repo.
   - `top_source`: Top source name. Overrides config_file setting.
   - `top_layout`: Top layout name. Overrides config_file setting.
   - `layout_file`: Top layout file name. Overrides config_file setting.

   References: (created from config_file)
   - `$WORK_ROOT/flatglob`: cells to be flattened before extraction.
   - `$WORK_ROOT/abstract.glob`: cells to be abstracted during extraction.
   - `$WORK_ROOT/flatten.glob`: cells to be flattened during LVS.
   - `$WORK_ROOT/noflatten.glob`: cells not to be flattened during LVS.
   - `$WORK_ROOT/ignore.glob`: cells to be ignored during extraction.
   - `$WORK_ROOT/spice_files`: list of spice files in hierachical order (lowest level first).
   - `$WORK_ROOT/verilog_files`: list of verilog files in hierachical order (lowest level first).

   Output:
   - `$WORK_ROOT/ext/*`: Extraction results with well connectivity.
   - `$LOG_ROOT/ext.log`: Well connectivity extraction log.
   - `$LOG_ROOT/lvs.log`: LVS comparison log.
   - `$SIGNOFF_ROOT/lvs.report`: Comparison results.

   Hints:
   - Rerunning with --noextract is faster because previous extraction result will be used.
   - Add cells to the `EXTRACT_FLATGLOB` to flatten before extraction.
   - Cells in `EXTRACT_ABSTRACT` will be extracted (top level?), but netlisted as black-boxes.
   - `LVS_FLATTEN` is a list of cell names to be flattened during LVS.
     Flattening cells with unmatched ports may resolve proxy port errors.
   - netgen normally flattens unmatched cells which can lead to confusing results at higher levels.
     To avoid this, add cells to `LVS_NOFLATTEN`.
   - Add cells to `LVS_IGNORE` to skip LVS checks.

4. CVC-RV. Circuit Validity Check - Reliability Verification - voltage aware ERC.
   Voltage aware ERC tool to detect current leaks and electrical overstress errors.

   Usage: `run_cvc [--noextract] [lvs_config_file [top_layout [layout_file]]]]"

   Requires:
   - cvc_rv 1.1.4

   Arguments:
   - `--noextract`: Use previous extraction results.
   - `lvs_config_file`: Configuration file. For details, see sample in repo.
   - `top_layout`: Top layout name. Overrides config_file setting.
   - `layout_file`: gds file (gzip compression allowed). Overrides config_file setting.

   Input:
   - `$WORK_ROOT/ext/<top_layout>.gds.spice`: Extracted spice file.
   - `$WORK_ROOT/cvc.power.<top_layout>`: Power settings.
   - `cvc.$PDK.models`: Model settings.

   Output:
   - `$WORK_ROOT/ext/<top_layout>.cdl.gz`: CDL file converted from extracted spice file.
   - `$WORK_ROOT/cvc.error.gz`: Detailed errors results.
   - `$LOG_ROOT/cvc.log`: Log file with error summary.

   Analysis;
   - Works well with digital designs. Analog results can be obscure.
   - If the log file shows errors, look for details in the error file.
   - Error device locations can be found in the respective `$WORK_ROOT/ext/*.ext` files. (coordinates should be divided by 200).

5. OEB check. Check for user oeb signal output to gpio cells.
   The following conditions are errors.
   - gpio with both digital (io_in/io_out) and analog (analog_io/gpio_analog) connections
   - gpio with analog (analog_io/gpio_analog) and oeb not high
   - gpio with only input (io_in) but oeb not high
   - gpio with output (io_out) but oeb never low
   The following condition is a warning.
   - gpio with both input (io_in) and output (io_out) and oeb always low

   Usage: `run_oeb_check [--noextract] [lvs_config_file [top_layout [layout_file]]]]"

   Requires:
   - cvc_rv 1.1.4

   Arguments:
   - `--noextract`: Use previous extraction results.
   - `lvs_config_file`: Configuration file. For details, see sample in repo.
   - `top_layout`: Top layout name. Overrides config_file setting.
   - `layout_file`: gds file (gzip compression allowed). Overrides config_file setting.

   Input:
   - `$WORK_ROOT/ext/<top_layout>.gds.spice`: Extracted spice file.
   - `$WORK_ROOT/cvc.power.<top_layout>`: Power settings.
   - `cvc.$PDK.models`: Model settings.

   Output:
   - `$WORK_ROOT/ext/<top_layout>.cdl.gz`: CDL file converted from extracted spice file.
   - `$WORK_ROOT/cvc.oeb.error.gz`: Detailed errors results.
   - `$LOG_ROOT/cvc.oeb.log`: Log file with error summary.
   - `$SIGNOFF_ROOT/cvc.oeb.report`: List of each gpio, connection counts, and errors
