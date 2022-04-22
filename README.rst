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

Caravel Harness
===============

|License| |Documentation Status| |Build Status|

**NOTE:**

   Documentation for this project is being updated to reflect the changes
   for the new redesigned version of Caravel.

Table of contents
=================

-  `Overview <#overview>`__
-  `Caravel Architecture <#caravel-architecture>`__
-  `Quick Start for User Projects  <#quick-start-for-user-projects>`__

   - `Digital User Project <#digital-user-project>`__
   - `Analog User Project <#analog-user-project>`__

-  `Required Directory Structure <#required-directory-structure>`__
-  `Additional Material <#additional-material>`__

Overview
========

Caravel is a template SoC for Efabless Open MPW and chipIgnite shuttles based on the Sky130 node from SkyWater Technologies. The
current SoC architecture is given below.

.. image:: docs/source/_static/caravel_block_diagram.jpg
    :align: center

Datasheet and detailed documentation exist `here <https://caravel-harness.readthedocs.io/>`__

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
.. _getting-started:

Caravel Architecture
====================

Caravel is composed of the harness frame plus two wrappers for drop-in modules for the *management area* and *user project area*.

.. _harness-definition:

Harness Definition
------------------

The harness itself contains the clocking module, DLL, user ID,
housekeeping SPI, POR, and GPIO control.

GPIO handling moved out of management SoC and into SPI.  SPI
gets a wishbone interface;  the management SoC talks to the SPI
through wishbone, not by taking over the 4-pin SPI interface.

A new block like the ID has the mode at power-up for
each GPIO.  Can be configured with a text file.  SPI pins are
fixed for operation on startup.

On power-up, the SPI automatically configures the
GPIO.  Manual load is possible from both the SPI and from the
wishbone bus.

All functions within the harness but outside the management SoC
are incorporated into one large module called "housekeeping".
This includes a number of registers for all the included
functions, with a "front door" SPI interface connected to the
padframe through GPIO pins 1 to 4, and a "back door" wishbone
interface connected to the management SoC.  The management Soc
reserves the memory block at 0x26000000 for the
housekeeping module.  The housekeeping module exchanges data
with the management SoC via an interface that uses the byte-
wide SPI register data.  A small state machine reads four
contiguous wishbone addresses and an address decoder determines
the corresponding SPI register.  The state machine stalls the
SoC until all four bytes have been handled before returning the
acknowledge signal.

.. _management-area:

Management Area
--------------

The management area is a drop-in module implemented as a separate repo.
It typically includes a RISC-V based SoC that includes a number of peripherals like timers, uart, and gpio.
The management area runs firmware that can be used to:

-  Configure User Project I/O pads
-  Observe and control User Project signals (through on-chip logic
   analyzer probes)
-  Control the User Project power supply

The management area implements SRAM for the management SoC.

The default instantiation for the management core can be found `here <https://github.com/efabless/caravel_mgmt_soc_litex>`__ .
See documentation of the management core for further details.

.. _user-project-area:

User Project Area
--------------

This is the user space. It has a limited silicon area ``2.92mm x 3.52mm`` as well as a fixed number of I/O pads ``38`` and power pads ``4``.

The user space has access to the following utilities provided by the management SoC:

- ``38`` IO Ports
- ``128`` Logic analyzer probes
- Wishbone port connection to the management SoC wishbone bus.


Quick Start for User Projects
=============================

Your area is the full user space, so feel free to add your
project there or create a different macro and harden it separately then
insert it into the ``user_project_wrapper`` for digital projects or insert it
into ``user_project_analog_wrapper`` for analog projects.

.. _digital-user-project:

Digital User Project
--------------------

If you are building a digital project for the user space, check a sample project at  `caravel_user_project <https://github.com/efabless/caravel_user_project>`__.

If you will use OpenLANE to harden your design, go through the instructions in this `README <https://github.com/efabless/caravel/blob/master/openlane/README.rst>`__.

Digital user projects should adhere the following requirements:

- Top module is named ``user_project_wrapper``


- The ``user_project_wrapper`` adheres to the pin order defined at `Digital Wrapper Pin Order <https://github.com/efabless/caravel/blob/master/openlane/user_project_wrapper_empty/pin_order.cfg>`__.


- The ``user_project_wrapper`` adheres to the fixed design configurations at `Digital Wrapper Fixed Configuration <https://github.com/efabless/caravel/blob/master/openlane/user_project_wrapper_empty/fixed_wrapper_cfgs.tcl>`__.


- The user project repository adheres to the `Required Directory Structure <#required-directory-structure>`__.


.. _analog-user-project:

Analog User Project
------------------

If you are building an analog project for the user space, check a sample project at  `caravel_user_project_analog <https://github.com/efabless/caravel_user_project_analog>`__.

