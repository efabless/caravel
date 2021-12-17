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
export RUN_WRAPPER=$TARGET_PATH/.travisCI/utils/run_wrapper.sh
cd ..
export PDK_ROOT=$(pwd)/pdks
export OPENLANE_ROOT=$(pwd)/openlane
cd $TARGET_PATH
export TARGET_MACRO=$1
export logFile=$TARGET_MACRO.run.log
make uncompress
cd openlane

bash $RUN_WRAPPER "make $TARGET_MACRO" 2>&1 | tee $logFile

rm -rf $TARGET_MACRO/runs

cnt=$(grep -c "Flow Completed Without Fatal Errors" $logFile)
if ! [[ $cnt ]]; then cnt=0; fi
if [[ $cnt -eq 1 ]]; then exit 0; fi
exit 2
