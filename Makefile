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

# cannot commit files larger than 100 MB to GitHub
FILE_SIZE_LIMIT_MB = 100

# Commands to be used to compress/uncompress files
# they must operate **in place** (otherwise, modify the target to delete the
# intermediate file/archive)
COMPRESS ?= gzip -n --best
UNCOMPRESS ?= gzip -d
ARCHIVE_EXT ?= gz

# The following variables are to build static pattern rules

# Needed to rebuild archives that were previously split
SPLIT_FILES := $(shell find . -type f -name "*.$(ARCHIVE_EXT).00.split")
SPLIT_FILES_SOURCES := $(basename $(basename $(basename $(SPLIT_FILES))))

# Needed to uncompress the existing archives
ARCHIVES := $(shell find . -type f -not -path "*/signoff/*" -name "*.$(ARCHIVE_EXT)")
ARCHIVE_SOURCES := $(basename $(ARCHIVES))

# Needed to compress and split files/archives that are too large
LARGE_FILES := $(shell find ./gds -type f -name "*.gds")
LARGE_FILES += $(shell find . -type f -size +$(FILE_SIZE_LIMIT_MB)M \
	-not -path "*/signoff/*" \
	-not -path "*/.git/*" \
	-not -path "./gds/*" \
	-not -path "./tapeout/outputs/oas/*" \
	-not -path "*/openlane/*" \
	-not -name "*.$(ARCHIVE_EXT)")
LARGE_FILES_GZ := $(addsuffix .$(ARCHIVE_EXT), $(LARGE_FILES))
LARGE_FILES_GZ_SPLIT := $(addsuffix .$(ARCHIVE_EXT).00.split, $(LARGE_FILES))
# consider splitting existing archives
LARGE_FILES_GZ_SPLIT += $(addsuffix .00.split, $(ARCHIVES))

MCW_ROOT?=$(PWD)/mgmt_core_wrapper
MCW ?=LITEX_VEXRISCV
MPW_TAG ?= mpw-9e

PYTHON_BIN ?= python3

# PDK switch varient
export PDK?=sky130A

# Install lite version of caravel, (1): caravel-lite, (0): caravel
MCW_LITE?=1

ifeq ($(MCW),LITEX_VEXRISCV)
	MCW_NAME := mcw-litex-vexriscv
	MCW_REPO ?= https://github.com/efabless/caravel_mgmt_soc_litex
	MCW_TAG ?= $(MPW_TAG)
else
	MCW_NAME := mcw-pico
	MCW_REPO ?= https://github.com/efabless/caravel_pico
	MCW_TAG ?= $(MPW_TAG)
endif

# Install caravel as submodule, (1): submodule, (0): clone
SUBMODULE?=0

# Caravel Root (Default: pwd)
# Need to be overwritten if running the makefile from UPRJ_ROOT,
# If caravel is sub-moduled in the user project, run export CARAVEL_ROOT=$(pwd)/caravel
CARAVEL_ROOT ?= $(shell pwd)

# User project root
UPRJ_ROOT ?= $(shell pwd)

# MANAGEMENT AREA ROOT
MGMT_AREA_ROOT ?= $(shell pwd)/mgmt_core_wrapper 

# Build tasks such as make ship, make generate_fill, make set_user_id, make final run in the foreground (1) or background (0)
FOREGROUND ?= 1

# Ensure commands which are piped through tee return the correct exit code
# to make
SHELL=/bin/bash -o pipefail

# PDK setup configs
THREADS ?= $(shell nproc)
STD_CELL_LIBRARY ?= sky130_fd_sc_hd
SPECIAL_VOLTAGE_LIBRARY ?= sky130_fd_sc_hvl
IO_LIBRARY ?= sky130_fd_io
PRIMITIVES_LIBRARY ?= sky130_fd_pr
SKYWATER_COMMIT ?= f70d8ca46961ff92719d8870a18a076370b85f6c
OPEN_PDKS_COMMIT ?= 0059588eebfc704681dc2368bd1d33d96281d10f
# = 1.0.303
PDK_MAGIC_COMMIT ?= 085131b090cb511d785baf52a10cf6df8a657d44
# = 8.3.294

.DEFAULT_GOAL := ship
# We need portable GDS_FILE pointers...
.PHONY: ship
ship: check-env uncompress uncompress-caravel
ifeq ($(FOREGROUND),1)
	@echo "Running make ship in the foreground..."
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __ship
	@echo "Make ship completed." 2>&1 | tee -a ./signoff/build/make_ship.out
else
	@echo "Running make ship in the background..."
	nohup $(MAKE) -f $(CARAVEL_ROOT)/Makefile __ship >/dev/null 2>&1 &
	tail -f signoff/build/make_ship.out
	@echo "Make ship completed."  2>&1 | tee -a ./signoff/build/make_ship.out
endif

__ship:
	@echo "###############################################"
	@echo "Generating Caravel GDS (sources are in the 'gds' directory)"
	@sleep 1
#### Runs from the CARAVEL_ROOT mag directory 
	@echo "\
		random seed `$(CARAVEL_ROOT)/scripts/set_user_id.py -report`; \
		drc off; \
		crashbackups stop; \
		addpath hexdigits; \
		addpath $(MCW_ROOT)/mag; \
		addpath $(UPRJ_ROOT)/mag; \
		load user_project_wrapper; \
		property LEFview true; \
		property GDS_FILE $(UPRJ_ROOT)/gds/user_project_wrapper.gds; \
		property GDS_START 0; \
		load $(UPRJ_ROOT)/mag/user_id_programming; \
		load $(UPRJ_ROOT)/mag/user_id_textblock; \
		load $(CARAVEL_ROOT)/maglef/simple_por; \
		load $(UPRJ_ROOT)/mag/caravel_core -dereference; \
		load caravel -dereference; \
		select top cell; \
		expand; \
		cif *hier write disable; \
		cif *array write disable; \
		gds write $(UPRJ_ROOT)/gds/caravel.gds; \
		quit -noprompt;" > $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl
### Runs from CARAVEL_ROOT
	@mkdir -p ./signoff/build
	#@cd $(CARAVEL_ROOT)/mag && PDKPATH=${PDK_ROOT}/$(PDK) MAGTYPE=mag magic -noc -dnull -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl 2>&1 | tee $(UPRJ_ROOT)/signoff/build/make_ship.out
	@cd $(CARAVEL_ROOT)/mag && PDKPATH=${PDK_ROOT}/$(PDK) MAGTYPE=mag magic -noc -dnull -rcfile ./.magicrc $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl 2>&1 | tee $(UPRJ_ROOT)/signoff/build/make_ship.out
###	@rm $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl

truck: check-env uncompress uncompress-caravel
ifeq ($(FOREGROUND),1)
	@echo "Running make truck in the foreground..."
	mkdir -p ./signoff
	mkdir -p ./build
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __truck
	@echo "Make truck completed." 2>&1 | tee -a ./signoff/build/make_truck.out
else
	@echo "Running make truck in the background..."
	mkdir -p ./signoff
	mkdir -p ./build
	nohup $(MAKE) -f $(CARAVEL_ROOT)/Makefile __truck >/dev/null 2>&1 &
	tail -f signoff/build/make_truck.out
	@echo "Make truck completed."  2>&1 | tee -a ./signoff/build/make_truck.out
endif

__truck: 
	@echo "###############################################"
	@echo "Generating Caravan GDS (sources are in the 'gds' directory)"
	@sleep 1
#### Runs from the CARAVEL_ROOT mag directory 
	@echo "\
		random seed `$(CARAVEL_ROOT)/scripts/set_user_id.py -report`; \
		drc off; \
		crashbackups stop; \
		addpath hexdigits; \
		addpath $(MCW_ROOT)/mag; \
		addpath $(UPRJ_ROOT)/mag; \
		load user_analog_project_wrapper; \
		property LEFview true; \
		property GDS_FILE $(UPRJ_ROOT)/gds/user_analog_project_wrapper.gds; \
		property GDS_START 0; \
		load $(UPRJ_ROOT)/mag/user_id_programming; \
		load $(UPRJ_ROOT)/mag/user_id_textblock; \
		load $(CARAVEL_ROOT)/maglef/simple_por; \
		load $(UPRJ_ROOT)/mag/caravan_core -dereference; \
		load caravan -dereference; \
		select top cell; \
		expand; \
		cif *hier write disable; \
		cif *array write disable; \
		gds write $(UPRJ_ROOT)/gds/caravan.gds; \
		quit -noprompt;" > $(UPRJ_ROOT)/mag/mag2gds_caravan.tcl
