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
# set_user_id.py ---
#
# Manipulate the magic database, GDS, and verilog source files for the
# user_id_programming block to set the user ID number.
#
# The user ID number is a 32-bit value that is passed to this routine
# as an 8-digit hex number.  If not given as an option, then the script
# will look for the value of the key "project_id" in the info.yaml file
# in the project top level directory
#
# user_id_programming layout map:
# Positions marked (in microns) for value = 0.  For value = 1, move
# the via 0.92um to the left.
#
# Layout grid is 0.46um x 0.34um with half-pitch offset (0.23um, 0.17um)
#
# Signal        Via position (um)
# name		X      Y     
#--------------------------------
# mask_rev[0]   14.49  9.35
# mask_rev[1]	16.33  9.35
# mask_rev[2]	10.35 20.23
# mask_rev[3]	 8.05  9.35
# mask_rev[4]	28.29  9.35
# mask_rev[5]	21.85 25.67
# mask_rev[6]	 8.05 20.23
# mask_rev[7]   20.47  9.35
# mask_rev[8]   17.25 17.85
# mask_rev[9]   25.53 12.07
# mask_rev[10]  22.31 20.23
# mask_rev[11]  13.11  9.35
# mask_rev[12]	23.69 23.29
# mask_rev[13]	24.15 12.07
# mask_rev[14]	13.57 17.85
# mask_rev[15]	23.23  6.97
# mask_rev[16]	24.15 17.85
# mask_rev[17]	 8.51 17.85
# mask_rev[18]	23.69 20.23
# mask_rev[19]	10.81 23.29
# mask_rev[20]	14.95  6.97
# mask_rev[21]	18.17 23.29
# mask_rev[22]	21.39 17.85
# mask_rev[23]	26.45 25.67
# mask_rev[24]	 9.89 17.85
# mask_rev[25]	15.87 17.85
# mask_rev[26]	26.45 17.85
# mask_rev[27]	 8.51  6.97
# mask_rev[28]	10.81  9.35
# mask_rev[29]	27.83 20.23
# mask_rev[30]	16.33 23.29
# mask_rev[31]	 8.05 14.79
#----------------------------------------------------------------------

import os
import sys
import re
import subprocess

def usage():
    print("Usage:")
    print("set_user_id.py [<user_id_value>] [<path_to_project>]")
    print("")
    print("where:")
    print("    <user_id_value>   is a character string of eight hex digits, and")
    print("    <path_to_project> is the path to the project top level directory.")
    print("")
    print("  If <user_id_value> is not given, then it must exist in the info.yaml file.")
    print("  If <path_to_project> is not given, then it is assumed to be the cwd.")
    return 0

