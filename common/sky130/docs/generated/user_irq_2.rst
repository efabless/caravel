USER_IRQ_2
==========

Register Listing for USER_IRQ_2
-------------------------------

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
^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^

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

