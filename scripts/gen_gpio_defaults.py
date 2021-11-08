#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

#----------------------------------------------------------------------
#
# gen_gpio_defaults.py ---
#
# Manipulate the magic database and GDS to create and apply defaults
# to the GPIO control blocks based on the user's specification in the
# user_defines.v file.
#
# The GPIO defaults block contains 13 bits that set the state of the
# GPIO on power-up.  GPIOs 0 to 4 in the user project area are fixed
# and cannot be modified (to maintain access to the housekeeping SPI
# on startup).  GPIOs 5 to 37 are by default set to be an input pad
# controlled by the user project.  The file "user_defines.v" contains
# the state specified by the user for each GPIO pad, and is what is
# used in verilog simulation.
#
# This script parses the user_defines.v file to determine the state
# of each GPIO.  Then it creates as many new layouts as needed to
# represent all unique states, modifies the caravel.mag layout
# to replace the default layouts with the new ones as needed, and
# generates GDS files for each of the layouts.
#
# gpio_defaults_block layout map:
# Positions marked (in microns) for value = 0.  For value = 1, move
# the via 0.69um to the left.  The given position is the lower left
# corner position of the via.  The via itself is 0.17um x 0.17um.
# The values below are for the file gpio_defaults_block_1403.
# Positions marked "Y" for "Programmed One?" are already moved to
# the left, and so should be move 0.69um to the right if the bit
# should be zero.
#
# Signal                Via position (um)
# name		        X       Y
#-------------------------------------------------------------------
# gpio_defaults[0]   	 5.435  4.165
# gpio_defaults[1]	 6.815  3.825
# gpio_defaults[2]	 8.195  4.165
# gpio_defaults[3]	 9.575  3.825
# gpio_defaults[4]	10.955  3.825
# gpio_defaults[5]	12.565  3.825
# gpio_defaults[6]	14.865  3.825
# gpio_defaults[7]   	17.165  3.825
# gpio_defaults[8]   	19.465  3.825
# gpio_defaults[9]   	21.765  3.825
# gpio_defaults[10]  	24.755  3.825
# gpio_defaults[11]	27.055  3.825
# gpio_defaults[12]  	23.605  4.165
#-------------------------------------------------------------------

import os
import sys
import re

def usage():
    print('Usage:')
    print('gen_gpio_defaults.py [<path_to_project>]')
    print('')
    print('where:')
    print('    <path_to_project> is the path to the project top level directory.')
    print('')
    print('  If <path_to_project> is not given, then it is assumed to be the cwd.')
    print('  The file "user_defines.v" must exist in verilog/rtl/ relative to')
    print('  <path_to_project>.')
    return 0

