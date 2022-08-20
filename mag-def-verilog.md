#mpw2 #mag #def

## mag-def

1. create abstract lef views for the blocks that don't have a lef view. For example:

```
load mag/gpio_defaults_block_0403
select top cell
lef write lef/gpio_defaults_block_0403.lef -hide
```
the above was done for the following blocks:
1. `gpio_defaults_block_0403`
2. `gpio_defaults_block_1803`
3. `caravel_power_routing`

2. mag-def:

```
# read all lefs 
foreach lef [glob lef/*.lef] { lef_read $lef }
load mag/caravel
# extract to get a nets section in the def
extract
def write caravel.def
```

##### problems with def:

- no special nets; power nets are treated as nets
- `BLOCKAGES`  section likely has bad syntax

3. def-verilog; using openroad:

```
read_lef <tlef>
foreach lef [glob lef/*.lef] { lef_read $lef }
read_def caravel.def
write_verilog caravel.v
```

##### problems with verilog:

- power/ground nets concerns


### general notes

- in order to have special nets sections we need to read and annotate with a def that has a special nets section; from magic docs http://opencircuitdesign.com/magic/commandref/def.html :

```
The "-labels" option to the "def read" command causes each net in the NETS and SPECIALNETS sections of the DEF file to be annotated with a label having the net name as the label text.
```

- in order to generate an ouput def out of a mag while preserving the net names of the def input/source to mag we need to label the nets while reading in the def before creating the mag (too late) or annotate the mag after the fact with the original def file. however they are so different that side effect are unkown however this remains untested