### Runs from CARAVEL_ROOT
	@mkdir -p ./signoff/build
	#@cd $(CARAVEL_ROOT)/mag && PDKPATH=${PDK_ROOT}/$(PDK) MAGTYPE=mag magic -noc -dnull -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc $(UPRJ_ROOT)/mag/mag2gds_caravan.tcl 2>&1 | tee $(UPRJ_ROOT)/signoff/build/make_truck.out
	@cd $(CARAVEL_ROOT)/mag && PDKPATH=${PDK_ROOT}/$(PDK) MAGTYPE=mag magic -noc -dnull -rcfile ./.magicrc $(UPRJ_ROOT)/mag/mag2gds_caravan.tcl 2>&1 | tee $(UPRJ_ROOT)/signoff/build/make_truck.out
###	@rm $(UPRJ_ROOT)/mag/mag2gds_caravan.tcl

.PHONY: openframe
openframe: check-env uncompress uncompress-caravel
ifeq ($(FOREGROUND),1)
	@echo "Running make openframe in the foreground..."
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __openframe
	@echo "Make openframe completed." 2>&1 | tee -a ./signoff/build/make_openframe.out
else
	@echo "Running make openframe in the background..."
	nohup $(MAKE) -f $(CARAVEL_ROOT)/Makefile __openframe >/dev/null 2>&1 &
	tail -f signoff/build/make_openframe.out
	@echo "Make openframe completed."  2>&1 | tee -a ./signoff/build/make_openframe.out
endif

__openframe:
	@echo "###############################################"
	@echo "Generating Caravel GDS (sources are in the 'gds' directory)"
	@sleep 1
#### Runs from the CARAVEL_ROOT mag directory
	@echo "\
		drc off; \
		crashbackups stop; \
		addpath hexdigits; \
		addpath $(UPRJ_ROOT)/mag; \
		load openframe_project_wrapper; \
		property LEFview true; \
		property GDS_FILE $(UPRJ_ROOT)/gds/openframe_project_wrapper.gds; \
		property GDS_START 0; \
		load $(CARAVEL_ROOT)/maglef/simple_por; \
		load caravel_openframe -dereference; \
		select top cell; \
		expand; \
		cif *hier write disable; \
		cif *array write disable; \
		gds write $(UPRJ_ROOT)/gds/caravel.gds; \
		quit -noprompt;" > $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl
### Runs from CARAVEL_ROOT
	@mkdir -p ./signoff/build
	#@cd $(CARAVEL_ROOT)/mag && PDKPATH=${PDK_ROOT}/$(PDK) MAGTYPE=mag magic -noc -dnull -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl 2>&1 | tee $(UPRJ_ROOT)/signoff/build/make_ship.out
	@cd $(CARAVEL_ROOT)/mag && PDKPATH=${PDK_ROOT}/$(PDK) MAGTYPE=mag magic -noc -dnull -rcfile ./.magicrc $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl 2>&1 | tee $(UPRJ_ROOT)/signoff/build/make_ship.out
###	@rm $(UPRJ_ROOT)/mag/mag2gds_caravel.tcl

.PHONY: clean
clean:
	cd $(CARAVEL_ROOT)/verilog/dv/caravel/mgmt_soc/ && \
		$(MAKE) -j$(THREADS) clean
	cd $(CARAVEL_ROOT)/verilog/dv/wb_utests/ && \
		$(MAKE) -j$(THREADS) clean


.PHONY: verify
verify:
	cd $(CARAVEL_ROOT)/verilog/dv/caravel/mgmt_soc/ && \
		$(MAKE) -j$(THREADS) all
	cd $(CARAVEL_ROOT)/verilog/dv/wb_utests/ && \
		$(MAKE) -j$(THREADS) all



#####
$(LARGE_FILES_GZ): %.$(ARCHIVE_EXT): %
	@if ! [ $(suffix $<) = ".$(ARCHIVE_EXT)" ]; then\
		$(COMPRESS) $< > /dev/null &&\
		echo "$< -> $@";\
	fi

$(LARGE_FILES_GZ_SPLIT): %.$(ARCHIVE_EXT).00.split: %.$(ARCHIVE_EXT)
	@if [ -n "$$(find "$<" -prune -size +$(FILE_SIZE_LIMIT_MB)M)" ]; then\
		split $< -b $(FILE_SIZE_LIMIT_MB)M $<. -d &&\
		rm $< &&\
		for file in $$(ls $<.*); do mv "$$file" "$$file.split"; done &&\
		echo -n "$< -> $$(ls $<.*.split)" | tr '\n' ' ' && echo "";\
	fi

# This target compresses all files larger than $(FILE_SIZE_LIMIT_MB) MB
.PHONY: compress
compress: $(LARGE_FILES_GZ) $(LARGE_FILES_GZ_SPLIT)
	@echo "Files larger than $(FILE_SIZE_LIMIT_MB) MBytes are compressed!"



#####
$(ARCHIVE_SOURCES): %: %.$(ARCHIVE_EXT)
	@$(UNCOMPRESS) $<
	@echo "$< -> $@"

.SECONDEXPANSION:
$(SPLIT_FILES_SOURCES): %: $$(sort $$(wildcard %.$(ARCHIVE_EXT).*.split))
	@cat $? > $@.$(ARCHIVE_EXT)
	@rm $?
	@echo "$? -> $@.$(ARCHIVE_EXT)"
	@$(UNCOMPRESS) $@.$(ARCHIVE_EXT)
	@echo "$@.$(ARCHIVE_EXT) -> $@"


.PHONY: uncompress
uncompress: $(SPLIT_FILES_SOURCES) $(ARCHIVE_SOURCES)
	@echo "All files are uncompressed!"

# Needed for targets that are run from UPRJ_ROOT for which caravel isn't submoduled. 
.PHONY: uncompress-caravel
uncompress-caravel:
	cd $(CARAVEL_ROOT) && \
	$(MAKE) uncompress

# Digital Wrapper
# verify that the wrapper was respected
xor-wrapper: uncompress uncompress-caravel
### first erase the user's user_project_wrapper.gds
	sh $(CARAVEL_ROOT)/utils/erase_box.sh gds/user_project_wrapper.gds 0 0 2920 3520
### do the same for the empty wrapper
	sh $(CARAVEL_ROOT)/utils/erase_box.sh $(CARAVEL_ROOT)/gds/user_project_wrapper_empty.gds 0 0 2920 3520
	mkdir -p signoff/user_project_wrapper_xor
### XOR the two resulting layouts
	sh $(CARAVEL_ROOT)/utils/xor.sh \
		$(CARAVEL_ROOT)/gds/user_project_wrapper_empty_erased.gds gds/user_project_wrapper_erased.gds \
		user_project_wrapper user_project_wrapper.xor.xml
	sh $(CARAVEL_ROOT)/utils/xor.sh \
		$(CARAVEL_ROOT)/gds/user_project_wrapper_empty_erased.gds gds/user_project_wrapper_erased.gds \
		user_project_wrapper gds/user_project_wrapper.xor.gds > signoff/user_project_wrapper_xor/xor.log 
	rm $(CARAVEL_ROOT)/gds/user_project_wrapper_empty_erased.gds gds/user_project_wrapper_erased.gds
	mv gds/user_project_wrapper.xor.gds gds/user_project_wrapper.xor.xml signoff/user_project_wrapper_xor
	python $(CARAVEL_ROOT)/utils/parse_klayout_xor_log.py \
		-l signoff/user_project_wrapper_xor/xor.log \
		-o signoff/user_project_wrapper_xor/total.txt
### screenshot the result for convenience
	sh $(CARAVEL_ROOT)/utils/scrotLayout.sh \
		$(PDK_ROOT)/$(PDK)/libs.tech/klayout/$(PDK).lyt \
		signoff/user_project_wrapper_xor/user_project_wrapper.xor.gds
	@cat signoff/user_project_wrapper_xor/total.txt

# Analog Wrapper
# verify that the wrapper was respected
xor-analog-wrapper: uncompress uncompress-caravel
### first erase the user's user_project_wrapper.gds
	sh $(CARAVEL_ROOT)/utils/erase_box.sh gds/user_analog_project_wrapper.gds 0 0 2920 3520 -8 -8 
### do the same for the empty wrapper
	sh $(CARAVEL_ROOT)/utils/erase_box.sh $(CARAVEL_ROOT)/gds/user_analog_project_wrapper_empty.gds 0 0 2920 3520 -8 -8 
	mkdir -p signoff/user_analog_project_wrapper_xor
