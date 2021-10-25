// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`ifndef __USER_DEFINE_H
// User GPIO initial configuration parameters
`define __USER_DEFINE_H

// The power-on configuration for GPIO 0 to 4 is fixed and cannot be
// modified (allowing the SPI and debug to always be accessible unless
// overridden by a flash program).
`define USER_CONFIG_GPIO_5_INIT 13'h0403
`define USER_CONFIG_GPIO_6_INIT 13'h0403
`define USER_CONFIG_GPIO_7_INIT 13'h0403
`define USER_CONFIG_GPIO_8_INIT 13'h0403
`define USER_CONFIG_GPIO_9_INIT 13'h0403
`define USER_CONFIG_GPIO_10_INIT 13'h0403
`define USER_CONFIG_GPIO_11_INIT 13'h0403
`define USER_CONFIG_GPIO_12_INIT 13'h0403
`define USER_CONFIG_GPIO_13_INIT 13'h0403
`define USER_CONFIG_GPIO_14_INIT 13'h0403

// Configurations of GPIO 15 to 25 are used on caravel but not caravan.
`define USER_CONFIG_GPIO_15_INIT 13'h0403
`define USER_CONFIG_GPIO_16_INIT 13'h0403
`define USER_CONFIG_GPIO_17_INIT 13'h0403
`define USER_CONFIG_GPIO_18_INIT 13'h0403
`define USER_CONFIG_GPIO_19_INIT 13'h0403
`define USER_CONFIG_GPIO_20_INIT 13'h0403
`define USER_CONFIG_GPIO_21_INIT 13'h0403
`define USER_CONFIG_GPIO_22_INIT 13'h0403
`define USER_CONFIG_GPIO_23_INIT 13'h0403
`define USER_CONFIG_GPIO_24_INIT 13'h0403
`define USER_CONFIG_GPIO_25_INIT 13'h0403

`define USER_CONFIG_GPIO_26_INIT 13'h0403
`define USER_CONFIG_GPIO_27_INIT 13'h0403
`define USER_CONFIG_GPIO_28_INIT 13'h0403
`define USER_CONFIG_GPIO_29_INIT 13'h0403
`define USER_CONFIG_GPIO_30_INIT 13'h0403
`define USER_CONFIG_GPIO_31_INIT 13'h0403
`define USER_CONFIG_GPIO_32_INIT 13'h0403
`define USER_CONFIG_GPIO_33_INIT 13'h0403
`define USER_CONFIG_GPIO_34_INIT 13'h0403
`define USER_CONFIG_GPIO_35_INIT 13'h0403
`define USER_CONFIG_GPIO_36_INIT 13'h0403
`define USER_CONFIG_GPIO_37_INIT 13'h0403

`endif // __USER_DEFINE_H
