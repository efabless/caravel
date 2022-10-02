import argparse
import gzip
import logging
import os
import re
import subprocess
from pathlib import Path
from converters import magic_drc_to_rdb, magic_drc_to_tcl, magic_drc_to_tr_drc, tr2klayout


def check_if_binary_has(word, filename):
    f = gzip.open(filename, 'r', errors='ignore') if 'gz' in str(filename) else open(filename, errors='ignore')
    content = f.read()
    f.close()
    return int(bool(re.search(word, content)))


def is_valid_magic_drc_report(drc_content):
    split_line = '----------------------------------------'
    drc_sections = drc_content.split(split_line)
    return len(drc_sections) >= 2


def violations_count(drc_content):
    """
        design name
        violation message
        list of violations
        Total Count:
    """
    split_line = '----------------------------------------'
    drc_sections = drc_content.split(split_line)
    if len(drc_sections) == 2:
        return 0
    else:
        vio_dict = dict()
        for i in range(1, len(drc_sections) - 1, 2):
            vio_dict[drc_sections[i]] = len(drc_sections[i + 1].split("\n")) - 2
        count = 0
        for key in vio_dict:
            val = vio_dict[key]
            count += val
            logging.error(f"Violation Message '{str(key.strip())}' found {str(val)} times.")
        return count


def magic_gds_drc_check(gds_ut_path, design_name, pdk_path, logs_directory, signoff_directory):
    parent_directory = Path(__file__).parent
    reports_directory = signoff_directory / 'reports'

    design_magic_drc_file_path = reports_directory / f"{design_name}_magic_drc.drc.report"

    installed_sram_modules_names = []
    sram_maglef_files_generator = Path(pdk_path / 'libs.ref/sky130_sram_macros/maglef').glob('*.mag')
    for installed_sram in sram_maglef_files_generator:
        installed_sram_modules_names.append(installed_sram.stem)
    sram_modules_in_gds = []
    for sram in installed_sram_modules_names:
        if check_if_binary_has(sram, gds_ut_path):
            sram_modules_in_gds.append(sram)  # only the name of the module

    magicrc_file_path = f"{pdk_path}/libs.tech/magic/sky130A.magicrc"
    magic_drc_tcl_path = parent_directory / 'magic_drc.tcl'
    design_magic_drc_mag_file_path = logs_directory / f"{design_name}.magic.drc.mag"
    esd_fet = 'sky130_fd_io__signal_5_sym_hv_local_5term'
    # cli arguments for a tcl script has to be a string
    has_sram_as_str = str(check_if_binary_has('sram', gds_ut_path))
    has_esd_fet_as_str = str(check_if_binary_has('sky130_fd_io__signal_5_sym_hv_local_5term', gds_ut_path))
    # TODO(ahmad.nofal@efabless.com): This should be a command line argument
    os.environ['MAGTYPE'] = 'mag'
    run_magic_drc_check_cmd = ['magic', '-noconsole', '-dnull', '-rcfile', magicrc_file_path, magic_drc_tcl_path, gds_ut_path,
                               design_name, pdk_path, design_magic_drc_file_path, design_magic_drc_mag_file_path,
                               ' '.join(sram_modules_in_gds), esd_fet, has_sram_as_str, has_esd_fet_as_str]

    magic_drc_log_file_path = logs_directory / f'{design_name}_magic_drc.log'
    with open(magic_drc_log_file_path, 'w') as magic_drc_log:
        process = subprocess.run(run_magic_drc_check_cmd, stderr=magic_drc_log, stdout=magic_drc_log)
    if not design_magic_drc_file_path.exists():
        logging.error(f"No {design_magic_drc_file_path} file produced by the drc check")
        return False

    # drc_violations_count = process.returncode
    # if drc_violations_count != 0:
    #     drc_violations_count = (drc_violations_count + 3) / 4  # TODO(ahmad.nofal@efabless.com): Check validity
    # magic_drc_total_file_path = logs_directory / f'{design_name}_magic_drc.total'
    # with open(magic_drc_total_file_path, 'w') as magic_drc_total:
    #     magic_drc_total.write(str(drc_violations_count))

    # Write all different formats for drc violations reports using converters
    try:
        design_magic_rdb_file_path = reports_directory / f"{design_name}_magic_drc.rdb"
        magic_drc_to_rdb.convert(design_magic_drc_file_path, design_magic_rdb_file_path)
        design_magic_drc_tcl_file_path = reports_directory / f"magic_drc.tcl"
        magic_drc_to_tcl.convert(design_magic_drc_file_path, design_magic_drc_tcl_file_path)
        design_tr_drc_file_path = reports_directory / f"{design_name}_magic_drc.tr"
        magic_drc_to_tr_drc.convert(design_magic_drc_file_path, design_tr_drc_file_path)
        design_klayout_xml_file_path = reports_directory / f"{design_name}_magic_drc.xml"
        tr2klayout.convert(design_tr_drc_file_path, design_klayout_xml_file_path, design_name)
    except Exception as e:
        logging.warning(f"Error generating DRC violation report(s), the full set of Magic DRC reports will not be generated. {e}")

    with open(magic_drc_log_file_path) as magic_drc_log:
        log_content = magic_drc_log.read()

    if log_content.find("was used but not defined.") != -1:
        logging.error(f"The GDS is not valid/corrupt contains cells that are used but not defined. Please check: {magic_drc_log_file_path}")
        return False

    if log_content.find("Unrecognized layer (type) name \"<<<<<\"") != -1:
        logging.error(f"The GDS is not valid/corrupt contains cells. Please check: {magic_drc_log_file_path}")
        return False

    with open(design_magic_drc_file_path) as magic_drc_report:
        drc_content = magic_drc_report.read()

    if not is_valid_magic_drc_report(drc_content):
        logging.error(f"Incomplete DRC Report. Maybe you ran out of RAM. Please check: {magic_drc_log_file_path}")
        return False
    else:
        count = violations_count(drc_content)
        logging.info(f"{count} DRC violations") if count == 0 else logging.error(f"{count} DRC violations")
        magic_drc_total_file_path = logs_directory / f'{design_name}_magic_drc.total'
        with open(magic_drc_total_file_path, 'w') as magic_drc_total:
            magic_drc_total.write(str(count))
        return True if count == 0 else False


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG, format=f"%(asctime)s | %(levelname)-7s | %(message)s", datefmt='%d-%b-%Y %H:%M:%S')
    parser = argparse.ArgumentParser(description='Runs magic and klayout drc checks on a given GDS.')
    parser.add_argument('--gds_input_file_path', '-g', required=True, help='GDS File to apply DRC checks on')
    parser.add_argument('--log_directory', '-l', required=True, help='log Directory')
    parser.add_argument('--signoff_directory', '-s', required=True, help='signoff Directory')
    parser.add_argument('--pdk_path', '-p', required=True, help='PDK Path')
    parser.add_argument('--design_name', '-d', required=True, help='Design Name')

    args = parser.parse_args()
    gds_input_file_path = Path(args.gds_input_file_path)
    log_directory = Path(args.log_directory)
    signoff_directory = Path(args.signoff_directory)
    pdk_path = Path(args.pdk_path)
    design_name = args.design_name

    if gds_input_file_path.exists() and gds_input_file_path.suffix == ".gds":
        if magic_gds_drc_check(gds_input_file_path, args.design_name, pdk_path, log_directory, signoff_directory):
            logging.info("Magic GDS DRC Clean")
        else:
            logging.info("Magic GDS DRC Dirty")
    else:
        logging.error(f"{gds_input_file_path} is not valid")