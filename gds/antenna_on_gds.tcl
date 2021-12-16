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

gds read $::env(DESIGN_IN_ANTENNA).gds
select top cell
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
extract unique
# extract warn all
extract
feedback save ./tmp/$::env(DESIGN_IN_ANTENNA)_ext2spice.antenna.feedback.txt
antennacheck debug
antennacheck
