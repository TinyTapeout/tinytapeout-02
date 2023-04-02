#!/bin/bash
docker run --rm \
    -v $(pwd):$(pwd) \
    -v $OPENLANE_ROOT:$OPENLANE_ROOT \
    -v $PDK_ROOT:$PDK_ROOT \
    --user 1000:1000 \
    efabless/openlane:a35b64aa200c91e9eb7dde56db787d6b4c0ea12a-amd64 \
    cd $(pwd) && sh verilog/gl/sta.sh

    #sh verilog/gl/sta.sh
    #-v /home/matt/work/asic-workshop/shuttle7/openlane/designs:/openlane/install \
    #-v /home/matt/work/asic-workshop/shuttle7/pdk:/home/matt/work/asic-workshop/shuttle7/pdk \
    #-v /tmp/.X11-unix:/tmp/.X11-unix \
    #-v /home/matt/.Xauthority:/.Xauthority \

    #-e PDK_ROOT=/home/matt/work/asic-workshop/shuttle7/pdk \
    #-e OPENLANE_ROOT=/home/matt/work/asic-workshop/shuttle9/openlane \