### XOR the two resulting layouts
	sh $(CARAVEL_ROOT)/utils/xor.sh \
		$(CARAVEL_ROOT)/gds/user_analog_project_wrapper_empty_erased.gds gds/user_analog_project_wrapper_erased.gds \
		user_analog_project_wrapper user_analog_project_wrapper.xor.xml
	sh $(CARAVEL_ROOT)/utils/xor.sh \
		$(CARAVEL_ROOT)/gds/user_analog_project_wrapper_empty_erased.gds gds/user_analog_project_wrapper_erased.gds \
		user_analog_project_wrapper gds/user_analog_project_wrapper.xor.gds > signoff/user_analog_project_wrapper_xor/xor.log 
	rm $(CARAVEL_ROOT)/gds/user_analog_project_wrapper_empty_erased.gds gds/user_analog_project_wrapper_erased.gds
	mv gds/user_analog_project_wrapper.xor.gds gds/user_analog_project_wrapper.xor.xml signoff/user_analog_project_wrapper_xor
	python $(CARAVEL_ROOT)/utils/parse_klayout_xor_log.py \
		-l signoff/user_analog_project_wrapper_xor/xor.log \
		-o signoff/user_analog_project_wrapper_xor/total.txt
### screenshot the result for convenience
	sh $(CARAVEL_ROOT)/utils/scrotLayout.sh \
		$(PDK_ROOT)/$(PDK)/libs.tech/klayout/$(PDK).lyt \
		signoff/user_analog_project_wrapper_xor/user_analog_project_wrapper.xor.gds
	@cat signoff/user_analog_project_wrapper_xor/total.txt

