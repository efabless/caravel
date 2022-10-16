import argparse
import logging
import subprocess
from pathlib import Path
import os


def klayout_gds_drc_check(design_name, drc_script_path, gds_input_file_path, signoff_directory, logs_directory):
    report_file_path = signoff_directory / f'{design_name}' / f'standalone_pvr/{design_name}_klayout_drc.xml'
    run_drc_check_cmd = ['klayout', '-b', '-r', drc_script_path,
                         '-rd', f"input={gds_input_file_path}",
                         '-rd', f"report={report_file_path}",
                         '-rd', f"feol=1",
                         '-rd', f"beol=1",
                         '-rd', f"seal=1"]

    log_file_path = logs_directory / f'{design_name}_drc_check.log'
    with open(log_file_path, 'w') as klayout_drc_log:
        subprocess.run(run_drc_check_cmd, stderr=klayout_drc_log, stdout=klayout_drc_log)

    with open(report_file_path) as klayout_xml_report:
        drc_content = klayout_xml_report.read()
        drc_count = drc_content.count('<item>')
        total_file_path = logs_directory / f'{design_name}_klayout_drc.total'
        with open(total_file_path, 'w') as drc_total:
            drc_total.write(f"{drc_count}")
        if drc_count == 0:
            logging.info("No DRC Violations found")
            return True
        else:
            logging.error(f"Total # of DRC violations is {drc_count} Please check {report_file_path} For more details")
            return False


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG, format=f"%(asctime)s | %(levelname)-7s | %(message)s", datefmt='%d-%b-%Y %H:%M:%S')
    parser = argparse.ArgumentParser(description='Runs magic and klayout drc checks on a given GDS.')
    parser.add_argument('--gds_input_file_path', '-g', required=True, help='GDS File to apply DRC checks on')
    parser.add_argument('--log_directory', '-l', required=True, help='log Directory')
    parser.add_argument('--signoff_directory', '-s', required=True, help='signoff Directory')
    parser.add_argument('--design_name', '-d', required=True, help='Design Name')
    args = parser.parse_args()

    gds_input_file_path = Path(args.gds_input_file_path)
    log_directory = Path(args.log_directory)
    signoff_directory = Path(args.signoff_directory)
    design_name = args.design_name

    klayout_sky130A_mr_drc_script_path = "tech-files/sky130A_mr.drc"

    if gds_input_file_path.exists() and gds_input_file_path.suffix == ".gds":
        if klayout_gds_drc_check(design_name, klayout_sky130A_mr_drc_script_path, gds_input_file_path, signoff_directory, log_directory):
            logging.info("Klayout GDS DRC Clean")
        else:
            logging.info("Klayout GDS DRC Dirty")
    else:
        logging.error(f"{gds_input_file_path} is not valid")