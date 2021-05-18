#!/usr/bin/env python3
from fusesoc.capi2.generator import Generator
import os
import shutil
import subprocess

class CaravelHexGenerator(Generator):
    def run(self):
        #Get the basedir parameter from the user
        basedir = self.config.get('basedir')

        #Get the testcase parameter from the user
        testcase = self.config.get('testcase')

        #Set name of created hex file
        testcase_hex = testcase+'.hex'

        #Store absolute path to the testcase
        testcase_root = os.path.join(self.files_root, basedir, testcase)

        #Setup the command to run
        cmd = ['make', 'clean', 'hex']

        #Try to detect a RISC-V toolchain. Otherwise falls back to the paths
        #set in the Makefile
        tmp = shutil.which('riscv32-unknown-elf-gcc') or \
            shutil.which('riscv64-unknown-elf-gcc')
        if tmp:
            (path, name) = os.path.split(tmp)
            cmd += ['GCC_PATH='+path,
                    'GCC_PREFIX='+name[:-4]]

        #Set the working directory to the absolute path of the testcase
        cwd = os.path.join(os.path.dirname(__file__), testcase_root)

        #Execute command and exit on errors
        rc = subprocess.call(cmd, cwd=cwd)
        if rc:
            exit(1)

        #Move the compiled hex file from the build directory to the root
        #directory of the generated core
        shutil.move(os.path.join(cwd, testcase_hex), testcase_hex)

        #Register the hex file in a fileset of the generated core and use
        # copyto, so that it ends up in the EDA tool work_root
        files = [{testcase_hex : {'file_type' : 'user', 'copyto' : testcase_hex}}]
        self.add_files(files)

g = CaravelHexGenerator()
g.run()
g.write()
