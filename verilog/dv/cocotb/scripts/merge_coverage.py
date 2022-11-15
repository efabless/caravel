from cocotb_coverage.coverage import merge_coverage
import os
import os.path
import logging 
import argparse
parser = argparse.ArgumentParser(description='merge cocotb functional coverage')
parser.add_argument('-path','-p', help='name of regression can found in tests.json')
args = parser.parse_args()
path = args.path
logger = logging.getLogger('example_logger')
# print (path)
cov_files = []
for dirpath, dirnames, filenames in os.walk(path):
    for filename in [f for f in filenames if f =="coverage.ylm"]:
        cov_files.append(os.path.join(dirpath, filename))
        # print (os.path.join(dirpath, filename))
merge_coverage(logger.info,f"{path}/merged.ylm", *cov_files)


""" add HTML reports """ 
import sys
from pathlib import Path
import oyaml as yaml
from prettytable import PrettyTable
from anytree import NodeMixin, RenderTree
import html

reports_path = f"{path}/coverageReports"
Path(f"{reports_path}").mkdir(parents=True, exist_ok=True)
CSS_TEXT = """
        <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <style>
        body
        {
            padding-left: 20px;
        }
        th:nth-child(1) {
          width: 200px;
          }
        
        /* the second */
        th:nth-child(2) {
          width: 200px;
        }
        
        /* the third */
        th:nth-child(3) {
          width: 100px;
         }
         /* the third */
         th:nth-child(4) {
          width: 420px;
         }
         
         pre {
            white-space: -moz-pre-wrap; /* Mozilla, supported since 1999 */
            white-space: -pre-wrap; /* Opera */
            white-space: -o-pre-wrap; /* Opera */
            white-space: pre-wrap; /* CSS3 - Text module (Candidate Recommendation) http://www.w3.org/TR/css3-text/#white-space */
            word-wrap: break-word; /* IE 5.5+ */
            width: 725px
         }
          </style>
        </head>
        """

class Node(NodeMixin):  # Add Node feature
    def __init__(self, key, parent=None, children=None):
        self.key = key
        nodes = key.split('.')
        level = key.count('.')

        self.name = nodes[level]
        self.parent = parent
        if children:
            self.children = children
    def __repr__(self):
        return(self.key)


with open(f"{path}/merged.ylm") as file:
    # The FullLoader parameter handles the conversion from YAML
    # scalar values to Python the dictionary format
    yaml_file_object = yaml.load(file, Loader=yaml.FullLoader)
    root = ""
    tree = {}
    for key in yaml_file_object:
        level = key.count('.')
        nodes = key.split('.')
        key_parent = key.replace(f'.{nodes[level]}', '')
        if level == 0 : 
            root = key
            tree[key] = Node(key=key)
        else: 
            tree[key] = Node(key=key,parent=tree[key_parent])

    for key in yaml_file_object:
        # print(f"{key}  level = {key.count('.')}  yalm: {yaml_file_object[key]} children {tree[key].children}" )
        body_st = []
        prettyTable = PrettyTable()
        body_st.append("<h2>" + key + "</h2>")
        if len(tree[key].children) >0:
            prettyTable.field_names = ["Cover Group", "Size", "Coveraged", "Cover Percentage"]
            for child in tree[key].children:
                prettyTable.add_row([f'<a href="{reports_path}/{child.key}.html"> {child.name}</a>' , yaml_file_object[child.key]["size"], yaml_file_object[child.key]["coverage"], yaml_file_object[child.key]["cover_percentage"]])
        else: 
            prettyTable.field_names = ["Cover Bin", "at least", "hits"]
            for bin in yaml_file_object[key]["bins:_hits"]:
                # print(yaml_file_object[key])
                prettyTable.add_row([bin,yaml_file_object[key]["at_least"] , yaml_file_object[key]["bins:_hits"][bin]])

        table = prettyTable.get_html_string(attributes={"name": key,
                                                        "id": key,
                                                        "class": "table table-striped table-condensed",
                                                        "style": "width: 1450px;table-layout: fixed;overflow-wrap: "
                                                                 "break-word;"},format=True)
        # table = table.get_html_string(format=True)
        table = html.unescape(table)
        body_st.append(table)
        if key == root:
            OUTPUT_HTMl = f"{reports_path}/dashboard.html"
        else: 
            OUTPUT_HTMl = f"{reports_path}/{key}.html"
        f = open(OUTPUT_HTMl, "w")
        html_st = []
        html_st.append(CSS_TEXT)
        html_st.append(" ".join(body_st))
        html_st.append("</html>")
        f.write(" ".join(html_st))
        f.close()
        if key == root:
            print("File " + OUTPUT_HTMl + " has been generated")
        