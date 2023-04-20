#!/usr/local/bin/python

import argparse
from cmath import log
import logging
import os
import subprocess
from sys import stdout
import count_lvs
import glob
import time
import shutil


def build_caravel_caravan(caravel_root, mcw_root, pdk_root, log_dir, pdk_env, design):
    os.environ["CARAVEL_ROOT"] = caravel_root
    os.environ["MCW_ROOT"] = mcw_root
    os.environ["PDK_ROOT"] = pdk_root
    os.environ["PDK"] = pdk_env
    os.environ["DESIGN"] = design

    gpio_defaults_cmd = ["python3", f"scripts/gen_gpio_defaults.py"]
    build_cmd = [
        "magic",
        "-noconsole",
        "-dnull",
        "-rcfile",
        f"{pdk_root}/{pdk_env}/libs.tech/magic/{pdk_env}.magicrc",
        "tech-files/build.tcl",
    ]
    log_file_path = f"{log_dir}/build_{design}.log"
    with open(log_file_path, "w") as build_log:
        subprocess.run(
            gpio_defaults_cmd, cwd=caravel_root, stderr=build_log, stdout=build_log
        )
        subprocess.run(build_cmd, stderr=build_log, stdout=build_log)

def run_drc(design_root, timestr, signoff_dir, pdk_path, design):
    log_dir = f"{signoff_dir}/{design}/standalone_pvr/{timestr}/logs"
    if "sky130" in os.getenv('PDK'):
        klayout_drc_cmd = [
            "python3",
            "klayout_drc.py",
            "-g",
            f"{design_root}/gds/{design}.gds",
            "-l",
            f"{log_dir}",
            "-s",
            f"{signoff_dir}/{design}/standalone_pvr/{timestr}",
            "-d",
            f"{design}",
        ]
    elif "gf180" in os.getenv('PDK'):
        klayout_drc_cmd = [
            "python3",
            f"{pdk_path}/libs.tech/klayout/drc/run_drc.py",
            "--variant=C",
            f"--path={design_root}/gds/{design}.gds",
            f"--run_dir={signoff_dir}/{design}/standalone_pvr/{timestr}",
        ]

    p1 = subprocess.Popen(klayout_drc_cmd)
    return p1


