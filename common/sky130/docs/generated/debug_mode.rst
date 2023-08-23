DEBUG_MODE
==========

Register Listing for DEBUG_MODE
-------------------------------

+----------------------------------------+------------------------------------+
| Register                               | Address                            |
+========================================+====================================+
| :ref:`DEBUG_MODE_OUT <DEBUG_MODE_OUT>` | :ref:`0xf0000800 <DEBUG_MODE_OUT>` |
+----------------------------------------+------------------------------------+

DEBUG_MODE_OUT
^^^^^^^^^^^^^^

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


