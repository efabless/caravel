#!/usr/bin/env python3
# This script runs PrimeTime STA
# Rev 1 
# 6/10/2022

import argparse
import os

def run_sta_all (
  design: str,
  output_dir: str,
  log_dir: str
):
  proc_corners = ["t", "s", "f"]
  rc_corners = ["nom", "max", "min"]
  for proc in proc_corners:
    for rc in rc_corners:
      run_sta (design, proc, rc, output_dir, log_dir)

def run_sta (
  design: str,
  proc_corner: str,
  rc_corner: str,
  output_dir: str,
  log_dir: str
):
  print (f"PrimeTime STA run for design: {design} at process corner {proc_corner} and RC corner {rc_corner}")
  
  # Enviornment Variables
  check_env_vars()
  os.environ["PDK_ROOT"] = os.getenv('PDK_ROOT')
  os.environ["PDK"] = os.getenv('PDK')
  os.environ["PT_LIB_ROOT"] = os.getenv('PT_LIB_ROOT')
  os.environ["CARAVEL_ROOT"] = os.getenv('CARAVEL_ROOT')
  os.environ["MCW_ROOT"] = os.getenv('MCW_ROOT')
  os.environ["OUT_DIR"] = output_dir
  SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
  os.environ["DESIGN"] = design
  os.environ["PROC_CORNER"] = proc_corner
  os.environ["RC_CORNER"] = rc_corner

  # PrimeTime command
  PT_tcl = f"{SCRIPT_DIR}/pt_sta.tcl"
  pt_command = f"source /tools/bashrc_snps; pt_shell -f {PT_tcl} -output_log_file {log_dir}/{design}/{design}-{rc_corner}-{proc_corner}-sta.log"
  os.system(pt_command)

  # Check if there exists any violations
  sta_pass=search_viol(f"{output_dir}/pt_reports/{design}/{design}-{rc_corner}-{proc_corner}-all_viol.rpt")
  if sta_pass == "pass":
    print (f"STA run passed!")
  else:
    print (f"STA run failed!")
    if sta_pass == "viol":
      print(f"There are violations. check report: {output_dir}/pt_reports/{design}/{design}-{rc_corner}-{proc_corner}-all_viol.rpt")
    else:
      print(f"Linking failed. check log: {log_dir}/{design}/{design}-{rc_corner}-{proc_corner}-sta.log")

# Check the required env variables
def check_env_vars():
  pdk_root = os.getenv('PDK_ROOT')
  pdk = os.getenv('PDK')
  pt_lib_root = os.getenv('PT_LIB_ROOT')
  caravel_root = os.getenv('CARAVEL_ROOT')
  mcw_root = os.getenv('MCW_ROOT')
  if pdk_root is None:
    raise FileNotFoundError(
    "Please export PDK_ROOT to the PDK path"
    )
  if pdk is None:
    raise FileNotFoundError(
    "Please export PDK to either sky130A or sky130B"
    )
  if pt_lib_root is None:
    raise FileNotFoundError(
    "Please export PT_LIB_ROOT to the PrimeTime liberties path"
    )
  if caravel_root is None:
    raise FileNotFoundError(
    "Please export CARAVEL_ROOT to the Caravel repo path"
    )
  if mcw_root is None:
    raise FileNotFoundError(
    "Please export MCW_ROOT to the Caravel Management SoC Litex repo path"
    )

# Analyze the STA all violators output report
def search_viol(
  report_path: str
):
  with open(report_path, 'r') as report:
    data = report.read()
    if "(VIOLATED)" in data:
      return "viol"
    elif "Could not auto-link design" in data:
      return "no link"
    else: 
      return "pass"

if __name__ == "__main__":
  parser = argparse.ArgumentParser(
    description="Run STA using PrimeTime"
  )
  parser.add_argument(
    "-d",
    "--design",
    help="design name",
    required=True
  )
  parser.add_argument(
    "-o",
    "--output_dir",
    help="output directory",
    required=True
  )
  parser.add_argument(
    "-l",
    "--logs_dir",
    help="output directory",
    required=True
  )
  parser.add_argument(
    "-rc",
    "--rc_corner",
    help="Specify the RC corner for the parasitics (Values are nom, max, or min) <default is nom>",
    nargs="?",
    default="nom"
  )
  parser.add_argument(
    "-proc",
    "--proc_corner",
    help="Specify the process corner (Values are t, f, or s) <default is t>",
    nargs="?",
    default="t"
  )
  parser.add_argument(
    "-a",
    "--all",
    help="Specify to run all the process corners and rc corners combinations for the design",
    action='store_true'
  )

  args = parser.parse_args()

  output = os.path.abspath(args.output_dir)
  log = os.path.abspath(args.logs_dir)

  try:
    os.makedirs(output)
  except FileExistsError:
    # directory already exists
    pass

  try:
    os.makedirs(log)
  except FileExistsError:
    # directory already exists
    pass
 
  try:
    os.makedirs(os.path.join(log,args.design))
  except FileExistsError:
    # directory already exists
    pass

  sub_dirs = ['pt_reports', 'pt_sdf', 'pt_etm']
  for item in sub_dirs:
    path = os.path.join(output,item)
    try:
      os.makedirs(path)
    except FileExistsError:
      # directory already exists
      pass
    try:
      os.makedirs(os.path.join(path,args.design))
    except FileExistsError:
      # directory already exists
      pass

  if args.all:
    run_sta_all (args.design, output, log) 
  else:
    run_sta (args.design, args.proc_corner, args.rc_corner, output, log)
