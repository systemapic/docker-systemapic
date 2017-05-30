#!/bin/bash
# 
# This script is meant for quick & easy install via:
#   'wget -qO- https://get.mapic.io/ | sh'
# or:
#   'curl -sSL https://get.mapic.io/ | sh'
#
# #

# clone mapic
git clone https://github.com/mapic/mapic.git

# install mapic-cli
cd mapic/cli && bash mapic-cli.sh

# run mapic cli
mapic
