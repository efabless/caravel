#!/usr/bin/python3
# -*- coding: utf-8 -*-
import collections
import json
import sys
import os
from pathlib import Path
from fnmatch import fnmatch
from datetime import datetime
import random
from pathlib import Path
import shutil
from subprocess import PIPE, run
import threading
import time

iverilog = True
vcs = False
coverage = False
zip_waves = True

def go_up(path, n):
    for i in range(n):
        path = os.path.dirname(path)
    return path
# search pattern in file
def search_str(file_path, word):
    with open(file_path, 'r') as file:
        # read all content of a file
        content = file.read()
        # check if string present in a file
        if word in content:
            return "passed"
        else:
            return "failed"

def change_dff(str,new_str,file_path):
    # Read in the file
    with open(file_path, 'r') as file :
        filedata = file.read()

    filedata = filedata.replace(str, new_str)

    # Write the file out again
    with open(file_path, 'w') as file:
        file.write(filedata)

class RunTest:
    def __init__(self,test_name,sim,corner) -> None:
        self.cocotb_path = f"{os.getenv('CARAVEL_ROOT')}/verilog/dv/cocotb"
        self.test_name = test_name
        self.sim_type  = sim
        self.corner  = corner
        self.create_log_file()
        self.hex_generate()
        self.runTest()
    
    # create and open full terminal log to be able to use it before run the test
    def create_log_file(self):
        self.cd_cocotb()
        os.chdir(f"sim/{os.getenv('RUNTAG')}")
        test_dir = f"{self.sim_type}-{self.test_name}"
        if (self.sim_type == "GL_SDF"):
            test_dir = f'{test_dir}-{self.corner}'
        os.makedirs(f"{test_dir}",exist_ok=True)
        self.cd_cocotb()
        self.sim_path = f"sim/{os.getenv('RUNTAG')}/{test_dir}/"
        terminal_log=f"{self.sim_path}/fullTerminal.log"
        test_log=f"{self.sim_path}/{self.test_name}.log"
        self.test_log=open(test_log, "w")
        self.full_file=f"{self.sim_path}/full.log"
        self.full_terminal = open(self.full_file, "w")
        
    def runTest(self):
        self.full_test_name = f"{self.sim_type}-{self.test_name}"
        if (self.sim_type=="GL_SDF"):
            self.full_test_name =  f"{self.sim_type}-{self.test_name}-{self.corner}"
        os.environ["TESTFULLNAME"] = f"{self.full_test_name}"
        if (iverilog):return self.runTest_iverilog()
        elif(vcs): return self.runTest_vcs()

    # iverilog function
    def runTest_iverilog(self):
        print(f"Start running test: {self.sim_type}-{self.test_name}")
        CARAVEL_ROOT = os.getenv('CARAVEL_ROOT')
        CARAVEL_VERILOG_PATH  = os.getenv('CARAVEL_VERILOG_PATH')
        MCW_ROOT = os.getenv('MCW_ROOT')
        VERILOG_PATH = os.getenv('VERILOG_PATH')
        CARAVEL_PATH = os.getenv('CARAVEL_PATH')
        USER_PROJECT_VERILOG  = os.getenv('USER_PROJECT_VERILOG')
        FIRMWARE_PATH = os.getenv('FIRMWARE_PATH')
        RUNTAG = os.getenv('RUNTAG')
        ERRORMAX = os.getenv('ERRORMAX')
        PDK_ROOT = os.getenv('PDK_ROOT')
        PDK = os.getenv('PDK')
        TESTFULLNAME = os.getenv('TESTFULLNAME')
        env_vars = f"-e {CARAVEL_ROOT} -e CARAVEL_VERILOG_PATH={CARAVEL_VERILOG_PATH} -e MCW_ROOT={MCW_ROOT} -e VERILOG_PATH={VERILOG_PATH} -e CARAVEL_PATH={CARAVEL_PATH} -e USER_PROJECT_VERILOG={USER_PROJECT_VERILOG} -e FIRMWARE_PATH={FIRMWARE_PATH} -e RUNTAG={RUNTAG} -e ERRORMAX={ERRORMAX} -e PDK_ROOT={PDK_ROOT} -e PDK={PDK} -e TESTFULLNAME={TESTFULLNAME}"
        macros = f'-DFUNCTIONAL -DSIM=\\\"{self.sim_type}\\\"  -DUSE_POWER_PINS -DUNIT_DELAY=#1 -DMAIN_PATH=\\\"{self.cocotb_path}\\\" -DIVERILOG -DTESTNAME=\\\"{self.test_name}\\\" -DTAG=\\\"{RUNTAG}\\\" '
        if self.test_name == "la":
            macros = f'{macros} -DLA_TESTING'
        if self.test_name in ["gpio_all_o_user","gpio_all_i_user","gpio_all_i_pu_user","gpio_all_i_pd_user","gpio_all_bidir_user"]:
            macros = f'{macros} -DGPIO_TESTING'
        if(self.sim_type=="RTL"): 
            includes = f"-f {VERILOG_PATH}/includes/includes.rtl.caravel"
        elif(self.sim_type=="GL"): 
            macros = f'{macros}  -DGL'
            includes = f"-f {VERILOG_PATH}/includes/includes.gl.caravel"
        elif(self.sim_type=="GLSDF"): 
            print(f"iverilog can't run SDF for test {self.test_name} Please use anothor simulator like cvc" )
            return
        
        iverilog_command = (f"iverilog -Ttyp {macros} {includes}  -o {self.sim_path}/sim.vvp"
                            f" {CARAVEL_PATH}/rtl/__user_project_wrapper.v {CARAVEL_PATH}/rtl/__user_project_gpio_example.v {CARAVEL_PATH}/rtl/__user_project_la_example.v  caravel_top.sv"
                            f" && TESTCASE={self.test_name} MODULE=caravel_tests vvp -M $(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus {self.sim_path}/sim.vvp")
        docker_command = f"docker run -it {env_vars} -v {os.getenv('CARAVEL_ROOT')}:{os.getenv('CARAVEL_ROOT')} -v {os.getenv('MCW_ROOT')}:{os.getenv('MCW_ROOT')} -v {os.getenv('PDK_ROOT')}:{os.getenv('PDK_ROOT')}   efabless/dv:cocotb sh -c 'cd {self.cocotb_path} && {iverilog_command}' >> {self.full_file}"
        self.full_terminal = open(self.full_file, "a")
        self.full_terminal.write(f"docker command for running iverilog and cocotb:\n% ")
        self.full_terminal.write(os.path.expandvars(docker_command)+"\n")
        self.full_terminal.close()
        
        os.system(docker_command)
        self.passed = search_str(self.test_log.name,"Test passed with (0)criticals (0)errors")
        Path(f'{self.sim_path}/{self.passed}').touch()
        if self.passed == "passed": 
            print(f"Test: {self.sim_type}-{self.test_name} passed")
        else : 
            print(f"Test: {self.sim_type}-{self.test_name} Failed please check logs under {self.sim_path}")


    # vcs function      
    def runTest_vcs(self):
        print(f"Start running test: {self.sim_type}-{self.test_name}")
        PDK_ROOT = os.getenv('PDK_ROOT')
        PDK = os.getenv('PDK')
        VERILOG_PATH = os.getenv('VERILOG_PATH')
        dirs = f'+incdir+\\\"{PDK_ROOT}/{PDK}\\\" '
        if self.sim_type == "RTL":
            dirs = f' {dirs} -f \\\"{VERILOG_PATH}/includes/rtl_caravel_vcs.list\\\" '
        else: 
            dirs = f' {dirs} -f \\\"{VERILOG_PATH}/includes/gl_caravel_vcs.list\\\" '
        macros = f'+define+FUNCTIONAL +define+USE_POWER_PINS +define+UNIT_DELAY=#1 +define+MAIN_PATH=\\\"{self.cocotb_path}\\\" +define+VCS '
        if self.test_name == "la":
            macros = f'{macros} +define+LA_TESTING'
        if self.test_name in ["gpio_all_o_user","gpio_all_i_user","gpio_all_i_pu_user","gpio_all_i_pd_user","gpio_all_bidir_user"]:
            macros = f'{macros} +define+GPIO_TESTING'
        # shutil.copyfile(f'{self.test_full_dir}/{self.test_name}.hex',f'{self.sim_path}/{self.test_name}.hex')
        # if os.path.exists(f'{self.test_full_dir}/test_data'):
        #     shutil.copyfile(f'{self.test_full_dir}/test_data',f'{self.sim_path}/test_data')
        if (self.sim_type=="GL_SDF"):
            macros = f'{macros} +define+ENABLE_SDF +define+SIM=GL_SDF +define+GL +define+SDF_POSTFIX=\\\"{self.corner[-1]}{self.corner[-1]}\\\" +define+CORNER=\\\"{self.corner[0:3]}\\\"'
            # corner example is corner nom-t so `SDF_POSTFIX = tt and `CORNER = nom
            # os.makedirs(f"annotation_logs",exist_ok=True)
            dirs = f"{dirs}  +incdir+\\\"{os.getenv('MCW_ROOT')}/verilog/\\\" "
            # +incdir+\\\"{os.getenv('CARAVEL_ROOT')}/signoff/caravel/primetime-signoff/\\\"
        elif(self.sim_type=="GL"): 
            macros = f'{macros}  +define+GL  +define+SIM=GL'
        elif (self.sim_type=="RTL"): 
            macros = f'{macros} +define+SIM=\\\"RTL\\\"'
        else: 
            print(f"Fatal: incorrect simulation type {self.sim_type}")
        coverage_command = ""
        if coverage: 
            coverage_command = "-cm line+tgl+cond+fsm+branch+assert"
        os.environ["TESTCASE"] = f"{self.test_name}"
        os.environ["MODULE"] = f"caravel_tests"
        os.environ["SIM"] = self.sim_type

        os.system(f"vlogan -full64  -sverilog +error+30 caravel_top.sv {dirs} {macros} +define+TESTNAME=\\\"{self.test_name}\\\" +define+FTESTNAME=\\\"{self.full_test_name}\\\" +define+TAG=\\\"{os.getenv('RUNTAG')}\\\" -l {self.sim_path}/analysis.log -o {self.sim_path} ")
        os.system(f"vcs +lint=TFIPC-L {coverage_command} +error+30 -R -diag=sdf:verbose +sdfverbose +neg_tchk -debug_access -full64  -l {self.sim_path}/test.log  caravel_top -Mdir={self.sim_path}/csrc -o {self.sim_path}/simv +vpi -P pli.tab -load $(cocotb-config --lib-name-path vpi vcs)")
        self.passed = search_str(self.test_log.name,"Test passed with (0)criticals (0)errors")
        Path(f'{self.sim_path}/{self.passed}').touch()
        #delete wave when passed
        if self.passed == "passed" and zip_waves:
            os.chdir(f'{self.cocotb_path}/{self.sim_path}')
            os.system(f'zip -m waves_logs.zip analysis.log test.log *.vpd *.vcd')
            self.cd_cocotb()
        if os.path.exists(f"{self.cocotb_path}/sdfAnnotateInfo"):
            shutil.move(f"{self.cocotb_path}/sdfAnnotateInfo", f"{self.sim_path}/sdfAnnotateInfo")
        shutil.copyfile(f'{self.cocotb_path}/hex_files/{self.test_name}.hex',f'{self.sim_path}/{self.test_name}.hex')

    def find(self,name, path):
        for root, dirs, files in os.walk(path):
            if name in files:
                return os.path.join(root, name)
        print(f"Test {name} doesn't exist or don't have a C file ")

    def test_path(self):
        test_name = self.test_name
        test_name += ".c"
        tests_path = os.path.abspath(f"{self.cocotb_path}/tests")
        test_file =  self.find(test_name,tests_path)
        test_path = os.path.dirname(test_file)
        return (test_path)

    def hex_generate(self):
        tests_use_dff2 = ["mem_dff"]
        tests_use_dff = ["mem_dff2","debug"]
        #open docker 
        test_path =self.test_path()
        self.cd_make()
        if not os.path.exists(f"{self.cocotb_path}/hex_files"):
            os.makedirs(f"{self.cocotb_path}/hex_files") # Create a new hex_files directory because it does not exist 
        elf_out = f"{self.cocotb_path}/hex_files/{self.test_name}.elf"
        c_file = f"{test_path}/{self.test_name}.c"
        hex_file = f"{self.cocotb_path}/hex_files/{self.test_name}.hex"
        GCC_PATH = "/foss/tools/riscv-gnu-toolchain-rv32i/217e7f3debe424d61374d31e33a091a630535937/bin/"
        GCC_PREFIX = "riscv32-unknown-linux-gnu"
        SOURCE_FILES = f"{os.getenv('FIRMWARE_PATH')}/crt0_vex.S {os.getenv('FIRMWARE_PATH')}/isr.c"
        LINKER_SCRIPT = f"{os.getenv('FIRMWARE_PATH')}/sections.lds"
        CPUFLAGS = f"-march=rv32i -mabi=ilp32 -D__vexriscv__ "
        verilog_path = f"{os.getenv('VERILOG_PATH')}"
        test_dir = f"{os.getenv('VERILOG_PATH')}/dv/tests-caravel/mem" # linker script include // TODO: to fix this in the future from the mgmt repo
        #change linker script to for mem tests 
        if self.test_name in tests_use_dff2:
           LINKER_SCRIPT = self.linkerScript_for_mem("dff2",LINKER_SCRIPT)
        elif self.test_name in tests_use_dff:
           LINKER_SCRIPT = self.linkerScript_for_mem("dff",LINKER_SCRIPT)

        elf_command = (f"{GCC_PATH}/{GCC_PREFIX}-gcc -g -I{verilog_path}/dv/firmware -I{verilog_path}/dv/generated  -I{verilog_path}/dv/ "
                 f"-I{verilog_path}/common {CPUFLAGS} -Wl,-Bstatic,-T,{LINKER_SCRIPT},"
                 f"--strip-debug -ffreestanding -nostdlib -o {elf_out} {SOURCE_FILES} {c_file}")
        hex_command = f"{GCC_PATH}/{GCC_PREFIX}-objcopy -O verilog {elf_out} {hex_file} "
        sed_command = f"sed -ie 's/@10/@00/g' {hex_file}"
       
        hex_gen_state = os.system(f"docker run -it -v {go_up(self.cocotb_path,4)}:{go_up(self.cocotb_path,4)}  efabless/dv:latest sh -c 'cd {test_dir} && {elf_command} && {hex_command} && {sed_command} '")
        self.full_terminal.write("elf file generation command:\n% ")
        self.full_terminal.write(os.path.expandvars(elf_command)+"\n")
        self.full_terminal.write("hex file generation command:\n% ")
        self.full_terminal.write(os.path.expandvars(hex_command)+"\n% ")
        self.full_terminal.write(os.path.expandvars(sed_command)+"\n")
        self.cd_cocotb()
        self.full_terminal.close()
        if hex_gen_state != 0 :
            print(f"fatal: Error when generating hex")
            sys.exit()
        
    #change linker script to for mem tests 
    def linkerScript_for_mem(self,ram,LINKER_SCRIPT):
        new_LINKER_SCRIPT = f"{self.cocotb_path}/{self.sim_path}/sections.lds"
        shutil.copyfile(LINKER_SCRIPT, new_LINKER_SCRIPT)
        if ram == "dff2":  
            change_dff(str="> dff ",new_str="> dff2 ",file_path=new_LINKER_SCRIPT)
            change_dff(str="> dff\n",new_str="> dff2\n",file_path=new_LINKER_SCRIPT)
            change_dff(str="ORIGIN(dff)",new_str="ORIGIN(dff2)",file_path=new_LINKER_SCRIPT)
            change_dff(str="LENGTH(dff)",new_str="LENGTH(dff2)",file_path=new_LINKER_SCRIPT)
        elif ram == "dff":
            change_dff(str="> dff2 ",new_str="> dff ",file_path=new_LINKER_SCRIPT)
            change_dff(str="ORIGIN(dff2)",new_str="ORIGIN(dff)",file_path=new_LINKER_SCRIPT)
            change_dff(str="LENGTH(dff2)",new_str="LENGTH(dff)",file_path=new_LINKER_SCRIPT)
        else: 
            print(f"ERROR: wrong trype of ram {ram} need to be used for now the oldy rams that can be used for flashing and data are dff and dff2")
            sys.exit()
        return new_LINKER_SCRIPT

    def cd_make(self):
        os.chdir(f"{os.getenv('VERILOG_PATH')}/dv/make")
        
    def cd_cocotb(self):
        os.chdir(self.cocotb_path)

