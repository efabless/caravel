#!/usr/bin/env python3
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
import xml.dom.minidom as minidom
import xml.etree.ElementTree as ET
from pathlib import Path


def prettify(element):
    """Return a pretty-printed XML string for the element."""
    rough_string = ET.tostring(element, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent='    ', newl='\n')


def single_quote_between_category_tags(content):
    return re.sub('<category>(.*?)</category>', r"<category>'\1'</category>", content)


def convert(input_file, output_file, design_name):
    re_violation = re.compile(r"violation type: (?P<type>\S+)\s+"
                              r"srcs: (?P<src1>\S+)( (?P<src2>\S+))?\s+"
                              r"bbox = \( (?P<llx>\S+), (?P<lly>\S+) \)"
                              r" - "
                              r"\( (?P<urx>\S+), (?P<ury>\S+) \) "
                              r"on Layer (?P<layer>\S+)", re.M)

    with open(input_file) as fp, open(output_file, 'w') as fpw:
        content = fp.read()
        count = 0
        vio_dict = {}

        for match in re_violation.finditer(content):
            count += 1
            type_ = match.group('type')
            src1 = match.group('src1')
            src2 = match.group('src2')
            llx = match.group('llx')
            lly = match.group('lly')
            urx = match.group('urx')
            ury = match.group('ury')
            layer = match.group('layer')

            item = ET.Element('item')
            ET.SubElement(item, 'category').text = type_
            ET.SubElement(item, 'cell').text = design_name
            ET.SubElement(item, 'visited').text = 'false'
            ET.SubElement(item, 'multiplicity').text = '1'
            values = ET.SubElement(item, 'values')
            box = ET.SubElement(values, 'value')
            box.text = f"box: ({llx},{lly};{urx},{ury})"
            layer_msg = ET.SubElement(values, 'value')
            layer_msg.text = f"text: 'On layer {layer}'"
            srcs = ET.SubElement(values, 'value')
            srcs.text = f"text: 'Between {src1} {src2}'" if src2 else f"text: 'Between {src1}'"

            # create XML object
            if type_ not in vio_dict:
                vio_dict[type_] = []

            vio_dict[type_].append(item)

        print('Found', count, 'violations')

        report_database = ET.Element('report-database')
        categories = ET.SubElement(report_database, 'categories')
        for type_ in vio_dict.keys():
            category = ET.SubElement(categories, 'category')
            ET.SubElement(category, 'name').text = type_

        cells = ET.SubElement(report_database, 'cells')
        cell = ET.SubElement(cells, 'cell')
        ET.SubElement(cell, 'name').text = design_name

        items = ET.Element('items')
        for _, vios in vio_dict.items():
            for item in vios:
                items.append(item)

        report_database.append(items)
        fpw.write(single_quote_between_category_tags(prettify(report_database)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Converts a TritonRoute DRC Report to a KLayout database")
    parser.add_argument('--input_file', '-i', required=True)
    parser.add_argument('--output_file', '-o', required=True)
    parser.add_argument('--design_name', '-d', required=True)
    args = parser.parse_args()

    convert(Path(args.input_file), args.design_name, Path(args.output_file))
