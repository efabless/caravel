#!/bin/sh
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
# SPDX-License-Identifier: Apache-2.0



gunzip *.gz
mv sram_1rw1r_32_256_8_sky130_lp1.gds sram_1rw1r_32_256_8_sky130.gds

o-gds2mag-mag.sh simple_por.gds 
o-gds2mag-mag.sh gpio_control_block.gds
o-gds2mag-mag.sh digital_pll.gds
o-gds2mag-mag.sh storage.gds
o-gds2mag-mag.sh mgmt_core.gds
o-gds2mag-mag.sh chip_io.gds
o-gds2mag-mag.sh sram_1rw1r_32_256_8_sky130.gds

mv -f *.mag ../mag

gzip -9 storage.gds mgmt_core.gds chip_io.gds


