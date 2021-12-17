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

TARGET_PATH=$(pwd)/
OUT_FILE=tmp_manifest_output_file
echo "Going into $TARGET_PATH"
cd $TARGET_PATH
if [[ -f "manifest" ]]; then
    echo "Running shasum checks"
    shasum -c manifest > $OUT_FILE
    cat $OUT_FILE
    cnt=$(grep "FAILED" $OUT_FILE | wc -l)
    rm -f $OUT_FILE
    if [[ $cnt -eq 0 ]]; then exit 0; fi
    exit 2;
else
    echo "manifest file doesn't exist"
    exit 2 
fi