class RunRegression: 
    def __init__(self,regression,test,type_arg,testlist,corner) -> None:
        self.cocotb_path = f"{os.getenv('CARAVEL_ROOT')}/verilog/dv/cocotb"
        self.regression_arg = regression
        self.test_arg = test
        self.testlist_arg = testlist
        self.corners = corner
        self.total_start_time = datetime.now()
        if type_arg is None:
            type_arg = "RTL"
        self.type_arg = type_arg
        self.write_command_log()
        self.write_git_log()
        with open('tests.json') as f:
            self.tests_json = json.load(f)
            self.tests_json = self.tests_json["Tests"]
        self.get_tests()
        self.run_regression()

    def get_tests(self):
        self.tests = collections.defaultdict(lambda : collections.defaultdict(lambda : collections.defaultdict(dict))) #key is testname and value is list of sim types
        self.unknown_tests = 0
        self.passed_tests = 0
        self.failed_tests = 0
        # regression 
        if self.regression_arg is not None:
            sim_types = ("RTL","GL","GL_SDF")
            for test,test_elements in self.tests_json.items():
                if fnmatch(test,"_*"):
                        continue
                for sim_type in sim_types:
                    if sim_type =="GL_SDF": 
                        for corner in self.corners: 
                            if self.regression_arg in test_elements[sim_type]: 
                                self.add_new_test(test_name=test,sim_type = sim_type,corner = corner)
                    else: 
                        if self.regression_arg in test_elements[sim_type]: 
                                self.add_new_test(test_name=test,sim_type = sim_type,corner = "-")
            if (len(self.tests)==0):
                print(f"fatal:{self.regression_arg} is not a valid regression name please input a valid regression \ncheck tests.json for more info")
                sys.exit()
        #test
        if self.test_arg is not None:
            if isinstance(self.test_arg,list):
                for test in self.test_arg:
                    if test in self.tests_json:
                        if isinstance(self.type_arg,list):
                            for sim_type in self.type_arg:
                                if sim_type =="GL_SDF": 
                                    for corner in self.corners: 
                                        self.add_new_test(test_name=test,sim_type = sim_type, corner = corner)
                                else: self.add_new_test(test_name=test,sim_type = sim_type,corner = "-")
                        else:
                            if sim_type =="GL_SDF": 
                                for corner in self.corners: 
                                    self.add_new_test(test_name=test,sim_type = sim_type, corner = corner)
                            else: self.add_new_test(test_name=test,sim_type = sim_type,corner = "-")

            else:
                if self.test_arg in self.tests_json:
                    if isinstance(self.type_arg,list):
                        for sim_type in self.type_arg:
                            self.add_new_test(test_name=self.test_arg,sim_type = sim_type)
                    else:
                        self.add_new_test(test_name=self.test_arg,sim_type = self.type_arg)
        # testlist TODO: add logic for test list
        if self.testlist_arg is not None:
            print(f'fatal: code for test list isnt added yet')
            sys.exit()


        self.update_reg_log()

    def add_new_test(self,test_name,sim_type,corner):
        self.tests[test_name][sim_type][corner]["status"]= "pending"
        self.tests[test_name][sim_type][corner]["starttime"]= "-"
        self.tests[test_name][sim_type][corner]["endtime"]= "-"
        self.tests[test_name][sim_type][corner]["duration"] = "-"
        self.tests[test_name][sim_type][corner]["pass"]= "-"
        self.unknown_tests +=1

    def run_regression(self):
        threads = list()
        for test,sim_types in self.tests.items():
            for sim_type,corners in sim_types.items(): # TODO: add multithreading or multiprocessing here
                for corner,status in corners.items():
                    if iverilog: #threading
                        # x = threading.Thread(target=self.test_run_function,args=(test,sim_type,corner))
                        # threads.append(x)
                        # x.start()
                        # time.sleep(10)
                        self.test_run_function(test,sim_type,corner)
                    else: 
                        self.test_run_function(test,sim_type,corner)
        for index, thread in enumerate(threads):
            thread.join()

        if coverage:
            self.generate_cov()
        #TODO: add send mail here
    
    def test_run_function(self,test,sim_type,corner):
        start_time = datetime.now()
        self.tests[test][sim_type][corner]["starttime"] = datetime.now().strftime("%H:%M:%S(%a)")
        self.tests[test][sim_type][corner]["duration"] = "-"
        self.tests[test][sim_type][corner]["status"] = "running"
        self.update_reg_log()
        test_run = RunTest(test,sim_type,corner,)
        self.tests[test][sim_type][corner]["status"] = "done"
        self.tests[test][sim_type][corner]["endtime"] = datetime.now().strftime("%H:%M:%S(%a)")
        self.tests[test][sim_type][corner]["duration"] = ("%.10s" % (datetime.now() - start_time))
        self.tests[test][sim_type][corner]["pass"]= test_run.passed
        if test_run.passed == "passed":
            self.passed_tests +=1
        elif test_run.passed == "failed":
            self.failed_tests +=1
        self.unknown_tests -=1
        self.update_reg_log()


    def generate_cov(self):
        os.chdir(f"{self.cocotb_path}/sim/{os.getenv('RUNTAG')}")
        os.system(f"urg -dir RTL*/*.vdb -format both -show tests -report coverageRTL/")
        os.system(f"urg -dir GL*/*.vdb -format both -show tests -report coverageGL/")
        os.system(f"urg -dir SDF*/*.vdb -format both -show tests -report coverageSDF/")
        os.chdir(self.cocotb_path)

    def update_reg_log(self):
        file_name=f"sim/{os.getenv('RUNTAG')}/runs.log"
        f = open(file_name, "w")
        f.write(f"{'Test':<33} {'status':<10} {'start':<15} {'end':<15} {'duration':<13} {'p/f':<5}\n")
        for test,sim_types in self.tests.items():
            for sim_type,corners in sim_types.items():
                for corner,status in corners.items():
                    new_test_name= f"{sim_type}-{test}-{corner}"
                    f.write(f"{new_test_name:<33} {status['status']:<10} {status['starttime']:<15} {status['endtime']:<15} {status['duration']:<13} {status['pass']:<5}\n")
        f.write(f"\n\nTotal: ({self.passed_tests})passed ({self.failed_tests})failed ({self.unknown_tests})unknown  ({('%.10s' % (datetime.now() - self.total_start_time))})time consumed ")
        f.close()
    
    def write_command_log(self):
        file_name=f"sim/{os.getenv('RUNTAG')}/command.log"
        f = open(file_name, "w")
        f.write(f"{' '.join(sys.argv)}")
        f.close()
  
    def write_git_log(self):
        file_name=f"sim/{os.getenv('RUNTAG')}/git_show.log"
        f = open(file_name, "w")
        # status, output = commands.getstatusoutput("git show")
        f.write( f"Repo: {run('basename -s .git `git config --get remote.origin.url`', stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True).stdout}")
        f.write( f"Branch name: {run('git symbolic-ref --short HEAD', stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True).stdout}")
        f.write( run('git show --quiet HEAD', stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True).stdout)
        MCW_ROOT = f"MCW_ROOT"

        f.write( f"\n\nRepo: {run(f'cd {os.getenv(MCW_ROOT)};basename -s .git `git config --get remote.origin.url`', stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True).stdout}")
        f.write( f"Branch name: {run(f'cd {os.getenv(MCW_ROOT)};git symbolic-ref --short HEAD', stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True).stdout}")
        f.write( run(f'cd {os.getenv(MCW_ROOT)};git show --quiet HEAD', stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True).stdout)
        f.close()
