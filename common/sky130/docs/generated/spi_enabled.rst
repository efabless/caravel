SPI_ENABLED
===========

Register Listing for SPI_ENABLED
--------------------------------

+------------------------------------------+-------------------------------------+
| Register                                 | Address                             |
+==========================================+=====================================+
| :ref:`SPI_ENABLED_OUT <SPI_ENABLED_OUT>` | :ref:`0xf0004000 <SPI_ENABLED_OUT>` |
+------------------------------------------+-------------------------------------+

SPI_ENABLED_OUT
^^^^^^^^^^^^^^^

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


