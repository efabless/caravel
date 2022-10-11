# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0


PWDD := $(shell pwd)
BLOCKS := $(shell basename $(PWDD))

# ---- Include Partitioned Makefiles ----
CONFIG = caravel_user_project
# TestName = temp_partial
# export COCOTB_ANSI_OUTPUT=0 # disable color in termianl
export GUI=1
export COCOTB_REDUCED_LOG_FMT=1
# Change this line if you want to use existing cocotb test modules:
# export PYTHONPATH := $(DESIGNS)/verilog/rtl/<your design python tests>
# export LIBPYTHON_LOC=$(cocotb-config --libpython)
#export VERILOG_PATH = ../../../
#export CARAVEL_PATH = ../../../../../caravel/verilog/
# include $(MCW_ROOT)/verilog/dv/make/env.makefile
# #export VERILOG_PATH = ../../../
# include $(MCW_ROOT)/verilog/dv/make/var.makefile
# include $(MCW_ROOT)/verilog/dv/make/cpu.makefile
# include $(MCW_ROOT)/verilog/dv/make/sim.makefile
TESTCASE=$(TestName)

MODULE=caravel_tests
$(info $$MODULE is [$(MODULE)])
cocotb:
	rm -rf sim_build/
	mkdir sim_build/
	# change project_tb.v to match your testbench 
	#RTL
	iverilog -Ttyp -DFUNCTIONAL -DSIM -DUSE_POWER_PINS -DUNIT_DELAY=#1 \
	-DTESTNAME=\"$(TestName)\" -DTAG=\"$(RUNTAG)\" -DSIM=\"$(SIM)\" \
	-f$(VERILOG_PATH)/includes/includes.rtl.caravel \
	-o sim_build/sim.vvp $(CARAVEL_PATH)/rtl/__user_project_wrapper.v $(CARAVEL_PATH)/rtl/debug_regs.v caravel_top.sv
	#GL
	# iverilog -Ttyp -DFUNCTIONAL -DGL -DUSE_POWER_PINS -DUNIT_DELAY=#1 \
	# -DTESTNAME=\"$(TestName)\" -DRUNTAG=\"$(RUNTAG)\" -DSIM=\"$(SIM)\" \
	# -f$(VERILOG_PATH)/includes/includes.gl.caravel \
	# -f$(USER_PROJECT_VERILOG)/includes/includes.gl.$(CONFIG) -o sim_build/sim.vvp caravel_top.sv
	#CVC


	# TESTCASE=$(TestName) MODULE=caravel_tests cvc64  +interp +acc+2 \
	# 	+loadvpi=$(shell cocotb-config --lib-name-path vpi cvc):vlog_startup_routines_bootstrap\
	# 	+change_port_type +maxerrors 1\
	# 	+define+SIM +define+FUNCTIONAL +define+GL +define+USE_POWER_PINS +define+UNIT_DELAY=#0 \
	#   +define+TESTNAME=\"$(TestName)\" +define+RUNTAG=\"$(RUNTAG)\" +define+COCOTB_SIM=1\
	# 	-f $(VERILOG_PATH)/includes/includes.gl+sdf.caravel \
	#     -f $(USER_PROJECT_VERILOG)/includes/includes.gl+sdf.$(CONFIG) -o sim_build/sim.vvp 
	


	# verilator --vpi --public-flat-rw --prefix Vtop \
	# 		-LDFLAGS "-Wl,-rpath,$(cocotb-config --prefix)/cocotb/libs \
	# 		-L$(cocotb-config --prefix)/cocotb/libs \
	# 		-lcocotbvpi_verilator -lgpi -lcocotb -lgpilog -lcocotbutils" \
	# 		$(cocotb-config --share)/lib/verilator/verilator.cpp\
	# 		-y $(VERILOG_PATH)/includes/includes.rtl.caravel \
	# 		-y $(USER_PROJECT_VERILOG)/includes/includes.rtl.$(CONFIG) --cc -o sim_build/sim.vvp caravel_top.sv
	# change this line to choose the comma separated test cases and the name of your python test module

	TESTCASE=$(TestName) MODULE=caravel_tests vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

