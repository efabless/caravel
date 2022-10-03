from cocotb_bus.scoreboard import Scoreboard
from cocotb.utils import hexdump, hexdiffs
from cocotb.log import SimLog
from cocotb.result import TestFailure, TestSuccess
from cocotb_bus.monitors import Monitor
import cocotb


class HKScoreboard(Scoreboard):
    def __init__(self, dut, reorder_depth=0, fail_immediately=True):

        Scoreboard.__init__(self, dut, reorder_depth, fail_immediately)

    def compare(self, got, exp, log, strict_type=True):
        # Compare the types
        if strict_type and type(got) != type(exp):
            self.errors += 1
            log.error("Received transaction type is different than expected")
            log.info("Received: %s but expected %s" %
                     (str(type(got)), str(type(exp))))
            if self._imm:
                raise TestFailure("Received transaction of wrong type. "
                                  "Set strict_type=False to avoid this.")
            return
        # Or convert to a string before comparison
        elif not strict_type:
            got, exp = str(got), str(exp)

        # Compare directly
        if  self.dict_compare(got, exp):
            self.errors += 1

            # Try our best to print out something useful
            strgot, strexp = str(got), str(exp)

            log.error("Received transaction differed from expected output")
            if not strict_type:
                log.info("Expected:\n" + hexdump(strexp))
            else:
                log.info("Expected:\n" + repr(exp))
            if not isinstance(exp, str):
                try:
                    for word in exp:
                        log.info(str(word))
                except Exception:
                    pass
            if not strict_type:
                log.info("Received:\n" + hexdump(strgot))
            else:
                log.info("Received:\n" + repr(got))
            if not isinstance(got, str):
                try:
                    for word in got:
                        log.info(str(word))
                except Exception:
                    pass
            log.warning("Difference:\n%s" % hexdiffs(strexp, strgot))
            if self._imm:
                raise TestFailure("Received transaction differed from expected "
                                  "transaction")
        else:
            # Don't want to fail the test
            # if we're passed something without __len__
            try:
                log.debug("Received expected transaction %d bytes" %
                          (len(got)))
                log.debug(repr(got))
            except Exception:
                pass

    def dict_compare(self,d1, d2):
        d1_keys = set(d1.keys())
        d2_keys = set(d2.keys())
        shared_keys = d1_keys.intersection(d2_keys)
        different_keys = d1_keys.symmetric_difference(d2_keys)
        if different_keys is not None: 
            cocotb.log.info(f"[HKScoreboard][dict_compare] return False because different_keys \n {d1} \n {d2}")
            self.print_expected()
            return False
        modified = {o : (d1[o], d2[o]) for o in shared_keys if d1[o] != d2[o]}
        if modified is not None:
            cocotb.log.info(f"[HKScoreboard][dict_compare] return False because modified \n {d1} \n {d2}")
            self.print_expected()
            return False
        cocotb.log.info(f"[HKScoreboard][dict_compare] return True \n {d1} \n {d2}")
        self.print_expected()
        return True

    
    def print_expected(self):
        for val in self.expected.items():
            cocotb.log.info(val)
