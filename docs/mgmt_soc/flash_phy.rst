FLASH_PHY
=========

Register Listing for FLASH_PHY
------------------------------

+------------------------------------------------------+-------------------------------------------+
| Register                                             | Address                                   |
+======================================================+===========================================+
| :ref:`FLASH_PHY_CLK_DIVISOR <FLASH_PHY_CLK_DIVISOR>` | :ref:`0xf0002000 <FLASH_PHY_CLK_DIVISOR>` |
+------------------------------------------------------+-------------------------------------------+

FLASH_PHY_CLK_DIVISOR
^^^^^^^^^^^^^^^^^^^^^

`Address: 0xf0002000 + 0x0 = 0xf0002000`


    .. wavedrom::
        :caption: FLASH_PHY_CLK_DIVISOR

        {
            "reg": [
                {"name": "clk_divisor[7:0]", "attr": 'reset: 1', "bits": 8},
                {"bits": 24},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


