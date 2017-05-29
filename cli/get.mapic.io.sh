#!/bin/bash
#
# This script is meant for quick & easy install via:
#   'curl -sSL https://get.mapic.io/ | sh'
# or:
#   'wget -qO- https://get.mapic.io/ | sh'
#

# install mapic cli
git clone git@github.com:mapic/mapic.git
cd mapic/cli
bash mapic-cli.sh

# run mapic cli
mapic install 