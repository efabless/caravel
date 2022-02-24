# SPDX-FileCopyrightText: 2020 Efabless Corporation
# # Licensed under the Apache License, Version 2.0 (the "License");
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

OPENLANE_TAG ?= 2021.11.23_01.42.34
OPENLANE_IMAGE_NAME ?= efabless/openlane:$(OPENLANE_TAG)
OPENLANE_BASIC_COMMAND = "cd $(PWD)/../openlane && flow.tcl -design ./$* -save_path .. -save -tag $* -overwrite"
OPENLANE_INTERACTIVE_COMMAND = "cd $(PWD)/../openlane && flow.tcl -it -file ./$*/interactive.tcl"

all: $(BLOCKS)

$(CONFIG) :
	@echo "Missing $@. Please create a configuration for that design"
	@exit 1

.PHONY: $(BLOCKS)
$(BLOCKS) : % : ./%/config.tcl
ifeq ($(OPENLANE_ROOT),)
	@echo "Please export OPENLANE_ROOT"
	@exit 1
endif
ifeq ($(PDK_ROOT),)
	@echo "Please export PDK_ROOT"
	@exit 1
endif
	@echo "###############################################"
	@sleep 1

	@if [ -f ./$*/interactive.tcl ]; then\
		docker run --rm -v $(OPENLANE_ROOT):/openlane \
		-v $(PDK_ROOT):$(PDK_ROOT) \
		-v $(PWD)/..:$(PWD)/.. \
		-v $(CARAVEL_ROOT):$(CARAVEL_ROOT) \
		-v $(MGMT_AREA_ROOT):$(MGMT_AREA_ROOT) \
		-e PDK_ROOT=$(PDK_ROOT) \
		-e CARAVEL_ROOT=$(CARAVEL_ROOT) \
		-u $(shell id -u $(USER)):$(shell id -g $(USER)) \
		$(OPENLANE_IMAGE_NAME) sh -c $(OPENLANE_INTERACTIVE_COMMAND);\
	else\
		docker run --rm -v $(OPENLANE_ROOT):/openlane \
		-v $(PDK_ROOT):$(PDK_ROOT) \
		-v $(PWD)/..:$(PWD)/.. \
		-v $(CARAVEL_ROOT):$(CARAVEL_ROOT) \
		-v $(MGMT_AREA_ROOT):$(MGMT_AREA_ROOT) \
		-e PDK_ROOT=$(PDK_ROOT) \
		-e CARAVEL_ROOT=$(CARAVEL_ROOT) \
		-u $(shell id -u $(USER)):$(shell id -g $(USER)) \
		$(OPENLANE_IMAGE_NAME) sh -c $(OPENLANE_BASIC_COMMAND);\
	fi
	mkdir -p ../signoff/$*/
	cp $*/runs/$*/OPENLANE_VERSION ../signoff/$*/
	cp $*/runs/$*/PDK_SOURCES ../signoff/$*/
	cp $*/runs/$*/reports/final_summary_report.csv ../signoff/$*/

.PHONY: openlane
openlane: check-openlane-env
	if [ -d "$(OPENLANE_ROOT)" ]; then\
		echo "Deleting exisiting $(OPENLANE_ROOT)" && \
		rm -rf $(OPENLANE_ROOT) && sleep 2; \
	fi
	git clone https://github.com/The-OpenROAD-Project/OpenLane --branch=$(OPENLANE_TAG) --depth=1 $(OPENLANE_ROOT) && \
		cd $(OPENLANE_ROOT) && \
		export OPENLANE_IMAGE_NAME=efabless/openlane:$(OPENLANE_TAG) && \
		export IMAGE_NAME=efabless/openlane:$(OPENLANE_TAG) && \
		$(MAKE) pull-openlane

.PHONY: check-openlane-env
check-openlane-env:
ifeq ($(OPENLANE_ROOT),)
	@echo "Please export OPENLANE_ROOT"
	@exit 1
endif

FORCE:

clean:
	@echo "Use clean_all to clean everything :)"

clean_all: $(CLEAN)

$(CLEAN): clean-% :
	rm -rf runs/$*
	rm -rf ../gds/$**
	rm -rf ../mag/$**
	rm -rf ../lef/$**
