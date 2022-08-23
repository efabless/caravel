# caravel
The eco'ed Gate Level netlist can be found in `verilog/gl/caravel_eco.v`

To get the LVS clean we had to remove the power ports from `chip_io` in the eco'ed GL netlist
We also removed the `caravel_power_routing` macro because it is not in the original caravel netlist and not used
The modified eco'ed netlist can be found in `verilog/gl/caravel_eco-nopwr.v`

We removed the power ports from the original caravel netlist and can be found in `verilog/gl/caravel-nopwr.v`

## LVS
### To run LVS:

```
git clone https://github.com/efabless/utilities.git
./lvs -i caravel-nopwr.v caravel_eco-nopwr.v -o lvs -bb
```