# LVS
BLOCKS = $(shell cd openlane && find * -maxdepth 0 -type d)
LVS_BLOCKS = $(foreach block, $(BLOCKS), lvs-$(block))
$(LVS_BLOCKS): lvs-% : ./mag/%.mag ./verilog/gl/%.v
	echo "Extracting $*"
	mkdir -p ./mag/tmp
	echo "addpath $(CARAVEL_ROOT)/mag/hexdigits;\
		addpath $(CARAVEL_ROOT)/mag/primitives;\
		addpath $(MCW_ROOT)/mag;\
		addpath $(CARAVEL_ROOT)/subcells/simple_por/mag;\
		addpath \$$PDKPATH/libs.ref/sky130_ml_xx_hd/mag;\
		load $* -dereference;\
		select top cell;\
		foreach cell [cellname list children] {\
			load \$$cell -dereference;\
			property LEFview TRUE;\
		};\
		load $* -dereference;\
		select top cell;\
		extract no all;\
		extract do local;\
		extract unique;\
		extract;\
		ext2spice lvs;\
		ext2spice $*.ext;\
		feedback save extract_$*.log;\
		exit;" > ./mag/extract_$*.tcl
	cd mag && \
		export MAGTYPE=maglef; \
		magic -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc -noc -dnull extract_$*.tcl < /dev/null
	mv ./mag/$*.spice ./spi/lvs
	rm ./mag/*.ext
	mv -f ./mag/extract_$*.tcl ./mag/tmp
	mv -f ./mag/extract_$*.log ./mag/tmp
	####
	mkdir -p ./spi/lvs/tmp
	sh $(CARAVEL_ROOT)/spi/lvs/run_lvs.sh ./spi/lvs/$*.spice ./verilog/gl/$*.v $*
	@echo ""
	python3 $(CARAVEL_ROOT)/scripts/count_lvs.py -f ./verilog/gl/$*.v_comp.json | tee ./spi/lvs/tmp/$*.lvs.summary.log
	mv -f ./verilog/gl/*.out ./spi/lvs/tmp 2> /dev/null || true
	mv -f ./verilog/gl/*.json ./spi/lvs/tmp 2> /dev/null || true
	mv -f ./verilog/gl/*.log ./spi/lvs/tmp 2> /dev/null || true
	@echo ""
	@echo "LVS: ./spi/lvs/$*.spice vs. ./verilog/gl/$*.v"
	@echo "Comparison result: ./spi/lvs/tmp/$*.v_comp.out"
	@awk '/^NET mismatches/,0' ./spi/lvs/tmp/$*.v_comp.out


LVS_GDS_BLOCKS = $(foreach block, $(BLOCKS), lvs-gds-$(block))
$(LVS_GDS_BLOCKS): lvs-gds-% : ./gds/%.gds ./verilog/gl/%.v
	echo "Extracting $*"
	mkdir -p ./gds/tmp
	echo "	gds flatglob \"*_example_*\";\
		gds flatten true;\
		gds read ./$*.gds;\
		load $* -dereference;\
		select top cell;\
		extract no all;\
		extract do local;\
		extract unique;\
		extract;\
		ext2spice lvs;\
		ext2spice $*.ext;\
		feedback save extract_$*.log;\
		exit;" > ./gds/extract_$*.tcl
	cd gds && \
		magic -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc -noc -dnull extract_$*.tcl < /dev/null
	mv ./gds/$*.spice ./spi/lvs
	rm ./gds/*.ext
	mv -f ./gds/extract_$*.tcl ./gds/tmp
	mv -f ./gds/extract_$*.log ./gds/tmp
	####
	mkdir -p ./spi/lvs/tmp
	MAGIC_EXT_USE_GDS=1 sh $(CARAVEL_ROOT)/spi/lvs/run_lvs.sh ./spi/lvs/$*.spice ./verilog/gl/$*.v $*
	@echo ""
	python3 $(CARAVEL_ROOT)/scripts/count_lvs.py -f ./verilog/gl/$*.v_comp.json | tee ./spi/lvs/tmp/$*.lvs.summary.log
	mv -f ./verilog/gl/*.out ./spi/lvs/tmp 2> /dev/null || true
	mv -f ./verilog/gl/*.json ./spi/lvs/tmp 2> /dev/null || true
	mv -f ./verilog/gl/*.log ./spi/lvs/tmp 2> /dev/null || true
	@echo ""
	@echo "LVS: ./spi/lvs/$*.spice vs. ./verilog/gl/$*.v"
	@echo "Comparison result: ./spi/lvs/tmp/$*.v_comp.out"
	@awk '/^NET mismatches/,0' ./spi/lvs/tmp/$*.v_comp.out


# connect-by-label is enabled here!
LVS_MAGLEF_BLOCKS = $(foreach block, $(BLOCKS), lvs-maglef-$(block))
$(LVS_MAGLEF_BLOCKS): lvs-maglef-% : ./mag/%.mag ./verilog/gl/%.v
	echo "Extracting $*"
	mkdir -p ./maglef/tmp
	echo "load $* -dereference;\
		select top cell;\
		foreach cell [cellname list children] {\
			load \$$cell -dereference;\
			property LEFview TRUE;\
		};\
		load $* -dereference;\
		select top cell;\
		extract no all;\
		extract do local;\
		extract;\
		ext2spice lvs;\
		ext2spice $*.ext;\
		feedback save extract_$*.log;\
		exit;" > ./mag/extract_$*.tcl
	cd mag && export MAGTYPE=maglef; magic -noc -dnull extract_$*.tcl < /dev/null
	mv ./mag/$*.spice ./spi/lvs
	rm ./maglef/*.ext
	mv -f ./mag/extract_$*.tcl ./maglef/tmp
	mv -f ./mag/extract_$*.log ./maglef/tmp
	####
	mkdir -p ./spi/lvs/tmp
	sh $(CARAVEL_ROOT)/spi/lvs/run_lvs.sh ./spi/lvs/$*.spice ./verilog/gl/$*.v $*
	@echo ""
	python3 $(CARAVEL_ROOT)/scripts/count_lvs.py -f ./verilog/gl/$*.v_comp.json | tee ./spi/lvs/tmp/$*.maglef.lvs.summary.log
	mv -f ./verilog/gl/*.out ./spi/lvs/tmp 2> /dev/null || true
	mv -f ./verilog/gl/*.json ./spi/lvs/tmp 2> /dev/null || true
	mv -f ./verilog/gl/*.log ./spi/lvs/tmp 2> /dev/null || true
	@echo ""
	@echo "LVS: ./spi/lvs/$*.spice vs. ./verilog/gl/$*.v"
	@echo "Comparison result: ./spi/lvs/tmp/$*.v_comp.out"
	@awk '/^NET mismatches/,0' ./spi/lvs/tmp/$*.v_comp.out

# DRC
BLOCKS = $(shell cd openlane && find * -maxdepth 0 -type d)
DRC_BLOCKS = $(foreach block, $(BLOCKS), drc-$(block))
$(DRC_BLOCKS): drc-% : ./gds/%.gds
	echo "Running DRC on $*"
	mkdir -p ./gds/tmp
	cd gds && export DESIGN_IN_DRC=$* && export MAGTYPE=mag; magic -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc -noc -dnull $(CARAVEL_ROOT)/gds/drc_on_gds.tcl < /dev/null
	@echo "DRC result: ./gds/tmp/$*.drc"

# Antenna
BLOCKS = $(shell cd openlane && find * -maxdepth 0 -type d)
ANTENNA_BLOCKS = $(foreach block, $(BLOCKS), antenna-$(block))
$(ANTENNA_BLOCKS): antenna-% : ./gds/%.gds
	echo "Running Antenna Checks on $*"
	mkdir -p ./gds/tmp
	cd gds && export DESIGN_IN_ANTENNA=$* && export MAGTYPE=mag; magic -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc -noc -dnull $(CARAVEL_ROOT)/gds/antenna_on_gds.tcl < /dev/null 2>&1 | tee ./tmp/$*.antenna
	mv -f ./gds/*.ext ./gds/tmp/
	@echo "Antenna result: ./gds/tmp/$*.antenna"

# MAG2GDS
BLOCKS = $(shell cd openlane && find * -maxdepth 0 -type d)
MAG_BLOCKS = $(foreach block, $(BLOCKS), mag2gds-$(block))
$(MAG_BLOCKS): mag2gds-% : ./mag/%.mag uncompress
	echo "Converting mag file $* to GDS..."
	echo "addpath $(CARAVEL_ROOT)/mag/hexdigits;\
		addpath ${PDKPATH}/libs.ref/sky130_ml_xx_hd/mag;\
		addpath $(CARAVEL_ROOT)/mag/primitives;\
		drc off;\
		gds rescale false;\
		load $* -dereference;\
		select top cell;\
		expand;\
		gds write $*.gds;\
		exit;" > ./mag/mag2gds_$*.tcl
	cd ./mag && magic -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc -noc -dnull mag2gds_$*.tcl < /dev/null
	rm ./mag/mag2gds_$*.tcl
	mv -f ./mag/$*.gds ./gds/

# MAG2LEF 
BLOCKS = $(shell cd openlane && find * -maxdepth 0 -type d)
MAG_BLOCKS = $(foreach block, $(BLOCKS), mag2lef-$(block))
$(MAG_BLOCKS): mag2lef-% : ./mag/%.mag uncompress
	echo "Converting mag file $* to LEF..."
	echo "addpath $(CARAVEL_ROOT)/mag/hexdigits;\
		addpath ${PDKPATH}/libs.ref/sky130_ml_xx_hd/mag;\
		addpath $(CARAVEL_ROOT)/mag/primitives;\
		drc off;\
		load $*;\
		lef write $*.lef;\
		exit;" > ./mag/mag2lef_$*.tcl
	cd ./mag && magic -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc -noc -dnull mag2lef_$*.tcl < /dev/null
	rm ./mag/mag2lef_$*.tcl
	mv -f ./mag/$*.lef ./lef/

# MAG2DEF 
# BLOCKS = $(shell cd openlane && find * -maxdepth 0 -type d)
# MAG_BLOCKS = $(foreach block, $(BLOCKS), mag2lef-$(block))
# $(MAG_BLOCKS): mag2lef-% : ./mag/%.mag uncompress
# 	echo "Converting mag file $* to DEF..."
# 	echo "addpath $(CARAVEL_ROOT)/mag/hexdigits;\
# 		addpath ${PDKPATH}/libs.ref/sky130_ml_xx_hd/mag;\
# 		addpath $(CARAVEL_ROOT)/mag/primitives;\
# 		drc off;\
# 		load $*;\
# 		lef write $*.lef;\
# 		exit;" > ./mag/mag2lef_$*.tcl
# 	cd ./mag && magic -rcfile ${PDK_ROOT}/$(PDK)/libs.tech/magic/$(PDK).magicrc -noc -dnull mag2lef_$*.tcl < /dev/null
# 	rm ./mag/mag2lef_$*.tcl
# 	mv -f ./mag/$*.lef ./lef/

.PHONY: help
help:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

# RCX Extraction
BLOCKS = $(shell cd openlane && find * -maxdepth 0 -type d)
RCX_BLOCKS = $(foreach block, $(BLOCKS), rcx-$(block))
OPENLANE_IMAGE_NAME=efabless/openlane:2021.11.25_01.26.14
$(RCX_BLOCKS): rcx-% : ./def/%.def 
	echo "Running RC Extraction on $*"
	mkdir -p ./def/tmp 
	# merge techlef and standard cell lef files
	python3 $(OPENLANE_ROOT)/scripts/mergeLef.py -i $(PDK_ROOT)/$(PDK)/libs.ref/$(STD_CELL_LIBRARY)/techlef/$(STD_CELL_LIBRARY).tlef $(PDK_ROOT)/$(PDK)/libs.ref/$(STD_CELL_LIBRARY)/lef/*.lef $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/techlef/$(SPECIAL_VOLTAGE_LIBRARY).tlef $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lef/*.lef $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lef/*.lef -o ./def/tmp/merged.lef
	echo "\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(STD_CELL_LIBRARY)/lib/$(STD_CELL_LIBRARY)__tt_025C_1v80.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__tt_025C_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__tt_025C_3v30_lv1v80.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_gpiov2_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_hvc_wpad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_tt_100C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_power_lvc_wpad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_xres4v2_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__gpiov2_pad_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vdda_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssa_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped3_pad_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped3_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped_pad_tt_025C_1v80_3v30.lib;\
		set std_cell_lef ./def/tmp/merged.lef;\
		set sram_lef $(PDK_ROOT)/$(PDK)/libs.ref/sky130_sram_macros/lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef;\
		if {[catch {read_lef \$$std_cell_lef} errmsg]} {\
    			puts stderr \$$errmsg;\
    			exit 1;\
		};\
		if {[catch {read_lef \$$sram_lef} errmsg]} {\
    			puts stderr \$$errmsg;\
    			exit 1;\
		};\
		foreach lef_file [glob ./lef/*.lef] {\
			if {[catch {read_lef \$$lef_file} errmsg]} {\
    			puts stderr \$$errmsg;\
    			exit 1;\
			}\
		};\
		if {[catch {read_def -order_wires ./def/$*.def} errmsg]} {\
			puts stderr \$$errmsg;\
			exit 1;\
		};\
		read_sdc -echo ./sdc/$*.sdc;\
		set_propagated_clock [all_clocks];\
		set rc_values \"mcon 9.249146E-3,via 4.5E-3,via2 3.368786E-3,via3 0.376635E-3,via4 0.00580E-3\";\
		set l_rc \"li1 1.499e-04 7.176e-02,met1 1.449e-04 8.929e-04,met2 1.331e-04 8.929e-04,met3 1.464e-04 1.567e-04,met4 1.297e-04 1.567e-04,met5 1.501e-04 1.781e-05\";\
		set layers_rc [split \$$l_rc ","];\
		foreach layer_rc \$$layers_rc {\
			set layer_name [lindex \$$layer_rc 0];\
			set capacitance [lindex \$$layer_rc 1];\
			set resistance [lindex \$$layer_rc 2];\
			set_layer_rc -layer \$$layer_name -capacitance \$$capacitance -resistance \$$resistance;\
		};\
		set vias_rc [split \$$rc_values ","];\
    	foreach via_rc \$$vias_rc {\
        		set layer_name [lindex \$$via_rc 0];\
        		set resistance [lindex \$$via_rc 1];\
       			set_layer_rc -via \$$layer_name -resistance \$$resistance;\
    	};\
		set_wire_rc -signal -layer met2;\
		set_wire_rc -clock -layer met5;\
		define_process_corner -ext_model_index 0 X;\
		extract_parasitics -ext_model_file ${PDK_ROOT}/$(PDK)/libs.tech/openlane/rcx_rules.info -corner_cnt 1 -max_res 50 -coupling_threshold 0.1 -cc_model 10 -context_depth 5;\
		write_spef ./spef/$*.spef" > ./def/tmp/rcx_$*.tcl
## Generate Spef file
	docker run -it -v $(OPENLANE_ROOT):/openlane -v $(PDK_ROOT):$(PDK_ROOT) -v $(PWD):/caravel -e PDK_ROOT=$(PDK_ROOT) -u $(shell id -u $(USER)):$(shell id -g $(USER)) $(OPENLANE_IMAGE_NAME) \
	sh -c " cd /caravel; openroad -exit ./def/tmp/rcx_$*.tcl |& tee ./def/tmp/rcx_$*.log" 
## Run OpenSTA
	echo "\
		set std_cell_lef ./def/tmp/merged.lef;\
		set sram_lef $(PDK_ROOT)/$(PDK)/libs.ref/sky130_sram_macros/lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef;\
		if {[catch {read_lef \$$std_cell_lef} errmsg]} {\
    			puts stderr \$$errmsg;\
    			exit 1;\
		};\
		if {[catch {read_lef \$$sram_lef} errmsg]} {\
    			puts stderr \$$errmsg;\
    			exit 1;\
		};\
		foreach lef_file [glob ./lef/*.lef] {\
			if {[catch {read_lef \$$lef_file} errmsg]} {\
    			puts stderr \$$errmsg;\
    			exit 1;\
			}\
		};\
		set_cmd_units -time ns -capacitance pF -current mA -voltage V -resistance kOhm -distance um;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(STD_CELL_LIBRARY)/lib/$(STD_CELL_LIBRARY)__tt_025C_1v80.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__tt_025C_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/sky130_fd_sc_hvl__tt_025C_3v30_lv1v80.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_gpiov2_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_hvc_wpad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_tt_100C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_power_lvc_wpad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_xres4v2_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__gpiov2_pad_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vdda_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssa_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped3_pad_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped3_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped_pad_tt_025C_1v80_3v30.lib;\
		read_verilog ./verilog/gl/$*.v;\
		link_design $*;\
		read_spef ./spef/$*.spef;\
		read_sdc -echo ./sdc/$*.sdc;\
		write_sdf ./sdf/$*.sdf -divider . -include_typ;\
		report_checks -fields {capacitance slew input_pins nets fanout} -path_delay min_max -group_count 5;\
		report_check_types -max_slew -max_capacitance -max_fanout -violators;\
		report_checks -to [all_outputs] -group_count 1000;\
		" > ./def/tmp/sta_$*.tcl 
	docker run -it -v $(OPENLANE_ROOT):/openlane -v $(PDK_ROOT):$(PDK_ROOT) -v $(PWD):/caravel -e PDK_ROOT=$(PDK_ROOT) -u $(shell id -u $(USER)):$(shell id -g $(USER)) $(OPENLANE_IMAGE_NAME) \
	sh -c "cd /caravel; openroad -exit ./def/tmp/sta_$*.tcl |& tee ./def/tmp/sta_$*.log" 


caravel_timing_typ: ./def/caravel.def ./sdc/caravel.sdc ./verilog/gl/caravel.v check-mcw
	mkdir -p ./def/tmp
## Run OpenSTA
	echo "\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(STD_CELL_LIBRARY)/lib/$(STD_CELL_LIBRARY)__tt_025C_1v80.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__tt_025C_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__tt_025C_3v30_lv1v80.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_gpiov2_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_hvc_wpad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_tt_100C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_power_lvc_wpad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_xres4v2_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__gpiov2_pad_tt_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vdda_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssa_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped3_pad_tt_025C_1v80_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped3_pad_tt_025C_1v80_3v30_3v30.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped_pad_tt_025C_1v80_3v30.lib;\
		read_verilog $(MCW_ROOT)/verilog/gl/mgmt_core.v;\
		read_verilog $(MCW_ROOT)/verilog/gl/DFFRAM.v;\
		read_verilog $(MCW_ROOT)/verilog/gl/mgmt_core_wrapper.v;\
		read_verilog ./verilog/gl/caravel_clocking.v;\
		read_verilog ./verilog/gl/digital_pll.v;\
		read_verilog ./verilog/gl/housekeeping.v;\
		read_verilog ./verilog/gl/gpio_logic_high.v;\
		read_verilog ./verilog/gl/gpio_control_block.v;\
		read_verilog ./verilog/gl/gpio_defaults_block.v;\
		read_verilog ./verilog/gl/gpio_defaults_block_0403.v;\
		read_verilog ./verilog/gl/gpio_defaults_block_1803.v;\
		read_verilog ./verilog/gl/mgmt_protect_hv.v;\
		read_verilog ./verilog/gl/mprj_logic_high.v;\
		read_verilog ./verilog/gl/mprj2_logic_high.v;\
		read_verilog ./verilog/gl/mgmt_protect.v;\
		read_verilog ./verilog/gl/user_id_programming.v;\
		read_verilog ./verilog/gl/xres_buf.v;\
		read_verilog ./verilog/gl/spare_logic_block.v;\
		read_verilog ./verilog/gl/chip_io.v;\
		read_verilog ./verilog/gl/caravel.v;\
		link_design caravel;\
		read_spef -path soc/DFFRAM_0 $(MCW_ROOT)/spef/DFFRAM.spef;\
		read_spef -path soc/core $(MCW_ROOT)/spef/mgmt_core.spef;\
		read_spef -path soc $(MCW_ROOT)/spef/mgmt_core_wrapper.spef;\
		read_spef -path padframe ./spef/chip_io.spef;\
		read_spef -path rstb_level ./spef/xres_buf.spef;\
		read_spef -path pll ./spef/digital_pll.spef;\
		read_spef -path housekeeping ./spef/housekeeping.spef;\
		read_spef -path mgmt_buffers/powergood_check ./spef/mgmt_protect_hv.spef;\
		read_spef -path mgmt_buffers/mprj_logic_high_inst ./spef/mprj_logic_high.spef;\
		read_spef -path mgmt_buffers/mprj2_logic_high_inst ./spef/mprj2_logic_high.spef;\
		read_spef -path mgmt_buffers ./spef/mgmt_protect.spef;\
		read_spef -path \gpio_control_bidir_1[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_1[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_2[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_2[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[10] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[6] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[7] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[8] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[9] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[10] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[11] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[12] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[13] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[14] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[15] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[6] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[7] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[8] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[9] ./spef/gpio_control_block.spef;\
		read_spef -path gpio_defaults_block_0 ./spef/gpio_defaults_block_1803.spef;\
		read_spef -path gpio_defaults_block_1 ./spef/gpio_defaults_block_1803.spef;\
		read_spef -path gpio_defaults_block_2 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_3 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_4 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_5 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_6 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_7 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_8 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_9 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_10 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_11 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_12 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_13 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_14 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_15 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_16 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_17 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_18 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_19 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_20 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_21 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_22 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_23 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_24 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_25 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_26 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_27 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_28 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_29 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_30 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_31 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_32 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_33 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_34 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_35 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_36 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_37 ./spef/gpio_defaults_block.spef;\
		read_spef ./spef/caravel.spef;\
		read_sdc -echo ./sdc/caravel.sdc;\
		report_checks -path_delay min -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50;\
		report_checks -path_delay max -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50;\
		report_worst_slack -max ;\
		report_worst_slack -min ;\
		echo \" Management Area Interface \";\
		report_checks -to soc/core_clk -unconstrained -group_count 1;\
		echo \" User project Interface \";\
		report_checks -to mprj/wb_clk_i -unconstrained -group_count 1;\
		report_checks -to mprj/wb_rst_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_cyc_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_stb_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_we_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_sel_i[*] -unconstrained -group_count 4;\
		report_checks -to mprj/wbs_adr_i[*] -unconstrained -group_count 32;\
		report_checks -to mprj/io_in[*] -unconstrained -group_count 32;\
		report_checks -to mprj/user_clock2 -unconstrained -group_count 32;\
		report_checks -to mprj/user_irq[*] -unconstrained -group_count 32;\
		report_checks -to mprj/la_data_in[*] -unconstrained -group_count 128;\
		report_checks -to mprj/la_oenb[*] -unconstrained -group_count 128;\
		echo \" Flash output Interface \";\
		report_checks -to flash_clk -group_count 1;\
		report_checks -to flash_csb -group_count 1;\
		report_checks -to flash_io0 -group_count 1;\
		" > ./def/tmp/caravel_timing_typ.tcl 
	sta -exit ./def/tmp/caravel_timing_typ.tcl | tee ./signoff/caravel/caravel_timing_typ.log 

caravel_timing_slow: ./def/caravel.def ./sdc/caravel.sdc ./verilog/gl/caravel.v check-mcw
	mkdir -p ./def/tmp
## Run OpenSTA
	echo "\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(STD_CELL_LIBRARY)/lib/$(STD_CELL_LIBRARY)__ss_100C_1v60.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__ss_100C_1v65.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__ss_100C_1v65_lv1v40.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_gpiov2_ss_ss_100C_1v40_1v65.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_hvc_wpad_ss_100C_1v60_3v00_3v00.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_ss_100C_1v40_1v65.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_power_lvc_wpad_ss_100C_1v60_3v00_3v00.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_xres4v2_ss_ss_100C_1v40_1v65.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__gpiov2_pad_wrapped_ss_ss_100C_1v60_3v00.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vdda_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vdda_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ss_100C_1v40_1v65.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ss_100C_1v60_3v00_3v00.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped_pad_ss_100C_1v60_3v00.lib;\
		read_verilog $(MCW_ROOT)/verilog/gl/mgmt_core.v;\
		read_verilog $(MCW_ROOT)/verilog/gl/DFFRAM.v;\
		read_verilog $(MCW_ROOT)/verilog/gl/mgmt_core_wrapper.v;\
		read_verilog ./verilog/gl/caravel_clocking.v;\
		read_verilog ./verilog/gl/digital_pll.v;\
		read_verilog ./verilog/gl/housekeeping.v;\
		read_verilog ./verilog/gl/gpio_logic_high.v;\
		read_verilog ./verilog/gl/gpio_control_block.v;\
		read_verilog ./verilog/gl/gpio_defaults_block.v;\
		read_verilog ./verilog/gl/gpio_defaults_block_0403.v;\
		read_verilog ./verilog/gl/gpio_defaults_block_1803.v;\
		read_verilog ./verilog/gl/mgmt_protect_hv.v;\
		read_verilog ./verilog/gl/mprj_logic_high.v;\
		read_verilog ./verilog/gl/mprj2_logic_high.v;\
		read_verilog ./verilog/gl/mgmt_protect.v;\
		read_verilog ./verilog/gl/user_id_programming.v;\
		read_verilog ./verilog/gl/xres_buf.v;\
		read_verilog ./verilog/gl/spare_logic_block.v;\
		read_verilog ./verilog/gl/chip_io.v;\
		read_verilog ./verilog/gl/caravel.v;\
		link_design caravel;\
		read_spef -path soc/DFFRAM_0 $(MCW_ROOT)/spef/DFFRAM.spef;\
		read_spef -path soc/core $(MCW_ROOT)/spef/mgmt_core.spef;\
		read_spef -path soc $(MCW_ROOT)/spef/mgmt_core_wrapper.spef;\
		read_spef -path padframe ./spef/chip_io.spef;\
		read_spef -path rstb_level ./spef/xres_buf.spef;\
		read_spef -path pll ./spef/digital_pll.spef;\
		read_spef -path housekeeping ./spef/housekeeping.spef;\
		read_spef -path mgmt_buffers/powergood_check ./spef/mgmt_protect_hv.spef;\
		read_spef -path mgmt_buffers/mprj_logic_high_inst ./spef/mprj_logic_high.spef;\
		read_spef -path mgmt_buffers/mprj2_logic_high_inst ./spef/mprj2_logic_high.spef;\
		read_spef -path mgmt_buffers ./spef/mgmt_protect.spef;\
		read_spef -path \gpio_control_bidir_1[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_1[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_2[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_2[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[10] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[6] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[7] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[8] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[9] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[10] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[11] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[12] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[13] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[14] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[15] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[6] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[7] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[8] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[9] ./spef/gpio_control_block.spef;\
		read_spef -path gpio_defaults_block_0 ./spef/gpio_defaults_block_1803.spef;\
		read_spef -path gpio_defaults_block_1 ./spef/gpio_defaults_block_1803.spef;\
		read_spef -path gpio_defaults_block_2 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_3 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_4 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_5 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_6 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_7 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_8 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_9 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_10 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_11 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_12 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_13 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_14 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_15 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_16 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_17 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_18 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_19 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_20 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_21 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_22 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_23 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_24 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_25 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_26 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_27 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_28 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_29 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_30 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_31 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_32 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_33 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_34 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_35 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_36 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_37 ./spef/gpio_defaults_block.spef;\
		read_spef ./spef/caravel.spef;\
		read_sdc -echo ./sdc/caravel.sdc;\
		report_checks -path_delay min -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50;\
		report_checks -path_delay max -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50;\
		report_worst_slack -max ;\
		report_worst_slack -min ;\
		echo \" Management Area Interface \";\
		report_checks -to soc/core_clk -unconstrained -group_count 1;\
		echo \" User project Interface \";\
		report_checks -to mprj/wb_clk_i -unconstrained -group_count 1;\
		report_checks -to mprj/wb_rst_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_cyc_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_stb_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_we_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_sel_i[*] -unconstrained -group_count 4;\
		report_checks -to mprj/wbs_adr_i[*] -unconstrained -group_count 32;\
		report_checks -to mprj/io_in[*] -unconstrained -group_count 32;\
		report_checks -to mprj/user_clock2 -unconstrained -group_count 32;\
		report_checks -to mprj/user_irq[*] -unconstrained -group_count 32;\
		report_checks -to mprj/la_data_in[*] -unconstrained -group_count 128;\
		report_checks -to mprj/la_oenb[*] -unconstrained -group_count 128;\
		" > ./def/tmp/caravel_timing_slow.tcl 
	sta -exit ./def/tmp/caravel_timing_slow.tcl | tee ./signoff/caravel/caravel_timing_slow.log 


caravel_timing_fast: ./def/caravel.def ./sdc/caravel.sdc ./verilog/gl/caravel.v check-mcw
	mkdir -p ./def/tmp
## Run OpenSTA
	echo "\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(STD_CELL_LIBRARY)/lib/$(STD_CELL_LIBRARY)__ff_n40C_1v95.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__ff_n40C_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(SPECIAL_VOLTAGE_LIBRARY)/lib/$(SPECIAL_VOLTAGE_LIBRARY)__ff_n40C_4v40_lv1v95.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_gpiov2_ff_ff_n40C_1v95_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_hvc_wpad_ff_n40C_1v95_5v50_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_ff_n40C_1v95_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_ground_lvc_wpad_ff_n40C_1v95_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_power_lvc_wpad_ff_n40C_1v95_5v50_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_fd_io__top_xres4v2_ff_ff_n40C_1v95_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__gpiov2_pad_wrapped_ff_ff_n40C_1v95_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vdda_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssa_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ff_n40C_1v95_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ff_n40C_1v95_5v50_5v50.lib;\
		read_liberty $(PDK_ROOT)/$(PDK)/libs.ref/$(IO_LIBRARY)/lib/sky130_ef_io__vssd_lvc_clamped_pad_ff_n40C_1v95_5v50.lib;\
		read_verilog $(MCW_ROOT)/verilog/gl/mgmt_core.v;\
		read_verilog $(MCW_ROOT)/verilog/gl/DFFRAM.v;\
		read_verilog $(MCW_ROOT)/verilog/gl/mgmt_core_wrapper.v;\
		read_verilog ./verilog/gl/caravel_clocking.v;\
		read_verilog ./verilog/gl/digital_pll.v;\
		read_verilog ./verilog/gl/housekeeping.v;\
		read_verilog ./verilog/gl/gpio_logic_high.v;\
		read_verilog ./verilog/gl/gpio_control_block.v;\
		read_verilog ./verilog/gl/gpio_defaults_block.v;\
		read_verilog ./verilog/gl/gpio_defaults_block_0403.v;\
		read_verilog ./verilog/gl/gpio_defaults_block_1803.v;\
		read_verilog ./verilog/gl/mgmt_protect_hv.v;\
		read_verilog ./verilog/gl/mprj_logic_high.v;\
		read_verilog ./verilog/gl/mprj2_logic_high.v;\
		read_verilog ./verilog/gl/mgmt_protect.v;\
		read_verilog ./verilog/gl/user_id_programming.v;\
		read_verilog ./verilog/gl/xres_buf.v;\
		read_verilog ./verilog/gl/spare_logic_block.v;\
		read_verilog ./verilog/gl/chip_io.v;\
		read_verilog ./verilog/gl/caravel.v;\
		link_design caravel;\
		read_spef -path soc/DFFRAM_0 $(MCW_ROOT)/spef/DFFRAM.spef;\
		read_spef -path soc/core $(MCW_ROOT)/spef/mgmt_core.spef;\
		read_spef -path soc $(MCW_ROOT)/spef/mgmt_core_wrapper.spef;\
		read_spef -path padframe ./spef/chip_io.spef;\
		read_spef -path rstb_level ./spef/xres_buf.spef;\
		read_spef -path pll ./spef/digital_pll.spef;\
		read_spef -path housekeeping ./spef/housekeeping.spef;\
		read_spef -path mgmt_buffers/powergood_check ./spef/mgmt_protect_hv.spef;\
		read_spef -path mgmt_buffers/mprj_logic_high_inst ./spef/mprj_logic_high.spef;\
		read_spef -path mgmt_buffers/mprj2_logic_high_inst ./spef/mprj2_logic_high.spef;\
		read_spef -path mgmt_buffers ./spef/mgmt_protect.spef;\
		read_spef -path \gpio_control_bidir_1[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_1[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_2[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_bidir_2[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[10] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[6] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[7] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[8] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1[9] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_1a[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[0] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[10] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[11] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[12] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[13] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[14] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[15] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[1] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[2] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[3] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[4] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[5] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[6] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[7] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[8] ./spef/gpio_control_block.spef;\
		read_spef -path \gpio_control_in_2[9] ./spef/gpio_control_block.spef;\
		read_spef -path gpio_defaults_block_0 ./spef/gpio_defaults_block_1803.spef;\
		read_spef -path gpio_defaults_block_1 ./spef/gpio_defaults_block_1803.spef;\
		read_spef -path gpio_defaults_block_2 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_3 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_4 ./spef/gpio_defaults_block_0403.spef;\
		read_spef -path gpio_defaults_block_5 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_6 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_7 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_8 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_9 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_10 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_11 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_12 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_13 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_14 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_15 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_16 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_17 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_18 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_19 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_20 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_21 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_22 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_23 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_24 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_25 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_26 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_27 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_28 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_29 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_30 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_31 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_32 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_33 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_34 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_35 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_36 ./spef/gpio_defaults_block.spef;\
		read_spef -path gpio_defaults_block_37 ./spef/gpio_defaults_block.spef;\
		read_spef ./spef/caravel.spef;\
		read_sdc -echo ./sdc/caravel.sdc;\
		report_checks -path_delay min -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50;\
		report_checks -path_delay max -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50;\
		report_worst_slack -max ;\
		report_worst_slack -min ;\
		echo \" Management Area Interface \";\
		report_checks -to soc/core_clk -unconstrained -group_count 1;\
		echo \" User project Interface \";\
		report_checks -to mprj/wb_clk_i -unconstrained -group_count 1;\
		report_checks -to mprj/wb_rst_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_cyc_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_stb_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_we_i -unconstrained -group_count 1;\
		report_checks -to mprj/wbs_sel_i[*] -unconstrained -group_count 4;\
		report_checks -to mprj/wbs_adr_i[*] -unconstrained -group_count 32;\
		report_checks -to mprj/io_in[*] -unconstrained -group_count 32;\
		report_checks -to mprj/user_clock2 -unconstrained -group_count 32;\
		report_checks -to mprj/user_irq[*] -unconstrained -group_count 32;\
		report_checks -to mprj/la_data_in[*] -unconstrained -group_count 128;\
		report_checks -to mprj/la_oenb[*] -unconstrained -group_count 128;\
		" > ./def/tmp/caravel_timing_fast.tcl 
	sta -exit ./def/tmp/caravel_timing_fast.tcl | tee ./signoff/caravel/caravel_timing_fast.log 

###########################################################################
.PHONY: generate_fill
generate_fill: check-env check-uid check-project uncompress
ifeq ($(FOREGROUND),1)
	@echo "Running generate_fill in the foreground..."
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __generate_fill
	@echo "Generate fill completed." 2>&1 | tee -a ./signoff/build/generate_fill.out
else
	@echo "Running generate_fill in the background..."
	@nohup $(MAKE) -f $(CARAVEL_ROOT)/Makefile __generate_fill >/dev/null 2>&1 &
	tail -f signoff/build/generate_fill.out
	@echo "Generate fill completed." | tee -a signoff/build/generate_fill.out
endif

__generate_fill:
	@mkdir -p ./signoff/build
	@cp -r $(CARAVEL_ROOT)/mag/.magicrc $(shell pwd)/mag
	#python3 $(CARAVEL_ROOT)/scripts/generate_fill.py $(USER_ID) $(PROJECT) $(shell pwd) -dist 2>&1 | tee ./signoff/build/generate_fill.out
	python3 $(CARAVEL_ROOT)/scripts/generate_fill.py $(USER_ID) $(PROJECT) $(shell pwd) -keep 2>&1 | tee ./signoff/build/generate_fill.out


.PHONY: final
final: check-env check-uid check-project uncompress uncompress-caravel
ifeq ($(FOREGROUND),1)
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __final
	@echo "Final build completed." 2>&1 | tee -a ./signoff/build/final_build.out
else
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __final >/dev/null 2>&1 &
	tail -f signoff/build/final_build.out
	@echo "Final build completed." 2>&1 | tee -a ./signoff/build/final_build.out
endif

__final:
	python3 $(CARAVEL_ROOT)/scripts/compositor.py $(USER_ID) $(PROJECT) $(shell pwd) $(CARAVEL_ROOT)/mag $(shell pwd)/gds -keep
	#mv $(CARAVEL_ROOT)/mag/caravel_$(USER_ID).mag ./mag/
	@rm -rf ./mag/tmp

.PHONY: set_user_id
set_user_id: check-env check-uid uncompress uncompress-caravel
ifeq ($(FOREGROUND),1)
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __set_user_id
	@echo "Set user ID completed." 2>&1 | tee -a ./signoff/build/set_user_id.out
else
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __set_user_id >/dev/null 2>&1 &
	tail -f signoff/build/set_user_id.out
	@echo "Set user ID completed." 2>&1 | tee -a ./signoff/build/set_user_id.out
endif

__set_user_id: 
	mkdir -p ./signoff/build
	# Update info.yaml
	# sed -r "s/^(\s*project_id\s*:\s*).*/\1${USER_ID}/" -i info.yaml
	cp $(CARAVEL_ROOT)/mag/user_id_programming.mag ./mag/user_id_programming.mag
	cp $(CARAVEL_ROOT)/mag/user_id_textblock.mag ./mag/user_id_textblock.mag
	cp $(CARAVEL_ROOT)/verilog/rtl/caravel_core.v ./verilog/rtl/caravel_core.v
	cp $(CARAVEL_ROOT)/verilog/gl/user_id_programming.v ./verilog/gl/user_id_programming.v
	python3 $(CARAVEL_ROOT)/scripts/set_user_id.py $(USER_ID) $(shell pwd) 2>&1 | tee ./signoff/build/set_user_id.out

