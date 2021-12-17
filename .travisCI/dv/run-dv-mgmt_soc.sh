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
MGMT_SOC_PATTERNS_1=(gpio perf hkspi sysctrl)
MGMT_SOC_PATTERNS_2=(mprj_ctrl pass_thru user_pass_thru storage)
MGMT_SOC_PATTERNS_3=(uart irq)
MGMT_SOC_PATTERNS_4=(timer timer2 caravan)
MGMT_SOC_PATTERNS_5=(mem pll qspi)

VERDICT_FILE=$TARGET_PATH/mgmt_soc_verdict.out
OUT_FILE=$TARGET_PATH/mgmt_soc_dv.$ID.out

case $ID in

  1)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${MGMT_SOC_PATTERNS_1[@]}" caravel mgmt_soc 1 $TARGET_PATH
    len=${#MGMT_SOC_PATTERNS_1[@]}
    export TOTAL=$(( 2*len ))
    ;;

  2)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${MGMT_SOC_PATTERNS_2[@]}" caravel mgmt_soc 2 $TARGET_PATH
    len=${#MGMT_SOC_PATTERNS_2[@]}
    export TOTAL=18
    ;;

  3)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${MGMT_SOC_PATTERNS_3[@]}" caravel mgmt_soc 3 $TARGET_PATH
    len=${#MGMT_SOC_PATTERNS_3[@]}
    export TOTAL=$(( 2*len ))
    ;;

  4)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${MGMT_SOC_PATTERNS_4[@]}" caravel mgmt_soc 4 $TARGET_PATH
    len=${#MGMT_SOC_PATTERNS_4[@]}
    export TOTAL=$(( 2*len ))
    ;;

  5)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${MGMT_SOC_PATTERNS_5[@]}" caravel mgmt_soc 5 $TARGET_PATH
    len=${#MGMT_SOC_PATTERNS_5[@]}
    export TOTAL=10
    ;;

  *)
    echo -n "unknown ID $ID"
    exit 2
    ;;
esac

cnt=$(grep -i "Passed" $OUT_FILE | wc -l)


echo "total passed expected: $TOTAL"
echo "passed found: $cnt"
if [[ $cnt -eq $TOTAL ]]; then echo "PASS" > $VERDICT_FILE; exit 0; fi

echo "FAIL" > $VERDICT_FILE


echo "Total Verdict File:"
cat $VERDICT_FILE

exit 0
