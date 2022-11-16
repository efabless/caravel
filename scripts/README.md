# Caravel Automation scripts

## Dependencies
- [Magic](https://github.com/RTimothyEdwards/magic)
- [Klayout](https://github.com/KLayout/klayout)
- [Netgen](https://github.com/RTimothyEdwards/netgen)

## How to run
````
export CARAVEL_ROOT=<caravel path>
export MCW_ROOT=<mgmt core path>
export UPRJ_ROOT=<caravel user project path>
export PDK_ROOT=<path to pdk>
export PDK=<sky130A/B>

python3 signoff_automation.py [-options]

usage: signoff_automation.py [-h] [-d] [-l] [-v] [-rtl] [-gl] [-sdf] [-iv] [-sta] [-a]

optional arguments:
  -h, --help                    show this help message and exit

  -drc, --drc_check             run drc check

  -l, --lvs_check               run lvs check

  -v, --verification            run verification

  -rtl, --rtl                   run rtl verification

  -gl, --gl                     run gl verification

  -sdf, --sdf                   run sdf verification

  -iv, --iverilog               run verification using iverilog

  -sta, --primetime_sta         run STA using PrimeTime

  -d DESIGN, --design DESIGN    design under test

  -a, --all                     run all checks
````
### How to run Caravel top-level STA including user project wrapper
1. edit in [spef_mapping.tcl](./spef_mapping.tcl#L3) to add mapping of the modules instantiated in user_project_wrapper/user_analog_project_wrapper to their `spef`. this is required to enable hierarchical parasitic annotation.
2. run the command
  ````
  python3 signoff_automation.py -d caravel -sta
  ````
## Reports and logs

Reports can be found at `$CARAVEL_ROOT/signoff/<design_name>/`

Logs can be found at `$CARAVEL_ROOT/signoff/<design_name>/standalone_pvr/logs` and `$CARAVEL_ROOT/signoff/<design_name>/primetime-signoff/logs`
> If the design is related to the Management Core SoC, `$CARAVEL_ROOT` is replaced by `$MCW_ROOT` for the reports and logs