.PHONY: gpio_defaults
gpio_defaults: check-env uncompress uncompress-caravel
ifeq ($(FOREGROUND),1)
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __gpio_defaults
	@echo "GPIO defaults completed." 2>&1 | tee -a ./signoff/build/__gpio_defaults.out
else
	$(MAKE) -f $(CARAVEL_ROOT)/Makefile __gpio_defaults >/dev/null 2>&1 &
	tail -f signoff/build/gpio_defaults.out
	@echo "GPIO defaults completed." 2>&1 | tee -a ./signoff/build/__gpio_defaults.out
endif

__gpio_defaults:
	mkdir -p ./signoff/build
	mkdir -p ./verilog/gl
	python3 $(CARAVEL_ROOT)/scripts/gen_gpio_defaults.py $(shell pwd) 2>&1 | tee ./signoff/build/gpio_defaults.out

.PHONY: update_caravel
update_caravel:
	cd caravel/ && \
		git checkout master && \
		git pull

###########################################################################

# Install Mgmt Core Wrapper
.PHONY: install_mcw
install_mcw:
	if [ -d "$(MCW_ROOT)" ]; then \
		echo "Deleting existing $(MCW_ROOT)" && \
		rm -rf $(MCW_ROOT) && sleep 2;\
	fi
ifeq ($(SUBMODULE),1)
	@echo "Installing $(MCW_NAME) as a submodule.."
