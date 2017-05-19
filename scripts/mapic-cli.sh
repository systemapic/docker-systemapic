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
user_usage () {
    echo "Usage: mapic user [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  list        List registered users"
    echo "  create      Create user"
    echo "  super       Promote user to superadmin"
    echo ""
    exit 1
}
run_usage () {
    echo "Usage: mapic run [filter] [commands]"
    echo ""
    echo "Example: mapic run engine bash"
    exit 1
}
env_usage () {
    echo "You need to set MAPIC_ROOT_FOLDER and MAPIC_DOMAIN enviroment variable before you can use this script."
    exit 1
}
symlink_usage () {
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
    if [ "$2" = "" ]
    then
        if [ "$MAPIC_DOMAIN" = "" ]
        then
            install_usage
        else 
            mapic_run_install
        fi
    else 
        export MAPIC_DOMAIN=$2
        mapic_run_install
    fi

}
mapic_run_install () {
    echo "Installing Mapic to $MAPIC_DOMAIN"
    echo ""
    echo "Press Ctrl-C in next 5 seconds to cancel."
    sleep 5
    cd $MAPIC_ROOT_FOLDER/scripts/install
    bash install-to-localhost.sh
}
mapic_user () {
    [ -z "$2" ] && user_usage

    # api
    case "$2" in
        list)       mapic_user_list;;
        create)     mapic_user_create;;
        super)      mapic_user_super;;
        *)          user_usage;
    esac 
}
mapic_user_list () {
    echo "List users!"
}
mapic_user_create () {
    echo "'mapic user create' not yet supported."
}
mapic_user_super () {
    echo "'mapic user super' not yet supported."
}
mapic_run () {
    [ -z "$2" ] && run_usage
    [ -z "$3" ] && run_usage
    CONTAINER=$(docker ps -q --filter name=$2)
    [ -z "$CONTAINER" ] && enter_usage_missing_container "$@"
    docker exec $CONTAINER ${@:3}
}


# instructions
mapic_help () {
    echo ""
    echo "Usage: mapic COMMAND"
    echo ""
    echo "A CLI for Mapic"
    echo ""
    echo "Commands:"
    echo "  install [domain]    Install Mapic."
    echo "  start               Start Mapic server"
    echo "  restart             Stop, flush and start Mapic server"
    echo "  stop                Stop Mapic server"
    echo "  enter [filter]      Enter running container. Filter in grep format for finding Docker container."
    echo "  run [filter] [cmd]  Run command inside a container."
    echo "  logs                Show logs of running Mapic server"
    echo "  logs dump           Dump logs of running Mapic server to disk"
    echo "  user                Show user information"
    echo "  ps                  Show running containers"
    echo "  help                This is it."
    echo ""
    exit 0
}


# checks
test -z "$MAPIC_ROOT_FOLDER" && env_usage # check MAPIC_ROOT_FOLDER is set
test -z "$MAPIC_DOMAIN" && env_usage # check MAPIC_DOMAIN is set
test ! -f /usr/bin/mapic && symlink_usage # create symlink for global mapic
test -z "$1" && mapic_help # check for command line arguments


# api
case "$1" in
    install)    mapic_install "$@";;
    start)      mapic_start;;
    restart)    mapic_start;;
    stop)       mapic_stop;;
    enter)      mapic_enter "$@";;
    run)        mapic_run "$@";;
    logs)       mapic_logs "$@";;
    user)       mapic_user "$@";;
    help)       mapic_help;;
    ps)         mapic_ps;;
    *)          mapic_help;;
esac

