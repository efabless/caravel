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
import re
from pathlib import Path


def cleanup(vio_type):
    return str(vio_type).replace(' ', '_').replace('>', 'gt').replace('<', 'lt').replace('=', 'eq').replace('!', 'not').replace('^', 'pow').replace('.', 'dot').replace('-', '_').replace('+', 'plus').replace('(', '').replace(')', '')


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
        pattern = re.compile(r'.*\s*\((\S+)\.?\s*[^\(\)]+\)')
        if drc_content is not None:
            drc_sections = drc_content.split(split_line)
            if len(drc_sections) > 2:
                for i in range(1, len(drc_sections) - 1, 2):
                    vio_name = drc_sections[i].strip()
                    match = pattern.match(vio_name)
                    if match:
                        layer = match.group(1).split('.')[0]
                    message_prefix = f"  violation type: {cleanup(vio_name)}\n    srcs: N/A N/A\n"
                    for vio in drc_sections[i + 1].split('\n'):
                        vio_cor = vio.strip().split()
                        if len(vio_cor) > 3:
                            vio_line = f"{message_prefix}    bbox = ( {vio_cor[0]}, {vio_cor[1]} ) - ( {vio_cor[2]}, {vio_cor[3]} ) on Layer {layer}"
                            fpw.write(f"{vio_line}\n")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Converts a magic.drc file to a TritonRoute DRC format file.")
    parser.add_argument('--input_file', '-i', required=True)
    parser.add_argument('--output_file', '-o', required=True)
    args = parser.parse_args()

    convert(Path(args.input_file), Path(args.output_file))
