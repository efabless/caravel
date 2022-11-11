# Caravel Signoff
>**NOTE:**
This document is wip 
## Signoff Results 
- Summary of the [signoff automation script](../../scripts/signoff_automation.py) could be found [here](./signoff.rpt)
- LVS: the full report could be found [here](./standalone_pvr/caravel.lvs.report)
- DRC: the total number of violations could be found [here](./standalone_pvr/logs/caravel_drc_check.log) and the error database could be found [here](./standalone_pvr/caravel_klayout_drc.xml) 
- STA: 
    - Generated logs could be found [here](./primetime-signoff/logs/). 
    - Generated reports could be found [here](./primetime-signoff/reports/). 
    - For a summary of the results of each corner, check `*global.rpt` and `*all_viol.rpt`. The detailed timing paths and path groups could be found in the archive of each corner. 
    - Sheet of the top-level and block-level results could be found [here](https://docs.google.com/spreadsheets/d/1qtXJMD_F52O1XYO1QAmjWdQ_ZjM7UPMbNuJjrnJr0h0/edit#gid=0)
- CVC: the log could be found [here](./standalone_pvr/caravel.cvc.log)
- Antenna: the summary could be found [here](./standalone_pvr/antenna_summary.txt)
- Top-level wire length report could be found [here](./openlane-signoff/wire-length-sorted.txt)

## Signoff STA Constraints
Clock period: `25ns` (`40MHz`)

