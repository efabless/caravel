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

PDK_PATH = $(PDK_ROOT)/$(PDK)
VERILOG_PATH = ../../../
RTL_PATH = $(VERILOG_PATH)/rtl

SIM ?= RTL

.SUFFIXES:

PATTERN = chip_io

all:  ${PATTERN:=.vcd}

%.vvp: %_tb.v
ifeq ($(SIM),RTL)
	iverilog -Ttyp -DFUNCTIONAL -I $(PDK_PATH) -I $(VERILOG_PATH) -I .. -I $(RTL_PATH) \
	$< -o $@
endif
ifeq ($(SIM),SPLIT_BUS)
	iverilog -Ttyp  -DFUNCTIONAL -DSPLIT_BUS -I $(PDK_PATH) -I $(VERILOG_PATH) -I .. -I $(RTL_PATH) \
	$< -o $@
endif
ifeq ($(SIM),GL)
	iverilog -Ttyp -DFUNCTIONAL -DGL -I $(PDK_PATH) -I $(VERILOG_PATH) -I .. -I $(RTL_PATH) \
	$< -o $@
endif

%.vcd: %.vvp check-env
	vvp $<

check-env:
ifndef PDK_ROOT
	$(error PDK_ROOT is undefined, please export it before running make)
endif

clean:
	rm -f *.vvp *.vcd

.PHONY: clean all
