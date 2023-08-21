#!/bin/sh

docker run -it -v $OPENLANE_ROOT:/openlane -v $PDK_ROOT:$PDK_ROOT -v $PWD/..:/project -e PDK_ROOT=$PDK_ROOT -u $(id -u):$(id -g) efabless/openlane:2021.11.26_01.21.38 bash -c "cd /project/openlane ;flow.tcl -design $1 -tag $1 -overwrite -save -save_path ../"

