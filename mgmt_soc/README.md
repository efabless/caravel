# caravel_mgmt_soc_litex

To install litex library dependencies
```
cd litex
make setup
```
To build the caravel mgmt soc

```
cd litex
make
```

To simulate

```
cd sim
make clean sim
```

## ECO done in DFFRAMS to get antenna clean

The ECOs were done on both DFFRAMs to clean antenna violations, these ECOs were only on metal layers and were done using the jumper method for antenna avoidance

The non-eco'd views coming out of OpenLane is postfixed by `-openlane`, for example: `gds/RAM128-openlane.gds.gz`

The eco'd views are the views that doesn't have postfix

After the eco `scripts/update_views.sh` was ran to produce mag, lef and def views for the eco'd gds

`scripts/build_mgmt_core_wrapper.sh` was ran to produce the final gds for mgmt_core_wrapper 