TIMER0
======

Timer
-----

Provides a generic Timer core.

The Timer is implemented as a countdown timer that can be used in various modes:

- Polling : Returns current countdown value to software
- One-Shot: Loads itself and stops when value reaches ``0``
- Periodic: (Re-)Loads itself when value reaches ``0``

``en`` register allows the user to enable/disable the Timer. When the Timer is enabled, it is
automatically loaded with the value of `load` register.

When the Timer reaches ``0``, it is automatically reloaded with value of `reload` register.

The user can latch the current countdown value by writing to ``update_value`` register, it will
update ``value`` register with current countdown value.

To use the Timer in One-Shot mode, the user needs to:

- Disable the timer
- Set the ``load`` register to the expected duration
- (Re-)Enable the Timer

To use the Timer in Periodic mode, the user needs to:

- Disable the Timer
- Set the ``load`` register to 0
- Set the ``reload`` register to the expected period
- Enable the Timer

For both modes, the CPU can be advertised by an IRQ that the duration/period has elapsed. (The
CPU can also do software polling with ``update_value`` and ``value`` to know the elapsed duration)


Register Listing for TIMER0
---------------------------

+--------------------------------------------------+-----------------------------------------+
| Register                                         | Address                                 |
+==================================================+=========================================+
| :ref:`TIMER0_LOAD <TIMER0_LOAD>`                 | :ref:`0xf0005000 <TIMER0_LOAD>`         |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_RELOAD <TIMER0_RELOAD>`             | :ref:`0xf0005004 <TIMER0_RELOAD>`       |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EN <TIMER0_EN>`                     | :ref:`0xf0005008 <TIMER0_EN>`           |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_UPDATE_VALUE <TIMER0_UPDATE_VALUE>` | :ref:`0xf000500c <TIMER0_UPDATE_VALUE>` |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_VALUE <TIMER0_VALUE>`               | :ref:`0xf0005010 <TIMER0_VALUE>`        |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EV_STATUS <TIMER0_EV_STATUS>`       | :ref:`0xf0005014 <TIMER0_EV_STATUS>`    |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EV_PENDING <TIMER0_EV_PENDING>`     | :ref:`0xf0005018 <TIMER0_EV_PENDING>`   |
+--------------------------------------------------+-----------------------------------------+
| :ref:`TIMER0_EV_ENABLE <TIMER0_EV_ENABLE>`       | :ref:`0xf000501c <TIMER0_EV_ENABLE>`    |
+--------------------------------------------------+-----------------------------------------+

TIMER0_LOAD
^^^^^^^^^^^

`Address: 0xf0005000 + 0x0 = 0xf0005000`

    Load value when Timer is (re-)enabled. In One-Shot mode, the value written to
    this register specifies the Timer's duration in clock cycles.

    .. wavedrom::
        :caption: TIMER0_LOAD

        {
            "reg": [
                {"name": "load[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


TIMER0_RELOAD
^^^^^^^^^^^^^

`Address: 0xf0005000 + 0x4 = 0xf0005004`

    Reload value when Timer reaches ``0``. In Periodic mode, the value written to
    this register specify the Timer's period in clock cycles.

    .. wavedrom::
        :caption: TIMER0_RELOAD

        {
            "reg": [
                {"name": "reload[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


TIMER0_EN
^^^^^^^^^

`Address: 0xf0005000 + 0x8 = 0xf0005008`

    Enable flag of the Timer. Set this flag to ``1`` to enable/start the Timer.  Set
    to ``0`` to disable the Timer.

    .. wavedrom::
        :caption: TIMER0_EN

        {
            "reg": [
                {"name": "en", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


TIMER0_UPDATE_VALUE
^^^^^^^^^^^^^^^^^^^

`Address: 0xf0005000 + 0xc = 0xf000500c`

    Update trigger for the current countdown value. A write to this register latches
    the current countdown value to ``value`` register.

    .. wavedrom::
        :caption: TIMER0_UPDATE_VALUE

        {
            "reg": [
                {"name": "update_value", "bits": 1},
                {"bits": 31},
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


TIMER0_VALUE
^^^^^^^^^^^^

`Address: 0xf0005000 + 0x10 = 0xf0005010`

    Latched countdown value. This value is updated by writing to ``update_value``.

    .. wavedrom::
        :caption: TIMER0_VALUE

        {
            "reg": [
                {"name": "value[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


TIMER0_EV_STATUS
^^^^^^^^^^^^^^^^

`Address: 0xf0005000 + 0x14 = 0xf0005014`

    This register contains the current raw level of the zero event trigger.  Writes
    to this register have no effect.

    .. wavedrom::
        :caption: TIMER0_EV_STATUS

        {
            "reg": [
                {"name": "zero",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+-----------------------------+
| Field | Name | Description                 |
+=======+======+=============================+
| [0]   | ZERO | Level of the ``zero`` event |
+-------+------+-----------------------------+

TIMER0_EV_PENDING
^^^^^^^^^^^^^^^^^

`Address: 0xf0005000 + 0x18 = 0xf0005018`

    When a  zero event occurs, the corresponding bit will be set in this register.
    To clear the Event, set the corresponding bit in this register.

    .. wavedrom::
        :caption: TIMER0_EV_PENDING

        {
            "reg": [
                {"name": "zero",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+--------------------------------------------------------------------------------+
| Field | Name | Description                                                                    |
+=======+======+================================================================================+
| [0]   | ZERO | `1` if a `zero` event occurred. This Event is triggered on a **falling** edge. |
+-------+------+--------------------------------------------------------------------------------+

TIMER0_EV_ENABLE
^^^^^^^^^^^^^^^^

`Address: 0xf0005000 + 0x1c = 0xf000501c`

    This register enables the corresponding zero events.  Write a ``0`` to this
    register to disable individual events.

    .. wavedrom::
        :caption: TIMER0_EV_ENABLE

        {
            "reg": [
                {"name": "zero",  "bits": 1},
                {"bits": 31}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 4 }, "options": {"hspace": 400, "bits": 32, "lanes": 4}
        }


+-------+------+--------------------------------------------+
| Field | Name | Description                                |
+=======+======+============================================+
| [0]   | ZERO | Write a ``1`` to enable the ``zero`` Event |
+-------+------+--------------------------------------------+

