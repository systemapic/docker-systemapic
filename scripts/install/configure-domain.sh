#!/bin/bash

# docker create helper
install_mapic() {
    echo "Cloning default configuration..."
    
    export MAPIC_DOMAIN # todo: check that domain string is sane

    # get default config
    git clone https://github.com/mapic/config-$MAPIC_DOMAIN.git || abort "Unable to get the $MAPIC_DOMAIN config. Check your internet connection. Quitting!"
    
    # rename
    mv config-$MAPIC_DOMAIN $MAPIC_DOMAIN || abort "Folder already exists. Quitting!"

    # enter folder
    cd $MAPIC_DOMAIN

    # renanme nginx config
    mv domain.example.com.nginx.conf $MAPIC_DOMAIN.nginx.conf
    rm nginx.conf
    ln -s $MAPIC_DOMAIN.nginx.conf nginx.conf

    # get ip
    IP="`wget http://ipinfo.io/ip -qO -`"
    echo "Your IP is $IP"

    # edit dns config file
    cd dns
    cp config.template.json config.json
    nano config.json

    

}

abort() {
    echo $1;
    exit;
}

echo ""
echo "Welcome to the automagic installation of Mapic to your hosted domain."
echo ""
echo "Just enter your desired domain, and I will take care of the rest:"
echo ""

read -p "Which domain do you wish to use for Mapic? (Example: domain.example.com)  > " -e MAPIC_DOMAIN

while true; do
    echo ""
    read -p "Do you want to install Mapic to [https://$MAPIC_DOMAIN]? " yn
    case $yn in
        [Yy]* ) install_mapic; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


