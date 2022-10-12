# Caravel Automation scripts

## Dependencies
- [Magic](https://github.com/RTimothyEdwards/magic)
- [Klayout](https://github.com/KLayout/klayout)
- [Netgen](https://github.com/RTimothyEdwards/netgen)

## How to run
````
export CARAVEL_ROOT=<caravel path>
export MCW_ROOT=<mgmt core path>
export PDK_ROOT=<path to pdk>
export PDK=<sky130A/B>

python3 signoff_automation.py [-options]

usage: signoff_automation.py [-h] [-d] [-l] [-v] [-rtl] [-gl] [-sdf] [-iv] [-sta] [-a]

optional arguments:

  -h, --help            show this help message and exit

  -d, --drc_check       run drc check

  -l, --lvs_check       run lvs check

  -v, --verification    run verification

  -rtl, --rtl           run rtl verification

  -gl, --gl             run gl verification

  -sdf, --sdf           run sdf verification

  -iv, --iverilog       run verification using iverilog

  -sta, --primetime_sta
                        run verification using iverilog

  -a, --all             run all checks
````

## Reports and logs

Reports can be found `$CARAVEL_ROOT/signoff/<design_name>/`
Logs can be found at `$CARAVEL_ROOT/scripts/logs/`
