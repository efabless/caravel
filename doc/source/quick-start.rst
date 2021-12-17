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

User project quick start guide
==============================

This section describes how to get going with the `efabless/caravel repository <https://github.com/efabless/caravel>`_ by adding a user project to the harness and merging the ``.gds`` files to create your own ``caravel.gds``.

Building the example user project
---------------------------------

Building the example user project works without any configuration needed. Just cd into ``openlane`` and run ``make`` on the wanted targets:

.. code-block:: bash

   cd openlane
   make user_proj_example
   make user_project_wrapper

Prerequisites
-------------

* OpenLANE
* Caravel

If you have followed the Getting Started Guide you should have all of these installed. To proceed make sure, that your environment variables are set correctly:

.. code-block:: bash

   export PDK_ROOT=/path/to/pdk
   export OPENLANE_ROOT=/path/to/openlane

Adding a user project
---------------------

For a more detailed documentation on using openlane with caravel check this documentation :ref:`carave-with-openlane`.

Requirements
^^^^^^^^^^^^

In the current version of Caravel the top level module of your design needs to be compatible with the interface required by `user_project_wrapper <https://github.com/efabless/caravel/blob/master/verilog/rtl/user_project_wrapper.v>`_. Make sure that your design uses the same ports as ``user_proj_example``.


Adding a new design
^^^^^^^^^^^^^^^^^^^

To add a user project, there are multiple possible ways:

* Creating a new design in ``openlane``
* Modifying ``user_proj_example`` to incorporate your design
* Replacing ``user_project_wrapper`` with your design

In this guide we will focus on the first option, creating a new design. A design in Caravel/OpenLANE has the following structure:

.. code-block:: bash

   openlane/design_name
   ├── config.tcl
   └── pinout.cfg

The configuration file ``config.tcl`` contains configuration options and parameters, as well as the path to the source files, which are not located inside the design folder, but rather at the top level of the repository in ``verilog/rtl``. The ``pinout.cfg`` contains the pin configuration, which you should copy from ``user_proj_example`` without modifying it.

To create your own design go into ``openlane`` and create a new directory named like your design with the appropriate config file and copy ``pinout.cfg`` from ``user_proj_example``. The name of the directory  should be the same as the top level module of your design. You can also copy the config file from ``user_proj_example``, as it provides a good starting point for your own configuration.

.. code-block:: bash

   cd openlane
   mkdir user_proj
   cp user_proj_example/config.tcl user_proj/

Configuration
^^^^^^^^^^^^^

Configuration options and their parameters can be found in the `OpenLANE repository <https://github.com/efabless/openlane/tree/master/configuration>`_.

It is recommended to create a new subdirectory for your source files under ``verilog/rtl`` if you have more than one source file and place them there. Alternatively you can just place them in ``verilog/rtl``. After adding your source files you have to provide the path to them in your ``config.tcl``:

.. code-block:: tcl

   set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_proj/top_level.v \
	$script_dir/../../verilog/rtl/user_proj/ctrl.v \
	$script_dir/../../verilog/rtl/user_proj/io.v"

There are three more configuration options you have to adjust:

* ``DESIGN_NAME``: This has to be equal to the name of your top level module and therefore your design directory.
* ``CLOCK_PORT``: The clock port. If your design does not have one you can use ``wb_clk_i``
* ``CLOCK_NET``: The clock net. This does not have to be set manually. To unset it just delete the line.

Building your design
--------------------

To build your design go into ``openlane`` and run make with your design name as a target:

.. code-block:: bash

   cd openlane
   make user_proj

This will run your design throught the OpenLANE workflow and if successfull produce a ``.gds`` file of your project. The subdirectory ``runs/user_proj`` will be created in your designs folder, which contains the results of the run. The following result files in ``runs/user_proj/`` are important:

* ``user_proj/runs/user_proj/reports/final_summary_report.csv``: Contains the results of the run including violations
* ``user_proj/runs/user_proj/results/magic/user_proj.lef``
* ``user_proj/runs/user_proj/results/magic/user_proj.gds``

The ``.gds`` and ``.lef`` files can also be found in the ``gds`` and ``lef`` directories on the top level of the repository.

Adding your design to the wrapper
---------------------------------

After building your design you can add it to ``user_project_wrapper``, which takes the ``.gds`` and ``.lef`` files you produced by building your design. To achieve this, we need to adjust a few configuration options in ``user_project_wrapper/config.tcl``:

.. code-block:: tcl

   set ::env(VERILOG_FILES_BLACKBOX) "\
       $script_dir/../../verilog/rtl/defines.v \
       $script_dir/../../verilog/rtl/user_proj/top_level.v"

   set ::env(EXTRA_LEFS) "\
       $script_dir/../../lef/user_proj.lef"

   set ::env(EXTRA_GDS_FILES) "\
       $script_dir/../../gds/user_proj.gds"

In many cases it will be sufficient, to just replace ``user_proj_example`` with the name of your user project. For ``VERILOG_FILES_BLACKBOX`` you need to provide the path to the source file of your top level module.

Placement macro
^^^^^^^^^^^^^^^

If your design is different in size to the example you should adjust the position, where your module will be placed inside the wrapper. This can be done in ``user_project_wrapper/macro.cfg``:

.. code-block:: tcl

   mprj 850 1100 N

In this case 850/1100 specify the X/Y position of the macro. The size of the wrapper can be found in ``user_project_wrapper/config.tcl``, with that and the size of your design you can figure out, where you need to place your design.

Building the wrapper
^^^^^^^^^^^^^^^^^^^^

After modifying the configuration files of the wrapper you can build it to produce a wrapper, which contains your design:

.. code-block:: bash

   cd openlane
   make user_project_wrapper

Building Caravel
----------------

To build the whole Caravel system you just need to run make in the root of the repository:

.. code-block:: bash

   make

The resulting ``.gds`` file can be found in ``gds/caravel.gds``.

Troubleshooting
---------------

Common error messages/warnings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Pin mprj/xxx is outside die area
""""""""""""""""""""""""""""""""

Either your design is too big for the wrapper or you need to adjust the position of your design in the wrapper. See `Placement macro <#placement-macro>`_.

No clock nets have been found
"""""""""""""""""""""""""""""

``CLOCK_PORT`` in your config.tcl is not set propertly.

Design congestion too high
""""""""""""""""""""""""""

Reduce ``PL_TARGET_DENSITY`` and/or ``FP_CORE_UTIL`` and/or ``CELL_PAD``.
