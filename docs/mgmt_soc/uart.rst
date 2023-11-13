UART
====

Register Listing for UART
-------------------------

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
^^^^^^^^^

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
^^^^^^^^^^^

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
^^^^^^^^^^^^

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
^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^

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
^^^^^^^^^^^^

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
^^^^^^^^^^^

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