# Convert MCW_ROOT to relative path because .gitmodules doesn't accept '/'
	$(eval MCW_PATH := $(shell realpath --relative-to=$(shell pwd) $(MCW_ROOT)))
	@if [ ! -d $(MCW_ROOT) ]; then git submodule add --name $(MCW_NAME) $(MCW_REPO) $(MCW_PATH); fi
	@git submodule update --init
	@cd $(MCW_ROOT); git checkout $(MCW_TAG)
	$(MAKE) simlink
else
	@echo "Installing $(MCW_NAME).."
	@git clone -b $(MCW_TAG) $(MCW_REPO) $(MCW_ROOT) --depth=1
endif


# Update Mgmt Core Wrapper
.PHONY: update_mcw
update_mcw: check-mcw
ifeq ($(SUBMODULE),1)
	@git submodule update --init --recursive
	cd $(MCW_ROOT) && \
	git checkout $(MCW_TAG) && \
	git pull
else
	cd $(MCW_ROOT)/ && \
		git checkout $(MCW_TAG) && \
		git pull
endif

# Uninstall Mgmt Core Wrapper
.PHONY: uninstall_mcw
uninstall_mcw:
ifeq ($(SUBMODULE),1)
	git config -f .gitmodules --remove-section "submodule.$(MCW_NAME)"
	git add .gitmodules
	git submodule deinit -f $(MCW_ROOT)
	git rm --cached $(MCW_ROOT)
	rm -rf .git/modules/$(MCW_NAME)
	rm -rf $(MCW_ROOT)
