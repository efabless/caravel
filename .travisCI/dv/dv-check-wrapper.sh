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
export TARGET_PATH=$(pwd)
cd ../
export PDK_PATH=$(pwd)/pdks/sky130A
export PDK_ROOT=$(pwd)/pdks
export GCC_PATH=/opt/riscv32i/bin
export GCC_PREFIX=riscv32-unknown-elf

cd $TARGET_PATH

export RUN_WRAPPER=$TARGET_PATH/.travisCI/utils/run_wrapper.sh

target_dv=$1
target_id=$2

bash $RUN_WRAPPER "docker pull efabless/dv_setup:latest"

docker run -it -v $TARGET_PATH:$TARGET_PATH -v $PDK_PATH:$PDK_PATH -v $PDK_ROOT:$PDK_ROOT\
            -e TARGET_PATH=$TARGET_PATH -e PDK_PATH=$PDK_PATH -e PDK_ROOT=$PDK_ROOT -e GCC_PATH=$GCC_PATH -e GCC_PREFIX=$GCC_PREFIX  \
            -u $(id -u $USER):$(id -g $USER) efabless/dv_setup:latest \
            bash -c "bash $TARGET_PATH/.travisCI/dv/run-dv-$target_dv.sh $PDK_PATH $TARGET_PATH $target_id"

echo "DONE!"

VERDICT_FILE=$TARGET_PATH/$target_dv\_verdict.out
cat $VERDICT_FILE
if [ -f $VERDICT_FILE ]; then
        cnt=$(grep "PASS" $VERDICT_FILE -s | wc -l)
        if ! [[ $cnt ]]; then cnt = 0; fi
else
        echo "DV check failed due to subscript failure. Please review the logs";
        exit 2;
fi

echo "Verdict: $cnt"

if [[ $cnt -eq 1 ]]; then exit 0; fi
exit 2;
