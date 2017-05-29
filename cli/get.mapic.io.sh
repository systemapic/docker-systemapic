#!/bin/bash
#
# This script is meant for quick & easy install via:
#   'curl -sSL https://get.mapic.io/ | sh'
# or:
#   'wget -qO- https://get.mapic.io/ | sh'
#
# The source of this script lives at https://raw.githubusercontent.com/mapic/mapic/master/cli/get.mapic.io.sh
#
#


# clone mapic
git clone https://github.com/mapic/mapic.git

# install mapic-cli
cd mapic/cli && bash mapic-cli.sh

# run mapic cli
mapic install mapic