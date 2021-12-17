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
block=$1
export IMAGE_NAME=efabless/openlane:$OPENLANE_TAG
export CARAVEL_PATH=$(pwd)
cd ../
export PDK_ROOT=$(pwd)/pdks
cd $CARAVEL_PATH
export PDKPATH=$PDK_ROOT/sky130A
make uncompress

# LVS
BLOCKS=($block)
if [ $block == all ]; then
        BLOCKS=$(cd openlane && find * -maxdepth 0 -type d ! -name "caravel" ! -name "caravan" ! -name "chip_io_alt" ! -name "chip_io" ! -name "mgmt_core" ! -name "user_project_wrapper_empty" ! -name "user_analog_project_wrapper_empty")
fi

echo "Running Full LVS:"
for BLOCK in ${BLOCKS[*]}
do
        echo "Running Full LVS on block $BLOCK:"
        docker run -it -v $CARAVEL_PATH:$CARAVEL_PATH -e CARAVEL_PATH=$CARAVEL_PATH -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) $IMAGE_NAME  bash -c "cd $CARAVEL_PATH; make lvs-$BLOCK"

        lvs_report=$CARAVEL_PATH/spi/lvs/tmp/$BLOCK.lvs.summary.log
        if [ -f $lvs_report ]; then
                lvs_total_errors=$(grep "Total errors =" $lvs_report -s | tail -1 | sed -r 's/[^0-9]*//g')
                if ! [[ $lvs_total_errors ]]; then lvs_total_errors=0; fi
        else
                echo "lvs check failed due to netgen failure";
                exit 2;
        fi

        echo "LVS summary:"
        cat $lvs_report
        echo "Total Count: $lvs_total_errors"
        if [[ $BLOCK != caravel ]] &&  [[ $BLOCK != caravan ]] ; then
                if [[ $lvs_total_errors -ne 0 ]]; then exit 2; fi
        else
                if [[ $lvs_total_errors -gt 7 ]]; then exit 2; fi
        fi
done
echo "All LVS checks on all blocks passed!"

exit 0
