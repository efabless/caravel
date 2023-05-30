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

================================
GPIO pin power-on configuration
================================

The Caravel design for MPW-two includes a new feature that allows the
designer of the user project area to specify how the GPIO pins will be
configured on power-up.

For MPW-one, all user-area GPIO pins (``mprj_io[0]`` to ``mprj_io[37]``) had a
fixed configuration on power-up with management access, and an input
function on ``mprj_io[37:6]``.  ``mprj_io[5:1]`` belong to the housekeeping SPI
and are configured for SPI use;  ``mprj_io[0]`` is for system debug but was
unused on MPW-one.  The purpose of this configuration is to keep the
chip from generating current on the outputs until after power-up.  It
is the responsibility of the management SoC flash program to configure
the GPIO pins for the function needed by the user project.

**There were two issues with this configuration:**  

1. The configuration of the GPIO is completely dependent on the management SoC
2. It is possible for a user project to be designed such that the user project attempts to start communicating with the outside world before the management SoC has configured the GPIO, and may end up in a stalled state before it can be configured.

To make the system more flexible, the new design allows the configuration
of the GPIOs on power-up to be custom configured.  The configuration is
described in file ``user_defines.v``.  A default set of definitions
corresponding to the original configuration of MPW-one is supplied with
the caravel repository in file ``verilog/rtl/user_defines.v``.

The file ``user_defines.v`` contains a set of verilog definitions in the form:

.. code:: bash
    
    define USER_CONFIG_GPIO_<n>_INIT  <value>

where ``<n>`` is the GPIO index;  e.g., ``USER_CONFIG_GPIO_5`` corresponds to pin ``mprj_io[5]``.  The default ``<value>`` is a 13-bit value that is the bit setting of the GPIO configuration.  
Because the raw bit value is an inconvenient form, a number of additional verilog definitions have been made at the top of the file.  
These definitions have the same names as those from the ``defs.h`` file included in management SoC C programs. 

**These are the values most likely to be of interest to the user project designer, and are as follows:**

    ``GPIO_MODE_MGMT_STD_INPUT_NOPULL    (13'h0403)``:
	    The management SoC has access to the GPIO pin.
	    The pin is an input (output disbled) and has no pull-up or pull-down.

    ``GPIO_MODE_MGMT_STD_INPUT_PULLDOWN  (13'h0803)``:
	    The management SoC has access to the GPIO pin.
	    The pin is an input (output disbled) and has a 5kOhm pull-down.

    ``GPIO_MODE_MGMT_STD_INPUT_PULLUP    (13'h0c03)``:
	    The management SoC has access to the GPIO pin.
	    The pin is an input (output disbled) and has a 5kOhm pull-up.

    ``GPIO_MODE_MGMT_STD_OUTPUT          (13'h1809)``:
	    The management SoC has access to the GPIO pin.
	    The pin is an output (input disbled).

    ``GPIO_MODE_MGMT_STD_BIDIRECTIONAL   (13'h1801)``:
	    The management SoC has access to the GPIO pin.
	    The pin is either an output or an input, depending on the state
	    of the output enable pin.  Only GPIO pins 0 (debug), 1 (housekeeping
	    SPI SDO), 35 (SPI master SDO), 36 (flash IO2), and 37 (flash IO3)
	    are able to be set as bidirectional, and the bidirectional function
	    is only used by the associated system function (debug, housekeeping
	    SPI, or SPI master).

    ``GPIO_MODE_MGMT_STD_ANALOG          (13'h000b)``:
	    The management SoC has access to the GPIO pin.
	    All digital buffers (input and output) are turned off.  There is
	    no effective difference between user or management control in this
	    case.  Only user projects may supply analog signals to the GPIO
	    pads.

    ``GPIO_MODE_USER_STD_INPUT_NOPULL    (13'h0402)``:
	    The user project has access to the GPIO pin.
	    The pin is an input (output disbled) and has no pull-up or pull-down.

    ``GPIO_MODE_USER_STD_INPUT_PULLDOWN  (13'h0802)``:
	    The user project has access to the GPIO pin.
	    The pin is an input (output disbled) and has a 5kOhm pull-down.

    ``GPIO_MODE_USER_STD_INPUT_PULLUP    (13'h0c02)``:
	    The user project has access to the GPIO pin.
	    The pin is an input (output disbled) and has a 5kOhm pull-up.

    ``GPIO_MODE_USER_STD_OUTPUT          (13'h1808)``:
	    The user project has access to the GPIO pin.
	    The pin is an output (input disbled).

    ``GPIO_MODE_USER_STD_BIDIRECTIONAL   (13'h1800)``:
	    The user project has access to the GPIO pin.
	    The pin is bidirectional.  Input is always enabled, and output
	    is enabled if the corresponding OEB (output-enable-bar) pin is
	    driven low by the user project.

    ``GPIO_MODE_USER_STD_OUT_MONITORED   (13'h1802)``:
	    The user project has access to the GPIO pin.
	    The pin is bidirectional (see bidirectional mode, above).
	    The value of the pin is copied to the management SoC for
	    purposes of signal monitoring (i.e., the pin simultaneously
	    acts as mode ``MGMT_STD_INPUT_NOPULL`` as seen from the
	    management SoC).

    ``GPIO_MODE_USER_STD_ANALOG	       (13'h000a)``:
	    The user project has access to the GPIO pin.
	    Both input and output buffers are disabled.  If the user
	    project connects an analog signal to this pad, it will
	    appear (unbuffered) on the pad.


GPIO indexes 0 to 5 are not represented in this file, because the Caravel
design requires that the debug function and the housekeeping SPI function
be accessible during initial power-on and while the management SoC is held
in reset.  This allows the housekeeping to access the full chip reset and
the pass-through programming modes, so that the demonstration board cannot
be accidentally "bricked" by writing a program that both prevents the
system from working and prevents the housekeeping SPI or debug functions
from being accessed.  If you want to have the user project run without setup
from the management SoC program, you will need to avoid using GPIO pins 0
to 5.  If you need to use pins 0 to 5, they will have to be configured by
the management SoC program.

The default setting for all GPIO pins is ``GPIO_MODE_MGMT_STD_INPUT_NOPULL``,
corresponding to a pad that is under the control of the management SoC
and is configured as an input, with the output buffer disabled.

To set different defaults, copy the file ``user_defines.v`` to the user
project space and place it in the verilog/rtl/ directory.  Then change
the definition for each of the GPIO pins to correspond to the GPIO
configuration that your project needs on startup.

The settings in ``user_defines.v`` are sufficient for verilog full-chip
simulation.  The actual changes to the layout are done at time of tape-in,
when the Caravel chip is assembled.  The contents of ``user_defines.v`` are
used to via-program the GPIO default block layout.  The final layout and
GDS will reflect this configuration definition.
