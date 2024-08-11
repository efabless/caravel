#! /usr/bin/env python3

"""
Create environment variables from a hierarchy of configuration files.

Return codes:
0: no error
2: file not found
3: invalid json
4. could not substitute environment variable
"""

import argparse
import logging
import subprocess
import os
import pprint
import sys
from pathlib import Path
from datetime import datetime
import json
import re

lvs_vars = [
    'TOP_SOURCE',
    'TOP_LAYOUT',
    'LAYOUT_FILE',
    'EXTRACT_FLATGLOB',
    'EXTRACT_ABSTRACT',
    'EXTRACT_CREATE_SUBCUT',
    'EXTRACT_TYPE',
    'LVS_FLATTEN',
    'LVS_NOFLATTEN',
    'LVS_IGNORE',
    'LVS_SPICE_FILES_TO_FIX',
    'LVS_SPICE_FILES',
    'LVS_VERILOG_FILES'
]


def substitute_env_variables(input_string, env):
    """ Return the string after replacing all environment variables ($varname) with the corresponding values from the environment.

    Only handles simple variables $[A-Za-z0-9_]*. Does not handle ${varname}, $$, etc.
    Missing variables are fatal errors.
    """
    string = input_string
    if "$" in string:
        words = re.findall(r'\$\w+', string)  # returns a list of all environment variables used.
        for w in words:
            env_var = w[1:]  # remove leading '$'
            if env_var in env:
                string = string.replace(w, env.get(env_var), 1)  # only replace first occurence. Others will be replaced later.
            else:
                print(f"ERROR: couldn't find environment variable {w} used in {input_string}", file=sys.stderr)
                sys.exit(4)

    return string


def parse_config_file(json_file, lvs_env):
    """ Parses a json file which may reference other json files and uses the values to set environment variables.

    List values are accumulated while scalar values are overwritten when processing sub files.
    Duplicate list values are silently ignored.
    json syntax errors are fatal errors.
    """
    if not os.path.exists(f"{json_file}"):
        print(f"ERROR: Could not find configuration file {json_file}", file=sys.stderr)
        sys.exit(2)

    print(f"Loading LVS environment from {json_file}", file=sys.stderr)
    try:
        with open(json_file, "r") as f:
            data = json.load(f)
        for key, value in data.items():
            if type(value) == list:
                exports = lvs_env[key].split() if key in lvs_env else []  # current environment list values
                for val in value:
                    val = substitute_env_variables(val, lvs_env)
                    if val not in exports:  # only add if not already in list
                        exports.append(val)
                        if key == 'INCLUDE_CONFIGS':  # load child configs
                            lvs_env['INCLUDE_CONFIGS'] += " " + val  # prevents loading same config twice
                            parse_config_file(val, lvs_env)
                if key != 'INCLUDE_CONFIGS':  # the value of the INCLUDE_CONFIGS key is already updated before the recursive call.
                    lvs_env[key] = ' '.join(exports)
            else:  # value is not a list. new value overrides any previous value.
                value = substitute_env_variables(value, lvs_env)
                lvs_env[key] = value
    except Exception as err:
        print(type(err), file=sys.stderr)
        print(err.args, file=sys.stderr)
        print(f"ERROR: with file {json_file}", file=sys.stderr)
        sys.exit(3)


def clear_env(env, keys):
    """ Clear any previous setting for keys in the environment.
    """
    for key in keys:
        if key in env:
            del env[key]
            print(f"unset {key}")


def print_env(env, keys):
    """ Print assignment statements for keys in env.
    """
    for key in keys:
        if key in env:
            print(f"export {key}='{env[key]}'")
            #pprint.pprint({key: env[key]}, stream=sys.stderr)
        else:
            print(f"export {key}=")
            #pprint.pprint({key: ''}, stream=sys.stderr)


def set_lvs_env(config_file, design_name):
    """ Print a list of shell export commands to set LVS variables.

    Any errors are fatal.
    """
    lvs_env = os.environ.copy()
    clear_env(lvs_env, lvs_vars)
    lvs_env['INCLUDE_CONFIGS'] = f"{config_file}"
    lvs_env['DESIGN_NAME'] = design_name
    parse_config_file(config_file, lvs_env)
    print_env(lvs_env, lvs_vars)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Creates the LVS environment')
    parser.add_argument('--config_file', '-c', required=True, help='LVS config file')
    parser.add_argument('--design_name', '-d', required=False, help='Top source override')
    args = parser.parse_args()
    config_file = Path(args.config_file)
    set_lvs_env(config_file, args.design_name)
