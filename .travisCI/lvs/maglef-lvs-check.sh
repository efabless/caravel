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

export IMAGE_NAME=efabless/openlane:$OPENLANE_TAG
export CARAVEL_PATH=$(pwd)
cd ../
export PDK_ROOT=$(pwd)/pdks
cd $CARAVEL_PATH
export PDKPATH=$PDK_ROOT/sky130A
make uncompress

# MAGLEF LVS
echo "Running Abstract (maglef) LVS:"
docker run -it -v $CARAVEL_PATH:$CARAVEL_PATH -e CARAVEL_PATH=$CARAVEL_PATH -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) $IMAGE_NAME  bash -c "cd $CARAVEL_PATH; make lvs-maglef-caravel"

lvs_report=$CARAVEL_PATH/spi/lvs/tmp/caravel.maglef.lvs.summary.log
if [ -f $lvs_report ]; then
        lvs_total_errors=$(grep "Total errors =" $lvs_report -s | tail -1 | sed -r 's/[^0-9]*//g')
        if ! [[ $lvs_total_errors ]]; then lvs_total_errors=0; fi
else
        echo "lvs check failed due to netgen failure";
        exit 2;
fi

echo "Maglef LVS summary:"
cat $lvs_report
echo "Total Count: $lvs_total_errors"

if [[ $lvs_total_errors -eq 0 ]]; then exit 0; fi
exit 2
