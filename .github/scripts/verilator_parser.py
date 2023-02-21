import os
import subprocess
import glob
import argparse


def parse_rtl(verilog):
    modules = []
    line_list = []
    with open(verilog, 'r') as file:
        for index, line in enumerate(file):
            line_list.append(line)
            if "`ifdef USE_POWER_PINS" in line:
                if "sky130" not in line_list[index-1] and "module" not in line_list[index-1]:
                    if len(line_list[index-1].replace("(", "").replace(")", "").strip().split()) > 1:
                        modules.append(line_list[index-1].replace("(", "").replace(")", "").strip().split()[0])
    file.close()
    return(modules)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="verilator processor")
    parser.add_argument(
        "-i",
        "--input",
        help="input files to run LVS on them. Takes two input files",
        required=True,
    )
    args = parser.parse_args()
    input_dir = args.input
    verilog_files = glob.glob(f"{input_dir}/verilog/rtl/*.v")
    flag = False
    os.mkdir('./logs')
    for file in verilog_files:
        if "defines" not in file:
            print(f"running verilator on {file}")
            modules = parse_rtl(file)
            includes = ""
            for i in modules:
                includes += f"-I {modules}"
            verilator_cmd = [
                "verilator",
                "--lint-only",
                "-Wall",
                "-I",
                f"{os.getenv('PDK_ROOT')}/{os.getenv('PDK')}/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v",
                "-I",
                f"{os.getenv('PDK_ROOT')}/{os.getenv('PDK')}/libs.ref/sky130_fd_sc_hd/verilog/primitives.v",
                "-I",
                f"{input_dir}/verilog/rtl/defines.v",
                includes,
                file
            ]
            std_out = subprocess.Popen(
                    verilator_cmd, stderr=subprocess.STDOUT, stdout=subprocess.PIPE, cwd=f"{input_dir}/verilog/rtl"
                )
            with open(f"logs/{os.path.splitext(os.path.basename(file))[0]}.log", "w") as f:
                while True:
                    output = std_out.stdout.readline()
                    if std_out.poll() is not None:
                        break
                    if output:
                        out = output.decode("utf-8")
                        if "ERROR" in out or "Warning" in out:
                            flag = True
                        print(out)
                        f.write(out)

    if flag:
        print("There are errors or warnings")
        exit(1)