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
    for filename in [f for f in filenames if f =="coverage.xml"]:
        cov_files.append(os.path.join(dirpath, filename))
        # print (os.path.join(dirpath, filename))
merge_coverage(logger.info,f"{path}/merged.xml", *cov_files)