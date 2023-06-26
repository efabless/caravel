/*
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
*/

INCLUDE ../generated/regions.ld

SECTIONS {
	/* The program code and other data goes into FLASH */
	.text :
	{
		. = ALIGN(4);
		*(.text)	/* .text sections (code) */
		*(.text*)	/* .text* sections (code) */
		*(.rodata)	/* .rodata sections (constants, strings, etc.) */
		*(.rodata*)	/* .rodata* sections (constants, strings, etc.) */
		*(.srodata)	/* .srodata sections (constants, strings, etc.) */
		*(.srodata*)	/* .srodata*sections (constants, strings, etc.) */
		. = ALIGN(4);
		_etext = .;		/* define a global symbol at end of code */
		_sidata = _etext;	/* This is used by the startup to initialize data */
	} >flash

	/* Initialized data section */
	.data : AT ( _sidata )
	{
		. = ALIGN(4);
		_sdata = .;
		_ram_start = .;
		. = ALIGN(4);
		*(.data)
		*(.data*)
		*(.sdata)
		*(.sdata*)
		. = ALIGN(4);
		_edata = .;
	} >sram

	/* Uninitialized data section */
	.bss :
	{
		. = ALIGN(4);
		_sbss = .;
		*(.bss)
		*(.bss*)
		*(.sbss)
		*(.sbss*)
		*(COMMON)

		. = ALIGN(4);
		_ebss = .;
	} >sram

	/* Define the start of the heap */
	.heap :
	{
		. = ALIGN(4);
		_heap_start = .;
	} >sram
}

PROVIDE(_fstack = ORIGIN(sram) + LENGTH(sram));
