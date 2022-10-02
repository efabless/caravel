# Copyright 2020 Efabless Corporation
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

import argparse
from pathlib import Path


def convert(input_file, output_file):
    """
        design name
        violation message
        list of violations
        Total Count:
    """

    # Converting Magic DRC
    split_line = '----------------------------------------'
    with open(input_file) as fp, open(output_file, 'w') as fpw:
        drc_content = fp.read()
        if drc_content is not None:
            drc_sections = drc_content.split(split_line)
            if len(drc_sections) > 2:
                for i in range(1, len(drc_sections) - 1, 2):
                    vio_name = drc_sections[i].strip()
                    for vio in drc_sections[i + 1].split('\n'):
                        vio = "um ".join(vio.strip().split())
                        if len(vio):
                            vio_line = "box " + vio + "; feedback add \"" + vio_name + "\" medium"
                            fpw.write(f"{vio_line}\n")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Converts a magic.drc file to a magic readable tcl file.")
    parser.add_argument('--input_file', '-i', required=True)
    parser.add_argument('--output_file', '-o', required=True)
    args = parser.parse_args()

    convert(Path(args.input_file), Path(args.output_file))
