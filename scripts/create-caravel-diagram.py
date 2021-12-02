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
import sys
import os
import subprocess
from pathlib import Path
import argparse
from tempfile import mkstemp
import re


def remove_inouts(jsonpath, replacewith='input'):
    """Replaces inouts with either input or output statements.

    Netlistsvg does not parse inout ports as for now, so they need to be
    replaced with either input or output to produce a diagram.

    Parameters
    ----------
    jsonpath : str
        Path to JSON file to fix
    replacewith : str
        The string to replace 'inout', can be 'input' or 'output'
    """
    assert replacewith in ['input', 'output']
    with open(jsonpath, 'r') as withinouts:
        lines = withinouts.readlines()
    with open(jsonpath, 'w') as withoutinouts:
        for line in lines:
            withoutinouts.write(re.sub('inout', replacewith, line))


def main(argv):
    parser = argparse.ArgumentParser(argv[0])
    parser.add_argument(
        'verilog_rtl_dir',
        help="Path to the project's verilog/rtl directory",
        type=Path)
    parser.add_argument(
        'output',
        help="Path to the output SVG file",
        type=Path)
    parser.add_argument(
        '--num-iopads',
        help='Number of iopads to render',
        type=int,
        default=38)
    parser.add_argument(
        '--yosys-executable',
        help='Path to yosys executable',
        type=Path,
        default='yosys')
    parser.add_argument(
        '--netlistsvg-executable',
        help='Path to netlistsvg executable',
        type=Path,
        default='netlistsvg')
    parser.add_argument(
        '--inouts-as',
        help='To what kind of IO should inout ports be replaced',
        choices=['input', 'output'],
        default='input'
    )

    args = parser.parse_args(argv[1:])

    fd, jsonpath = mkstemp(suffix='-yosys.json')
    os.close(fd)

    yosyscommand = [
        f'{str(args.yosys_executable)}',
        '-p',
        'read_verilog pads.v defines.v; ' +
        'read_verilog -lib -overwrite *.v; ' +
        f'verilog_defines -DMPRJ_IO_PADS={args.num_iopads}; ' +
        'read_verilog -overwrite caravel.v; ' +
        'hierarchy -top caravel; ' +
        'proc; ' +
        'opt; ' +
        f'write_json {jsonpath}; '
    ]

    result = subprocess.run(
        yosyscommand,
        cwd=args.verilog_rtl_dir,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    )

    exitcode = 0
    if result.returncode != 0:
        print(f'Failed to run: {" ".join(yosyscommand)}', file=sys.stderr)
        print(result.stdout.decode())
        exitcode = result.returncode
    else:
        # TODO once netlistsvg supports inout ports, this should be removed
        remove_inouts(jsonpath, args.inouts_as)
        command = f'{args.netlistsvg_executable} {jsonpath} -o {args.output}'
        result = subprocess.run(
            command.split(),
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT
        )
        if result.returncode != 0:
            print(f'Failed to run: {command}', file=sys.stderr)
            print(result.stdout.decode())
            exitcode = result.returncode

    os.unlink(jsonpath)
    sys.exit(exitcode)


if __name__ == '__main__':
    sys.exit(main(sys.argv))
