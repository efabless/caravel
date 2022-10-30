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
puts "inserting buffer on serial_clock_out"
set serial_clock_out_instance [get_property [get_cells -of_objects serial_clock_out] name]
insert_buffer ${serial_clock_out_instance}/X ITerm sky130_fd_sc_hd__clkbuf_16 serial_clock_out_buffered serial_clock_out_buffer

puts "inserting buffer on serial_load_out"
set serial_load_out_instance [get_property [get_cells -of_objects serial_load_out] name]
insert_buffer ${serial_load_out_instance}/X ITerm sky130_fd_sc_hd__clkbuf_16 serial_load_out_buffered serial_load_out_buffer

#    .HI(one),
#    .LO(zero));
puts "inserting buffer on one"
set const_instance [get_property [get_cells -of_objects one] name]
insert_buffer ${const_instance}/HI ITerm sky130_fd_sc_hd__buf_16 one_buffered one_buffer

puts "inserting buffer on zero"
set const_instance [get_property [get_cells -of_objects zero] name]
insert_buffer ${const_instance}/LO ITerm sky130_fd_sc_hd__buf_16 zero_buffered zero_buffer

write
