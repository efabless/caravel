import re
import sys
from tokenize import group
from unittest.util import _MIN_COMMON_LEN 
import string
import cocotb
import os
class Regs:
    def __init__(self):
        pass

    def get_addr(self,reg):
        search1 = self.get_add_defs(reg)
        # if all(c in string.hexdigits for c in search1[2:]): 
        return int(search1,16)
        # return hex(self.get_hexa(search1))
        

    """get address from defs.h"""
    def get_add_defs(self,reg):
        pattern = re.compile(rf'#define {reg}\s*\(\*\(volatile uint32_t\*\)\s*(.*)\s*\)')
        with open(f'{os.getenv("FIRMWARE_PATH")}/defs.h') as f:
            for line in f:
                m= re.search(pattern,line)
                if m:
                    break
        if m:
            if not all(c in string.hexdigits for c in m.group(1)): 
                return hex(self.get_hexa(m.group(1)))
            else:           
                return m.group(1) 
        else: 
            cocotb.log.info(f" [defsParser] can't find {reg} inside defs")
            sys.exit()
            
    """get address from defs.h"""
    def get_add_csr(self,reg):
        pattern1 = re.compile(rf'#define {reg}\s*\(\*\(volatile uint32_t\*\)\s*(.*)\s*\)')
        pattern2 = re.compile(rf'#define {reg}\s*(.*)')
        m = False
        with open(f'{os.getenv("FIRMWARE_PATH")}/../generated/csr.h') as f:
            for line in f:
                m1= re.search(pattern1,line)
                m2= re.search(pattern2,line)
                if m1:
                    m = m1
                    break
                if m2: 
                    m=m2
                    break
        if m:
            matched_str= m.group(1)
            if matched_str[-1] == "L" and matched_str[-2].isnumeric:
                matched_str = matched_str[:-1]
            if not all(c in string.hexdigits for c in matched_str[2:]): 
                matched_str= hex(self.get_hexa(matched_str))
                       
            return matched_str 
        else: 
            cocotb.log.info(f" [defsParser] can't find {reg} inside csr")
            sys.exit()


    def get_hexa(self,s:string):
        pattern2 = re.compile(r'\((.*)\s*\+\s*(.*)\)')
        search_match = re.search(pattern2,s)
        if search_match :
            matches = [search_match.group(1),search_match.group(2)]
        else:
            matches = [s]
        nothex = 1
        while nothex:
            nothex = 0
            for i,match in enumerate(matches):
                if not all(c in string.hexdigits for c in match[2:-1]): 
                    matches[i]=self.get_add_csr(match)
                    nothex = 0
                else:
                    if match[-1] == "L" and match[-2].isnumeric:
                        matches[i]=matches[i][:-1]
                    
        if len(matches) ==2:
            return int(matches[0],16) + int(matches[1],16)
        else: 
            return int(matches[0],16) 


