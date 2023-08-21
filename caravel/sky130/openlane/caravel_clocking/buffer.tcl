# Copyright 2020 Efabless Corporation
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
source $::env(SCRIPTS_DIR)/openroad/common/io.tcl
read
source $::env(SCRIPTS_DIR)/openroad/insert_buffer.tcl
puts "inserting buffer on user_clk"
set user_clk_instance [get_property [get_cells -of_objects user_clk] name]
puts "insert_buffer ${user_clk_instance}/X ITerm sky130_fd_sc_hd__clkbuf_16 user_clk_buffered user_clk_out_buffer"
insert_buffer ${user_clk_instance}/X ITerm sky130_fd_sc_hd__clkbuf_16 user_clk_buffered user_clk_out_buffer

write
