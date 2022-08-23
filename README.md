# caravel

This repo contains the final layout and netlist of caravel, including the eco's. The final def eco'ed file is `def/caravel_eco.def` and the corresponding verilog netlist is `verilog/gl/caravel_eco.v`.

The eco'ed def was generated from the eco'ed mag view using magic. The corresponding eco'ed netlist was generated using the OpenROAD app from the eco'ed def.


The generated eco'ed netlist generated from the eco'ed def was compared to the netlist that corresponds to the eco'ed mag (`verilog/gl/caravel.v`) using netgen. To get a clean comparison we had to remove the power ports from `chip_io` in `verilog/gl/caravel_eco.v`; we also removed the `caravel_power_routing` macro because it is not in the original caravel netlist. The modified eco'ed netlist can be found in `verilog/gl/caravel_eco-nopwr.v`


We removed the power ports from the original caravel netlist and can be found in `verilog/gl/caravel-nopwr.v`


## Netlist VS Netlist comparison
we ran netlist VS netlist comparison to make sure that the eco'ed netlist matches the original one
### To run Netlist VS Netlist comparison:

```
git clone https://github.com/efabless/utilities.git
./lvs -i caravel-nopwr.v caravel_eco-nopwr.v -o lvs -bb
```

## Files to be used for timing verification
- `caravel.sdc`
- `verilog/gl/caravel_eco.v`
- `def/caravel_eco.def`

All other referenced verilog and def files for the top level can be found under `verilog/gl/` and `def/` 
