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

# THE FOLLOWING SECTIONS CAN BE CHANGED IF NEEDED

# PDN Horizontal Pitch as mutliples of 30. Horizontal Pitch = 60 + FP_PDN_HPITCH_MULT * 30. 
# FP_PDN_HPITCH_MULT is an integer. Minimum value is 0.
set ::env(FP_PDN_HPITCH_MULT) 1

##
# PDN Vertical Pitch. Can be changed to any value.
set ::env(FP_PDN_VPITCH) 90

##
# PDN vertical Offset. Can be changed to any value.
set ::env(FP_PDN_VOFFSET) 5