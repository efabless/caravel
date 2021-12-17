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

set -e

echo "Current git status"

git status

echo "Deleting README.rst & openlane/README.rst"
rm -rf README.rst
rm -rf openlane/README.rst

echo "Running make README.rst"
make README.rst -B

echo "New git status"
TMP_FILE=git_dif_tmp_file
git diff > $TMP_FILE

git status

echo "git diff:"
cat $TMP_FILE

cnt=$(cat $TMP_FILE | wc -l)
echo $cnt
rm -f $TMP_FILE
if [[ $cnt -gt 1 ]]; then exit 2; fi
exit 0
