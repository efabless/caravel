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

BLOCKS = $(shell find * -maxdepth 0 -type d)
CONFIG = $(foreach block,$(BLOCKS), ./$(block)/config.tcl)
CLEAN = $(foreach block,$(BLOCKS), clean-$(block))

# OpenLane Image
OPENLANE_TAG ?= 2021.11.23_01.42.34
export OPENLANE_IMAGE_NAME ?= efabless/openlane:$(OPENLANE_TAG)

# OpenLane Root
export OPENLANE_ROOT ?=

# PDK Root
export PDK_ROOT ?=

# Caravel Root
export CARAVEL_ROOT ?= $(shell pwd)

# Management Area Root
export MGMT_AREA_ROOT ?= $(shell pwd)/mgmt_core_wrapper 

# Parent Folder
export PARENT_FOLDER = $(shell realpath $(PWD)/..)

# PDK setup configs
export THREADS ?= $(shell nproc)
export STD_CELL_LIBRARY ?= sky130_fd_sc_hd
export SPECIAL_VOLTAGE_LIBRARY ?= sky130_fd_sc_hvl
export IO_LIBRARY ?= sky130_fd_io
export PRIMITIVES_LIBRARY ?= sky130_fd_pr
export SKYWATER_COMMIT ?= c094b6e83a4f9298e47f696ec5a7fd53535ec5eb
export OPEN_PDKS_COMMIT ?= 27ecf1c16911f7dd4428ffab96f62c1fb876ea70
export INSTALL_SRAM ?= enabled

all: $(BLOCKS)

$(CONFIG) :
	@echo "Missing $@. Please create a configuration for that design"
	@exit 1

$(BLOCKS) : % : ./%/config.tcl FORCE
	@echo "###############################################"
	@sleep 1

	@./run $*

	mkdir -p ../signoff/$*/
	cp $*/runs/$*/OPENLANE_VERSION ../signoff/$*/
	cp $*/runs/$*/PDK_SOURCES ../signoff/$*/
	cp $*/runs/$*/reports/final_summary_report.csv ../signoff/$*/

.PHONY: openlane
openlane:
ifeq ($(OPENLANE_ROOT),)
	@echo "OPENLANE_ROOT not set."
	@exit 1
endif
	rm -rf "$(OPENLANE_ROOT)" &&\
		git clone https://github.com/The-OpenROAD-Project/OpenLane \
			--branch=$(OPENLANE_TAG) \
			--depth=1 $(OPENLANE_ROOT) && \
		cd $(OPENLANE_ROOT) && \
		export IMAGE_NAME=efabless/openlane:$(OPENLANE_TAG) && \
		$(MAKE) pull-openlane

###########################################################################
.PHONY: pdk
pdk:
ifeq ($(OPENLANE_ROOT),)
	@echo "OPENLANE_ROOT not set."
	@exit 1
endif
	cd $(OPENLANE_ROOT) && $(MAKE) pdk

FORCE:

clean:
	@echo "Use clean_all to clean everything."

clean_all: $(CLEAN)

$(CLEAN): clean-% :
	rm -rf runs/$*
	rm -rf ../gds/$**
	rm -rf ../mag/$**
	rm -rf ../lef/$**
