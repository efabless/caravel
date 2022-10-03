#!/usr/local/bin/python

import argparse
from cmath import log
import logging
import os
import subprocess


def build_caravel(caravel_root, mcw_root, pdk_root, log_dir, pdk_env):
    os.environ["CARAVEL_ROOT"] = caravel_root
    os.environ["MCW_ROOT"] = mcw_root
    os.environ["PDK_ROOT"] = pdk_root
    os.environ["PDK"] = pdk_env
    build_cmd = [
        "magic",
        "-noconsole",
        "-dnull",
        "-rcfile",
        f"{pdk_root}/{pdk_env}/libs.tech/magic/{pdk_env}.magicrc",
        "build.tcl",
    ]
    log_file_path = f"{log_dir}/build_caravel.log"
    with open(log_file_path, "w") as build_log:
        subprocess.run(build_cmd, stderr=build_log, stdout=build_log)

def run_drc(caravel_root, log_dir, signoff_dir, pdk_root):
    klayout_drc_cmd = [
        "python3",
        "klayout_drc.py",
        "-g",
        f"{caravel_root}/gds/caravel.gds",
        "-l",
        f"{log_dir}",
        "-s",
        f"{signoff_dir}",
        "-d",
        "caravel"
    ]
    mag_drc_cmd = [
        "python3",
        "magic_drc.py",
        "-g",
        f"{caravel_root}/gds/caravel.gds",
        "-l",
        f"{log_dir}",
        "-s",
        f"{signoff_dir}",
        "-p",
        f"{pdk_root}/sky130A",
        "-d",
        "caravel"
    ]
    p1 = subprocess.Popen(klayout_drc_cmd)
    p2 = subprocess.Popen(mag_drc_cmd)
    return p1, p2

def run_lvs(caravel_root, mcw_root, log_dir, signoff_dir, pdk_root, lvs_root, pdk_env):
    os.environ["PDK_ROOT"] = pdk_root
    os.environ["PDK"] = pdk_env
    os.environ["LVS_ROOT"] = lvs_root
    os.environ["LOG_ROOT"] = log_dir
    os.environ["CARAVEL_ROOT"] = caravel_root
    os.environ["MCW_ROOT"] = mcw_root
    os.environ["SIGNOFF_ROOT"] = os.path.join(signoff_dir,"reports")
    lvs_cmd = [
        "bash",
        "./extra_be_checks/run_full_lvs",
        "caravel",
        f"{caravel_root}/verilog/gl/caravel.v",
        "caravel",
        f"{caravel_root}/gds/caravel.gds"
    ]
    p1 = subprocess.Popen(lvs_cmd)
    return p1

def check_errors(log_dir, signoff_dir, drc, lvs):
    drc_count_mag = os.path.join(log_dir, "caravel_magic_drc.total")
    drc_count_klayout = os.path.join(log_dir, "caravel_klayout_drc.total")
    lvs_report = os.path.join(signoff_dir, "reports/caravel.lvs.report")
    count = 0
    if drc:
        with open(drc_count_mag) as rep:
            if rep.readline() != 0:
                logging.error("magic DRC failed")
                count = count + 1
        with open(drc_count_klayout) as rep:
            if rep.readline() != 0:
                logging.error("klayout DRC failed")
                count = count + 1
    if lvs:
        with open(lvs_report) as rep:
            if "Netlists do not match" in rep.read():
                logging.error("LVS failed")
                count = count + 1

    if count > 0:
        return False
    return True


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG, format=f"%(asctime)s | %(levelname)-7s | %(message)s", datefmt='%d-%b-%Y %H:%M:%S')
    parser = argparse.ArgumentParser(description='CI wrapper')
    parser.add_argument(
             "-d",
             "--drc_check",
             help="run drc check",
             action="store_true",
         )
    parser.add_argument(
             "-l",
             "--lvs_check",
             help="run lvs check",
             action="store_true",
         )
    args = parser.parse_args()

    if not os.getenv("PDK_ROOT"):
        logging.error("Please export PDK_ROOT")
        exit(1)
    if not os.getenv("PDK"):
        logging.error("Please export PDK")
        exit(1)
    caravel_redesign_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    caravel_root = os.path.join(caravel_redesign_root, "caravel")
    mcw_root = os.path.join(caravel_redesign_root, "caravel_mgmt_soc_litex")
    pdk_root = os.getenv("PDK_ROOT")
    pdk_env = os.getenv("PDK")
    log_dir = os.path.join(caravel_root,"scripts/logs")
    signoff_dir = os.path.join(caravel_root,"signoff")
    lvs_root = os.path.join(caravel_root, "scripts/extra_be_checks")
    drc = args.drc_check
    lvs = args.lvs_check

    if not os.path.exists(f"{log_dir}"):
        os.makedirs(f"{log_dir}")
    if not os.path.exists(f"{signoff_dir}/reports"):
        os.makedirs(f"{signoff_dir}/reports")

    logging.info("Building caravel...")

    build_caravel(caravel_root, mcw_root, pdk_root, log_dir, pdk_env)

    if drc:
        drc_p1, drc_p2 = run_drc(caravel_root, log_dir, signoff_dir, pdk_root)
        logging.info("Running klayout and magic DRC on caravel")
    if lvs:
        lvs_p1 = run_lvs(caravel_root, mcw_root, log_dir, signoff_dir, pdk_root, lvs_root, pdk_env)
        logging.info("Running LVS on caravel")

    if lvs and drc:
        drc_p1.wait()
        drc_p2.wait()
        lvs_p1.wait()
    elif lvs:
        lvs_p1.wait()
    elif drc:
        drc_p1.wait()
        drc_p2.wait()

    if not check_errors(log_dir, signoff_dir, drc, lvs):
        exit(1)



