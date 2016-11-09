#!/bin/bash

# get working dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

clear
echo "                      ----------------------------------------                            "          
echo "                   +ssyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyso:                         "          
echo "                  syyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy/   //-                  "          
echo "                 -yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyys   ++-                  "          
echo "                 -yyysooysooosyyoooosyyyysooooooyyyyyoossoooosyyys                        "          
echo "                 -yyyo  :     /-     +yyyo       oyyy  -      /sys  +os+    :oo++++:      "          
echo "                 -yyyo   oss:  :sss-  yyyysssso-  yyy   +sss+  /ys   :yo   /yo            "          
echo "                 -yyyo  oyyy+  syyy+  syyo:       yyy  -yyyyy   ys   :yo   yy-            "          
echo "                 -yyyo  oyyyo  syyy+  syo  :ooo:  yyy  -yyyys  -ys   :yo   yy-            "          
echo "                 -yyyo  oyyyo  syyy+  sy+  +sss:  yyy  -ssso-  oys   :yo   /yo-           "          
echo "                 -yyyo  syyyo  syyy+  syy/        yyy        :oyys   -s+    -+oo+++/      "          
echo "                 -yyyyssyyyyyssyyyysssyyyyysooosssyyy  -ooosyyyyys                        "          
echo "                 -yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy  -yyyyyyyyys                        "          
echo "                  syyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: /yyyyyyyyy/                        "          
echo "                   /ssssssssssssssssssssssssssssssssssssssssssso-                         "          
echo "                                                                                          "                
echo ""
echo ""    
echo "=========================================================================================="
echo "======================== Welcome to Mapic localhost installation ========================="
echo "=========================================================================================="
echo ""
echo "(Grab a coffee, this might take a while! No interaction necessary. Estimated installation time is 30 minutes.)"
echo ""
echo "Installing to localhost:"
echo "------------------------"
echo ""
echo "# Current working directory: $DIR"
echo ""
echo "# Downloading code..."
echo ""

print_log () {
    echo ""
    echo "$1"
    echo "___________________________"
    echo ""
}

# init mapic/mapic submodule
cd $DIR 
git submodule init
git submodule update --recursive --remote
git submodule foreach --recursive git checkout master

# init mapic/mile submodule
cd $DIR/modules/mile
git submodule init
git submodule update --recursive --remote

# init mapic/engine submodule
cd $DIR/modules/engine
git submodule init
git submodule update --recursive --remote

# init mapic/mapic.js submodule
cd $DIR/modules/mapic.js
git submodule init
git submodule update --recursive --remote

# init mapic/sdk submodule
cd $DIR/modules/sdk
git submodule init
git submodule update --recursive --remote


print_log "# Creating SSL certficate..."
docker run --rm -it --name openssl \
  -v $DIR/config/localhost:/certs \
  wallies/openssl \
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /certs/ssl_certificate.key -out /certs/ssl_certificate.pem -subj "/C=NO/ST=Oslo/L=Oslo/O=Mapic/OU=IT Department/CN=localhost"

export MAPIC_DOMAIN=localhost

# update config
print_log "# Updating configuration..."
cd $DIR/scripts
node update-configs.js

print_log "# Creating storage containers..."
cd $DIR/docker/compose/
./create-storage-containers.sh

print_log "# Starting Mapic server..."
./start-containers.sh --no-logs

print_log "# Running tests..."
cd $DIR/scripts
./run-localhost.tests.sh

print_log "# Opening logs..."
cd $DIR/docker/compose/
./show-logs.sh


