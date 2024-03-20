export RUN_TAG=RUN_20
rm -rf ../caravel/openlane/caravel_core/runs/$RUN_TAG
export DEFINE_CLOCKS=0 ; python3 -m openlane ../caravel/openlane/caravel_core/config.json ../caravel/openlane/caravel_core/macros.json --run-tag $RUN_TAG --to OpenROAD.CTS --log-level WARNING
export DEFINE_CLOCKS=1 ; python3 -m openlane ../caravel/openlane/caravel_core/config.json ../caravel/openlane/caravel_core/macros.json --run-tag $RUN_TAG --from OpenROAD.ResizerTimingPostCTS --to OpenROAD.RCX --log-level WARNING
python3 -m openlane ../caravel/openlane/caravel_core/config.json ../caravel/openlane/caravel_core/macros-sta.json --run-tag $RUN_TAG --from OpenROAD.STAPostPNR --log-level WARNING