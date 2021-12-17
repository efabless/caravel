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

Pinout description
==================

This section describes lists the pinout for the SoC, and provides the description for pins.

.. todo::

    Verify `flash_io[1:0]`, `flash_csb`, `flash2_io[1:0]`, `flash2_csb` pins.
    There was inconsistency (Pinout vs Pin description) in source PDF.

Ball assignment (6x10 WLCSP)
----------------------------

.. figure:: _static/package_as_viewed_from_the_bottom.svg
    :name: ball_assignment
    :width: 30%
    :align: center

    Ball assignment (6x10 WLCSP)

Pinout (6x10 WLCSP)
-------------------

.. list-table:: Pinout
    :name: pinout
    :header-rows: 1
    :stub-columns: 1

    * -
      - F
      - E
      - D
      - C
      - B
      - A
    * - 1
      - :ref:`mprj_io[15] <mprj_io>`
      - :ref:`mprj_io[16] <mprj_io>`
      - :ref:`mprj_io[18] <mprj_io>`
      - :ref:`mprj_io[19] <mprj_io>`
      - :ref:`mprj_io[21] <mprj_io>`
      - :ref:`mprj_io[23] <mprj_io>`
    * - 2
      - :ref:`vccd1 <vccd1>`
      - :ref:`mprj_io[14] <mprj_io>`
      - :ref:`mprj_io[17] <mprj_io>`
      - :ref:`mprj_io[20] <mprj_io>`
      - :ref:`mprj_io[22] <mprj_io>`
      - :ref:`vccd2 <vccd2>`
    * - 3
      - :ref:`mprj_io[12] <mprj_io>`
      - :ref:`mprj_io[11] <mprj_io>`

        :ref:`flash2_io[1] <flash2_io>`
      - :ref:`mprj_io[13] <mprj_io>`
      - :ref:`mprj_io[24] <mprj_io>`
      - :ref:`vssa2 <vssa2>`
      - :ref:`mprj_io[25] <mprj_io>`
    * - 4
      - :ref:`mprj_io[10] <mprj_io>`

        :ref:`flash2_io[0] <flash2_io>`
      - :ref:`mprj_io[9] <mprj_io>`

        :ref:`flash2_sck <flash2_sck>`
      - :ref:`vdda1 <vdda1>`
      - :ref:`vddio <vddio>`
      - :ref:`mprj_io[26] <mprj_io>`
      - :ref:`mprj_io[27] <mprj_io>`
    * - 5
      - :ref:`mprj_io[8] <mprj_io>`

        :ref:`flash2_csb <flash2_csb>`
      - :ref:`mprj_io[7] <mprj_io>`

        :ref:`irq <irq>`
      - :ref:`vssio <vssio_vssa_vssd>`

        :ref:`vssa <vssio_vssa_vssd>`

        :ref:`vssd <vssio_vssa_vssd>`
      - :ref:`vssio <vssio_vssa_vssd>`

        :ref:`vssa <vssio_vssa_vssd>`

        :ref:`vssd <vssio_vssa_vssd>`
      - :ref:`mprj_io[28] <mprj_io>`
      - :ref:`mprj_io[29] <mprj_io>`
    * - 6
      - :ref:`vssd1 <vssd1>`
      - :ref:`vssa1 <vssa1>`
      - :ref:`vssio <vssio_vssa_vssd>`

        :ref:`vssa <vssio_vssa_vssd>`

        :ref:`vssd <vssio_vssa_vssd>`
      - :ref:`vssio <vssio_vssa_vssd>`

        :ref:`vssa <vssio_vssa_vssd>`

        :ref:`vssd <vssio_vssa_vssd>`
      - :ref:`mprj_io[30] <mprj_io>`
      - :ref:`mprj_io[31] <mprj_io>`
    * - 7
      - :ref:`mprj_io[6] <mprj_io>`

        :ref:`ser_tx <ser_tx>`
      - :ref:`mprj_io[5] <mprj_io>`

        :ref:`ser_rx <ser_rx>`
      - :ref:`mprj_io[0] <mprj_io>`

        :ref:`JTAG <jtag>`
      - :ref:`vdda2 <vdda2>`
      - :ref:`vssd2 <vssd2>`
      - :ref:`mprj_io[32] <mprj_io>`
    * - 8
      - :ref:`mprj_io[4] <mprj_io>`

        :ref:`SCK <sck>`
      - :ref:`mprj_io[3] <mprj_io>`

        :ref:`CSB <csb>`
      - :ref:`flash_clk <flash_clk>`
      - :ref:`mprj_io[33] <mprj_io>`
      - :ref:`mprj_io[34] <mprj_io>`
      - :ref:`mprj_io[35] <mprj_io>`
    * - 9
      - :ref:`mprj_io[2] <mprj_io>`

        :ref:`SDI <sdi>`
      - :ref:`mprj_io[1] <mprj_io>`

        :ref:`SDO <sdo>`
      - :ref:`flash_io[1] <flash_io>`
      - :ref:`clock <clock>`
      - :ref:`mprj_io[36] <mprj_io>`
      - :ref:`mprj_io[37] <mprj_io>`
    * - 10
      - :ref:`vdda <vdda>`
      - :ref:`gpio <gpio>`
      - :ref:`flash_io[0] <flash_io>`
      - :ref:`flash_csb <flash_csb>`
      - :ref:`resetb <resetb>`
      - :ref:`vccd <vccd>`

