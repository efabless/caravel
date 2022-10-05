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
        "tech-files/build.tcl",
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
    p1 = subprocess.Popen(klayout_drc_cmd)
    return p1

def run_lvs(caravel_root, mcw_root, log_dir, signoff_dir, pdk_root, lvs_root, work_root, pdk_env):
    os.environ["PDK_ROOT"] = pdk_root
    os.environ["PDK"] = pdk_env
    os.environ["LVS_ROOT"] = lvs_root
    os.environ["WORK_ROOT"] = work_root
    os.environ["LOG_ROOT"] = log_dir
    os.environ["CARAVEL_ROOT"] = caravel_root
    os.environ["MCW_ROOT"] = mcw_root
    os.environ["SIGNOFF_ROOT"] = os.path.join(signoff_dir,"caravel")
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

def run_verification(caravel_root, pdk_root, pdk_env, sim):
    os.environ["PDK_ROOT"] = pdk_root
    os.environ["PDK"] = pdk_env
    lvs_cmd = [
        "python3",
        "verify_cocotb.py",
        "-tag",
        f"CI_{sim}",
        "-r",
        f"r_{sim}",
        "-v"
    ]
    p1 = subprocess.Popen(lvs_cmd, cwd=f"{caravel_root}/verilog/dv/cocotb", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return p1


def check_errors(caravel_root, log_dir, signoff_dir, drc, lvs, verification):
    drc_count_mag = os.path.join(log_dir, "caravel_magic_drc.total")
    drc_count_klayout = os.path.join(log_dir, "caravel_klayout_drc.total")
    lvs_report = os.path.join(signoff_dir, "caravel/caravel.lvs.report")
    count = 0
    if drc:
        with open(drc_count_mag) as rep:
            if rep.readline() != 0:
                logging.error("magic DRC failed")
                count = count + 1
        with open(drc_count_klayout) as rep:
            if rep.readline() != 0:
                logging.error(f"klayout DRC failed")
                count = count + 1
    if lvs:
        with open(lvs_report) as rep:
            if "Netlists do not match" in rep.read():
                logging.error(f"LVS failed, find report in {lvs_report}")
                count = count + 1

    if verification:
        for sim in ["rtl", "gl", "sdf"]:
            verification_report = os.path.join(caravel_root, f"/verilog/dv/cocotb/sim/CI_{sim}/runs.log")
            with open(verification_report) as rep:
                if "(0)failed" in rep.read():
                    pass
                else:
                    logging.error(f"{sim} simulations failed, find report in {verification_report}")
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
    parser.add_argument(
             "-v",
             "--verification",
             help="run verification",
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
    work_root = os.path.join(caravel_root, "scripts/tech-files")
    drc = args.drc_check
    lvs = args.lvs_check
    verification = args.verification

    if not os.path.exists(f"{log_dir}"):
        os.makedirs(f"{log_dir}")
    if not os.path.exists(f"{signoff_dir}/caravel"):
        os.makedirs(f"{signoff_dir}/caravel")

    logging.info("Building caravel...")

    build_caravel(caravel_root, mcw_root, pdk_root, log_dir, pdk_env)

    if drc:
        drc_p1 = run_drc(caravel_root, log_dir, signoff_dir, pdk_root)
        logging.info("Running klayout and magic DRC on caravel")
    if lvs:
        lvs_p1 = run_lvs(caravel_root, mcw_root, log_dir, signoff_dir, pdk_root, lvs_root, work_root, pdk_env)
        logging.info("Running LVS on caravel")
    if verification:
        verify_p = []
        sim = ["rtl", "gl", "sdf"]
        for sim in sim:
            logging.info(f"Running all {sim} verification on caravel")
            verify_p.append(run_verification(caravel_root, pdk_root, pdk_env, sim))
        for i in range(len(verify_p)):
            out, err = verify_p[i].communicate()
            if err:
                logging.error(err.decode())

    if lvs and drc:
        drc_p1.wait()
        lvs_p1.wait()
    if lvs:
        lvs_p1.wait()
    if drc:
        drc_p1.wait()

    if not check_errors(caravel_root, log_dir, signoff_dir, drc, lvs, verification):
        exit(1)



