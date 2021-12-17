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
cd ..
export PDK_ROOT=$(pwd)/precheck_pdks
cd $TARGET_PATH/open_mpw_precheck/

docker run -v $(pwd):/usr/local/bin -v $TARGET_PATH:$TARGET_PATH -v $PDK_ROOT:$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/open_mpw_precheck:latest bash -c "python3 open_mpw_prechecker.py -p $PDK_ROOT -t $TARGET_PATH"
output=$TARGET_PATH/checks/full_log.log

gzipped_file=$TARGET_PATH/checks/full_log.log.gz

if [[ -f $gzipped_file ]]; then
    gzip -d $gzipped_file
fi

grep "Violation Message" $output

cnt=$(grep -c "All Checks PASSED!" $output)
if ! [[ $cnt ]]; then cnt=0; fi
if [[ $cnt -eq 1 ]]; then exit 0; fi
exit 2
