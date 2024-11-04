#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2024 Efabless Corporation
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

#
# generate_subcut.py ---
#
#    Run the subcut generation on a layout top level.
#

import sys
import os
import re
import glob
import subprocess
import multiprocessing

def Usage():
    print("Usage:")
    print("generate_subcut.py <cellname> <input_filename> <output_filename> [-keep] [-test]")
    print("")
    print("where:")
    print("    <cellname> is the target cell name.")
    print("    <input_filename> is the input gds filename.")
    print("    <output_filename> is the output gds filename.")
    print("")
    print("  If '-keep' is specified, then keep the generation script.")
    print("  If '-test' is specified, then create but do not run the generation script.")

    return 0


def Create_Subcut_Script(script_filename,      # this file will be created
                         gds_filename,         # input gds file
                         cellname,             # 
                         subcut_cellname,      # cellname of new subcut only cell
                         subcut_filename): # filename of gds with new subcut cell

    subcut_script_template = """
#!/bin/env wish
drc off
tech unlock *
snap internal
cif istyle subcutin
set starttime [orig_clock format [orig_clock seconds] -format "%D %T"]
puts stdout "Started: $starttime"
    
# Read the cellname from GDS
gds rescale false
gds read {gds_filename}
load {cellname}
select top cell
# Save the boundary
set cellboundary [property FIXED_BBOX]
expand
    
# Flatten into a cell with a new name
puts stdout "Flattening layout ..."
flush stdout
update idletasks
flatten -dobox -nolabels {subcut_cellname}
load {subcut_cellname}
# Reset the boundary after flattening
property FIXED_BBOX $cellboundary
# Remove any GDS_FILE reference (there should not be any?)
property GDS_FILE ""
select top cell
flush stdout
update idletasks
cif ostyle subcutout

gds write {subcut_filename}
set endtime [orig_clock format [orig_clock seconds] -format "%D %T"]
puts stdout "Ended: $endtime"
quit -noprompt
"""
    with open(script_filename, 'w') as script_file:
        print(subcut_script_template.format(gds_filename=gds_filename,
                                            cellname=cellname,
                                            subcut_cellname=subcut_cellname,
                                            subcut_filename=subcut_filename), 
              file=script_file)


if __name__ == '__main__':

    optionlist = []
    arguments = []

    debugmode = False
    keepmode = False
    testmode = False

    for option in sys.argv[1:]:
        if option.find('-', 0) == 0:
            optionlist.append(option)
        else:
            arguments.append(option)

    if len(arguments) < 3:
        print("Wrong number of arguments given to generate_subcut.py.")
        Usage()
        sys.exit(1)

    cellname = arguments[0]
    gds_filename = arguments[1]
    subcut_filename = arguments[2]
    
    if '-debug' in optionlist:
        debugmode = True
    if '-keep' in optionlist:
        keepmode = True
    if '-test' in optionlist:
        testmode = True

    lvs_root = os.getenv("LVS_ROOT")
    pdk = os.getenv("PDK")
    rcfilename = lvs_root + '/tech/' + pdk + '/subcut.magicrc'

    if not os.path.isfile(rcfilename):
        print("Cannot find subcut.magicrc. Should be in $LVS_ROOT/tech/$PDK")
        sys.exit(2)

    if not os.path.isfile(gds_filename):
        print("Could not locate GDS file " + gds_filename)
        sys.exit(2)

    script_filename = 'generate_' + cellname + '_subcut.tcl'
    Create_Subcut_Script(script_filename=script_filename,
                         gds_filename=gds_filename,
                         cellname=cellname,
                         subcut_cellname=cellname+'_subcut',
                         subcut_filename=subcut_filename)

    myenv = os.environ.copy()
    myenv['MAGTYPE'] = 'mag'

    if not testmode:
        # Diagnostic
        print('This script will generate ' + subcut_filename)
        mproc = subprocess.run(['magic', '-dnull', '-noconsole', '-rcfile', rcfilename, script_filename],
		stdin = subprocess.DEVNULL,
		stdout = subprocess.PIPE,
		stderr = subprocess.PIPE,
		env = myenv,
		universal_newlines = True)
        if mproc.stdout:
            for line in mproc.stdout.splitlines():
                print(line)
        if mproc.stderr:
            print('Error message output from magic:')
            for line in mproc.stderr.splitlines():
                print(line)
            if mproc.returncode != 0:
                print('ERROR:  Magic exited with status ' + str(mproc.returncode))

    if not keepmode:
        # Remove fill generation script
        os.remove(script_filename)

    print('Done!')
    exit(0)