else
	rm -rf $(MCW_ROOT)/*
endif


###########################################################################

.PHONY: pdk-with-volare
pdk-with-volare: check-python install-volare 
	./venv/bin/volare enable ${OPEN_PDKS_COMMIT}

check-python:
ifeq ($(shell which python3),)
$(error Please install python 3.6+)
endif

.PHONY: install-volare
install-volare:
	rm -rf ./venv
	$(PYTHON_BIN) -m venv ./venv
	./venv/bin/$(PYTHON_BIN) -m pip install --upgrade --no-cache-dir pip
	./venv/bin/$(PYTHON_BIN) -m pip install --upgrade --no-cache-dir volare


###########################################################################
pdk-with-sram: pdk
.PHONY: pdk
pdk: check-env skywater-pdk open-pdks sky130 gen-sources

.PHONY: clean-pdk
clean-pdk:
	rm -rf $(PDK_ROOT)

.PHONY: skywater-pdk
skywater-pdk:
	if [ -d "$(PDK_ROOT)/skywater-pdk" ]; then\
		echo "Deleting existing $(PDK_ROOT)/skywater-pdk" && \
		rm -rf $(PDK_ROOT)/skywater-pdk && sleep 2;\
	fi
	git clone https://github.com/google/skywater-pdk.git $(PDK_ROOT)/skywater-pdk
	cd $(PDK_ROOT)/skywater-pdk && \
		git checkout main && git pull && \
		git checkout -qf $(SKYWATER_COMMIT) && \
		git submodule update --init libraries/$(STD_CELL_LIBRARY)/latest && \
		git submodule update --init libraries/$(IO_LIBRARY)/latest && \
		git submodule update --init libraries/$(SPECIAL_VOLTAGE_LIBRARY)/latest && \
		git submodule update --init libraries/$(PRIMITIVES_LIBRARY)/latest && \
		$(MAKE) timing

### OPEN_PDKS
.PHONY: open-pdks
open-pdks:
	if [ -d "$(PDK_ROOT)/open_pdks" ]; then \
		echo "Deleting existing $(PDK_ROOT)/open_pdks" && \
		rm -rf $(PDK_ROOT)/open_pdks && sleep 2; \
	fi
	git clone git://opencircuitdesign.com/open_pdks $(PDK_ROOT)/open_pdks
	cd $(PDK_ROOT)/open_pdks && \
		git checkout master && git pull && \
		git checkout -qf $(OPEN_PDKS_COMMIT)

.PHONY: sky130
sky130:
	if [ -d "$(PDK_ROOT)/$(PDK)" ]; then \
		echo "Deleting existing $(PDK_ROOT)/$(PDK)" && \
		rm -rf $(PDK_ROOT)/$(PDK) && sleep 2;\
	fi
	docker run --rm\
		-v $(PDK_ROOT):$(PDK_ROOT)\
		-u $(shell id -u $(USER)):$(shell id -g $(USER)) \
		-e PDK_ROOT=$(PDK_ROOT)\
		-e GIT_COMMITTER_NAME="caravel"\
		-e GIT_COMMITTER_EMAIL="caravel@caravel.caravel"\
		efabless/openlane-tools:magic-$(PDK_MAGIC_COMMIT)-centos-7\
		sh -c "\
			cd $(PDK_ROOT)/open_pdks && \
			./configure --enable-sky130-pdk=$(PDK_ROOT)/skywater-pdk --enable-sram-sky130 && \
			make && \
			make SHARED_PDKS_PATH=$(PDK_ROOT) install && \
			make clean \
		"
.PHONY: gen-sources
gen-sources:
	touch $(PDK_ROOT)/$(PDK)/SOURCES
	printf "skywater-pdk " >> $(PDK_ROOT)/$(PDK)/SOURCES
	cd $(PDK_ROOT)/skywater-pdk && git rev-parse HEAD >> $(PDK_ROOT)/$(PDK)/SOURCES
	printf "open_pdks " >> $(PDK_ROOT)/$(PDK)/SOURCES
	cd $(PDK_ROOT)/open_pdks && git rev-parse HEAD >> $(PDK_ROOT)/$(PDK)/SOURCES
	printf "magic $(PDK_MAGIC_COMMIT)" >> $(PDK_ROOT)/$(PDK)/SOURCES

.RECIPE: manifest
manifest: mag/ maglef/ verilog/rtl/ Makefile
	touch manifest && \
	find verilog/rtl/* -type f ! -name "caravel_netlists.v" ! -name "user_*.v" ! -name "README" ! -name "defines.v" -exec shasum {} \; > manifest && \
	shasum scripts/set_user_id.py scripts/generate_fill.py scripts/compositor.py >> manifest
# shasum lef/user_project_wrapper_empty.lef >> manifest
# find maglef/*.mag -type f ! -name "user_project_wrapper.mag" -exec shasum {} \; >> manifest && \
# shasum mag/caravel.mag mag/.magicrc >> manifest

.RECIPE: master_manifest
master_manifest:
	find verilog/rtl/* -type f -exec shasum {} \; > master_manifest && \
	find verilog/gl/* -type f -exec shasum {} \; >> master_manifest && \
	shasum scripts/set_user_id.py scripts/generate_fill.py scripts/compositor.py >> master_manifest && \
	find lef/*.lef -type f -exec shasum {} \; >> master_manifest && \
	find def/*.def -type f -exec shasum {} \; >> master_manifest && \
	find mag/*.mag -type f  -exec shasum {} \; >> master_manifest && \
	find maglef/*.mag -type f -exec shasum {} \; >> master_manifest && \
	find spi/lvs/*.spice -type f -exec shasum {} \; >> master_manifest && \
	find gds/*.gds -type f -exec shasum {} \; >> master_manifest 
	
.PHONY: check-env
check-env:
ifndef PDK_ROOT
	$(error PDK_ROOT is undefined, please export it before running make)
endif

check-uid:
ifndef USER_ID
	$(error USER_ID is undefined, please export it before running make set_user_id)
else 
	@echo USER_ID is set to $(USER_ID)
endif

check-project:
ifndef PROJECT
	$(error PROJECT is undefined, please export it before running make generate_fill or make final)
else
	@echo PROJECT is set to $(PROJECT)
endif

check-mcw:
	@if [ ! -d "$(MCW_ROOT)" ]; then \
		echo "MCW Root: "$(MCW_ROOT)" doesn't exists, please export the correct path before running make. "; \
		exit 1; \
	fi

# Make README.rst
README.rst: README.src.rst docs/source/getting-started.rst docs/source/tool-versioning.rst openlane/README.src.rst docs/source/caravel-with-openlane.rst Makefile
	pip -q install rst_include && \
	rm -f README.rst && \
		rst_include include README.src.rst - | \
			sed \
				-e's@\.\/\_static@\/docs\/source\/\_static@g' \
				-e's@:doc:`tool-versioning`@`tool-versioning.rst <./docs/source/tool-versioning.rst>`__@g' \
				-e's@.. note::@**NOTE:**@g' \
				-e's@.. warning::@**WARNING:**@g' \
				> README.rst && \
		rst_include include openlane/README.src.rst - | \
			sed \
				-e's@https://github.com/efabless/caravel/blob/master/verilog@../verilog@g' \
				-e's@:ref:`getting-started`@`README.rst <../README.rst>`__@g' \
				-e's@https://github.com/efabless/caravel/blob/master/openlane/@./@g' \
				-e's@.. note::@**NOTE:**@g' \
				-e's@.. warning::@**WARNING:**@g' \
				> openlane/README.rst

.PHONY: clean-openlane
clean-openlane:
	rm -rf $(OPENLANE_ROOT)

