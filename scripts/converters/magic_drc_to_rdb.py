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

import argparse
from pathlib import Path


def convert(input_file, output_file, data=True, drc=False):
    try:
        line_type = data
        with open(input_file) as fp, open(output_file, 'w') as fpw:
            line = fp.readline()
            fpw.write(f"${line} 100\n")
            while line:
                line = fp.readline()
                if ('[INFO]' in line) or (len(line.strip()) == 0):
                    continue
                elif '------' in line:
                    line_type = not line_type
                elif line_type == drc:
                    drc_rule = line.strip().split("(")
                    drc_rule = [drc_rule, "UnknownRule"] if len(drc_rule) < 2 else drc_rule
                    fpw.write(f"r_0_{drc_rule[1][:-1]}\n")
                    # fpw.write("500 500 2 Nov 29 03:26:39 2020\n")
                    fpw.write(f"Rule File Pathname: {input_file}\n")
                    fpw.write(f"{drc_rule[1][:-1]}: {drc_rule[0]}\n")
                    drc_number = 1
                elif line_type == data:
                    cord = [int(float(i)) * 100 for i in line.strip().split(' ')]
                    fpw.write(f"p {drc_number} 4\n")
                    fpw.write(f"{cord[0]} {cord[1]}\n")
                    fpw.write(f"{cord[2]} {cord[1]}\n")
                    fpw.write(f"{cord[2]} {cord[3]}\n")
                    fpw.write(f"{cord[0]} {cord[3]}\n")
                    drc_number += 1
    except IOError:
        print(f"Magic DRC Error file not found {input_file}")
    except:
        print("Failed to generate RDB file")


def formatter(prog):
    return argparse.HelpFormatter(prog, max_help_position=60)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(formatter_class=formatter)
    parser.add_argument('--input_file', '-i', required=True)
    parser.add_argument('--output_file', '-o', required=True)
    args = parser.parse_args()

    convert(Path(args.input_file), Path(args.output_file), data=True, drc=False)