class main():
    def __init__(self,args) -> None:
        self.regression = args.regression
        self.test       = args.test
        self.testlist   = args.testlist
        self.sim       = args.sim
        self.tag        = args.tag
        self.corner        = args.corner
        self.maxerr        = args.maxerr
        self.check_valid_args()
        self.set_tag()
        self.def_env_vars()
        RunRegression(self.regression,self.test,self.sim,self.testlist,self.corner)

    def check_valid_args(self):
        if all(v is  None for v in [self.regression, self.test, self.testlist]):
            print ("Fatal: Should provide at least one of the following options regression, test or testlist for more info use --help")
            sys.exit()
        if not set(self.sim).issubset(["RTL","GL","GL_SDF"]):
            print (f"Fatal: {self.sim} isnt a correct type for -sim it should be one or combination of the following RTL, GL or GL_SDF")
            sys.exit()
    def set_tag(self):
        self.TAG = None # tag will be set in the main phase and other functions will use it
        if self.tag is not None:
            self.TAG = self.tag
        elif self.regression is not None: 
            self.TAG = f'{self.regression}_{datetime.now().strftime("%H_%M_%S_%d_%m")}'
        else: 
            self.TAG = f'run{random.randint(0,1000)}_{datetime.now().strftime("%H_%M_%S_%d_%m")}'
        Path(f"sim/{self.TAG}").mkdir(parents=True, exist_ok=True)
        print(f"Run tag: {self.TAG}")

    def def_env_vars(self):
        if os.getenv('CARAVEL_ROOT') is None or os.getenv('MCW_ROOT') is None:
            print(f"Fatal: CARAVEL_ROOT or MCW_ROOT are not defined")
            sys.exit()
        cocotb_path = f"{os.getenv('CARAVEL_ROOT')}/verilog/dv/cocotb"
        os.environ["CARAVEL_VERILOG_PATH"] = f"{os.getenv('CARAVEL_ROOT')}/verilog"
        os.environ["VERILOG_PATH"] = f"{os.getenv('MCW_ROOT')}/verilog"
        os.environ["CARAVEL_PATH"] = f"{os.getenv('CARAVEL_VERILOG_PATH')}"
        os.environ["FIRMWARE_PATH"] = f"{os.getenv('MCW_ROOT')}/verilog/dv/firmware"
        os.environ["RUNTAG"] = f"{self.TAG}"
        os.environ["ERRORMAX"] = f"{self.maxerr}"



