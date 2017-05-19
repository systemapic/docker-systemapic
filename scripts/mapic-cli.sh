#!/bin/bash
usage () {
    echo "Usage: mapic [COMMAND]"
    exit 1
}
enter_usage () {
    echo "Usage: mapic enter [filter]"
    exit 1
}
enter_usage_missing_container () {
    echo "No container matched filter: $2" 
    exit 1
}
install_usage () {
    echo "Usage: mapic install [domain] (or set \$MAPIC_DOMAIN env variable)"
    exit 1
}
env_not_set () {
    echo "You need to set MAPIC_ROOT_FOLDER and MAPIC_DOMAIN enviroment variable before you can use this script."
    exit 1
}
symlink_not_set () {
    ln -s $MAPIC_ROOT_FOLDER/scripts/mapic-cli.sh /usr/bin/mapic
    echo "Self-registered as global command."
    usage;
}

# mapic-cli functions
mapic_ps () {
    docker ps 
    exit 0
}
mapic_start () {
    cd $MAPIC_ROOT_FOLDER
    ./restart-mapic.sh
}
mapic_stop () {
    cd $MAPIC_ROOT_FOLDER
    ./stop-mapic.sh
}
mapic_logs () {
    if [ "$2" == "dump" ]; then
        # dump logs to disk
        cd $MAPIC_ROOT_FOLDER/scripts/log
        bash dump-logs.sh
        exit 0
    else
        # print logs to console
        cd $MAPIC_ROOT_FOLDER/scripts/log
        bash show-logs.sh
    fi
}
mapic_enter () {
    [ -z "$1" ] && enter_usage
    CONTAINER=$(docker ps -q --filter name=$2)
    [ -z "$CONTAINER" ] && enter_usage_missing_container "$@"
    docker exec -it $CONTAINER bash
}
mapic_install () {
    # ensure either $MAPIC_DOMAIN is set, or arg for domain is passed
    # todo: better sanity checks for domain, maybe confirm
    if [ "$MAPIC_DOMAIN" = "" ]
    then
        if [ "$2" = "" ] 
        then
            install_usage
        else
            export MAPIC_DOMAIN=$2
            run_mapic_install
        fi
    else
       run_mapic_install
    fi
}
run_mapic_install () {
    echo "running install $MAPIC_DOMAIN"
}
mapic_help () {
    echo ""
    echo "Usage: mapic COMMAND"
    echo ""
    echo "A CLI for Mapic"
    echo ""
    echo "Commands:"
    echo "  start           Start Mapic server"
    echo "  restart         Stop, flush and start Mapic server"
    echo "  stop            Stop Mapic server"
    echo "  enter [filter]  Enter running container. Filter in grep format for finding Docker container."
    echo "  logs            Show logs of running Mapic server"
    echo "  ps              Show running containers"
    echo "  install         Install Mapic."
    echo "  help            This is it."
    echo ""
    exit 0
}


# checks
test -z "$MAPIC_ROOT_FOLDER" && env_not_set # check MAPIC_ROOT_FOLDER is set
test -z "$MAPIC_DOMAIN" && env_not_set # check MAPIC_DOMAIN is set
test ! -f /usr/bin/mapic && symlink_not_set # create symlink for global mapic
test -z "$1" && mapic_help # check for command line arguments


# api
case "$1" in
    start)      mapic_start;;
    restart)    mapic_start;;
    stop)       mapic_stop;;
    enter)      mapic_enter "$@";;
    logs)       mapic_logs "$@";;
    install)    mapic_install "$@";;
    help)       mapic_help;;
    ps)         mapic_ps;;
    *)          mapic_help;;
esac