if __name__ == '__main__':

    # Coordinate pairs in microns for the zero position on each bit
    mask_rev = (
	(14.49,  9.35), (16.33,  9.35), (10.35, 20.23), ( 8.05,  9.35),
	(28.29,  9.35), (21.85, 25.67), ( 8.05, 20.23), (20.47,  9.35),
	(17.25, 17.85), (25.53, 12.07), (22.31, 20.23), (13.11,  9.35),
	(23.69, 23.29), (24.15, 12.07), (13.57, 17.85), (23.23,  6.97),
	(24.15, 17.85), ( 8.51, 17.85), (23.69, 20.23), (10.81, 23.29),
	(14.95,  6.97), (18.17, 23.29), (21.39, 17.85), (26.45, 25.67),
	( 9.89, 17.85), (15.87, 17.85), (26.45, 17.85), ( 8.51,  6.97),
	(10.81,  9.35), (27.83, 20.23), (16.33, 23.29), ( 8.05, 14.79));

    optionlist = []
    arguments = []

    debugmode = False
    reportmode = False

    for option in sys.argv[1:]:
        if option.find('-', 0) == 0:
            optionlist.append(option)
        else:
            arguments.append(option)

    if len(arguments) > 2:
        print("Wrong number of arguments given to set_user_id.py.")
        usage()
        sys.exit(0)

    if '-debug' in optionlist:
        debugmode = True
    if '-report' in optionlist:
        reportmode = True

    user_id_value = None
    user_project_path = None

    if len(arguments) > 0:
        user_id_value = arguments[0]

        # Convert to binary
        try:
            user_id_int = int('0x' + user_id_value, 0)
            user_id_bits = '{0:032b}'.format(user_id_int)
        except:
            user_project_path = arguments[0]

    if len(arguments) == 0:
        user_project_path = os.getcwd()
    elif len(arguments) == 2:
        user_project_path = arguments[1]
    elif user_project_path == None:
        user_project_path = arguments[0]
    else:
        user_project_path = os.getcwd()

    if not os.path.isdir(user_project_path):
        print('Error:  Project path "' + user_project_path + '" does not exist or is not readable.')
        sys.exit(1)

    # Check for valid directories

    if not user_id_value:
        if os.path.isfile(user_project_path + '/info.yaml'):
            with open(user_project_path + '/info.yaml', 'r') as ifile:
                infolines = ifile.read().splitlines()
                for line in infolines:
                    kvpair = line.split(':')
                    if len(kvpair) == 2:
                        key = kvpair[0].strip()
                        value = kvpair[1].strip()
                        if key == 'project_id':
                            user_id_value = value.strip('"\'')
                            break

            if not user_id_value:
                print('Error:  No project_id key:value pair found in project info.yaml.')
                sys.exit(1)

            try:
                user_id_int = int('0x' + user_id_value, 0)
                user_id_bits = '{0:032b}'.format(user_id_int)
            except:
                print('Error:  Cannot parse user ID "' + user_id_value + '" as an 8-digit hex number.')
                sys.exit(1)

        else:
            print('Error:  No info.yaml file and no user ID argument given.')
            sys.exit(1)

    if reportmode:
        print(str(user_id_int))
        sys.exit(0)

    print('Setting project user ID to: ' + user_id_value)

    magpath = user_project_path + '/mag'
    vpath = user_project_path + '/verilog'
    errors = 0 

    if not os.path.isdir(vpath):
        print('No directory ' + vpath + ' found (path to verilog).')
        sys.exit(1)

    if not os.path.isdir(magpath):
        print('No directory ' + magpath + ' found (path to magic databases).')
        sys.exit(1)

    print('Step 1:  Modify layout of the user_id_programming subcell')

    # Bytes leading up to via position are:
    viarec = "00 06 0d 02 00 43 00 06 0e 02 00 2c 00 2c 10 03 "
    viabytes = bytes.fromhex(viarec)

    # Read the ID programming layout.  If a backup was made of the
    # zero-value program, then use it.

    magbak = magpath + '/user_id_prog_zero.mag'
    magfile = magpath + '/user_id_programming.mag'

    if os.path.isfile(magbak):
        with open(magbak, 'r') as ifile:
            magdata = ifile.read()
    else:
        with open(magfile, 'r') as ifile:
            magdata = ifile.read()

    for i in range(0,32):
        # Ignore any zero bits.
        if user_id_bits[i] == '0':
            continue

        coords = mask_rev[i]
        xum = coords[0]
        yum = coords[1]

        # Contact is 0.17 x 0.17, so add and subtract 0.085 to get
        # the corner positions.

        xllum = xum - 0.085
        yllum = yum - 0.085
        xurum = xum + 0.085
        yurum = yum + 0.085
 
        # Get the values for the corner coordinates in magic internal units
        xlli = int(round(xllum * 200))
        ylli = int(round(yllum * 200))
        xuri = int(round(xurum * 200))
        yuri = int(round(yurum * 200))

        viaoldposdata = 'rect ' + xlli + ' ' + ylli + ' ' + xuri + ' ' + yuri

        # For "one" bits, the X position is moved 0.92 microns to the left
        newxllum = xllum - 0.92
        newxurum = xurum - 0.92

        # Get the values for the new corner coordinates in magic internal units
        newxlli = int(round(newxllum * 200))
        newxuri = int(round(newxurum * 200))

        vianewposdata = 'rect ' + newxlli + ' ' + ylli + ' ' + newxuri + ' ' + yuri

        # Diagnostic
        if debugmode:
            print('Bit ' + str(i) + ':')
            print('Via position ({0:3.2f}, {1:3.2f}) to ({2:3.2f}, {3:3.2f})'.format(xllum, yllum, xurum, yurum))
            print('Old string = "' + viaoldposdata + '"')
            print('New string = "' + vianewposdata + '"')

        # Replace the old data with the new
        if viaoldposdata not in magdata:
            print('Error: via not found for bit position ' + str(i))
            errors += 1 
        else:
            magdata == magdata.replace(viaoldposdata, vianewposdata)

    if errors == 0:
        # Keep a copy of the original 
        if not os.path.isfile(magbak):
            os.rename(magfile, magbak)

        with open(magfile, 'w') as ofile:
            ofile.write(magdata)

        print('Done!')
            
    else:
        print('There were errors in processing.  No file written.')
        print('Ending process.')
        sys.exit(1)

    print('Step 2:  Add user project ID parameter to source verilog.')

    changed = False
    with open(vpath + '/rtl/caravel.v', 'r') as ifile:
        vlines = ifile.read().splitlines()
        outlines = []
        for line in vlines:
            oline = re.sub("parameter USER_PROJECT_ID = 32'h[0-9A-F]+;",
			"parameter USER_PROJECT_ID = 32'h" + user_id_value + ";",
			line)
            if oline != line:
                changed = True
            outlines.append(oline)

    if changed:
        with open(vpath + '/rtl/caravel.v', 'w') as ofile:
            for line in outlines:
                print(line, file=ofile)
            print('Done!')
    else:
        print('Error:  No substitutions done on verilog/rtl/caravel.v.')
        print('Ending process.')
        sys.exit(1)

    print('Step 3:  Add user project ID parameter to gate-level verilog.')

    changed = False
    with open(vpath + '/gl/user_id_programming.v', 'r') as ifile:
        vdata = ifile.read()

    for i in range(0,32):
        # Ignore any zero bits.
        if user_id_bits[i] == '0':
            continue

        outdata = vdata.replace('high[' + str(i) + ']', 'XXXX')
        outdata = outdata.replace('low[' + str(i) + ']', 'high[' + str(i) + ']')
        outdata = outdata.replace('XXXX', 'low[' + str(i) + ']')
        outdata = outdata.replace('LO(mask_rev[' + str(i) + ']',
				  'HI(mask_rev[' + str(i) + ']')
        outdata = outdata.replace('HI(\\user_proj_id_low', 'LO(\\user_proj_id_low')
        changed = True

    if changed:
        with open(vpath + '/gl/user_id_programming.v', 'w') as ofile:
            ofile.write(outdata)
            print('Done!')
    else:
        print('Error:  No substitutions done on verilog/gl/user_id_programming.v.')
        print('Ending process.')
        sys.exit(1)

    print('Step 4:  Add user project ID text to top level layout.')

    with open(magpath + '/user_id_textblock.mag', 'r') as ifile:
        maglines = ifile.read().splitlines()
        outlines = []
        digit = 0
        wasseen = {}
        for line in maglines:
            if 'alphaX_' in line:
                dchar = user_id_value[7 - digit].upper()
                oline = re.sub('alpha_[0-9A-F]', 'alpha_' + dchar, line)
                # Add path reference if cell was not previously found in the file
                if dchar not in wasseen:
                    if 'hexdigits' not in oline:
                        oline += ' hexdigits'
                outlines.append(oline)
                wasseen[dchar] = True
                digit += 1
            else:
                outlines.append(line)

    if digit == 8:
        with open(magpath + '/user_id_textblock.mag', 'w') as ofile:
            for line in outlines:
                print(line, file=ofile)
        print('Done!')
    elif digit == 0:
        print('Error:  No digits were replaced in the layout.')
    else:
        print('Error:  Only ' + str(digit) + ' digits were replaced in the layout.')

    sys.exit(0)
