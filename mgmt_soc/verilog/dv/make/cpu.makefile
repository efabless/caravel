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

ifeq ($(CPU),picorv32)
	LINKER_SCRIPT=$(FIRMWARE_PATH)/sections.lds
	SOURCE_FILES=$(FIRMWARE_PATH)/start.s 
	VERILOG_FILES=
endif

ifeq ($(CPU),ibex)
	LINKER_SCRIPT=$(FIRMWARE_PATH)/link_ibex.ld
	SOURCE_FILES=$(FIRMWARE_PATH)/crt0_ibex.S $(FIRMWARE_PATH)/simple_system_common.c
# 	VERILOG_FILES=../ibex/*
	VERILOG_FILES=
endif

ifeq ($(CPU),vexriscv)
# 	LINKER_SCRIPT=$(FIRMWARE_PATH)/sections_vexriscv.lds
# 	SOURCE_FILES=$(FIRMWARE_PATH)/start_caravel_vexriscv.s
	LINKER_SCRIPT=$(FIRMWARE_PATH)/sections.lds
	SOURCE_FILES=$(FIRMWARE_PATH)/crt0_vex.S $(FIRMWARE_PATH)/isr.c
	VERILOG_FILES=
endif

