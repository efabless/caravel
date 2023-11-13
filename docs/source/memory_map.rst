.. raw:: html

   <!---
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
   -->

=========================================
Caravel memory map vs. SPI register map
=========================================

================ =========================== ============================== =======================
SPI register     description                 signal			                 memory map address
================ =========================== ============================== =======================
 00              SPI status (reserved)       (undefined)                    2610_0000
 01	             Manufacturer ID (high)      mfgr_id[11:8]                  2610_0006
 02	             Manufacturer ID (low)       mfgr_id[7:0]	                2610_0005
 03	             Product ID	                 prod_id[7:0]                   2610_0004
 04	             User project ID	         mask_rev[31:24]                2610_000b
 05	             User project ID	         mask_rev[23:16]                2610_000a
 06	             User project ID	         mask_rev[15:8]                 2610_0009
 07	             User project ID	         mask_rev[7:0]                  2610_0008
 08	             PLL enables	             pll_dco_ena, pll_ena           2610_000c
 09	             PLL bypass	                 pll_bypass		                2610_0010
 0a	             IRQ		                 irq			                2610_0014
 0b              Reset		                 reset			                2610_0018
 0c	             CPU trap state	             trap                           2610_0028
 0d	             PLL trim                    pll_trim[31:24]	            2610_001f
 0e	             PLL trim                    pll_trim[23:16]	            2610_001e
 0f	             PLL trim                    pll_trim[15:8]		            2610_001d
 10	             PLL trim                    pll_trim[7:0]		            2610_001c
 11              PLL source                  pll90_sel[2:0], pll_sel[2:0]   2610_0020
 12	             PLL divider                 pll_div[4:0]		            2610_0024
 13              GPIO control                serial_resetn/clock/data       2600_0000
 14	             SRAM read-only control      hkspi_sram_clk/csb	            2610_0034
 15	             SRAM read-only address      hkspi_sram_addr		        2610_0030
 16	             SRAM read-only data         hkspi_sram_data[31:24]	        2610_002f
 17	             SRAM read-only data         hkspi_sram_data[23:16]	        2610_002e	 
 18	             SRAM read-only data         hkspi_sram_data[15:8]	        2610_002d 
 19	             SRAM read-only data         hkspi_sram_data[7:0]	        2610_002c
 1a	             Power monitor	             usr1/2_vcc/vdd_pwrgood	        2620_0000
 1b	             Output redirect	         clk1/clk2/trap_output_dest     2620_0004
 1c	             Input redirect	             irq_8/7_inputsrc		        2620_000c
 1d              GPIO[0] configure           gpio_configure[0][12:8]        2600_0025
 1e              GPIO[0] configure           gpio_configure[0][7:0]	        2600_0024
 1f              GPIO[1] configure           gpio_configure[1][12:8]        2600_0029
 20              GPIO[1] configure           gpio_configure[1][7:0]         2600_0028
 21              GPIO[2] configure           gpio_configure[2][12:8]        2600_002d
 22              GPIO[2] configure           gpio_configure[2][7:0]         2600_002c
 23              GPIO[3] configure           gpio_configure[3][12:8]        2600_0031
 24              GPIO[3] configure           gpio_configure[3][7:0]         2600_0030
 25              GPIO[4] configure           gpio_configure[4][12:8]        2600_0035
 26              GPIO[4] configure           gpio_configure[4][7:0]         2600_0034
 27              GPIO[5] configure           gpio_configure[5][12:8]        2600_0039
 28              GPIO[5] configure           gpio_configure[5][7:0]         2600_0038
 29              GPIO[6] configure           gpio_configure[6][12:8]        2600_003d
 2a              GPIO[6] configure           gpio_configure[6][7:0]         2600_003c
 2b              GPIO[7] configure           gpio_configure[7][12:8]        2600_0041
 2c              GPIO[7] configure           gpio_configure[7][7:0]         2600_0040
 2d              GPIO[8] configure           gpio_configure[8][12:8]        2600_0045
 2e              GPIO[8] configure           gpio_configure[8][7:0]         2600_0044
 2f              GPIO[9] configure           gpio_configure[9][12:8]        2600_0049
 30              GPIO[9] configure           gpio_configure[9][7:0]         2600_0048
 31              GPIO[10] configure          gpio_configure[10][12:8]       2600_004d
 32              GPIO[10] configure          gpio_configure[10][7:0]        2600_004c
 33              GPIO[11] configure          gpio_configure[11][12:8]       2600_0051
 34              GPIO[11] configure          gpio_configure[11][7:0]        2600_0050
 35              GPIO[12] configure          gpio_configure[12][12:8]       2600_0055
 36              GPIO[12] configure          gpio_configure[12][7:0]        2600_0054
 37              GPIO[13] configure          gpio_configure[13][12:8]       2600_0059
 38              GPIO[13] configure          gpio_configure[13][7:0]        2600_0058
 39              GPIO[14] configure          gpio_configure[14][12:8]       2600_005d
 3a              GPIO[14] configure          gpio_configure[14][7:0]        2600_005c
 3b              GPIO[15] configure          gpio_configure[15][12:8]       2600_0061
 3c              GPIO[15] configure          gpio_configure[15][7:0]        2600_0060
 3d              GPIO[16] configure          gpio_configure[16][12:8]       2600_0065
 3e              GPIO[16] configure          gpio_configure[16][7:0]        2600_0064
 3f              GPIO[17] configure          gpio_configure[17][12:8]       2600_0069
 40              GPIO[17] configure          gpio_configure[17][7:0]        2600_0068
 41              GPIO[18] configure          gpio_configure[18][12:8]       2600_006d
 42              GPIO[18] configure          gpio_configure[18][7:0]        2600_006c
 43              GPIO[19] configure          gpio_configure[19][12:8]       2600_0071
 44              GPIO[19] configure          gpio_configure[19][7:0]        2600_0070
 45              GPIO[20] configure          gpio_configure[20][12:8]       2600_0075
 46              GPIO[20] configure          gpio_configure[20][7:0]        2600_0074
 47              GPIO[21] configure          gpio_configure[21][12:8]       2600_0079
 48              GPIO[21] configure          gpio_configure[21][7:0]        2600_0078
 49              GPIO[22] configure          gpio_configure[22][12:8]       2600_007d
 4a              GPIO[22] configure          gpio_configure[22][7:0]        2600_007c
 4b              GPIO[23] configure          gpio_configure[23][12:8]       2600_0081
 4c              GPIO[23] configure          gpio_configure[23][7:0]        2600_0080
 4d              GPIO[24] configure          gpio_configure[24][12:8]       2600_0085
 4e              GPIO[24] configure          gpio_configure[24][7:0]        2600_0084
 4f              GPIO[25] configure          gpio_configure[25][12:8]       2600_0089
 50              GPIO[25] configure          gpio_configure[25][7:0]        2600_0088
 51              GPIO[26] configure          gpio_configure[26][12:8]       2600_008d
 52              GPIO[26] configure          gpio_configure[26][7:0]        2600_008c
 53              GPIO[27] configure          gpio_configure[27][12:8]       2600_0091
 54              GPIO[27] configure          gpio_configure[27][7:0]        2600_0090
 55              GPIO[28] configure          gpio_configure[28][12:8]       2600_0095
 56              GPIO[28] configure          gpio_configure[28][7:0]        2600_0094
 57              GPIO[29] configure          gpio_configure[29][12:8]       2600_0099
 58              GPIO[29] configure          gpio_configure[29][7:0]        2600_0098
 59              GPIO[30] configure          gpio_configure[30][12:8]       2600_009d
 5a              GPIO[30] configure          gpio_configure[30][7:0]        2600_009c
 5b              GPIO[31] configure          gpio_configure[31][12:8]       2600_00a1
 5c              GPIO[31] configure          gpio_configure[31][7:0]        2600_00a0
 5d              GPIO[32] configure          gpio_configure[32][12:8]       2600_00a5
 5e              GPIO[32] configure          gpio_configure[32][7:0]        2600_00a4
 5f              GPIO[33] configure          gpio_configure[33][12:8]       2600_00a9
 60              GPIO[33] configure          gpio_configure[33][7:0]        2600_00a8
 61              GPIO[34] configure          gpio_configure[34][12:8]       2600_00ad
 62              GPIO[34] configure          gpio_configure[34][7:0]        2600_00ac
 63              GPIO[35] configure          gpio_configure[35][12:8]       2600_00b1
 64              GPIO[35] configure          gpio_configure[35][7:0]        2600_00b0
 65              GPIO[36] configure          gpio_configure[36][12:8]       2600_00b5
 66              GPIO[36] configure          gpio_configure[36][7:0]        2600_00b4
 67              GPIO[37] configure          gpio_configure[37][12:8]       2600_00b9
 68              GPIO[37] configure          gpio_configure[37][7:0]        2600_00b8
 69              GPIO data	                 mgmt_gpio_in[37:32]	        2600_0010
 6a              GPIO data	                 mgmt_gpio_in[31:24]	        2600_000f
 6b              GPIO data	                 mgmt_gpio_in[23:16]	        2600_000e
 6c              GPIO data	                 mgmt_gpio_in[15:8]	            2600_000d
 6d              GPIO data	                 mgmt_gpio_in[7:0]	            2600_000c
 6e	             Power control	             pwr_ctrl_out[3:0]	            2600_0004
 6f	             HK SPI disable	             hkspi_disable		            2620_0010
================ =========================== ============================== =======================

