Management SoC - Litex
======================

CTRL
----

Register Listing for CTRL
^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------+-------------------------------------+
| Register                                 | Address                             |
+==========================================+=====================================+
| :ref:`CTRL_RESET <CTRL_RESET>`           | :ref:`0xf0000000 <CTRL_RESET>`      |
+------------------------------------------+-------------------------------------+
| :ref:`CTRL_SCRATCH <CTRL_SCRATCH>`       | :ref:`0xf0000004 <CTRL_SCRATCH>`    |
+------------------------------------------+-------------------------------------+
| :ref:`CTRL_BUS_ERRORS <CTRL_BUS_ERRORS>` | :ref:`0xf0000008 <CTRL_BUS_ERRORS>` |
+------------------------------------------+-------------------------------------+

CTRL_RESET
..........

`Address: 0xf0000000 + 0x0 = 0xf0000000`


    .. wavedrom::
        :caption: CTRL_RESET

        {
            "reg": [
                {"name": "soc_rst",  "type": 4, "bits": 1},
                {"name": "cpu_rst",  "bits": 1},
                {"bits": 30}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+---------+------------------------------------------------------------------------+
| Field | Name    | Description                                                            |
+=======+=========+========================================================================+
| [0]   | SOC_RST | Write `1` to this register to reset the full SoC (Pulse Reset)         |
+-------+---------+------------------------------------------------------------------------+
| [1]   | CPU_RST | Write `1` to this register to reset the CPU(s) of the SoC (Hold Reset) |
+-------+---------+------------------------------------------------------------------------+

CTRL_SCRATCH
............

`Address: 0xf0000000 + 0x4 = 0xf0000004`

    Use this register as a scratch space to verify that software read/write accesses
    to the Wishbone/CSR bus are working correctly. The initial reset value of
    0x1234578 can be used to verify endianness.

    .. wavedrom::
        :caption: CTRL_SCRATCH

        {
            "reg": [
                {"name": "scratch[31:0]", "attr": 'reset: 305419896', "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


CTRL_BUS_ERRORS
...............

`Address: 0xf0000000 + 0x8 = 0xf0000008`

    Total number of Wishbone bus errors (timeouts) since start.

    .. wavedrom::
        :caption: CTRL_BUS_ERRORS

        {
            "reg": [
                {"name": "bus_errors[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


DEBUG_MODE
----------

Register Listing for DEBUG_MODE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+----------------------------------------+------------------------------------+
| Register                               | Address                            |
+========================================+====================================+
| :ref:`DEBUG_MODE_OUT <DEBUG_MODE_OUT>` | :ref:`0xf0000800 <DEBUG_MODE_OUT>` |
+----------------------------------------+------------------------------------+

DEBUG_MODE_OUT
..............

`Address: 0xf0000800 + 0x0 = 0xf0000800`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: DEBUG_MODE_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


DEBUG_OEB
---------

Register Listing for DEBUG_OEB
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------+-----------------------------------+
| Register                             | Address                           |
+======================================+===================================+
| :ref:`DEBUG_OEB_OUT <DEBUG_OEB_OUT>` | :ref:`0xf0001000 <DEBUG_OEB_OUT>` |
+--------------------------------------+-----------------------------------+

DEBUG_OEB_OUT
.............

`Address: 0xf0001000 + 0x0 = 0xf0001000`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: DEBUG_OEB_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


FLASH_CORE
----------

Register Listing for FLASH_CORE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------------------+-------------------------------------------------+
| Register                                                         | Address                                         |
+==================================================================+=================================================+
| :ref:`FLASH_CORE_MMAP_DUMMY_BITS <FLASH_CORE_MMAP_DUMMY_BITS>`   | :ref:`0xf0001800 <FLASH_CORE_MMAP_DUMMY_BITS>`  |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_CS <FLASH_CORE_MASTER_CS>`               | :ref:`0xf0001804 <FLASH_CORE_MASTER_CS>`        |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_PHYCONFIG <FLASH_CORE_MASTER_PHYCONFIG>` | :ref:`0xf0001808 <FLASH_CORE_MASTER_PHYCONFIG>` |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_RXTX <FLASH_CORE_MASTER_RXTX>`           | :ref:`0xf000180c <FLASH_CORE_MASTER_RXTX>`      |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_STATUS <FLASH_CORE_MASTER_STATUS>`       | :ref:`0xf0001810 <FLASH_CORE_MASTER_STATUS>`    |
+------------------------------------------------------------------+-------------------------------------------------+

FLASH_CORE_MMAP_DUMMY_BITS
..........................

`Address: 0xf0001800 + 0x0 = 0xf0001800`


    .. wavedrom::
        :caption: FLASH_CORE_MMAP_DUMMY_BITS

        {
            "reg": [
                {"name": "mmap_dummy_bits[7:0]", "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


FLASH_CORE_MASTER_CS
....................

`Address: 0xf0001800 + 0x4 = 0xf0001804`


    .. wavedrom::
        :caption: FLASH_CORE_MASTER_CS

        {
            "reg": [
                {"name": "master_cs", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


FLASH_CORE_MASTER_PHYCONFIG
...........................

`Address: 0xf0001800 + 0x8 = 0xf0001808`

    SPI PHY settings.

    .. wavedrom::
        :caption: FLASH_CORE_MASTER_PHYCONFIG

        {
            "reg": [
                {"name": "len",  "bits": 8},
                {"name": "width",  "bits": 4},
                {"bits": 4},
                {"name": "mask",  "bits": 8},
                {"bits": 8}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+---------+-------+-----------------------------------------------------------------------------+
| Field   | Name  | Description                                                                 |
+=========+=======+=============================================================================+
| [7:0]   | LEN   | SPI Xfer length (in bits).                                                  |
+---------+-------+-----------------------------------------------------------------------------+
| [11:8]  | WIDTH | SPI Xfer width (1/2/4/8).                                                   |
+---------+-------+-----------------------------------------------------------------------------+
| [23:16] | MASK  | SPI DQ output enable mask (set bits to ``1`` to enable output drivers on DQ |
|         |       | lines).                                                                     |
+---------+-------+-----------------------------------------------------------------------------+

FLASH_CORE_MASTER_RXTX
......................

`Address: 0xf0001800 + 0xc = 0xf000180c`


    .. wavedrom::
        :caption: FLASH_CORE_MASTER_RXTX

        {
            "reg": [
                {"name": "master_rxtx[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


FLASH_CORE_MASTER_STATUS
........................

`Address: 0xf0001800 + 0x10 = 0xf0001810`


    .. wavedrom::
        :caption: FLASH_CORE_MASTER_STATUS

        {
            "reg": [
                {"name": "tx_ready",  "bits": 1},
                {"name": "rx_ready",  "bits": 1},
                {"bits": 30}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+----------+-----------------------+
| Field | Name     | Description           |
+=======+==========+=======================+
| [0]   | TX_READY | TX FIFO is not full.  |
+-------+----------+-----------------------+
| [1]   | RX_READY | RX FIFO is not empty. |
+-------+----------+-----------------------+

FLASH_PHY
---------

Register Listing for FLASH_PHY
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`FLASH_PHY_CLK_DIVISOR <FLASH_PHY_CLK_DIVISOR>` | :ref:`0xf0002000 <FLASH_PHY_CLK_DIVISOR>` |
+------------------------------------------------------+-------------------------------------------+

FLASH_PHY_CLK_DIVISOR
.....................

`Address: 0xf0002000 + 0x0 = 0xf0002000`


    .. wavedrom::
        :caption: FLASH_PHY_CLK_DIVISOR

        {
            "reg": [
                {"name": "clk_divisor[7:0]", "attr": 'reset: 1', "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


GPIO
----

Register Listing for GPIO
^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------+--------------------------------+
| Register                       | Address                        |
+================================+================================+
| :ref:`GPIO_MODE1 <GPIO_MODE1>` | :ref:`0xf0002800 <GPIO_MODE1>` |
+--------------------------------+--------------------------------+
| :ref:`GPIO_MODE0 <GPIO_MODE0>` | :ref:`0xf0002804 <GPIO_MODE0>` |
+--------------------------------+--------------------------------+
| :ref:`GPIO_IEN <GPIO_IEN>`     | :ref:`0xf0002808 <GPIO_IEN>`   |
+--------------------------------+--------------------------------+
| :ref:`GPIO_OE <GPIO_OE>`       | :ref:`0xf000280c <GPIO_OE>`    |
+--------------------------------+--------------------------------+
| :ref:`GPIO_IN <GPIO_IN>`       | :ref:`0xf0002810 <GPIO_IN>`    |
+--------------------------------+--------------------------------+
| :ref:`GPIO_OUT <GPIO_OUT>`     | :ref:`0xf0002814 <GPIO_OUT>`   |
+--------------------------------+--------------------------------+

GPIO_MODE1
..........

`Address: 0xf0002800 + 0x0 = 0xf0002800`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_MODE1

        {
            "reg": [
                {"name": "mode1", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_MODE0
..........

`Address: 0xf0002800 + 0x4 = 0xf0002804`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_MODE0

        {
            "reg": [
                {"name": "mode0", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_IEN
........

`Address: 0xf0002800 + 0x8 = 0xf0002808`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_IEN

        {
            "reg": [
                {"name": "ien", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_OE
.......

`Address: 0xf0002800 + 0xc = 0xf000280c`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_OE

        {
            "reg": [
                {"name": "oe", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_IN
.......

`Address: 0xf0002800 + 0x10 = 0xf0002810`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: GPIO_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_OUT
........

`Address: 0xf0002800 + 0x14 = 0xf0002814`

    GPIO Ouptut(s) Control.

    .. wavedrom::
        :caption: GPIO_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


Interrupt Controller
--------------------

This device has an ``EventManager``-based interrupt system.  Individual modules
generate `events` which are wired into a central interrupt controller.

When an interrupt occurs, you should look the interrupt number up in the CPU-
specific interrupt table and then call the relevant module.

Assigned Interrupts
^^^^^^^^^^^^^^^^^^^

The following interrupts are assigned on this system:

+-----------+--------------------------------+
| Interrupt | Module                         |
+===========+================================+
| 0         | :doc:`TIMER0 <timer0>`         |
+-----------+--------------------------------+
| 1         | :doc:`UART <uart>`             |
+-----------+--------------------------------+
| 2         | :doc:`USER_IRQ_0 <user_irq_0>` |
+-----------+--------------------------------+
| 3         | :doc:`USER_IRQ_1 <user_irq_1>` |
+-----------+--------------------------------+
| 4         | :doc:`USER_IRQ_2 <user_irq_2>` |
+-----------+--------------------------------+
| 5         | :doc:`USER_IRQ_3 <user_irq_3>` |
+-----------+--------------------------------+
| 6         | :doc:`USER_IRQ_4 <user_irq_4>` |
+-----------+--------------------------------+
| 7         | :doc:`USER_IRQ_5 <user_irq_5>` |
+-----------+--------------------------------+

LA
--

Register Listing for LA
^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------+-----------------------------+
| Register                 | Address                     |
+==========================+=============================+
| :ref:`LA_IEN3 <LA_IEN3>` | :ref:`0xf0003000 <LA_IEN3>` |
+--------------------------+-----------------------------+
| :ref:`LA_IEN2 <LA_IEN2>` | :ref:`0xf0003004 <LA_IEN2>` |
+--------------------------+-----------------------------+
| :ref:`LA_IEN1 <LA_IEN1>` | :ref:`0xf0003008 <LA_IEN1>` |
+--------------------------+-----------------------------+
| :ref:`LA_IEN0 <LA_IEN0>` | :ref:`0xf000300c <LA_IEN0>` |
+--------------------------+-----------------------------+
| :ref:`LA_OE3 <LA_OE3>`   | :ref:`0xf0003010 <LA_OE3>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OE2 <LA_OE2>`   | :ref:`0xf0003014 <LA_OE2>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OE1 <LA_OE1>`   | :ref:`0xf0003018 <LA_OE1>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OE0 <LA_OE0>`   | :ref:`0xf000301c <LA_OE0>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN3 <LA_IN3>`   | :ref:`0xf0003020 <LA_IN3>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN2 <LA_IN2>`   | :ref:`0xf0003024 <LA_IN2>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN1 <LA_IN1>`   | :ref:`0xf0003028 <LA_IN1>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN0 <LA_IN0>`   | :ref:`0xf000302c <LA_IN0>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OUT3 <LA_OUT3>` | :ref:`0xf0003030 <LA_OUT3>` |
+--------------------------+-----------------------------+
| :ref:`LA_OUT2 <LA_OUT2>` | :ref:`0xf0003034 <LA_OUT2>` |
+--------------------------+-----------------------------+
| :ref:`LA_OUT1 <LA_OUT1>` | :ref:`0xf0003038 <LA_OUT1>` |
+--------------------------+-----------------------------+
| :ref:`LA_OUT0 <LA_OUT0>` | :ref:`0xf000303c <LA_OUT0>` |
+--------------------------+-----------------------------+

LA_IEN3
.......

`Address: 0xf0003000 + 0x0 = 0xf0003000`

    Bits 96-127 of `LA_IEN`. LA Input Enable

    .. wavedrom::
        :caption: LA_IEN3

        {
            "reg": [
                {"name": "ien[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IEN2
.......

`Address: 0xf0003000 + 0x4 = 0xf0003004`

    Bits 64-95 of `LA_IEN`.

    .. wavedrom::
        :caption: LA_IEN2

        {
            "reg": [
                {"name": "ien[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IEN1
.......

`Address: 0xf0003000 + 0x8 = 0xf0003008`

    Bits 32-63 of `LA_IEN`.

    .. wavedrom::
        :caption: LA_IEN1

        {
            "reg": [
                {"name": "ien[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IEN0
.......

`Address: 0xf0003000 + 0xc = 0xf000300c`

    Bits 0-31 of `LA_IEN`.

    .. wavedrom::
        :caption: LA_IEN0

        {
            "reg": [
                {"name": "ien[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE3
......

`Address: 0xf0003000 + 0x10 = 0xf0003010`

    Bits 96-127 of `LA_OE`. LA Output Enable

    .. wavedrom::
        :caption: LA_OE3

        {
            "reg": [
                {"name": "oe[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE2
......

`Address: 0xf0003000 + 0x14 = 0xf0003014`

    Bits 64-95 of `LA_OE`.

    .. wavedrom::
        :caption: LA_OE2

        {
            "reg": [
                {"name": "oe[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE1
......

`Address: 0xf0003000 + 0x18 = 0xf0003018`

    Bits 32-63 of `LA_OE`.

    .. wavedrom::
        :caption: LA_OE1

        {
            "reg": [
                {"name": "oe[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE0
......

`Address: 0xf0003000 + 0x1c = 0xf000301c`

    Bits 0-31 of `LA_OE`.

    .. wavedrom::
        :caption: LA_OE0

        {
            "reg": [
                {"name": "oe[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN3
......

`Address: 0xf0003000 + 0x20 = 0xf0003020`

    Bits 96-127 of `LA_IN`. LA Input(s) Status.

    .. wavedrom::
        :caption: LA_IN3

        {
            "reg": [
                {"name": "in[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN2
......

`Address: 0xf0003000 + 0x24 = 0xf0003024`

    Bits 64-95 of `LA_IN`.

    .. wavedrom::
        :caption: LA_IN2

        {
            "reg": [
                {"name": "in[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN1
......

`Address: 0xf0003000 + 0x28 = 0xf0003028`

    Bits 32-63 of `LA_IN`.

    .. wavedrom::
        :caption: LA_IN1

        {
            "reg": [
                {"name": "in[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN0
......

`Address: 0xf0003000 + 0x2c = 0xf000302c`

    Bits 0-31 of `LA_IN`.

    .. wavedrom::
        :caption: LA_IN0

        {
            "reg": [
                {"name": "in[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT3
.......

`Address: 0xf0003000 + 0x30 = 0xf0003030`

    Bits 96-127 of `LA_OUT`. LA Ouptut(s) Control.

    .. wavedrom::
        :caption: LA_OUT3

        {
            "reg": [
                {"name": "out[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT2
.......

`Address: 0xf0003000 + 0x34 = 0xf0003034`

    Bits 64-95 of `LA_OUT`.

    .. wavedrom::
        :caption: LA_OUT2

        {
            "reg": [
                {"name": "out[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT1
.......

`Address: 0xf0003000 + 0x38 = 0xf0003038`

    Bits 32-63 of `LA_OUT`.

    .. wavedrom::
        :caption: LA_OUT1

        {
            "reg": [
                {"name": "out[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT0
.......

`Address: 0xf0003000 + 0x3c = 0xf000303c`

    Bits 0-31 of `LA_OUT`.

    .. wavedrom::
        :caption: LA_OUT0

        {
            "reg": [
                {"name": "out[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


CTRL
----

Register Listing for CTRL
^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------+-------------------------------------+
| Register                                 | Address                             |
+==========================================+=====================================+
| :ref:`CTRL_RESET <CTRL_RESET>`           | :ref:`0xf0000000 <CTRL_RESET>`      |
+------------------------------------------+-------------------------------------+
| :ref:`CTRL_SCRATCH <CTRL_SCRATCH>`       | :ref:`0xf0000004 <CTRL_SCRATCH>`    |
+------------------------------------------+-------------------------------------+
| :ref:`CTRL_BUS_ERRORS <CTRL_BUS_ERRORS>` | :ref:`0xf0000008 <CTRL_BUS_ERRORS>` |
+------------------------------------------+-------------------------------------+

CTRL_RESET
..........

`Address: 0xf0000000 + 0x0 = 0xf0000000`


    .. wavedrom::
        :caption: CTRL_RESET

        {
            "reg": [
                {"name": "soc_rst",  "type": 4, "bits": 1},
                {"name": "cpu_rst",  "bits": 1},
                {"bits": 30}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+---------+------------------------------------------------------------------------+
| Field | Name    | Description                                                            |
+=======+=========+========================================================================+
| [0]   | SOC_RST | Write `1` to this register to reset the full SoC (Pulse Reset)         |
+-------+---------+------------------------------------------------------------------------+
| [1]   | CPU_RST | Write `1` to this register to reset the CPU(s) of the SoC (Hold Reset) |
+-------+---------+------------------------------------------------------------------------+

CTRL_SCRATCH
............

`Address: 0xf0000000 + 0x4 = 0xf0000004`

    Use this register as a scratch space to verify that software read/write accesses
    to the Wishbone/CSR bus are working correctly. The initial reset value of
    0x1234578 can be used to verify endianness.

    .. wavedrom::
        :caption: CTRL_SCRATCH

        {
            "reg": [
                {"name": "scratch[31:0]", "attr": 'reset: 305419896', "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


CTRL_BUS_ERRORS
...............

`Address: 0xf0000000 + 0x8 = 0xf0000008`

    Total number of Wishbone bus errors (timeouts) since start.

    .. wavedrom::
        :caption: CTRL_BUS_ERRORS

        {
            "reg": [
                {"name": "bus_errors[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


DEBUG_MODE
----------

Register Listing for DEBUG_MODE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+----------------------------------------+------------------------------------+
| Register                               | Address                            |
+========================================+====================================+
| :ref:`DEBUG_MODE_OUT <DEBUG_MODE_OUT>` | :ref:`0xf0000800 <DEBUG_MODE_OUT>` |
+----------------------------------------+------------------------------------+

DEBUG_MODE_OUT
..............

`Address: 0xf0000800 + 0x0 = 0xf0000800`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: DEBUG_MODE_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


DEBUG_OEB
---------

Register Listing for DEBUG_OEB
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------+-----------------------------------+
| Register                             | Address                           |
+======================================+===================================+
| :ref:`DEBUG_OEB_OUT <DEBUG_OEB_OUT>` | :ref:`0xf0001000 <DEBUG_OEB_OUT>` |
+--------------------------------------+-----------------------------------+

DEBUG_OEB_OUT
.............

`Address: 0xf0001000 + 0x0 = 0xf0001000`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: DEBUG_OEB_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


FLASH_CORE
----------

Register Listing for FLASH_CORE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------------------+-------------------------------------------------+
| Register                                                         | Address                                         |
+==================================================================+=================================================+
| :ref:`FLASH_CORE_MMAP_DUMMY_BITS <FLASH_CORE_MMAP_DUMMY_BITS>`   | :ref:`0xf0001800 <FLASH_CORE_MMAP_DUMMY_BITS>`  |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_CS <FLASH_CORE_MASTER_CS>`               | :ref:`0xf0001804 <FLASH_CORE_MASTER_CS>`        |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_PHYCONFIG <FLASH_CORE_MASTER_PHYCONFIG>` | :ref:`0xf0001808 <FLASH_CORE_MASTER_PHYCONFIG>` |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_RXTX <FLASH_CORE_MASTER_RXTX>`           | :ref:`0xf000180c <FLASH_CORE_MASTER_RXTX>`      |
+------------------------------------------------------------------+-------------------------------------------------+
| :ref:`FLASH_CORE_MASTER_STATUS <FLASH_CORE_MASTER_STATUS>`       | :ref:`0xf0001810 <FLASH_CORE_MASTER_STATUS>`    |
+------------------------------------------------------------------+-------------------------------------------------+

FLASH_CORE_MMAP_DUMMY_BITS
..........................

`Address: 0xf0001800 + 0x0 = 0xf0001800`


    .. wavedrom::
        :caption: FLASH_CORE_MMAP_DUMMY_BITS

        {
            "reg": [
                {"name": "mmap_dummy_bits[7:0]", "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


FLASH_CORE_MASTER_CS
....................

`Address: 0xf0001800 + 0x4 = 0xf0001804`


    .. wavedrom::
        :caption: FLASH_CORE_MASTER_CS

        {
            "reg": [
                {"name": "master_cs", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


FLASH_CORE_MASTER_PHYCONFIG
...........................

`Address: 0xf0001800 + 0x8 = 0xf0001808`

    SPI PHY settings.

    .. wavedrom::
        :caption: FLASH_CORE_MASTER_PHYCONFIG

        {
            "reg": [
                {"name": "len",  "bits": 8},
                {"name": "width",  "bits": 4},
                {"bits": 4},
                {"name": "mask",  "bits": 8},
                {"bits": 8}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+---------+-------+-----------------------------------------------------------------------------+
| Field   | Name  | Description                                                                 |
+=========+=======+=============================================================================+
| [7:0]   | LEN   | SPI Xfer length (in bits).                                                  |
+---------+-------+-----------------------------------------------------------------------------+
| [11:8]  | WIDTH | SPI Xfer width (1/2/4/8).                                                   |
+---------+-------+-----------------------------------------------------------------------------+
| [23:16] | MASK  | SPI DQ output enable mask (set bits to ``1`` to enable output drivers on DQ |
|         |       | lines).                                                                     |
+---------+-------+-----------------------------------------------------------------------------+

FLASH_CORE_MASTER_RXTX
......................

`Address: 0xf0001800 + 0xc = 0xf000180c`


    .. wavedrom::
        :caption: FLASH_CORE_MASTER_RXTX

        {
            "reg": [
                {"name": "master_rxtx[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


FLASH_CORE_MASTER_STATUS
........................

`Address: 0xf0001800 + 0x10 = 0xf0001810`


    .. wavedrom::
        :caption: FLASH_CORE_MASTER_STATUS

        {
            "reg": [
                {"name": "tx_ready",  "bits": 1},
                {"name": "rx_ready",  "bits": 1},
                {"bits": 30}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+----------+-----------------------+
| Field | Name     | Description           |
+=======+==========+=======================+
| [0]   | TX_READY | TX FIFO is not full.  |
+-------+----------+-----------------------+
| [1]   | RX_READY | RX FIFO is not empty. |
+-------+----------+-----------------------+

FLASH_PHY
---------

Register Listing for FLASH_PHY
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`FLASH_PHY_CLK_DIVISOR <FLASH_PHY_CLK_DIVISOR>` | :ref:`0xf0002000 <FLASH_PHY_CLK_DIVISOR>` |
+------------------------------------------------------+-------------------------------------------+

FLASH_PHY_CLK_DIVISOR
.....................

`Address: 0xf0002000 + 0x0 = 0xf0002000`


    .. wavedrom::
        :caption: FLASH_PHY_CLK_DIVISOR

        {
            "reg": [
                {"name": "clk_divisor[7:0]", "attr": 'reset: 1', "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


GPIO
----

Register Listing for GPIO
^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------+--------------------------------+
| Register                       | Address                        |
+================================+================================+
| :ref:`GPIO_MODE1 <GPIO_MODE1>` | :ref:`0xf0002800 <GPIO_MODE1>` |
+--------------------------------+--------------------------------+
| :ref:`GPIO_MODE0 <GPIO_MODE0>` | :ref:`0xf0002804 <GPIO_MODE0>` |
+--------------------------------+--------------------------------+
| :ref:`GPIO_IEN <GPIO_IEN>`     | :ref:`0xf0002808 <GPIO_IEN>`   |
+--------------------------------+--------------------------------+
| :ref:`GPIO_OE <GPIO_OE>`       | :ref:`0xf000280c <GPIO_OE>`    |
+--------------------------------+--------------------------------+
| :ref:`GPIO_IN <GPIO_IN>`       | :ref:`0xf0002810 <GPIO_IN>`    |
+--------------------------------+--------------------------------+
| :ref:`GPIO_OUT <GPIO_OUT>`     | :ref:`0xf0002814 <GPIO_OUT>`   |
+--------------------------------+--------------------------------+

GPIO_MODE1
..........

`Address: 0xf0002800 + 0x0 = 0xf0002800`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_MODE1

        {
            "reg": [
                {"name": "mode1", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_MODE0
..........

`Address: 0xf0002800 + 0x4 = 0xf0002804`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_MODE0

        {
            "reg": [
                {"name": "mode0", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_IEN
........

`Address: 0xf0002800 + 0x8 = 0xf0002808`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_IEN

        {
            "reg": [
                {"name": "ien", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_OE
.......

`Address: 0xf0002800 + 0xc = 0xf000280c`

    GPIO Tristate(s) Control.

    .. wavedrom::
        :caption: GPIO_OE

        {
            "reg": [
                {"name": "oe", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_IN
.......

`Address: 0xf0002800 + 0x10 = 0xf0002810`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: GPIO_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


GPIO_OUT
........

`Address: 0xf0002800 + 0x14 = 0xf0002814`

    GPIO Ouptut(s) Control.

    .. wavedrom::
        :caption: GPIO_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


Interrupt Controller
--------------------

This device has an ``EventManager``-based interrupt system.  Individual modules
generate `events` which are wired into a central interrupt controller.

When an interrupt occurs, you should look the interrupt number up in the CPU-
specific interrupt table and then call the relevant module.

Assigned Interrupts
^^^^^^^^^^^^^^^^^^^

The following interrupts are assigned on this system:

+-----------+--------------------------------+
| Interrupt | Module                         |
+===========+================================+
| 0         | :doc:`TIMER0 <timer0>`         |
+-----------+--------------------------------+
| 1         | :doc:`UART <uart>`             |
+-----------+--------------------------------+
| 2         | :doc:`USER_IRQ_0 <user_irq_0>` |
+-----------+--------------------------------+
| 3         | :doc:`USER_IRQ_1 <user_irq_1>` |
+-----------+--------------------------------+
| 4         | :doc:`USER_IRQ_2 <user_irq_2>` |
+-----------+--------------------------------+
| 5         | :doc:`USER_IRQ_3 <user_irq_3>` |
+-----------+--------------------------------+
| 6         | :doc:`USER_IRQ_4 <user_irq_4>` |
+-----------+--------------------------------+
| 7         | :doc:`USER_IRQ_5 <user_irq_5>` |
+-----------+--------------------------------+

MPRJ_WB_IENA
------------

Register Listing for MPRJ_WB_IENA
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------------+--------------------------------------+
| Register                                   | Address                              |
+============================================+======================================+
| :ref:`MPRJ_WB_IENA_OUT <MPRJ_WB_IENA_OUT>` | :ref:`0xf0003800 <MPRJ_WB_IENA_OUT>` |
+--------------------------------------------+--------------------------------------+

MPRJ_WB_IENA_OUT
................

`Address: 0xf0003800 + 0x0 = 0xf0003800`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: MPRJ_WB_IENA_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


QSPI_ENABLED
------------

Register Listing for QSPI_ENABLED
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------------+--------------------------------------+
| Register                                   | Address                              |
+============================================+======================================+
| :ref:`QSPI_ENABLED_OUT <QSPI_ENABLED_OUT>` | :ref:`0xf0004000 <QSPI_ENABLED_OUT>` |
+--------------------------------------------+--------------------------------------+

QSPI_ENABLED_OUT
................

`Address: 0xf0004000 + 0x0 = 0xf0004000`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: QSPI_ENABLED_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


SPI_ENABLED
-----------

Register Listing for SPI_ENABLED
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------+-------------------------------------+
| Register                                 | Address                             |
+==========================================+=====================================+
| :ref:`SPI_ENABLED_OUT <SPI_ENABLED_OUT>` | :ref:`0xf0004000 <SPI_ENABLED_OUT>` |
+------------------------------------------+-------------------------------------+

SPI_ENABLED_OUT
...............

`Address: 0xf0004000 + 0x0 = 0xf0004000`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: SPI_ENABLED_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


SPI_MASTER
----------

Register Listing for SPI_MASTER
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------------------------+--------------------------------------------+
| Register                                               | Address                                    |
+========================================================+============================================+
| :ref:`SPI_MASTER_CONTROL <SPI_MASTER_CONTROL>`         | :ref:`0xf0004800 <SPI_MASTER_CONTROL>`     |
+--------------------------------------------------------+--------------------------------------------+
| :ref:`SPI_MASTER_STATUS <SPI_MASTER_STATUS>`           | :ref:`0xf0004804 <SPI_MASTER_STATUS>`      |
+--------------------------------------------------------+--------------------------------------------+
| :ref:`SPI_MASTER_MOSI <SPI_MASTER_MOSI>`               | :ref:`0xf0004808 <SPI_MASTER_MOSI>`        |
+--------------------------------------------------------+--------------------------------------------+
| :ref:`SPI_MASTER_MISO <SPI_MASTER_MISO>`               | :ref:`0xf000480c <SPI_MASTER_MISO>`        |
+--------------------------------------------------------+--------------------------------------------+
| :ref:`SPI_MASTER_CS <SPI_MASTER_CS>`                   | :ref:`0xf0004810 <SPI_MASTER_CS>`          |
+--------------------------------------------------------+--------------------------------------------+
| :ref:`SPI_MASTER_LOOPBACK <SPI_MASTER_LOOPBACK>`       | :ref:`0xf0004814 <SPI_MASTER_LOOPBACK>`    |
+--------------------------------------------------------+--------------------------------------------+
| :ref:`SPI_MASTER_CLK_DIVIDER <SPI_MASTER_CLK_DIVIDER>` | :ref:`0xf0004818 <SPI_MASTER_CLK_DIVIDER>` |
+--------------------------------------------------------+--------------------------------------------+

SPI_MASTER_CONTROL
..................

`Address: 0xf0004800 + 0x0 = 0xf0004800`

    SPI Control.

    .. wavedrom::
        :caption: SPI_MASTER_CONTROL

        {
            "reg": [
                {"name": "start",  "type": 4, "bits": 1},
                {"bits": 7},
                {"name": "length",  "bits": 8},
                {"bits": 16}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+--------+--------+---------------------------------------------+
| Field  | Name   | Description                                 |
+========+========+=============================================+
| [0]    | START  | SPI Xfer Start (Write ``1`` to start Xfer). |
+--------+--------+---------------------------------------------+
| [15:8] | LENGTH | SPI Xfer Length (in bits).                  |
+--------+--------+---------------------------------------------+

SPI_MASTER_STATUS
.................

`Address: 0xf0004800 + 0x4 = 0xf0004804`

    SPI Status.

    .. wavedrom::
        :caption: SPI_MASTER_STATUS

        {
            "reg": [
                {"name": "done",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+-------------------------------------+
| Field | Name | Description                         |
+=======+======+=====================================+
| [0]   | DONE | SPI Xfer Done (when read as ``1``). |
+-------+------+-------------------------------------+

SPI_MASTER_MOSI
...............

`Address: 0xf0004800 + 0x8 = 0xf0004808`

    SPI MOSI data (MSB-first serialization).

    .. wavedrom::
        :caption: SPI_MASTER_MOSI

        {
            "reg": [
                {"name": "mosi[7:0]", "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


SPI_MASTER_MISO
...............

`Address: 0xf0004800 + 0xc = 0xf000480c`

    SPI MISO data (MSB-first de-serialization).

    .. wavedrom::
        :caption: SPI_MASTER_MISO

        {
            "reg": [
                {"name": "miso[7:0]", "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


SPI_MASTER_CS
.............

`Address: 0xf0004800 + 0x10 = 0xf0004810`

    SPI CS Chip-Select and Mode.

    .. wavedrom::
        :caption: SPI_MASTER_CS

        {
            "reg": [
                {"name": "sel",  "attr": '1', "bits": 1},
                {"bits": 15},
                {"name": "mode",  "bits": 1},
                {"bits": 15}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+-----------------------------------------------------------------------------------------------------------+
| Field | Name | Description                                                                                               |
+=======+======+===========================================================================================================+
| [0]   | SEL  |                                                                                                           |
|       |      |                                                                                                           |
|       |      | +--------------+-----------------------------------+                                                      |
|       |      | | Value        | Description                       |                                                      |
|       |      | +==============+===================================+                                                      |
|       |      | | ``0b0..001`` | Chip ``0`` selected for SPI Xfer. |                                                      |
|       |      | +--------------+-----------------------------------+                                                      |
|       |      | | ``0b1..000`` | Chip ``N`` selected for SPI Xfer. |                                                      |
|       |      | +--------------+-----------------------------------+                                                      |
+-------+------+-----------------------------------------------------------------------------------------------------------+
| [16]  | MODE |                                                                                                           |
|       |      |                                                                                                           |
|       |      | +---------+---------------------------------------------------------------------------------------------+ |
|       |      | | Value   | Description                                                                                 | |
|       |      | +=========+=============================================================================================+ |
|       |      | | ``0b0`` | Normal operation (CS handled by Core).                                                      | |
|       |      | +---------+---------------------------------------------------------------------------------------------+ |
|       |      | | ``0b1`` | Manual operation (CS handled by User, direct recopy of ``sel``), useful for Bulk transfers. | |
|       |      | +---------+---------------------------------------------------------------------------------------------+ |
+-------+------+-----------------------------------------------------------------------------------------------------------+

SPI_MASTER_LOOPBACK
...................

`Address: 0xf0004800 + 0x14 = 0xf0004814`

    SPI Loopback Mode.

    .. wavedrom::
        :caption: SPI_MASTER_LOOPBACK

        {
            "reg": [
                {"name": "mode",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+--------------------------------------------------+
| Field | Name | Description                                      |
+=======+======+==================================================+
| [0]   | MODE |                                                  |
|       |      |                                                  |
|       |      | +---------+------------------------------------+ |
|       |      | | Value   | Description                        | |
|       |      | +=========+====================================+ |
|       |      | | ``0b0`` | Normal operation.                  | |
|       |      | +---------+------------------------------------+ |
|       |      | | ``0b1`` | Loopback operation (MOSI to MISO). | |
|       |      | +---------+------------------------------------+ |
+-------+------+--------------------------------------------------+

SPI_MASTER_CLK_DIVIDER
......................

`Address: 0xf0004800 + 0x18 = 0xf0004818`

    SPI Clk Divider.

    .. wavedrom::
        :caption: SPI_MASTER_CLK_DIVIDER

        {
            "reg": [
                {"name": "clk_divider[15:0]", "attr": 'reset: 100', "bits": 16},
                {"bits": 16},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


TIMER0
------

Timer
^^^^^

Provides a generic Timer core.

The Timer is implemented as a countdown timer that can be used in various modes:

- Polling : Returns current countdown value to software
- One-Shot: Loads itself and stops when value reaches ``0``
- Periodic: (Re-)Loads itself when value reaches ``0``

``en`` register allows the user to enable/disable the Timer. When the Timer is enabled, it is
automatically loaded with the value of `load` register.

When the Timer reaches ``0``, it is automatically reloaded with value of `reload` register.

The user can latch the current countdown value by writing to ``update_value`` register, it will
update ``value`` register with current countdown value.

To use the Timer in One-Shot mode, the user needs to:

- Disable the timer
- Set the ``load`` register to the expected duration
- (Re-)Enable the Timer

To use the Timer in Periodic mode, the user needs to:

- Disable the Timer
- Set the ``load`` register to 0
- Set the ``reload`` register to the expected period
- Enable the Timer

For both modes, the CPU can be advertised by an IRQ that the duration/period has elapsed. (The
CPU can also do software polling with ``update_value`` and ``value`` to know the elapsed duration)


Register Listing for TIMER0
^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------------------+-----------------------------------------+
| Register                                         | Address                                 |
+==================================================+=========================================+
| :ref:`TIMER0_LOAD <TIMER0_LOAD>`                 | :ref:`0xf0005000 <TIMER0_LOAD>`         |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_RELOAD <TIMER0_RELOAD>`             | :ref:`0xf0005004 <TIMER0_RELOAD>`       |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EN <TIMER0_EN>`                     | :ref:`0xf0005008 <TIMER0_EN>`           |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_UPDATE_VALUE <TIMER0_UPDATE_VALUE>` | :ref:`0xf000500c <TIMER0_UPDATE_VALUE>` |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_VALUE <TIMER0_VALUE>`               | :ref:`0xf0005010 <TIMER0_VALUE>`        |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EV_STATUS <TIMER0_EV_STATUS>`       | :ref:`0xf0005014 <TIMER0_EV_STATUS>`    |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EV_PENDING <TIMER0_EV_PENDING>`     | :ref:`0xf0005018 <TIMER0_EV_PENDING>`   |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EV_ENABLE <TIMER0_EV_ENABLE>`       | :ref:`0xf000501c <TIMER0_EV_ENABLE>`    |
+--------------------------------------------------+-----------------------------------------+

TIMER0_LOAD
...........

`Address: 0xf0005000 + 0x0 = 0xf0005000`

    Load value when Timer is (re-)enabled. In One-Shot mode, the value written to
    this register specifies the Timer's duration in clock cycles.

    .. wavedrom::
        :caption: TIMER0_LOAD

        {
            "reg": [
                {"name": "load[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


TIMER0_RELOAD
.............

`Address: 0xf0005000 + 0x4 = 0xf0005004`

    Reload value when Timer reaches ``0``. In Periodic mode, the value written to
    this register specify the Timer's period in clock cycles.

    .. wavedrom::
        :caption: TIMER0_RELOAD

        {
            "reg": [
                {"name": "reload[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


TIMER0_EN
.........

`Address: 0xf0005000 + 0x8 = 0xf0005008`

    Enable flag of the Timer. Set this flag to ``1`` to enable/start the Timer.  Set
    to ``0`` to disable the Timer.

    .. wavedrom::
        :caption: TIMER0_EN

        {
            "reg": [
                {"name": "en", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


TIMER0_UPDATE_VALUE
...................

`Address: 0xf0005000 + 0xc = 0xf000500c`

    Update trigger for the current countdown value. A write to this register latches
    the current countdown value to ``value`` register.

    .. wavedrom::
        :caption: TIMER0_UPDATE_VALUE

        {
            "reg": [
                {"name": "update_value", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


TIMER0_VALUE
............

`Address: 0xf0005000 + 0x10 = 0xf0005010`

    Latched countdown value. This value is updated by writing to ``update_value``.

    .. wavedrom::
        :caption: TIMER0_VALUE

        {
            "reg": [
                {"name": "value[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


TIMER0_EV_STATUS
................

`Address: 0xf0005000 + 0x14 = 0xf0005014`

    This register contains the current raw level of the zero event trigger.  Writes
    to this register have no effect.

    .. wavedrom::
        :caption: TIMER0_EV_STATUS

        {
            "reg": [
                {"name": "zero",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+-----------------------------+
| Field | Name | Description                 |
+=======+======+=============================+
| [0]   | ZERO | Level of the ``zero`` event |
+-------+------+-----------------------------+

TIMER0_EV_PENDING
.................

`Address: 0xf0005000 + 0x18 = 0xf0005018`

    When a  zero event occurs, the corresponding bit will be set in this register.
    To clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: TIMER0_EV_PENDING

        {
            "reg": [
                {"name": "zero",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+--------------------------------------------------------------------------------+
| Field | Name | Description                                                                    |
+=======+======+================================================================================+
| [0]   | ZERO | `1` if a `zero` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+--------------------------------------------------------------------------------+

TIMER0_EV_ENABLE
................

`Address: 0xf0005000 + 0x1c = 0xf000501c`

    This register enables the corresponding zero events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: TIMER0_EV_ENABLE

        {
            "reg": [
                {"name": "zero",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+--------------------------------------------+
| Field | Name | Description                                |
+=======+======+============================================+
| [0]   | ZERO | Write a ``1`` to enable the ``zero`` Event |
+-------+------+--------------------------------------------+

UART
----

Register Listing for UART
^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------+-------------------------------------+
| Register                                 | Address                             |
+==========================================+=====================================+
| :ref:`UART_RXTX <UART_RXTX>`             | :ref:`0xf0005800 <UART_RXTX>`       |
+------------------------------------------+-------------------------------------+
| :ref:`UART_TXFULL <UART_TXFULL>`         | :ref:`0xf0005804 <UART_TXFULL>`     |
+------------------------------------------+-------------------------------------+
| :ref:`UART_RXEMPTY <UART_RXEMPTY>`       | :ref:`0xf0005808 <UART_RXEMPTY>`    |
+------------------------------------------+-------------------------------------+
| :ref:`UART_EV_STATUS <UART_EV_STATUS>`   | :ref:`0xf000580c <UART_EV_STATUS>`  |
+------------------------------------------+-------------------------------------+
| :ref:`UART_EV_PENDING <UART_EV_PENDING>` | :ref:`0xf0005810 <UART_EV_PENDING>` |
+------------------------------------------+-------------------------------------+
| :ref:`UART_EV_ENABLE <UART_EV_ENABLE>`   | :ref:`0xf0005814 <UART_EV_ENABLE>`  |
+------------------------------------------+-------------------------------------+
| :ref:`UART_TXEMPTY <UART_TXEMPTY>`       | :ref:`0xf0005818 <UART_TXEMPTY>`    |
+------------------------------------------+-------------------------------------+
| :ref:`UART_RXFULL <UART_RXFULL>`         | :ref:`0xf000581c <UART_RXFULL>`     |
+------------------------------------------+-------------------------------------+

UART_RXTX
.........

`Address: 0xf0005800 + 0x0 = 0xf0005800`


    .. wavedrom::
        :caption: UART_RXTX

        {
            "reg": [
                {"name": "rxtx[7:0]", "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


UART_TXFULL
...........

`Address: 0xf0005800 + 0x4 = 0xf0005804`

    TX FIFO Full.

    .. wavedrom::
        :caption: UART_TXFULL

        {
            "reg": [
                {"name": "txfull", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


UART_RXEMPTY
............

`Address: 0xf0005800 + 0x8 = 0xf0005808`

    RX FIFO Empty.

    .. wavedrom::
        :caption: UART_RXEMPTY

        {
            "reg": [
                {"name": "rxempty", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


UART_EV_STATUS
..............

`Address: 0xf0005800 + 0xc = 0xf000580c`

    This register contains the current raw level of the rx event trigger.  Writes to
    this register have no effect.

    .. wavedrom::
        :caption: UART_EV_STATUS

        {
            "reg": [
                {"name": "tx",  "bits": 1},
                {"name": "rx",  "bits": 1},
                {"bits": 30}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+---------------------------+
| Field | Name | Description               |
+=======+======+===========================+
| [0]   | TX   | Level of the ``tx`` event |
+-------+------+---------------------------+
| [1]   | RX   | Level of the ``rx`` event |
+-------+------+---------------------------+

UART_EV_PENDING
...............

`Address: 0xf0005800 + 0x10 = 0xf0005810`

    When a  rx event occurs, the corresponding bit will be set in this register.  To
    clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: UART_EV_PENDING

        {
            "reg": [
                {"name": "tx",  "bits": 1},
                {"name": "rx",  "bits": 1},
                {"bits": 30}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------------------------------------------+
| Field | Name | Description                                                                  |
+=======+======+==============================================================================+
| [0]   | TX   | `1` if a `tx` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+
| [1]   | RX   | `1` if a `rx` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+

UART_EV_ENABLE
..............

`Address: 0xf0005800 + 0x14 = 0xf0005814`

    This register enables the corresponding rx events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: UART_EV_ENABLE

        {
            "reg": [
                {"name": "tx",  "bits": 1},
                {"name": "rx",  "bits": 1},
                {"bits": 30}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------+
| Field | Name | Description                              |
+=======+======+==========================================+
| [0]   | TX   | Write a ``1`` to enable the ``tx`` Event |
+-------+------+------------------------------------------+
| [1]   | RX   | Write a ``1`` to enable the ``rx`` Event |
+-------+------+------------------------------------------+

UART_TXEMPTY
............

`Address: 0xf0005800 + 0x18 = 0xf0005818`

    TX FIFO Empty.

    .. wavedrom::
        :caption: UART_TXEMPTY

        {
            "reg": [
                {"name": "txempty", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


UART_RXFULL
...........

`Address: 0xf0005800 + 0x1c = 0xf000581c`

    RX FIFO Full.

    .. wavedrom::
        :caption: UART_RXFULL

        {
            "reg": [
                {"name": "rxfull", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


UART_ENABLED
------------

Register Listing for UART_ENABLED
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------------+--------------------------------------+
| Register                                   | Address                              |
+============================================+======================================+
| :ref:`UART_ENABLED_OUT <UART_ENABLED_OUT>` | :ref:`0xf0006000 <UART_ENABLED_OUT>` |
+--------------------------------------------+--------------------------------------+

UART_ENABLED_OUT
................

`Address: 0xf0006000 + 0x0 = 0xf0006000`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: UART_ENABLED_OUT

        {
            "reg": [
                {"name": "out", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_0
----------

Register Listing for USER_IRQ_0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`USER_IRQ_0_IN <USER_IRQ_0_IN>`                 | :ref:`0xf0006800 <USER_IRQ_0_IN>`         |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_0_MODE <USER_IRQ_0_MODE>`             | :ref:`0xf0006804 <USER_IRQ_0_MODE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_0_EDGE <USER_IRQ_0_EDGE>`             | :ref:`0xf0006808 <USER_IRQ_0_EDGE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_0_EV_STATUS <USER_IRQ_0_EV_STATUS>`   | :ref:`0xf000680c <USER_IRQ_0_EV_STATUS>`  |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_0_EV_PENDING <USER_IRQ_0_EV_PENDING>` | :ref:`0xf0006810 <USER_IRQ_0_EV_PENDING>` |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_0_EV_ENABLE <USER_IRQ_0_EV_ENABLE>`   | :ref:`0xf0006814 <USER_IRQ_0_EV_ENABLE>`  |
+------------------------------------------------------+-------------------------------------------+

USER_IRQ_0_IN
.............

`Address: 0xf0006800 + 0x0 = 0xf0006800`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: USER_IRQ_0_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_0_MODE
...............

`Address: 0xf0006800 + 0x4 = 0xf0006804`

    GPIO IRQ Mode: 0: Edge, 1: Change.

    .. wavedrom::
        :caption: USER_IRQ_0_MODE

        {
            "reg": [
                {"name": "mode", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_0_EDGE
...............

`Address: 0xf0006800 + 0x8 = 0xf0006808`

    GPIO IRQ Edge (when in Edge mode): 0: Rising Edge, 1: Falling Edge.

    .. wavedrom::
        :caption: USER_IRQ_0_EDGE

        {
            "reg": [
                {"name": "edge", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_0_EV_STATUS
....................

`Address: 0xf0006800 + 0xc = 0xf000680c`

    This register contains the current raw level of the i0 event trigger.  Writes to
    this register have no effect.

    .. wavedrom::
        :caption: USER_IRQ_0_EV_STATUS

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+---------------------------+
| Field | Name | Description               |
+=======+======+===========================+
| [0]   | I0   | Level of the ``i0`` event |
+-------+------+---------------------------+

USER_IRQ_0_EV_PENDING
.....................

`Address: 0xf0006800 + 0x10 = 0xf0006810`

    When a  i0 event occurs, the corresponding bit will be set in this register.  To
    clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: USER_IRQ_0_EV_PENDING

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------------------------------------------+
| Field | Name | Description                                                                  |
+=======+======+==============================================================================+
| [0]   | I0   | `1` if a `i0` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+

USER_IRQ_0_EV_ENABLE
....................

`Address: 0xf0006800 + 0x14 = 0xf0006814`

    This register enables the corresponding i0 events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: USER_IRQ_0_EV_ENABLE

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------+
| Field | Name | Description                              |
+=======+======+==========================================+
| [0]   | I0   | Write a ``1`` to enable the ``i0`` Event |
+-------+------+------------------------------------------+

USER_IRQ_1
----------

Register Listing for USER_IRQ_1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`USER_IRQ_1_IN <USER_IRQ_1_IN>`                 | :ref:`0xf0007000 <USER_IRQ_1_IN>`         |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_1_MODE <USER_IRQ_1_MODE>`             | :ref:`0xf0007004 <USER_IRQ_1_MODE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_1_EDGE <USER_IRQ_1_EDGE>`             | :ref:`0xf0007008 <USER_IRQ_1_EDGE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_1_EV_STATUS <USER_IRQ_1_EV_STATUS>`   | :ref:`0xf000700c <USER_IRQ_1_EV_STATUS>`  |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_1_EV_PENDING <USER_IRQ_1_EV_PENDING>` | :ref:`0xf0007010 <USER_IRQ_1_EV_PENDING>` |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_1_EV_ENABLE <USER_IRQ_1_EV_ENABLE>`   | :ref:`0xf0007014 <USER_IRQ_1_EV_ENABLE>`  |
+------------------------------------------------------+-------------------------------------------+

USER_IRQ_1_IN
.............

`Address: 0xf0007000 + 0x0 = 0xf0007000`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: USER_IRQ_1_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_1_MODE
...............

`Address: 0xf0007000 + 0x4 = 0xf0007004`

    GPIO IRQ Mode: 0: Edge, 1: Change.

    .. wavedrom::
        :caption: USER_IRQ_1_MODE

        {
            "reg": [
                {"name": "mode", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_1_EDGE
...............

`Address: 0xf0007000 + 0x8 = 0xf0007008`

    GPIO IRQ Edge (when in Edge mode): 0: Rising Edge, 1: Falling Edge.

    .. wavedrom::
        :caption: USER_IRQ_1_EDGE

        {
            "reg": [
                {"name": "edge", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_1_EV_STATUS
....................

`Address: 0xf0007000 + 0xc = 0xf000700c`

    This register contains the current raw level of the i0 event trigger.  Writes to
    this register have no effect.

    .. wavedrom::
        :caption: USER_IRQ_1_EV_STATUS

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+---------------------------+
| Field | Name | Description               |
+=======+======+===========================+
| [0]   | I0   | Level of the ``i0`` event |
+-------+------+---------------------------+

USER_IRQ_1_EV_PENDING
.....................

`Address: 0xf0007000 + 0x10 = 0xf0007010`

    When a  i0 event occurs, the corresponding bit will be set in this register.  To
    clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: USER_IRQ_1_EV_PENDING

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------------------------------------------+
| Field | Name | Description                                                                  |
+=======+======+==============================================================================+
| [0]   | I0   | `1` if a `i0` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+

USER_IRQ_1_EV_ENABLE
....................

`Address: 0xf0007000 + 0x14 = 0xf0007014`

    This register enables the corresponding i0 events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: USER_IRQ_1_EV_ENABLE

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------+
| Field | Name | Description                              |
+=======+======+==========================================+
| [0]   | I0   | Write a ``1`` to enable the ``i0`` Event |
+-------+------+------------------------------------------+

USER_IRQ_2
----------

Register Listing for USER_IRQ_2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`USER_IRQ_2_IN <USER_IRQ_2_IN>`                 | :ref:`0xf0007800 <USER_IRQ_2_IN>`         |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_2_MODE <USER_IRQ_2_MODE>`             | :ref:`0xf0007804 <USER_IRQ_2_MODE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_2_EDGE <USER_IRQ_2_EDGE>`             | :ref:`0xf0007808 <USER_IRQ_2_EDGE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_2_EV_STATUS <USER_IRQ_2_EV_STATUS>`   | :ref:`0xf000780c <USER_IRQ_2_EV_STATUS>`  |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_2_EV_PENDING <USER_IRQ_2_EV_PENDING>` | :ref:`0xf0007810 <USER_IRQ_2_EV_PENDING>` |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_2_EV_ENABLE <USER_IRQ_2_EV_ENABLE>`   | :ref:`0xf0007814 <USER_IRQ_2_EV_ENABLE>`  |
+------------------------------------------------------+-------------------------------------------+

USER_IRQ_2_IN
.............

`Address: 0xf0007800 + 0x0 = 0xf0007800`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: USER_IRQ_2_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_2_MODE
...............

`Address: 0xf0007800 + 0x4 = 0xf0007804`

    GPIO IRQ Mode: 0: Edge, 1: Change.

    .. wavedrom::
        :caption: USER_IRQ_2_MODE

        {
            "reg": [
                {"name": "mode", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_2_EDGE
...............

`Address: 0xf0007800 + 0x8 = 0xf0007808`

    GPIO IRQ Edge (when in Edge mode): 0: Rising Edge, 1: Falling Edge.

    .. wavedrom::
        :caption: USER_IRQ_2_EDGE

        {
            "reg": [
                {"name": "edge", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_2_EV_STATUS
....................

`Address: 0xf0007800 + 0xc = 0xf000780c`

    This register contains the current raw level of the i0 event trigger.  Writes to
    this register have no effect.

    .. wavedrom::
        :caption: USER_IRQ_2_EV_STATUS

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+---------------------------+
| Field | Name | Description               |
+=======+======+===========================+
| [0]   | I0   | Level of the ``i0`` event |
+-------+------+---------------------------+

USER_IRQ_2_EV_PENDING
.....................

`Address: 0xf0007800 + 0x10 = 0xf0007810`

    When a  i0 event occurs, the corresponding bit will be set in this register.  To
    clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: USER_IRQ_2_EV_PENDING

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------------------------------------------+
| Field | Name | Description                                                                  |
+=======+======+==============================================================================+
| [0]   | I0   | `1` if a `i0` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+

USER_IRQ_2_EV_ENABLE
....................

`Address: 0xf0007800 + 0x14 = 0xf0007814`

    This register enables the corresponding i0 events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: USER_IRQ_2_EV_ENABLE

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------+
| Field | Name | Description                              |
+=======+======+==========================================+
| [0]   | I0   | Write a ``1`` to enable the ``i0`` Event |
+-------+------+------------------------------------------+

USER_IRQ_3
----------

Register Listing for USER_IRQ_3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`USER_IRQ_3_IN <USER_IRQ_3_IN>`                 | :ref:`0xf0008000 <USER_IRQ_3_IN>`         |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_3_MODE <USER_IRQ_3_MODE>`             | :ref:`0xf0008004 <USER_IRQ_3_MODE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_3_EDGE <USER_IRQ_3_EDGE>`             | :ref:`0xf0008008 <USER_IRQ_3_EDGE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_3_EV_STATUS <USER_IRQ_3_EV_STATUS>`   | :ref:`0xf000800c <USER_IRQ_3_EV_STATUS>`  |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_3_EV_PENDING <USER_IRQ_3_EV_PENDING>` | :ref:`0xf0008010 <USER_IRQ_3_EV_PENDING>` |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_3_EV_ENABLE <USER_IRQ_3_EV_ENABLE>`   | :ref:`0xf0008014 <USER_IRQ_3_EV_ENABLE>`  |
+------------------------------------------------------+-------------------------------------------+

USER_IRQ_3_IN
.............

`Address: 0xf0008000 + 0x0 = 0xf0008000`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: USER_IRQ_3_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_3_MODE
...............

`Address: 0xf0008000 + 0x4 = 0xf0008004`

    GPIO IRQ Mode: 0: Edge, 1: Change.

    .. wavedrom::
        :caption: USER_IRQ_3_MODE

        {
            "reg": [
                {"name": "mode", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_3_EDGE
...............

`Address: 0xf0008000 + 0x8 = 0xf0008008`

    GPIO IRQ Edge (when in Edge mode): 0: Rising Edge, 1: Falling Edge.

    .. wavedrom::
        :caption: USER_IRQ_3_EDGE

        {
            "reg": [
                {"name": "edge", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_3_EV_STATUS
....................

`Address: 0xf0008000 + 0xc = 0xf000800c`

    This register contains the current raw level of the i0 event trigger.  Writes to
    this register have no effect.

    .. wavedrom::
        :caption: USER_IRQ_3_EV_STATUS

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+---------------------------+
| Field | Name | Description               |
+=======+======+===========================+
| [0]   | I0   | Level of the ``i0`` event |
+-------+------+---------------------------+

USER_IRQ_3_EV_PENDING
.....................

`Address: 0xf0008000 + 0x10 = 0xf0008010`

    When a  i0 event occurs, the corresponding bit will be set in this register.  To
    clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: USER_IRQ_3_EV_PENDING

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------------------------------------------+
| Field | Name | Description                                                                  |
+=======+======+==============================================================================+
| [0]   | I0   | `1` if a `i0` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+

USER_IRQ_3_EV_ENABLE
....................

`Address: 0xf0008000 + 0x14 = 0xf0008014`

    This register enables the corresponding i0 events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: USER_IRQ_3_EV_ENABLE

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------+
| Field | Name | Description                              |
+=======+======+==========================================+
| [0]   | I0   | Write a ``1`` to enable the ``i0`` Event |
+-------+------+------------------------------------------+

USER_IRQ_4
----------

Register Listing for USER_IRQ_4
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`USER_IRQ_4_IN <USER_IRQ_4_IN>`                 | :ref:`0xf0008800 <USER_IRQ_4_IN>`         |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_4_MODE <USER_IRQ_4_MODE>`             | :ref:`0xf0008804 <USER_IRQ_4_MODE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_4_EDGE <USER_IRQ_4_EDGE>`             | :ref:`0xf0008808 <USER_IRQ_4_EDGE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_4_EV_STATUS <USER_IRQ_4_EV_STATUS>`   | :ref:`0xf000880c <USER_IRQ_4_EV_STATUS>`  |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_4_EV_PENDING <USER_IRQ_4_EV_PENDING>` | :ref:`0xf0008810 <USER_IRQ_4_EV_PENDING>` |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_4_EV_ENABLE <USER_IRQ_4_EV_ENABLE>`   | :ref:`0xf0008814 <USER_IRQ_4_EV_ENABLE>`  |
+------------------------------------------------------+-------------------------------------------+

USER_IRQ_4_IN
.............

`Address: 0xf0008800 + 0x0 = 0xf0008800`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: USER_IRQ_4_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_4_MODE
...............

`Address: 0xf0008800 + 0x4 = 0xf0008804`

    GPIO IRQ Mode: 0: Edge, 1: Change.

    .. wavedrom::
        :caption: USER_IRQ_4_MODE

        {
            "reg": [
                {"name": "mode", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_4_EDGE
...............

`Address: 0xf0008800 + 0x8 = 0xf0008808`

    GPIO IRQ Edge (when in Edge mode): 0: Rising Edge, 1: Falling Edge.

    .. wavedrom::
        :caption: USER_IRQ_4_EDGE

        {
            "reg": [
                {"name": "edge", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_4_EV_STATUS
....................

`Address: 0xf0008800 + 0xc = 0xf000880c`

    This register contains the current raw level of the i0 event trigger.  Writes to
    this register have no effect.

    .. wavedrom::
        :caption: USER_IRQ_4_EV_STATUS

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+---------------------------+
| Field | Name | Description               |
+=======+======+===========================+
| [0]   | I0   | Level of the ``i0`` event |
+-------+------+---------------------------+

USER_IRQ_4_EV_PENDING
.....................

`Address: 0xf0008800 + 0x10 = 0xf0008810`

    When a  i0 event occurs, the corresponding bit will be set in this register.  To
    clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: USER_IRQ_4_EV_PENDING

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------------------------------------------+
| Field | Name | Description                                                                  |
+=======+======+==============================================================================+
| [0]   | I0   | `1` if a `i0` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+

USER_IRQ_4_EV_ENABLE
....................

`Address: 0xf0008800 + 0x14 = 0xf0008814`

    This register enables the corresponding i0 events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: USER_IRQ_4_EV_ENABLE

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------+
| Field | Name | Description                              |
+=======+======+==========================================+
| [0]   | I0   | Write a ``1`` to enable the ``i0`` Event |
+-------+------+------------------------------------------+

USER_IRQ_5
----------

Register Listing for USER_IRQ_5
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`USER_IRQ_5_IN <USER_IRQ_5_IN>`                 | :ref:`0xf0009000 <USER_IRQ_5_IN>`         |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_5_MODE <USER_IRQ_5_MODE>`             | :ref:`0xf0009004 <USER_IRQ_5_MODE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_5_EDGE <USER_IRQ_5_EDGE>`             | :ref:`0xf0009008 <USER_IRQ_5_EDGE>`       |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_5_EV_STATUS <USER_IRQ_5_EV_STATUS>`   | :ref:`0xf000900c <USER_IRQ_5_EV_STATUS>`  |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_5_EV_PENDING <USER_IRQ_5_EV_PENDING>` | :ref:`0xf0009010 <USER_IRQ_5_EV_PENDING>` |
+------------------------------------------------------+-------------------------------------------+
| :ref:`USER_IRQ_5_EV_ENABLE <USER_IRQ_5_EV_ENABLE>`   | :ref:`0xf0009014 <USER_IRQ_5_EV_ENABLE>`  |
+------------------------------------------------------+-------------------------------------------+

USER_IRQ_5_IN
.............

`Address: 0xf0009000 + 0x0 = 0xf0009000`

    GPIO Input(s) Status.

    .. wavedrom::
        :caption: USER_IRQ_5_IN

        {
            "reg": [
                {"name": "in", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_5_MODE
...............

`Address: 0xf0009000 + 0x4 = 0xf0009004`

    GPIO IRQ Mode: 0: Edge, 1: Change.

    .. wavedrom::
        :caption: USER_IRQ_5_MODE

        {
            "reg": [
                {"name": "mode", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_5_EDGE
...............

`Address: 0xf0009000 + 0x8 = 0xf0009008`

    GPIO IRQ Edge (when in Edge mode): 0: Rising Edge, 1: Falling Edge.

    .. wavedrom::
        :caption: USER_IRQ_5_EDGE

        {
            "reg": [
                {"name": "edge", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


USER_IRQ_5_EV_STATUS
....................

`Address: 0xf0009000 + 0xc = 0xf000900c`

    This register contains the current raw level of the i0 event trigger.  Writes to
    this register have no effect.

    .. wavedrom::
        :caption: USER_IRQ_5_EV_STATUS

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+---------------------------+
| Field | Name | Description               |
+=======+======+===========================+
| [0]   | I0   | Level of the ``i0`` event |
+-------+------+---------------------------+

USER_IRQ_5_EV_PENDING
.....................

`Address: 0xf0009000 + 0x10 = 0xf0009010`

    When a  i0 event occurs, the corresponding bit will be set in this register.  To
    clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: USER_IRQ_5_EV_PENDING

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------------------------------------------+
| Field | Name | Description                                                                  |
+=======+======+==============================================================================+
| [0]   | I0   | `1` if a `i0` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+------------------------------------------------------------------------------+

USER_IRQ_5_EV_ENABLE
....................

`Address: 0xf0009000 + 0x14 = 0xf0009014`

    This register enables the corresponding i0 events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: USER_IRQ_5_EV_ENABLE

        {
            "reg": [
                {"name": "i0",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+------------------------------------------+
| Field | Name | Description                              |
+=======+======+==========================================+
| [0]   | I0   | Write a ``1`` to enable the ``i0`` Event |
+-------+------+------------------------------------------+

USER_IRQ_ENA
------------

Register Listing for USER_IRQ_ENA
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+--------------------------------------------+--------------------------------------+
| Register                                   | Address                              |
+============================================+======================================+
| :ref:`USER_IRQ_ENA_OUT <USER_IRQ_ENA_OUT>` | :ref:`0xf0009800 <USER_IRQ_ENA_OUT>` |
+--------------------------------------------+--------------------------------------+

USER_IRQ_ENA_OUT
................

`Address: 0xf0009800 + 0x0 = 0xf0009800`

    GPIO Output(s) Control.

    .. wavedrom::
        :caption: USER_IRQ_ENA_OUT

        {
            "reg": [
                {"name": "out[2:0]", "bits": 3},
                {"bits": 29},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


