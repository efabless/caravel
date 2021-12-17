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
export RUN_ROOT=$(pwd)


# By default skip timing since we don't need the libs in any of the CI tests
export SKIP_TIMING=${1:-1}
export IMAGE_NAME=efabless/openlane:$OPENLANE_TAG
docker pull $IMAGE_NAME

cd $RUN_ROOT/..
export PDK_ROOT=$(pwd)/pdks
mkdir $PDK_ROOT
echo $PDK_ROOT
echo $RUN_ROOT
cd $RUN_ROOT
make skywater-pdk
make skywater-library
# The following section is for running on the CI.
# If you're running locally you should replace them with: `make skywater-library`
# This is because sometimes while setting up the conda env (skywater's make timing) it fails to fetch something
# Then it exits without retrying. So, here we're retrying, and if something goes wrong it will exit after 5 retries.
# Section Begin
if [ $SKIP_TIMING -eq 0 ]; then
	cnt=0
	until make skywater-timing; do
	cnt=$((cnt+1))
	if [ $cnt -eq 5 ]; then
		exit 2
	fi
	rm -rf $PDK_ROOT/skywater-pdk
	make skywater-pdk
	make skywater-library
	done
fi
# Section End

make open_pdks
docker run -it -v $RUN_ROOT:/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT $IMAGE_NAME  bash -c "yum install -y https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm ; yum install -y git; make build-pdk"
echo "done installing"
cd $RUN_ROOT
exit 0