import argparse
parser = argparse.ArgumentParser(description='Run cocotb tests')
parser.add_argument('-regression','-r', help='name of regression can found in tests.json')
parser.add_argument('-test','-t', nargs='+' ,help='name of test if no --sim provided RTL will be run <takes list as input>')
parser.add_argument('-sim', nargs='+' ,help='Simulation type to be run RTL,GL&GL_SDF provided only when run -test <takes list as input>')
parser.add_argument('-testlist','-tl', help='path of testlist to be run ')
parser.add_argument('-tag', help='provide tag of the run default would be regression name and if no regression is provided would be run_<random float>_<timestamp>_')
parser.add_argument('-maxerr', help='max number of errors for every test before simulation breaks default = 3')
parser.add_argument('-vcs','-v',action='store_true', help='use vcs as compiler if not used iverilog would be used')
parser.add_argument('-cov',action='store_true', help='enable code coverage')
parser.add_argument('-corner','-c', nargs='+' ,help='Corner type in case of GL_SDF run has to be provided')
parser.add_argument('-keep_pass_unzip',action='store_true', help='Normally the waves and logs of passed tests would be zipped. Using this option they wouldn\'t be zipped')
args = parser.parse_args()
if (args.vcs) : 
    iverilog = False
    vcs = True
if args.cov: 
    coverage = True
if args.sim == None: 
    args.sim= ["RTL"]
if args.corner == None: 
    args.corner= ["nom-t"]
if args.keep_pass_unzip: 
    zip_waves = False
print(f"regression:{args.regression}, test:{args.test}, testlist:{args.testlist} sim: {args.sim}")
main(args)





