GPIO
====

Register Listing for GPIO
-------------------------

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
^^^^^^^^^^

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
^^^^^^^^^^

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
^^^^^^^^

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
^^^^^^^

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
^^^^^^^

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
^^^^^^^^

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


