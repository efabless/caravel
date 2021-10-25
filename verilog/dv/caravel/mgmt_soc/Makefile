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

# ---- Test patterns for project striVe ----

.SUFFIXES:
.SILENT: clean all

PATTERNS = gpio_mgmt gpio mem uart perf hkspi sysctrl mprj_ctrl mprj_bitbang pass_thru timer timer2 pll storage qspi caravan irq user_pass_thru spi_master

all:  ${PATTERNS}
	for i in ${PATTERNS}; do \
		( cd $$i && SIM=RTL make -f Makefile $${i}.vcd &> verify.log && grep Monitor verify.log) ; \
		( cd $$i && SIM=GL make -f Makefile $${i}.vcd &> verify.log && grep Monitor verify.log) ; \
	done

clean:  ${PATTERNS}
	for i in ${PATTERNS}; do \
		( cd $$i && make clean ) ; \
	done

.PHONY: clean all
