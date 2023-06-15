# Environment setup

In order to run the verification simulation you need to set up the Caravel environment.
To do so, clone [Caravel](https://github.com/efabless/caravel) and the [Caravel management SoC](https://github.com/efabless/caravel_mgmt_soc_litex).

```
mkdir caravel_verification
cd caravel_verification
mkdir pdks
git clone https://github.com/efabless/caravel
git clone https://github.com/efabless/caravel_mgmt_soc_litex
```

Once the repositories are cloned, set the following environment variables:

```
export PDK_ROOT=$(pwd)/pdks
export MCW_ROOT=$(pwd)/caravel_mgmt_soc_litex
export CARAVEL_ROOT=$(pwd)/caravel
export PDK=sky130A #or SKY130B
```

The next step is installing the PDK.
This can be done using the Makefile from the Caravel repository:

```
cd caravel
make pdk
```

Once all the above settings are set and the prerequisites in place, you can run the simulations.
