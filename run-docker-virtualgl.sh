#!/bin/bash

docker build -t vgl -f Dockerfile-vgl .

export DOCKER_IMAGE=vgl
xauth merge /etc/opt/VirtualGL/vgl_xauth_key
rm ~/.Xauthority.docker
xauth nlist $DISPLAY :0.0 | sed -e 's/^..../ffff/' | xauth -f ~/.Xauthority.docker nmerge -
docker run -it   --gpus 1   --rm   -e DISPLAY   -v ~/.Xauthority.docker:/root/.Xauthority   -v /tmp/.X11-unix:/tmp/.X11-unix   ${DOCKER_IMAGE}   bash
