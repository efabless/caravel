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

PDK_PATH=$1; shift
PATTERNS=( "$@" )
last_idx=$(( ${#PATTERNS[@]} - 1 ))
TARGET_PATH=${PATTERNS[$last_idx]}
unset PATTERNS[$last_idx]
last_idx=$(( ${#PATTERNS[@]} - 1 ))
ID=${PATTERNS[$last_idx]}
unset PATTERNS[$last_idx]
last_idx=$(( ${#PATTERNS[@]} - 1 ))
TARGET_DV=${PATTERNS[$last_idx]}
unset PATTERNS[$last_idx]
last_idx=$(( ${#PATTERNS[@]} - 1 ))
PARENT=${PATTERNS[$last_idx]}
unset PATTERNS[$last_idx]


echo "arg1=$PDK_PATH"
echo "arg2=$PARENT"
echo "arg3=$TARGET_DV"
echo "arg4=$ID"
echo "arg5=$TARGET_PATH"
echo "PATTERNS contains:"
printf "%s\n" "${PATTERNS[@]}"

export RUN_WRAPPER=$TARGET_PATH/.travisCI/utils/run_wrapper.sh

OUT_FILE=$TARGET_PATH/$TARGET_DV\_dv.$ID.out
cd $TARGET_PATH/verilog/dv/$PARENT/$TARGET_DV;
touch $OUT_FILE
for PATTERN in ${PATTERNS[*]}
do
    echo "Executing DV on $PATTERN";
    cd $PATTERN;
    for x in RTL GL
    do
        export SIM=$x
        echo "Running $PATTERN $SIM.."
        logFile=$TARGET_PATH/$TARGET_DV\_$PATTERN.$SIM.dv.out
        bash $RUN_WRAPPER "make" 2>&1 | tee $logFile
        grep "Monitor" $logFile >> $OUT_FILE
        make clean
    done
    echo "Execution Done on $PATTERN!"
    cd ..;
done

cat $OUT_FILE

exit 0
