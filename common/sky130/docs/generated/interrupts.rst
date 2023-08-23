Interrupt Controller
====================

This device has an ``EventManager``-based interrupt system.  Individual modules
generate `events` which are wired into a central interrupt controller.

When an interrupt occurs, you should look the interrupt number up in the CPU-
specific interrupt table and then call the relevant module.

Assigned Interrupts
-------------------

The following interrupts are assigned on this system:

+-----------+--------------------------------+
| Interrupt | Module                         |
+===========+================================+
| 0         | :doc:`TIMER0 <timer0>`         |
+-----------+--------------------------------+
| 1         | :doc:`UART <uart>`             |
+-----------+--------------------------------+
| 2         | :doc:`USER_IRQ_0 <user_irq_0>` |
+-----------+--------------------------------+
| 3         | :doc:`USER_IRQ_1 <user_irq_1>` |
+-----------+--------------------------------+
| 4         | :doc:`USER_IRQ_2 <user_irq_2>` |
+-----------+--------------------------------+
| 5         | :doc:`USER_IRQ_3 <user_irq_3>` |
+-----------+--------------------------------+
| 6         | :doc:`USER_IRQ_4 <user_irq_4>` |
+-----------+--------------------------------+
| 7         | :doc:`USER_IRQ_5 <user_irq_5>` |
+-----------+--------------------------------+