Analog user projects should adhere the following requirements:

- Top module is named ``user_analog_project_wrapper``

- The ``user_analog_project_wrapper`` uses the `empty analog wrapper <https://github.com/efabless/caravel/blob/master/mag/user_analog_project_wrapper_empty.mag>`__.

- The ``user_analog_project_wrapper`` adheres to the same pin order and placement of the `empty analog wrapper <https://github.com/efabless/caravel/blob/master/mag/user_analog_project_wrapper_empty.mag>`__.

------

IMPORTANT
^^^^^^^^^

Please make sure to run ``make compress`` before committing anything to
your repository. Avoid having 2 versions of the
``gds/user_project_wrapper.gds`` one compressed and the
other not compressed.

For information on tooling and versioning, please refer to `tool-versioning.rst <./docs/source/tool-versioning.rst>`__.

-----

Required Directory Structure
============================

-  ``gds/`` : includes all the gds files used or produced from the
   project.
-  ``def`` : includes all the def files used or produced from the
   project.
-  ``lef/`` : includes all the lef files used or produced from the
   project.
-  ``mag/`` : includes all the mag files used or produced from the
   project.
-  ``maglef`` : includes all the maglef files used or produced from the
   project.
-  ``spi/lvs/`` : includes all the spice files used or produced from the
   project.
-  ``verilog/dv`` : includes all the simulation test benches and how to
   run them.
-  ``verilog/gl/`` : includes all the synthesized/elaborated netlists.
-  ``verilog/rtl`` : includes all the Verilog RTLs and source files.
-  ``openlane/<macro>/`` : includes all configuration files used to
   run openlane on your project.
-  ``info.yaml``: includes all the info required in `this
   example <https://github.com/efabless/caravel/blob/master/info.yaml>`__. Please make sure that you are pointing to an
   elaborated caravel netlist as well as a synthesized
   gate-level-netlist for the `user_project_wrapper`


**NOTE:**

    If you're using openlane to harden your design, the ``verilog/gl`` ``def/`` ``lef/`` ``gds/`` ``mag`` ``maglef`` directories should
    be automatically populated by openlane.

.. _additional-material:

Additional Material
===============

.. _mpw-two:

MPW Two
--------

- `Open MPW Program - MPW-TWO Walkthrough <https://www.youtube.com/watch?v=jBrBqhVNgDo>`__
- `MPW Two Shuttle Program <https://efabless.com/open_shuttle_program/2>`__

.. _mpw-one:

MPW One
--------------

-  `Caravel Legacy Repo (previous version used for MPW-ONE) <https://github.com/efabless/caravel_mpw-one>`__
-  `Caravel User Project Features -- What are the utilities provided by caravel to the user project ? <https://youtu.be/zJhnmilXGPo>`__
-  `Aboard Caravel -- How to integrate your design with Caravel? <https://youtu.be/9QV8SDelURk>`__
-  `Things to Clarify About Caravel -- What versions to use with Caravel? <https://youtu.be/-LZ522mxXMw>`__
- `45 Chips in 30 Days: Open Source ASIC at its best! <https://www.youtube.com/watch?v=qlBzE27at6M>`__

Check `mpw-one-final <https://github.com/efabless/caravel/tree/mpw-one-final>`__ for the caravel used for the mpw-one tapeout.

> :warning: You don't need to integrate your design with Caravel GDS for **MPW two**. Running ``make ship`` is no longer required.


.. |License| image:: https://img.shields.io/github/license/efabless/caravel
   :alt: GitHub license - Apache 2.0
   :target: https://github.com/efabless/caravel
.. |Documentation Status| image:: https://readthedocs.org/projects/caravel-harness/badge/?version=latest
   :alt: ReadTheDocs Badge - https://caravel-harness.rtfd.io
   :target: https://caravel-harness.readthedocs.io/en/latest/?badge=latest
.. |Build Status| image:: https://travis-ci.com/efabless/caravel.svg?branch=master
   :alt: Travis Badge - https://travis-ci.org/efabless/caravel
   :target: https://travis-ci.com/efabless/caravel

.. |License| image:: https://img.shields.io/github/license/efabless/caravel
   :alt: GitHub license - Apache 2.0
   :target: https://github.com/efabless/caravel
.. |Documentation Status| image:: https://readthedocs.org/projects/caravel-harness/badge/?version=latest
   :alt: ReadTheDocs Badge - https://caravel-harness.rtfd.io
   :target: https://caravel-harness.readthedocs.io/en/latest/?badge=latest
.. |Build Status| image:: https://travis-ci.com/efabless/caravel.svg?branch=master
   :alt: Travis Badge - https://travis-ci.org/efabless/caravel
   :target: https://travis-ci.com/efabless/caravel

