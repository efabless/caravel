#!/usr/bin/python3
import json
import os
from fnmatch import fnmatch
import collections


"""This script is for updating the README file with tests from test.json"""

with open('../../tests.json') as f:
    tests_json = json.load(f)["Tests"]


tests = collections.defaultdict(lambda : collections.defaultdict()) #key is testname and value is list of sim types
for test,test_elements in tests_json.items():
    if fnmatch(test,"_*"):
            continue
    elif fnmatch(test,"*bitbang*"):
        tests["bitbang"][test] = test_elements["description"]
    elif fnmatch(test,"*gpio*"):
        tests["gpio"][test] = test_elements["description"]
    elif fnmatch(test,"*hk*"):
        tests["housekeeping"][test] = test_elements["description"]
    elif fnmatch(test,"*spi*") or fnmatch(test,"*user_pass_thru*"):
        tests["housekeeping_spi"][test] = test_elements["description"]
    elif fnmatch(test,"*cpu*"):
        tests["cpu"][test] = test_elements["description"]
    elif fnmatch(test,"*irq*") or fnmatch(test,"*IRQ*"):
        tests["irq"][test] = test_elements["description"]
    elif fnmatch(test,"*timer*"):
        tests["timer"][test] = test_elements["description"]
    elif fnmatch(test,"*spi_master*"):
        tests["spi_master"][test] = test_elements["description"]
    elif fnmatch(test,"*uart*"):
        tests["uart"][test] = test_elements["description"]
    elif fnmatch(test,"*la*"):
        tests["la"][test] = test_elements["description"]
    elif fnmatch(test,"*pll*"):
        tests["pll"][test] = test_elements["description"]
    elif fnmatch(test,"*shifting*"):
        tests["shifting"][test] = test_elements["description"]
    else: 
        tests["general"][test] = test_elements["description"]

with open("README.md", 'w') as file:
    for key, value in tests.items():
        file.write(f"# {key}\n")
        for test,test_elements in value.items():
            file.write(f"### {test} \n")
            file.write(f"```{test_elements}``` \n")

for key, value in tests.items():
    print(key) 
    print(value)