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

USER_PROJ_EXAMPLE_PATTERNS_1=(io_ports la_test2)
USER_PROJ_EXAMPLE_PATTERNS_2=(la_test1)


VERDICT_FILE=$TARGET_PATH/user_proj_example_verdict.out
OUT_FILE=$TARGET_PATH/user_proj_example_dv.$ID.out

case $ID in

  1)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${USER_PROJ_EXAMPLE_PATTERNS_1[@]}" caravel user_proj_example 1 $TARGET_PATH
    len=${#USER_PROJ_EXAMPLE_PATTERNS_1[@]}
    export TOTAL=$(( 2*(len) ))
    ;;

  2)
    bash $TARGET_PATH/.travisCI/dv/run-dv-set.sh $PDK_PATH "${USER_PROJ_EXAMPLE_PATTERNS_2[@]}" caravel user_proj_example 2 $TARGET_PATH
    len=${#USER_PROJ_EXAMPLE_PATTERNS_2[@]}
    export TOTAL=$(( 2*(len) ))
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