Pin description (6x10 WLCSP)
----------------------------

.. list-table:: Pin description
    :name: pin-description
    :header-rows: 1

    * - Pin #
      - Name
      - Type
      - Summary description
    * - A9, B9, A8, B8, C8, A7, A6, B6, A5, B5, A4, B4, A3, C3, A1, B2, B1, C2, C1, D1, D2, E1, F1, E2, D3, F3, E3, F4, E4, F5, E5, F7, E7, F8, E8, F9, E9, D7
      - .. _mprj_io:

        ``mprj_io[37:0]``
      - Digital I/O
      - General purpose configurable digital I/O with pullup/pulldown, input or output, enable/disable, analog output, high voltage output, slew rate control.
        Shared between the user project area and the management SoC.
    * - D8
      - .. _flash_clk:

        ``flash_clk``
      - Digital out
      - Flash SPI clock
    * - C10
      - .. _flash_csb:

        ``flash_csb``
      - Digital out
      - Flash SPI chip select
    * - D9, D10
      - .. _flash_io:

        ``flash_io[1:0]``
      - Digital I/O
      - Flash SPI data input/output
    * - C9
      - .. _clock:

        ``clock``
      - Digital in
      - External CMOS 3.3V clock source
    * - B10
      - .. _resetb:

        ``resetb``
      - Digital in
      - SoC system reset (sense inverted)
    * - E9
      - .. _sdo:

        ``SDO``
      - Digital out
      - Housekeeping serial interface data output
    * - F9
      - .. _sdi:

        ``SDI``
      - Digital in
      - Housekeeping serial interface data input
    * - E8
      - .. _csb:

        ``CSB``
      - Digital in
      - Housekeeping serial interface chip select
    * - F8
      - .. _sck:

        ``SCK``
      - Digital in
      - Housekeeping serial interface clock
    * - F7
      - .. _ser_tx:

        ``ser_tx``
      - Digital out
      - UART transmit channel
    * - E7
      - .. _ser_rx:

        ``ser_rx``
      - Digital in
      - UART receive channel
    * - E5
      - .. _irq:

        ``irq``
      - Digital in
      - External interrupt
    * - E10
      - .. _gpio:

        ``gpio``
      - Digital I/O
      - Management GPIO/user power enable
    * - D7
      - .. _jtag:

        ``JTAG``
      - Digital I/O
      - JTAG system access
    * - F5
      - .. _flash2_csb:

        ``flash2_csb``
      - Digital out
      - User area QSPI flash enable (sense inverted)
    * - E4
      - .. _flash2_sck:

        ``flash2_sck``
      - Digital out
      - User area QSPI flash clock
    * - E3, F4
      - .. _flash2_io:

        ``flash2_io[1:0]``
      - Digital I/O
      - User area QSPI flash data
    * - F9
      - .. _spi_sdo:

        ``spi_sdo``
      - Digital out
      - Serial interface controller data output
    * - F8
      - .. _spi_sck:

        ``spi_sck``
      - Digital out
      - Serial interface controller clock
    * - E8
      - .. _spi_csb:

        ``spi_csb``
      - Digital out
      - Serial interface controller chip select
    * - E9
      - .. _spi_sdi:

        ``spi_sdi``
      - Digital in
      - Serial interface controller data input
    * - C4
      - .. _vddio:

        ``vddio``
      - 3.3V Power
      - ESD and padframe power supply
    * - F10
      - .. _vdda:

        ``vdda``
      - 3.3V Power
      - Management area power supply
    * - A10
      - .. _vccd:

        ``vccd``
      - 1.8V Power
      - Management area digital power supply
    * - C5, C6, D5, D7
      - .. _vssio_vssa_vssd:

        ``vssio``/``vssa``/``vssd``
      - Ground
      - ESD, padframe, and management area ground
    * - D4
      - .. _vdda1:

        ``vdda1``
      - 3.3V Power
      - User area 1 power supply
    * - F2
      - .. _vccd1:

        ``vccd1``
      - 1.8V Power
      - User area 1 digital power supply
    * - E6
      - .. _vssa1:

        ``vssa1``
      - Ground
      - User area 1 ground
    * - F6
      - .. _vssd1:

        ``vssd1``
      - Ground
      - User area 1 digital ground
    * - C7
      - .. _vdda2:

        ``vdda2``
      - 3.3V Power
      - User area 2 power supply
    * - A2
      - .. _vccd2:

        ``vccd2``
      - 1.8V Power
      - User area 2 digital power supply
    * - B3
      - .. _vssa2:

        ``vssa2``
      - Ground
      - User area 2 ground
    * - B7
      - .. _vssd2:

        ``vssd2``
      - Ground
      - User area 2 digital ground

.. list-table:: Package physical measurements
    :name: wlcsp-physical-measurements

    * - Standard package
      - WLCSP (bump bond)
    * - Package size
      - 3.2 mm x 5.3 mm
    * - Bump pitch
      - 0.5 mm
