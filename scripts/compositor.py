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

#
# compositor.py ---
#
#    Compose the final GDS for caravel from the caravel GDS, seal ring
#    GDS, and fill GDS.
#

import sys
import os
import re
import subprocess

def usage():
    print("Usage:")
    print("compositor.py <user_id_value> <project> <path_to_project> <path_to_mag_dir> <path_to_gds_dir [-keep]")
    print("")
    print("where:")
    print("   <user_id_value>   is a character string of eight hex digits, and")
    print("   <path_to_project> is the path to the project top level directory.")
    print("   <path_to_mag_dir> is the path to the mag directory.")
    print("   <path_to_gds_dir> is the path to the gds directory.")
    print("")
    print("  If <user_id_value> is not given, then it must exist in the info.yaml file.")
    print("  If <path_to_project> is not given, then it is assumed to be the cwd.")
    print("  If <path_to_mag_dir> is not given, then it is assumed to be the <path_to_project>/tmp.")
    print("  If <path_to_gds_dir> is not given, then it is assumed to be the <path_to_project>/gds.")
    print("  If '-keep' is specified, then keep the generation script.")
    return 0

if __name__ == '__main__':

    optionlist = []
    arguments = []

    debugmode = False
    keepmode = False

    for option in sys.argv[1:]:
        if option.find('-', 0) == 0:
            optionlist.append(option)
        else:
            arguments.append(option)

    if len(arguments) != 5:
        print("Wrong number of arguments given to compositor.py.")
        usage()
        sys.exit(0)

    user_id_value = arguments[0]
    project = arguments[1]
    user_project_path = arguments[2]
    mag_dir_path = arguments[3]
    gds_dir_path = arguments[4]

    # if len(arguments) > 0:
    #     user_id_value = arguments[0]

    # Convert to binary
    try:
        user_id_int = int('0x' + user_id_value, 0)
        user_id_bits = '{0:032b}'.format(user_id_int)
    except:
        print("User ID not recognized")
        usage()
        sys.exit(1)

    # if len(arguments) == 2 and user_project_path == None:
    #     user_project_path = arguments[1]
    #     mag_dir_path = user_project_path + "/mag"
    #     gds_dir_path = "../gds"
    # if len(arguments) == 3 and user_project_path == None:
    #     user_project_path = arguments[1]
    #     mag_dir_path = arguments[2]
    #     gds_dir_path = "../gds"
    # if len(arguments) == 4:
    #     user_project_path = arguments[1]
    #     mag_dir_path = arguments[2]
    #     gds_dir_path =  arguments[3]
    # elif len(arguments) == 3 and user_project_path != None:
    #     mag_dir_path = arguments[1]
    #     gds_dir_path =  arguments[2]
    # else:
    #     user_project_path = os.getcwd()
    #     mag_dir_path = user_project_path + "/mag"
    #     gds_dir_path = "../gds"

    # Check for valid user path

    if not os.path.isdir(user_project_path):
        print('Error:  Project path "' + user_project_path + '" does not exist or is not readable.')
        sys.exit(1)

    # Check for valid mag path

    if not os.path.isdir(mag_dir_path):
        print('Error:  Mag directory path "' + mag_dir_path + '" does not exist or is not readable.')
        sys.exit(1)

    # Check for valid gds path

    if not os.path.isdir(gds_dir_path):
        print('Error:  GDS directory path "' + gds_dir_path + '" does not exist or is not readable.')
        sys.exit(1)

    # Check for valid user ID
    # if not user_id_value:
    #     if os.path.isfile(user_project_path + '/info.yaml'):
    #         with open(user_project_path + '/info.yaml', 'r') as ifile:
    #             infolines = ifile.read().splitlines()
    #             for line in infolines:
    #                 kvpair = line.split(':')
    #                 if len(kvpair) == 2:
    #                     key = kvpair[0].strip()
    #                     value = kvpair[1].strip()
    #                     if key == 'project_id':
    #                         user_id_value = value.strip('"\'')
    #                         break

    if user_id_value:
        # project = 'caravel'
        # project_with_id = project + '_' + user_id_value
        project_with_id = 'caravel_' + user_id_value
        user_id_decimal = str(int(user_id_value, 16))
    else:
        print('Error:  No project_id found in info.yaml file.')
        sys.exit(1)

    if '-debug' in optionlist:
        debugmode = True
    if '-keep' in optionlist:
        keepmode = True

    magpath = mag_dir_path
    # rcfile = magpath + '/.magicrc'
    rcfile = os.getenv("PDK_ROOT") + '/sky130A/libs.tech/magic/sky130A.magicrc'

    gdspath = gds_dir_path

    # The compositor script will create <project_with_id>.mag, but is uses
    # "load", so the file must not already exist.

    if os.path.isfile(user_project_path + '/mag/' + project_with_id + '.mag'):
        print('Error:  File ' + project_with_id + '.mag exists already!  Exiting. . .')
        sys.exit(1)

    with open(user_project_path + '/mag/compose_final.tcl', 'w') as ofile:
        print('#!/bin/env wish', file=ofile)
        print('drc off', file=ofile)
        # Set the random seed from the project ID
        print('random seed ' + user_id_decimal, file=ofile)

        # Read project from .mag but set GDS properties so that it points
        # to the GDS file created by "make ship".
        print('load ' + project + ' -dereference', file=ofile)
        print('property GDS_FILE ' + gdspath + '/' + project + '.gds', file=ofile)
        print('property GDS_START 0', file=ofile)
        print('select top cell', file=ofile)
        print('set bbox [box values]', file=ofile)

        # Ceate a cell to represent the generated fill.  There are
        # no magic layers corresponding to the fill shape data, and
        # it's gigabytes anyway, so we don't want to deal with any
        # actual data.  So it's just a placeholder.

        print('load ' + project_with_id + '_fill_pattern -quiet', file=ofile)
        print('snap internal', file=ofile)
        print('box values {*}$bbox', file=ofile)
        print('paint comment', file=ofile)
        print('property GDS_FILE ' + gdspath + '/' + project_with_id + '_fill_pattern.gds', file=ofile)
        print('property GDS_START 0', file=ofile)
        print('property FIXED_BBOX "$bbox"', file=ofile)

        # Create a new project top level and place the fill cell.
        print('load ' + project_with_id + ' -quiet', file=ofile)
        print('box values 0 0 0 0', file=ofile)	
        print('box position 6um 6um', file=ofile)	
        print('getcell ' + project + ' child 0 0', file=ofile)
        print('getcell ' + project_with_id + '_fill_pattern child 0 0', file=ofile)

        # Move existing origin to (6um, 6um) for seal ring placement
        # print('move origin -6um -6um', file=ofile)

        # Read in abstract view of seal ring
        print('box position 0 0', file=ofile)
        print('getcell advSeal_6um_gen', file=ofile)

        # Write out completed project as "caravel_" + the user ID
        # print('save '  + user_project_path + '/mag/' + project_with_id, file=ofile)

        # Generate final GDS
        print('puts stdout "Writing final GDS. . . "', file=ofile)
        print('flush stdout', file=ofile)
        print('gds undefined allow', file=ofile)
        print('cif *hier write disable', file=ofile)
        print('gds write ' + gdspath + '/' + project_with_id + '.gds', file=ofile)
        print('quit -noprompt', file=ofile)

    myenv = os.environ.copy()
    # Abstract views are appropriate for final composition
    myenv['MAGTYPE'] = 'maglef'

    print('Building final GDS file ' + project_with_id + '.gds', flush=True)

    mproc = subprocess.run(['magic', '-dnull', '-noconsole',
		'-rcfile', rcfile, user_project_path + '/mag/compose_final.tcl'],
		stdin = subprocess.DEVNULL,
		stdout = subprocess.PIPE,
		stderr = subprocess.PIPE,
		cwd = magpath,
		env = myenv,
		universal_newlines = True)
    if mproc.stdout:
        for line in mproc.stdout.splitlines():
            print(line)
    if mproc.stderr:
        # NOTE:  Until there is a "load -quiet" option in magic, loading
        # a new cell generates an error.  This code ignores the error.
        newlines = []
        for line in mproc.stderr.splitlines():
            if line.endswith("_fill_pattern.mag couldn't be read"):
                continue
            if line.startswith("No such file or directory"):
                continue
            else:
                newlines.append(line)

        if len(newlines) > 0:
            print('Error message output from magic:')
            for line in newlines:
                print(line)
        if mproc.returncode != 0:
            print('ERROR:  Magic exited with status ' + str(mproc.returncode))

    if not keepmode:
        os.remove(user_project_path + '/mag/compose_final.tcl')

    print('Done!')
    exit(0)
