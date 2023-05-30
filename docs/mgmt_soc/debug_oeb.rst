DEBUG_OEB
=========

Register Listing for DEBUG_OEB
------------------------------

+--------------------------------------+-----------------------------------+
| Register                             | Address                           |
+======================================+===================================+
| :ref:`DEBUG_OEB_OUT <DEBUG_OEB_OUT>` | :ref:`0xf0001000 <DEBUG_OEB_OUT>` |
+--------------------------------------+-----------------------------------+

DEBUG_OEB_OUT
^^^^^^^^^^^^^

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


