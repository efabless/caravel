UART_ENABLED
============

Register Listing for UART_ENABLED
---------------------------------

+--------------------------------------------+--------------------------------------+
| Register                                   | Address                              |
+============================================+======================================+
| :ref:`UART_ENABLED_OUT <UART_ENABLED_OUT>` | :ref:`0xf0006000 <UART_ENABLED_OUT>` |
+--------------------------------------------+--------------------------------------+

UART_ENABLED_OUT
^^^^^^^^^^^^^^^^

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