def run_lvs(
    caravel_root, mcw_root, log_dir, signoff_dir, pdk_root, lvs_root, pdk_env, design
):
    myenv = os.environ.copy()
    myenv["PDK_ROOT"] = pdk_root
    myenv["PDK"] = pdk_env
    myenv["LVS_ROOT"] = lvs_root
    myenv["LOG_ROOT"] = log_dir
    myenv["CARAVEL_ROOT"] = caravel_root
    myenv["MCW_ROOT"] = mcw_root
    myenv["SIGNOFF_ROOT"] = os.path.join(signoff_dir, f"{design}/standalone_pvr")
    myenv["WORK_DIR"] = os.path.join(caravel_root, "extra_be_checks")

    if not os.path.exists(f"{lvs_root}"):
        subprocess.run(
            [
                "git",
                "clone",
                "https://github.com/d-m-bailey/extra_be_checks.git",
                "-b",
                f"caravel",
            ],
            cwd=f"{caravel_root}/scripts",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
    if (design == "mgmt_core_wrapper" or design == "RAM128" or design == "RAM256"):
        lvs_cmd = [
            "bash",
            "./run_full_lvs",
            f"{design}",
            f"{mcw_root}/verilog/gl/{design}.v",
            f"{design}",
            f"{mcw_root}/gds/{design}.gds",
        ]
    else:
        lvs_cmd = [
            "bash",
            "./run_full_lvs",
            f"{design}",
            f"{caravel_root}/verilog/gl/{design}.v",
            f"{design}",
            f"{caravel_root}/gds/{design}.gds",
        ]
    p1 = subprocess.Popen(
        lvs_cmd,
        env=myenv,
        cwd=f"{caravel_root}/scripts/extra_be_checks",
        universal_newlines=True,
    )
    return p1


def run_verification(caravel_root, pdk_root, pdk_env, sim, simulator="vcs"):
    myenv = os.environ.copy()
    myenv["PDK_ROOT"] = pdk_root
    myenv["PDK"] = pdk_env
    if simulator == "vcs":
        ver_cmd = [
            "python3",
            "verify_cocotb.py",
            "-tag",
            f"CI_{sim}",
            "-r",
            f"r_{sim}",
            "-v",
        ]
    else:
        ver_cmd = [
            "python3",
            "verify_cocotb.py",
            "-tag",
            f"CI_{sim}",
            "-r",
            f"r_{sim}",
        ]
    p1 = subprocess.Popen(
        ver_cmd,
        cwd=f"{caravel_root}/verilog/dv/cocotb",
        env=myenv,
        universal_newlines=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return p1


def run_sta(root, pt_lib_root, log_dir, signoff_dir, design, timestr, upw):
    myenv = os.environ.copy()
    myenv["PT_LIB_ROOT"] = pt_lib_root
    if "sky130" in os.getenv('PDK'):
        if not os.path.exists(f"{pt_lib_root}"):
            subprocess.run(
                [
                    "git",
                    "clone",
                    "git@github.com:efabless/pt_libs.git",
                ],
                cwd=f"{caravel_root}/scripts",
                stdout=subprocess.PIPE,
            )
    sta_cmd = [
        "python3",
        "run_pt_sta.py",
        "-a",
        "-d",
        f"{design}",
        "-o",
        f"{signoff_dir}/{design}/primetime/{timestr}",
        "-l",
        f"{log_dir}",
        "-r",
        f"{root}",
        "-upw",
        f"{upw}",
    ]
    p1 = subprocess.Popen(
        sta_cmd,
        cwd=f"{caravel_root}/scripts",
        env=myenv,
        universal_newlines=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return p1

def run_starxt (design_root, log_dir, signoff_dir, design, timestr):
    myenv = os.environ.copy()
    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    if not os.path.exists(f"{SCRIPT_DIR}/gf180mcu-tech/"):
        subprocess.run(
            [
                "git",
                "clone",
                "git@github.com:efabless/gf180mcu-tech.git",
            ],
            cwd=f"{caravel_root}/scripts",
            stdout=subprocess.PIPE,
        )
    starxt_cmd = [
        "python3",
        "extract_StarRC.py",
        "-a",
        "-d",
        f"{design}",
        "-o",
        f"{signoff_dir}/{design}/StarRC/{timestr}",
        "-r",
        f"{design_root}",
        "-l",
        f"{log_dir}",
    ]
    p1 = subprocess.Popen(
        starxt_cmd,
        cwd=f"{caravel_root}/scripts",
        env=myenv,
        universal_newlines=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return p1

def run_antenna(design_root, timestr, signoff_dir, pdk_path, design):
    klayout_antenna_cmd = [
        "python3",
        f"{pdk_path}/libs.tech/klayout/drc/run_drc.py",
        "--variant=C",
        "--antenna_only",
        f"--path={design_root}/gds/{design}.gds",
        f"--run_dir={signoff_dir}/{design}/standalone_pvr/{timestr}/",
    ]
    p1 = subprocess.Popen(klayout_antenna_cmd)
    return p1


def check_errors(
    caravel_root, log_dir, signoff_dir, drc, lvs, verification, sta, design, antenna
):
    f = open(os.path.join(signoff_dir, f"{design}/signoff.rpt"), "w")
    if drc:
        if "sky130" in os.getenv('PDK'):
            drc_count_klayout = os.path.join(log_dir, f"{design}_klayout_drc.total")
            with open(drc_count_klayout) as rep:
                if rep.readline().strip() != "0":
                    logging.error(f"klayout DRC failed")
                    f.write("Klayout MR DRC:    Failed\n")
                else:
                    logging.info("Klayout MR DRC:    Passed")
                    f.write("Klayout MR DRC:    Passed\n")
        elif "gf180" in os.getenv('PDK'):
            drc_output_dir = f"{signoff_dir}/{design}/standalone_pvr/{timestr}"
            log_drc_file = glob.glob(f"{drc_output_dir}/drc_run_*.log")[0]
            os.remove(f"{drc_output_dir}/main.drc")
            with open(log_drc_file) as rep:
                for lines in rep:
                    if "not clean" in lines:
                        logging.error(f"klayout DRC failed")
                        f.write("Klayout MR DRC:    Failed\n")
                    elif "clean" in lines:
                        logging.info("Klayout MR DRC:    Passed")
                        f.write("Klayout MR DRC:    Passed\n")
    if lvs:
        lvs_summary_report = open(
            os.path.join(signoff_dir, f"{design}/standalone_pvr/lvs_summary.rpt"), "w"
        )
        lvs_sum_rep = os.path.join(signoff_dir, f"{design}/standalone_pvr/lvs_summary.rpt")
        lvs_report = os.path.join(signoff_dir, f"{design}/standalone_pvr/{design}.lvs.json")
        failures = count_lvs.count_LVS_failures(lvs_report)
        if failures[0] > 0:
            lvs_summary_report.write("LVS reports:\n")
            lvs_summary_report.write("    net count difference = " + str(failures[5]) + "\n")
            lvs_summary_report.write(
                "    device count difference = " + str(failures[6]) + "\n"
            )
            lvs_summary_report.write("    unmatched nets = " + str(failures[1]) + "\n")
            lvs_summary_report.write("    unmatched devices = " + str(failures[2]) + "\n")
            lvs_summary_report.write("    unmatched pins = " + str(failures[3]) + "\n")
            lvs_summary_report.write("    property failures = " + str(failures[4]) + "\n")
            logging.error(f"LVS on {design} failed")
            logging.info(f"Find full report at {lvs_report}")
            logging.info(f"Find summary report at {lvs_sum_rep}")
            f.write("Layout Vs Schematic:    Failed\n")
        else:
            lvs_summary_report.write("Layout Vs Schematic Passed")
            logging.info("Layout Vs Schematic:    Passed")
            f.write("Layout Vs Schematic:    Passed\n")

    if verification:
        for sim in ["rtl", "gl", "sdf"]:
            verification_report = os.path.join(
                caravel_root, f"/verilog/dv/cocotb/sim/CI_{sim}/runs.log"
            )
            with open(verification_report) as rep:
                if "(0)failed" in rep.read():
                    logging.info(f"{sim} simulations:    Passed")
                    f.write(f"{sim} simulations:    Passed\n")
                else:
                    logging.error(
                        f"{sim} simulations failed, find report at {verification_report}"
                    )
                    f.write(f"{sim} simulations:    Failed\n")

    if sta:
        sta_logs = glob.glob(f"{sta_log_dir}/{design}-*sta.log")
        for l in sta_logs:
            with open(l) as rep:
                log_name = l.split("/")[-1]
                log_name = log_name.split(".")[0]
                data = rep.read()
                if "The following spefs are missing:" in data:
                    logging.warning(f"Missing spefs. check: {l}")
                rep.seek(0)
                lines = rep.readlines()
                if "Passed" in lines[-1]:
                    logging.info(f"{log_name} STA:    Passed")
                    f.write(f"{log_name} STA:    Passed\n")
                elif "max_transition and max_capacitance" in lines[-1]:
                    logging.warning(lines[-1])
                    logging.info(f"{log_name} STA:    Passed (except: max_tran & max_cap)")
                    f.write(f"{log_name} STA:    Passed (except: max_tran & max_cap)\n")
                elif "max_transition" in lines[-1]:
                    logging.warning(lines[-1])
                    logging.info(f"{log_name} STA:    Passed (except: max_tran)")
                    f.write(f"{log_name} STA:    Passed (except: max_tran)\n")
                elif "max_capacitance" in lines[-1]:
                    logging.warning(lines[-1])
                    logging.info(f"{log_name} STA:    Passed (except: max_cap)")
                    f.write(f"{log_name} STA:    Passed (except: max_cap)\n")
                elif "other violations" in lines[-1]:
                    logging.warning(lines[-1])
                    logging.info(f"{log_name} STA:    Passed")
                    f.write(f"{log_name} STA:    Passed\n")
                else:
                    logging.error(lines[-1])
                    if "setup" in lines[-1]:
                        f.write(f"{log_name} STA:    Failed (setup)\n")
                        logging.error(f"{log_name} STA:    Failed (setup)")
                    elif "hold" in lines[-1]:
                        f.write(f"{log_name} STA:    Failed (hold)\n")
                        logging.error(f"{log_name} STA:    Failed (hold)")
                    else:
                        logging.error(f"{log_name} STA:    Failed")
                        f.write(f"{log_name} STA:    Failed (" + lines[-1].split(" failed")[0] + ")\n")

    if antenna:
        antenna_report = os.path.join(signoff_dir, f"{design}/standalone_pvr/{timestr}/antenna-vios.report")
        xml_report = open(os.path.join(signoff_dir, f"{design}/standalone_pvr/{timestr}/{design}_antenna.lyrdb"))
        antenna_count = xml_report.read().count('<item>')
        antenna_count_log = open(os.path.join(signoff_dir, f"{design}/standalone_pvr/{timestr}/antenna_count.log"), "w")
        antenna_count_log.write(str(antenna_count))
        antenna_count_log.close()
        if antenna_count == 0:
            logging.info("Antenna checks:    Passed")
            f.write("Antenna checks:    Passed\n")
        else:
            logging.error(f"Antenna checks failed find report at {antenna_report}")
            f.write("Antenna checks:    Failed\n")

def save_latest_run (lvs, drc, antenna, sta, spef, run_dir):
    if spef:
        if os.path.exists(f"{run_dir}/../logs"):
            shutil.rmtree(f"{run_dir}/../logs")
        shutil.copytree(f"{run_dir}/logs", f"{run_dir}/../logs")
        spef_files = glob.glob(f"{run_dir}/*.spef")
        for spef_f in spef_files:
            spef_name =spef_f.split("/")[-1]
            shutil.copyfile(spef_f,f"{run_dir}/../{spef_name}")

    elif sta:
        dirs = ['lib', 'sdf', 'reports', 'logs']
        for dir in dirs:
            if os.path.exists(f"{run_dir}/../{dir}"):
                shutil.rmtree(f"{run_dir}/../{dir}")
            shutil.copytree(f"{run_dir}/{dir}", f"{run_dir}/../{dir}")
        cmd = f"sed -i -E 's#original_pin :.*##g' {run_dir}/../lib/*/*.lib"
        os.system(cmd)
    # if lvs or drc or antenna :
    #     if os.path.exists(f"{run_dir}/../logs"):
    #         shutil.rmtree(f"{run_dir}/../logs")
    #     shutil.copytree(f"{run_dir}/logs", f"{run_dir}/../logs")
    #     files = glob.glob(f"{run_dir}/*")
    #     for f in files:
    #         f_name = f.split("/")[-1]
    #         shutil.copyfile(spef_f,f"{run_dir}/../{f_name}")


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.DEBUG,
        format=f"%(asctime)s | %(levelname)-7s | %(message)s",
        datefmt="%d-%b-%Y %H:%M:%S",
    )
    parser = argparse.ArgumentParser(description="CI wrapper")
    parser.add_argument(
        "-drc",
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
        "--vcs",
        help="run verification using vcs",
        action="store_true",
    )
    parser.add_argument(
        "-rtl",
        "--rtl",
        help="run rtl verification",
        action="store_true",
    )
    parser.add_argument(
        "-gl",
        "--gl",
        help="run gl verification",
        action="store_true",
    )
    parser.add_argument(
        "-sdf",
        "--sdf",
        help="run sdf verification",
        action="store_true",
    )
    parser.add_argument(
        "-iv",
        "--iverilog",
        help="run verification using iverilog",
        action="store_true",
    )
    parser.add_argument(
        "-sta",
        "--primetime_sta",
        help="run sta using primetime",
        action="store_true",
    )
    parser.add_argument(
        "-upw",
        "--upw",
        help="Specify to run STA with non-empty user project wrapper",
        action="store_true",
    )
    parser.add_argument(
        "-spef",
        "--starRC_extract",
        help="run spef extraction using StarRC (gf180)",
        action="store_true",
    )
    parser.add_argument(
        "-ant",
        "--antenna",
        help="run antenna checks",
        action="store_true",
    )
    parser.add_argument(
        "-d",
        "--design",
        help="design under test",
        required=True,
    )
    parser.add_argument(
        "-a",
        "--all",
        help="run all checks",
        action="store_true",
    )
    args = parser.parse_args()

    if not os.getenv("PDK_ROOT"):
        logging.error("Please export PDK_ROOT")
        exit(1)
    if not os.getenv("PDK"):
        logging.error("Please export PDK")
        exit(1)
    caravel_redesign_root = os.path.dirname(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    )
    if os.getenv("CARAVEL_ROOT") == None:
        caravel_root = os.path.join(caravel_redesign_root, "caravel")
        logging.warning(f"CARAVEL_ROOT is not defined, defaulting to {caravel_root}")
    else:
        caravel_root = os.getenv("CARAVEL_ROOT")

    if os.getenv("MCW_ROOT") == None:
        mcw_root = os.path.join(caravel_redesign_root, "caravel_mgmt_soc_litex")
        logging.warning(f"MCW_ROOT is not defined, defaulting to {mcw_root}")
    else:
        mcw_root = os.getenv("MCW_ROOT")

    if not os.path.exists(f"{caravel_root}"):
        logging.error(f"{caravel_root} does not exist!")
        exit(1)
    if not os.path.exists(f"{mcw_root}"):
        logging.error(f"{mcw_root} does not exist!")
        exit(1)

    pdk_root = os.getenv("PDK_ROOT")
    pdk_env = os.getenv("PDK")
    signoff_dir = os.path.join(caravel_root, "signoff")
    lvs_root = os.path.join(caravel_root, "scripts/extra_be_checks")
    drc = args.drc_check
    lvs = args.lvs_check
    rtl = args.rtl
    gl = args.gl
    sdf = args.sdf
    iverilog = args.iverilog
    verification = args.vcs
    sta = args.primetime_sta
    if args.upw: upw = True
    else: upw = False
    spef = args.starRC_extract
    if spef and "sky130" in pdk_env:
        logging.erro(f"Spef extraction is available for gf180mcu only")
        spef = False
    design = args.design
    antenna = args.antenna

    if sta:
        os.environ["CHIP"] = "caravel"
        os.environ["CHIP_CORE"] = "caravel_core"
        os.environ["DEBUG"] = "0"

    if (design == "mgmt_core_wrapper" or design == "RAM128" or design == "RAM256" or design == "gf180_ram_512x8_wrapper"):
        signoff_dir = os.path.join(mcw_root, "signoff")
    elif (design == "user_project_wrapper" or design == "user_proj_example" or design == "user_project"):
        uprj_root = os.getenv("UPRJ_ROOT")
        signoff_dir = os.path.join(uprj_root, "signoff")

    timestr = time.strftime("%Y_%m_%d_%H_%M_%S")
    log_dir = os.path.join(signoff_dir, f"{design}/standalone_pvr/{timestr}/logs")

    if not os.path.exists(f"{signoff_dir}/{design}"):
        os.makedirs(f"{signoff_dir}/{design}")

    if lvs or drc or antenna:
        if not os.path.exists(f"{signoff_dir}/{design}/standalone_pvr"):
            os.makedirs(f"{signoff_dir}/{design}/standalone_pvr")
        if not os.path.exists(f"{signoff_dir}/{design}/standalone_pvr/{timestr}"):
            os.makedirs(f"{signoff_dir}/{design}/standalone_pvr/{timestr}")
        if not os.path.exists(f"{log_dir}"):
            os.makedirs(f"{log_dir}")
        if glob.glob(f"{caravel_root}/gds/*.gz"):
            logging.error(
                f"Compressed gds files in {caravel_root}. Please uncompress first."
            )
            exit(1)

        if glob.glob(f"{mcw_root}/gds/*.gz"):
            logging.error(
                f"Compressed gds files in {mcw_root}. Please uncompress first."
            )
            exit(1)

        design_root = os.path.join(caravel_root, f"gds/{design}.gds")
        if not os.path.exists(design_root):
            design_root = os.path.join(mcw_root, f"gds/{design}.gds")
        if not os.path.exists(design_root):
            logging.error(f"can't find {design}.gds file")

    # if design == "caravel" or design == "caravan":
    #     logging.info(f"Building {design} ...")
    #     build_caravel_caravan(caravel_root, mcw_root, pdk_root, log_dir, pdk_env, design)
    # else:
    #     logging.info(f"running checks on {design}")

    if args.all:
        drc = True
        lvs = True
        sta = True
        spef = True
        antenna = True

    pdk_path = pdk_root + "/" + pdk_env

    if drc:
        if (design == "mgmt_core_wrapper" or design == "RAM128" or design == "RAM256" or design == "gf180_ram_512x8_wrapper"):
            drc_p1 = run_drc(mcw_root, timestr, signoff_dir, pdk_path, design)
        else:
            drc_p1 = run_drc(caravel_root, timestr, signoff_dir, pdk_path, design)
        logging.info(f"Running klayout DRC on {design}")
    if lvs:
        lvs_p1 = run_lvs(
            caravel_root,
            mcw_root,
            log_dir,
            signoff_dir,
            pdk_root,
            lvs_root,
            pdk_env,
            design,
        )
        logging.info(f"Running LVS on {design}")

    if spef:
        if not os.path.exists(f"{signoff_dir}/{design}/StarRC"):
            os.makedirs(f"{signoff_dir}/{design}/StarRC")
        if not os.path.exists(f"{signoff_dir}/{design}/StarRC/{timestr}"):
            os.makedirs(f"{signoff_dir}/{design}/StarRC/{timestr}")
        spef_log_dir = os.path.join(signoff_dir, f"{design}/StarRC/{timestr}/logs")
        if not os.path.exists(f"{spef_log_dir}"):
            os.makedirs(f"{spef_log_dir}")            

        if (design == "mgmt_core_wrapper" or design == "RAM128" or design == "RAM256" or design == "gf180_ram_512x8_wrapper"):
            spef_p = run_starxt(
                mcw_root,
                spef_log_dir,
                signoff_dir,
                design,
                timestr,
            )
        elif (design == "user_project_wrapper" or design == "user_proj_example"):
            spef_p = run_starxt(
                uprj_root,
                spef_log_dir,
                signoff_dir,
                design,
                timestr,
            )
        else:
            spef_p = run_starxt(
                caravel_root,
                spef_log_dir,
                signoff_dir,
                design,
                timestr,
            )
        logging.info(f"Running StarRC all corners extraction on {design}")

    if sta and spef:
        out, err = spef_p.communicate()
        spef_log = open(f"{spef_log_dir}/{design}-error.log", "w")
        if err:
            if "ERROR" in err:
                logging.error(err[err.find("ERROR"):].split(')',1)[0]+")")
                spef_log.write(err[err.find("ERROR"):].split(')',1)[0]+")")
                spef_log.close()
            else:
                logging.info(f"StarRC spef extraction done")
                os.remove(f"{spef_log_dir}/{design}-error.log")
        save_latest_run (lvs, drc, antenna, sta, spef, f"{signoff_dir}/{design}/StarRC/{timestr}")
        spef = False
        if not os.path.exists(f"{signoff_dir}/{design}/primetime"):
            os.makedirs(f"{signoff_dir}/{design}/primetime")
        if not os.path.exists(f"{signoff_dir}/{design}/primetime/{timestr}"):
            os.makedirs(f"{signoff_dir}/{design}/primetime/{timestr}")
        sta_log_dir = os.path.join(signoff_dir, f"{design}/primetime/{timestr}/logs")
        if not os.path.exists(f"{sta_log_dir}"):
            os.makedirs(f"{sta_log_dir}")

        logging.info(f"Running PrimeTime STA all corners on {design}")
        if (design == "mgmt_core_wrapper" or design == "RAM128" or design == "RAM256" or design == "gf180_ram_512x8_wrapper"):
            sta_p = run_sta(
                mcw_root,
                f"{caravel_root}/scripts/pt_libs",
                sta_log_dir,
                signoff_dir,
                design,
                timestr,
                upw
            )
        elif (design == "user_project_wrapper" or design == "user_proj_example" or design == "user_project"):
            sta_p = run_sta(
                uprj_root,
                f"{caravel_root}/scripts/pt_libs",
                sta_log_dir,
                signoff_dir,
                design,
                timestr,
                upw
            )
        else:
            sta_p = run_sta(
                caravel_root,
                f"{caravel_root}/scripts/pt_libs",
                sta_log_dir,
                signoff_dir,
                design,
                timestr,
                upw
            )
    elif spef:
        out, err = spef_p.communicate()
        spef_log = open(f"{spef_log_dir}/{design}-error.log", "w")
        if err:
            if "ERROR" in err:
                logging.error(err[err.find("ERROR"):].split(')',1)[0]+")")
                spef_log.write(err[err.find("ERROR"):].split(')',1)[0]+")")
                spef_log.close()
            else:
                logging.info(f"StarRC spef extraction done")
                os.remove(f"{spef_log_dir}/{design}-error.log")
        save_latest_run (lvs, drc, antenna, sta, spef, f"{signoff_dir}/{design}/StarRC/{timestr}")
    elif sta:
        if not os.path.exists(f"{signoff_dir}/{design}/primetime"):
            os.makedirs(f"{signoff_dir}/{design}/primetime")
        if not os.path.exists(f"{signoff_dir}/{design}/primetime/{timestr}"):
            os.makedirs(f"{signoff_dir}/{design}/primetime/{timestr}")
        sta_log_dir = os.path.join(signoff_dir, f"{design}/primetime/{timestr}/logs")
        if not os.path.exists(f"{sta_log_dir}"):
            os.makedirs(f"{sta_log_dir}")

        logging.info(f"Running PrimeTime STA all corners on {design}")
        if (design == "mgmt_core_wrapper" or design == "RAM128" or design == "RAM256" or design == "gf180_ram_512x8_wrapper"):
            sta_p = run_sta(
                mcw_root,
                f"{caravel_root}/scripts/pt_libs",
                sta_log_dir,
                signoff_dir,
                design,
                timestr,
                upw
            )
        elif (design == "user_project_wrapper" or design == "user_proj_example" or design == "user_project"):
            sta_p = run_sta(
                uprj_root,
                f"{caravel_root}/scripts/pt_libs",
                sta_log_dir,
                signoff_dir,
                design,
                timestr,
                upw
            )
        else:
            sta_p = run_sta(
                caravel_root,
                f"{caravel_root}/scripts/pt_libs",
                sta_log_dir,
                signoff_dir,
                design,
                timestr,
                upw
            )

    if antenna:
        logging.info(f"Running antenna checks on {design}")
        if (design == "mgmt_core_wrapper" or design == "RAM128" or design == "RAM256"):
            ant = run_antenna(mcw_root, timestr, signoff_dir, pdk_path, design)
        else:
            ant = run_antenna(caravel_root, timestr, signoff_dir, pdk_path, design)

    if verification or iverilog:
        verify_p = []
        sim = []
        if rtl:
            sim.append("rtl")
        if gl:
            sim.append("gl")
        if sdf:
            sim.append("sdf")
        if not rtl and not gl and not sdf:
            sim = ["rtl", "gl", "sdf"]
        if verification:
            simulator = "vcs"
        elif iverilog:
            simulator = "iverilog"
        for sim_type in sim:
            logging.info(f"Running all {sim_type} verification on caravel")
            verify_p.append(
                run_verification(caravel_root, pdk_root, pdk_env, sim_type, simulator)
            )
        for i in range(len(verify_p)):
            out, err = verify_p[i].communicate()
            ver_log = open(f"{log_dir}/{sim[i]}_caravel.log", "w")
            if err:
                logging.error(err)
                ver_log.write(err)
            if out:
                ver_log.write(out)

    if sta:
        out, err = sta_p.communicate()
        sta_log = open(f"{sta_log_dir}/PT_STA_{design}.log", "w")
        if err:
            logging.error(err)
            sta_log.write(err)
            sta_log.close()
        else:
            os.remove(f"{sta_log_dir}/PT_STA_{design}.log")
        save_latest_run (lvs, drc, antenna, sta, spef, f"{signoff_dir}/{design}/primetime/{timestr}")

    if lvs:
        lvs_p1.wait()
    if drc:
        drc_p1.wait()
    if antenna:
        ant.wait()

    check_errors(
        caravel_root, log_dir, signoff_dir, drc, lvs, verification, sta, design, antenna
    )
