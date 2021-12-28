#!/bin/sh

export OPENLANE_ROOT=$TOOLS/OpenLane ; 
export PDK_ROOT=/ciic/pdks/openlane ; 
docker run -it -v $OPENLANE_ROOT:/openlane -v $PDK_ROOT:$PDK_ROOT -v $PWD/..:/project -e PDK_ROOT=$PDK_ROOT -u $(id -u):$(id -g) efabless/openlane:$2 bash -c "cd /project/openlane ;flow.tcl -design $1  -overwrite -save -save_path ../"

