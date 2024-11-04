# lvs_config.json

The `lvs_config.json` files are a possibly hierarchical set of files to set parameteters for device level LVS

Required variables:
- **TOP_SOURCE** : Top source cell name.
- **TOP_LAYOUT** : Top layout cell name.
- **LAYOUT_FILE** : Layout gds data file. 
- **LVS_SPICE_FILES_TO_FIX** : A list of spice files that work with mag extraction but need to be modified for gds extraction.
- **LVS_SPICE_FILES** : A list of spice files.
- **LVS_VERILOG_FILES** : A list of verilog files. Note: files with child modules should be listed before parent modules. Not needed for purely analog designs.

Files must be defined as a absolute path beginning with a shell variable such as `$PDK_ROOT` or `$UPRJ_ROOT`.
File globbing is permitted.

Optional variable lists: 
Hierarchical config files:
- **INCLUDE_CONFIGS** : List of configuration files to read recursively.

Extraction related. `*` may be used as a wild card character.
- **EXTRACT_FLATGLOB** : List of cell names to flatten before extraction. 
  Cells without text tend to work better if flattened.
  Note: it is necessary to flatten all sub cells of any cells listed.
- **EXTRACT_ABSTRACT** : List of cells to extract as abstract devices.
  Normally, cells that do not contain any devices will be flattened during netlisting.
  Using this variable can prevent unwanted flattening of empty cells.
  This has no effect of cells that are flattened because of a small number of layers.
  Internal connectivity is maintained (at least at the top level).

LVS related. `*` may be used as a wild card character.
- **LVS_FLATTEN** : List of cells to flatten before comparing,
        Sometimes matching topologies with mismatched pins cause errors at a higher level.
        Flattening these cells can yield a match.
- **LVS_NOFLATTEN** : List of cells not to be flattened in case of a mismatch.
        Lower level errors can propagate to the top of the chip resulting in long run times.
        Specify cells here to prevent flattening. May still cause higher level problems if there are pin mismatches.
- **LVS_IGNORE** : List of cells to ignore during LVS.
        Cells ignored result in LVS ending with a warning.
        Generally, should only be used when debugging and not on the final netlist.
        Ignoring cells results in a non-zero return code.

Simple shell variable substitution will be attempted on all values. Missing files and undefined variables result in fatal errors.
