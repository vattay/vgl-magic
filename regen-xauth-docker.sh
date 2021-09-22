#!/bin/bash

xauth merge /etc/opt/VirtualGL/vgl_xauth_key
rm ~/.Xauthority.docker
xauth nlist $DISPLAY :0.0 | sed -e 's/^..../ffff/' | xauth -f ~/.Xauthority.docker nmerge -
