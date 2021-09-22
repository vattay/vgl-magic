#!/bin/bash

export DOCKER_IMAGE=$1

docker build -t $1 -f Dockerfile-${DOCKER_IMAGE} .

xauth merge /etc/opt/VirtualGL/vgl_xauth_key
rm ~/.Xauthority.docker
xauth nlist $DISPLAY :0.0 | sed -e 's/^..../ffff/' | xauth -f ~/.Xauthority.docker nmerge -
docker run -it \
  --gpus 1 \
  --rm \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ~/.Xauthority.docker:/root/.Xauthority \
  ${DOCKER_IMAGE} \
  bash
  
