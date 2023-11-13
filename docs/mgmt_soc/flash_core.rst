FLASH_CORE
==========

Register Listing for FLASH_CORE
-------------------------------

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
^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^

`Address: 0xf0001800 + 0xc = 0xf000180c`


    .. wavedrom::
        :caption: FLASH_CORE_MASTER_RXTX

        {
            "reg": [
                {"name": "master_rxtx[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


FLASH_CORE_MASTER_STATUS
^^^^^^^^^^^^^^^^^^^^^^^^

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