if __name__ == '__main__':

    # Coordinate pairs in microns for the zero position on each bit
    via_pos = [[5.435, 4.165], [6.815, 3.825], [8.195, 4.165], [9.575, 3.825],
	[10.955, 3.825], [12.565, 3.825], [14.865, 3.825], [17.165, 3.825],
	[19.465, 3.825], [21.765, 3.825], [24.755, 3.825], [27.055, 3.825],
	[23.605, 4.165]]

    optionlist = []
    arguments = []

    debugmode = False
    testmode = False

    for option in sys.argv[1:]:
        if option.find('-', 0) == 0:
            optionlist.append(option)
        else:
            arguments.append(option)

    if len(arguments) > 2:
        print("Wrong number of arguments given to gen_gpio_defaults.py.")
        usage()
        sys.exit(0)

    if '-debug' in optionlist:
        debugmode = True
    if '-test' in optionlist:
        testmode = True

    user_project_path = None

    if len(arguments) == 0:
        user_project_path = os.getcwd()
    else:
        user_project_path = arguments[0]

    if not os.path.isdir(user_project_path):
        print('Error:  Project path "' + user_project_path + '" does not exist or is not readable.')
        sys.exit(1)

    magpath = user_project_path + '/mag'
    gdspath = user_project_path + '/gds'
    vpath = user_project_path + '/verilog'

    # Check paths
    if not os.path.isdir(gdspath):
        print('No directory ' + gdspath + ' found (path to GDS).')
        sys.exit(1)

    if not os.path.isdir(vpath):
        print('No directory ' + vpath + ' found (path to verilog).')
        sys.exit(1)

    if not os.path.isdir(magpath):
        print('No directory ' + magpath + ' found (path to magic databases).')
        sys.exit(1)

    # Parse the user defines verilog file
    kvpairs = {}
    if os.path.isfile(vpath + '/rtl/user_defines.v'):
        with open(vpath + '/rtl/user_defines.v', 'r') as ifile:
            infolines = ifile.read().splitlines()
            for line in infolines:
                tokens = line.split()
                if len(tokens) >= 3:
                    if tokens[0] == '`define':
                        if tokens[2][0] == '`':
                            # If definition is nested, substitute value.
                            tokens[2] = kvpairs[tokens[2]]
                        kvpairs['`' + tokens[1]] = tokens[2]
    else:
        print('Error:  No user_defines.v file found.')
        sys.exit(1)

    # Generate zero and one coordinates for each via
    llx_zero = []
    lly_zero = []
    urx_zero = []
    ury_zero = []
    llx_one  = []
    lly_one  = []
    urx_one  = []
    ury_one  = []
    
    zero_string = []
    one_string = []

    for i in range(0, 13):
        llx_zero = int(via_pos[i][0] * 200)
        lly_zero = int(via_pos[i][1] * 200)
        urx_zero = llx_zero + 34
        ury_zero = lly_zero + 34

        llx_one = llx_zero - 138
        lly_one = lly_zero
        urx_one = urx_zero - 138
        ury_one = ury_zero

        zero_string.append('rect {:d} {:d} {:d} {:d}'.format(llx_zero, lly_zero, urx_zero, ury_zero))
        one_string.append('rect {:d} {:d} {:d} {:d}'.format(llx_one, lly_one, urx_one, ury_one))

    # Create new cells for each unique type
    print('Step 1:  Create new cells for new GPIO default vectors.')

    cellsused = [None] * 38

    for i in range(5, 38):
        config_name = '`USER_CONFIG_GPIO_' + str(i) + '_INIT'
        try:
            config_value = kvpairs[config_name]
        except:
            print('No configuration specified for GPIO ' + str(i) + '; skipping.')
            continue

        try:
            default_str = config_value[-4:]
            binval = '{:013b}'.format(int(default_str, 16))
        except:
            print('Error:  Default value ' + config_value + ' is not a 4-digit hex number; skipping')
            continue

        cell_name = 'gpio_defaults_block_' + default_str
        mag_file = magpath + '/' + cell_name + '.mag'
        cellsused[i] = cell_name

        if not os.path.isfile(mag_file):
            # A cell with this set of defaults doesn't exist, so make it
            # First read the 0000 cell, then write to mag_path while
            # changing the position of vias on the "1" bits

            # Record which bits need to be set
            bitflips = []
            for j in range(0, 13):
                if binval[12 - j] == '1':
                    bitflips.append(j)
                
            with open(magpath + '/gpio_defaults_block_0000.mag', 'r') as ifile:
                maglines = ifile.read().splitlines()
                outlines = []
                for magline in maglines:
                    is_flipped = False
                    for bitflip in bitflips:
                        if magline == zero_string[bitflip]:
                            is_flipped = True
                            break
                    if is_flipped:
                        outlines.append(one_string[bitflip])
                    else:
                        outlines.append(magline)

            print('Creating new layout file ' + mag_file)
            if testmode:
                print('(Test only)')
            else:
                with open(mag_file, 'w') as ofile:
                    for outline in outlines:
                        print(outline, file=ofile)
        else:
            print('Layout file ' + mag_file + ' already exists and does not need to be generated.')

    print('Step 2:  Modify top-level layouts to use the specified defaults.')

    # Create a backup of the caravan and caravel layouts
    if not testmode:
        shutil.copy(magpath + '/caravel.mag', magpath + '/caravel.mag.bak')
        shutil.copy(magpath + '/caravan.mag', magpath + '/caravan.mag.bak')

    if testmode:
        print('Test only:  Caravel layout:')
    with open(magpath + '/caravel.mag', 'r') as ifile:
        maglines = ifile.read().splitlines()
        outlines = []
        for magline in maglines:
            if magline.startswith('use '):
                tokens = magline.split()
                instname = tokens[2]
                if instname.startswith('gpio_defaults_block_'):
                    gpioidx = instname[20:]
                    cellname = cellsused[int(gpioidx)]
                    if cellname:
                        tokens[1] = cellname
                    outlines.append(' '.join(tokens))
                    if testmode:
                        print('Replacing line: ' + magline)
                        print('With: ' + ' '.join(tokens))
                else:
                    outlines.append(magline)
            else:
                outlines.append(magline)

    if not testmode:
        with open(magpath + '/caravel.mag', 'w') as ofile:
            for outline in outlines:
                print(outline, file=ofile)

    if testmode:
        print('Test only:  Caravan layout:')
    with open(magpath + '/caravan.mag', 'r') as ifile:
        maglines = ifile.read().splitlines()
        outlines = []
        for magline in maglines:
            if magline.startswith('use '):
                tokens = magline.split()
                instname = tokens[2]
                if instname.startswith('gpio_defaults_block_'):
                    gpioidx = instname[20:]
                    cellname = cellsused[int(gpioidx)]
                    if cellname:
                        tokens[1] = cellname
                    outlines.append(' '.join(tokens))
                    if testmode:
                        print('Replacing line: ' + magline)
                        print('With: ' + ' '.join(tokens))
                else:
                    outlines.append(magline)
            else:
                outlines.append(magline)

    if not testmode:
        with open(magpath + '/caravan.mag', 'w') as ofile:
            for outline in outlines:
                print(outline, file=ofile)

    print('Done.')
    sys.exit(0)
