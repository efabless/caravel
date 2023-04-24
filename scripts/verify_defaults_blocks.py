#!/usr/bin/env python3
#
# run_lvs_defaults_blocks.py
#
# Check operation of gen_gpio_defaults.py by running simulation on all
# gpio_defaults_block_XXXX layouts.
#
# 1) create special user_defaults.v file
# 2) run gen_gpio_defaults.py script
# 3) for each gpio_default_block_XXXX layout in mag/:
#     1) extract the layout and generate a SPICE netlist
#     2) parse the netlist for the names of pins connected to conb cells
#     3) determine the connectivity according to the value of pins HI and LO
#     4) print out the binary value of the layout cell's output.
#

import os
import re
import sys
import gzip
import subprocess

bits_list = ["0000", "0001", "0002", "0004", "0008", "0010", "0020", "0040",
	"0080", "0100", "0200", "0400", "0800", "1000", "1fff", "2000",
	"1ffe", "1ffd", "1ffb", "1ff7", "1fef", "1fdf", "1fbf", "1f7f",
	"1eff", "1dff", "1bff", "17ff", "0fff", "1555", "0aaa", "0f0f",
	"10f0"]

expected_results = [
	"0000000000000", "0000000000001", "0000000000010", "0000000000100",
	"0000000001000", "0000000010000", "0000000100000", "0000001000000",
	"0000010000000", "0000100000000", "0001000000000", "0010000000000",
	"0100000000000", "1000000000000", "1111111111111", "1000000000000",
	"1111111111110", "1111111111101", "1111111111011", "1111111110111",
	"1111111101111", "1111111011111", "1111110111111", "1111101111111",
	"1111011111111", "1110111111111", "1101111111111", "1011111111111",
	"0111111111111", "1010101010101", "0101010101010", "0111100001111",
	"1000011110000", "0010000000011", "0100000000001", "1100000000011"]

# IMPORTANT NOTE:  This script is invasive and changes files and does not change
# them back.  Run this only in a git branch which can be removed afterward.

if not os.path.isdir('verilog/rtl'):
    print('***ERROR: This script must be run from the caravel top level directory.')
    sys.exit(1)

with open('verilog/rtl/user_defines.v', 'w') as ofile:
    print('`default_nettype none', file=ofile)
    print('`ifndef __USER_DEFINES_H', file=ofile)
    print('`define __USER_DEFINES_H', file=ofile)
    i = 5
    for bits in bits_list:
        print("`define USER_CONFIG_GPIO_" + str(i) + "_INIT  13'h" + bits, file=ofile)
        i = i + 1
    print('`endif // __USER_DEFINES_H', file=ofile)

subprocess.run('scripts/gen_gpio_defaults.py')

# Create the list of bits in order with channel number.
ordered_bits_list = ["1803", "1803", "0403", "0801", "0403"]
ordered_bits_list.extend(bits_list)

# Add the defaults for channels 0 to 5 to the list.
bits_list.extend(["0403", "0801", "1803"])

os.chdir('mag')
print('Generating netlists from gpio_defaults layouts')
for bits in bits_list:
    if not os.path.isfile('gpio_defaults_block_' + bits + '.mag'):
        print('***ERROR:  There is no layout file for gpio_defaults_block_' + bits + '!')
    elif not os.path.isfile('gpio_defaults_block_' + bits + '.spice'):
        with open('gpio_verify.tcl', 'w') as ofile:
            print('load gpio_defaults_block_' + bits, file=ofile)
            print('extract do local', file=ofile)
            print('extract do local', file=ofile)
            print('extract no all', file=ofile)
            print('extract all', file=ofile)
            print('ext2spice lvs', file=ofile)
            print('ext2spice', file=ofile)
            print('quit', file=ofile)

        # Depend on the .magicrc file in the mag/ directory?
        subprocess.run(['magic', '-dnull', '-noconsole', 'gpio_verify.tcl'])
		
conbrex = re.compile('^Xgpio_default_value.*\[([0-9]+).*\]')

i = 0
print('Checking each generated layout netlist:')
for bits in bits_list:
    # Read SPICE file and verify
    bits_verify = ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
    if not os.path.isfile('gpio_defaults_block_' + bits + '.spice'):
        print('***ERROR:  No netlist generated for gpio_defaults_block_' + bits + '!')
    else:
        with open('gpio_defaults_block_' + bits + '.spice', 'r') as ifile:
            spicelines = ifile.read().splitlines()
            for line in spicelines:
                cmatch = conbrex.match(line)
                if cmatch:
                    bitnum = int(cmatch.group(1))
                    tokens = line.split()
                    if 'gpio_defaults' in tokens[5] and 'gpio_default_value' in tokens[6]:
                        bits_verify[bitnum] = '1'
                    elif 'gpio_defaults' in tokens[6] and 'gpio_default_value' in tokens[5]:
                        bits_verify[bitnum] = '0'
                    else:
                        print('Bad line in netlist: ' + line)
            # Put zero bit at end
            bits_verify.reverse() 
            verify_string = ''.join(bits_verify)
            print('Layout for default ' + bits + ' has configuration ' + verify_string)
            if verify_string != expected_results[i]:
                print('***ERROR:  Expected bit string ' + expected_results[i] + ' but got ' + verify_string + '!')
        i = i + 1
        
blrex = re.compile('^use gpio_defaults_block_([0-9a-zA-Z]+).*gpio_defaults_block_([0-9]+)$')
found = 0

print('Checking modified caravel_core layout:')
if os.path.isfile('caravel_core.mag.gz'):
    with gzip.open('caravel_core.mag.gz', 'r') as ifile:
        for line in ifile.readlines():
            bmatch = blrex.match(line.decode('ascii'))
            if bmatch:
                found = found + 1
                index = int(bmatch.group(2))
                value = bmatch.group(1)
                if value != ordered_bits_list[index]:
                    print('***ERROR:  Expected bit string ' + ordered_bits_list[index] + ' but got ' + value + ' for defaults block index ' + str(index) + '!')
            
elif os.path.isfile('caravel_core.mag'):
    with open('caravel_core.mag', 'r') as ifile:
        for line in ifile.readlines():
            bmatch = blrex.match(line.decode('ascii'))
            if bmatch:
                found = found + 1
                index = int(bmatch.group(2))
                value = bmatch.group(1)
                if value != ordered_bits_list[index]:
                    print('***ERROR:  Expected bit string ' + ordered_bits_list[index] + ' but got ' + value + ' for defaults block index ' + str(index) + '!')
else:
    print('***ERROR:  There is no caravel_core.mag(.gz) file.  Did you run the script from the project top level?')
    
if found != 38:
    print('***ERROR:  Found ' + str(found) + ' defaults blocks in caravel_core, not the expected 38!')
    
# Remove all .ext and .spice files
for bits in bits_list:
    if os.path.isfile('gpio_defaults_block_' + bits + '.ext'):
        os.remove('gpio_defaults_block_' + bits + '.ext')
    if os.path.isfile('gpio_defaults_block_' + bits + '.spice'):
        os.remove('gpio_defaults_block_' + bits + '.spice')

# Remove the input file for magic
os.remove('gpio_verify.tcl')
