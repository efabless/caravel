USER_IRQ_ENA
============

Register Listing for USER_IRQ_ENA
---------------------------------

+--------------------------------------------+--------------------------------------+
| Register                                   | Address                              |
+============================================+======================================+
| :ref:`USER_IRQ_ENA_OUT <USER_IRQ_ENA_OUT>` | :ref:`0xf0009800 <USER_IRQ_ENA_OUT>` |
+--------------------------------------------+--------------------------------------+

USER_IRQ_ENA_OUT
^^^^^^^^^^^^^^^^

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


