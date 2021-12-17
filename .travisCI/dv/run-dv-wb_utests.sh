#!/bin/bash
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

PDK_PATH=$1
TARGET_PATH=$2
ID=$3
WB_UTESTS_PATTERNS_1=(intercon_wb spimemio_wb storage_wb uart_wb gpio_wb la_wb mprj_ctrl sysctrl_wb spi_sysctrl_wb mem_wb mgmt_protect chip_io)

VERDICT_FILE=$TARGET_PATH/wb_utests_verdict.out
OUT_FILE=$TARGET_PATH/wb_utests_dv.$ID.out

case $ID in

  1)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${WB_UTESTS_PATTERNS_1[@]}" . wb_utests 1 $TARGET_PATH
    len=${#WB_UTESTS_PATTERNS_1[@]}
    tot=$(( len*2 ))
    ;;

  *)
    echo -n "unknown ID $ID"
    exit 2
    ;;
esac

cnt=$(grep -i "Passed" $OUT_FILE | wc -l)


echo "array length: $len"
echo "total passed expected: $tot"
echo "passed found: $cnt"
if [[ $cnt -eq $tot ]]; then echo "PASS" > $VERDICT_FILE; exit 0; fi

echo "FAIL" > $VERDICT_FILE


echo "Total Verdict File:"
cat $VERDICT_FILE

exit 0
