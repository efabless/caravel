# SPDX-FileCopyrightText: 2020 Efabless Corporation
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

MAKEFLAGS+=--warn-undefined-variables

export OPENLANE_RUN_TAG ?= $(shell date '+%y_%m_%d_%H_%M')
OPENLANE_TAG ?= 2022.10.10
OPENLANE_IMAGE_NAME ?= efabless/openlane:$(OPENLANE_TAG)
IT_SCRIPT ?= ./interactive.tcl
designs = $(shell find * -maxdepth 0 -type d)
current_design = null

openlane_cmd = \
	"flow.tcl \
	-design $$(realpath ./$*) \
	-save_path $$(realpath ..) \
	-save \
	-tag $(OPENLANE_RUN_TAG) \
	-verbose 1 \
	-overwrite"
openlane_cmd_interactive = "flow.tcl -ignore_mismatches -it -file $$(realpath ./$*/$(IT_SCRIPT))"
openlane_cmd_regression = "cd /openlane && ./run_designs.py \
													 --regression $$(realpath ./$*/regression.config) \
													 --threads 6 \
													 $$(realpath ./$*)"

docker_mounts = \
	-v $(PDK_ROOT):/pdk \
	-v $(CARAVEL_ROOT):$(CARAVEL_ROOT) \
	-v $(HOME):$(HOME)

docker_env = \
	-e PDK_ROOT=/pdk \
	-e PDK=$(PDK) \
	-e MISMATCHES_OK=1 \
	-e CARAVEL_ROOT=$(CARAVEL_ROOT) \
	-e OPENLANE_RUN_TAG=$(OPENLANE_RUN_TAG) \
	-w $(PWD)

ifneq ($(OPENLANE_ROOT),)
$(info openlane $(OPENLANE_ROOT))
docker_mounts += -v $(OPENLANE_ROOT):/openlane
docker_mounts += -v $(OPENLANE_ROOT):/openLANE_flow
endif

ifneq ($(MCW_ROOT),)
docker_env += -e MCW_ROOT=$(MCW_ROOT)
docker_mounts += -v $(MCW_ROOT):$(MCW_ROOT)
endif

docker_startup_mode = $(shell test -t 0 && echo "-it" || echo "--rm" )
docker_run = \
	docker run $(docker_startup_mode) \
	$(docker_mounts) \
	$(docker_env) \
	-u $(shell id -u $(USER)):$(shell id -g $(USER))

list:
	@echo $(designs)

regression-designs=$(designs:%=%-regression)
.PHONY: $(regression-designs)
$(regression-designs): %-regression: ./%/regression.config
	$(docker_run) \
		$(OPENLANE_IMAGE_NAME) sh -c $(openlane_cmd_regression)


.PHONY: $(designs)
$(designs) : % : ./%/config.tcl
ifneq (,$(wildcard ./$(MAKECMDGOALS)/interactive.tcl)))
	$(docker_run) \
		$(OPENLANE_IMAGE_NAME) sh -c $(openlane_cmd_interactive)
	gzip -n9fk $(CARAVEL_ROOT)/gds/$*.gds
else
	# $(MAKECMDGOALS)
	mkdir -p ./$*/runs/$(OPENLANE_RUN_TAG) 
	$(docker_run) \
		$(OPENLANE_IMAGE_NAME) sh -c $(openlane_cmd)
	rm -rf ./$*/runs/$*
	ln -s $$(realpath ./$*/runs/$(OPENLANE_RUN_TAG)) ./$*/runs/$*
	mkdir -p $(CARAVEL_ROOT)/spef/$*
endif
	@mkdir -p ../signoff/$*/
	@{ [ -e ./$*/runs/$(OPENLANE_RUN_TAG)/OPENLANE_VERSION ] && cp ./$*/runs/$(OPENLANE_RUN_TAG)/OPENLANE_VERSION ../signoff/$*/; } || echo "OPENLANE_VERSION file not found"
	@cp ./$*/runs/$(OPENLANE_RUN_TAG)/PDK_SOURCES ../signoff/$*/
	@cp ./$*/runs/$(OPENLANE_RUN_TAG)/reports/*.csv ../signoff/$*/

	rm -rf $(CARAVEL_ROOT)/signoff/$*/openlane-signoff
	mkdir -p $(CARAVEL_ROOT)/signoff/$*/openlane-signoff
	mkdir -p $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/spef
	mkdir -p $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/sdf
	mv $(CARAVEL_ROOT)/spef/multicorner/$** $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/spef/ || true
	mv $(CARAVEL_ROOT)/sdf/multicorner/* $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/sdf || true
	mv $(CARAVEL_ROOT)/sdc/$*.sdc $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/ || true
	cp ./$*/runs/$(OPENLANE_RUN_TAG)/logs/signoff/* $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/ || true
	cp ./$*/runs/$(OPENLANE_RUN_TAG)/config.tcl $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/ || true
	cp ./$*/runs/$(OPENLANE_RUN_TAG)/reports/signoff/* $(CARAVEL_ROOT)/signoff/$*/openlane-signoff/ || true
	gzip -n9fk $(CARAVEL_ROOT)/gds/$*.gds

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
