#!/bin/bash

# TODO:
# ----- 
# 1. Create an ENV.sh file to source each time mapic-cli is run. 
#    That way we don't have to worry about globals, just our own env file.
#    Need to clean up this ENV across Mapic

# get absolute path of mapic-cli.sh
D="$(readlink -f "$0")"
MAPIC_CLI_DIR=${D%/*}

# source env file
set -o allexport
source $MAPIC_CLI_DIR/env-cli.sh

usage () {
    echo "Usage: mapic [COMMAND]"
    exit 1
}
failed () {
    echo "Something went wrong: $1"
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
    echo ""
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
    echo ""
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
ssl_usage () {
    echo ""
    echo "Usage: mapic ssl [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  create      Create SSL certificates for your domain"
    echo "  scan        Run security scan on your domain and SSL"
    echo ""
    exit 1   
}
dns_usage () {
    echo ""
    echo "Usage: mapic dns [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  create       Create DNS entries on Amazon Route 53 for your domain"
    echo ""
    exit 1   
}
test_usage () {
    echo ""
    echo "Usage: mapic test [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  all         Run all available Mapic tests"
    echo "  engine      Run all Mapic Engine tests"
    echo "  mile        Run all Mapic Mile tests"
    echo "  mapicjs     Run all Mapic.js tests"
    echo "  travis      Run a build test on Travis"
    echo ""
    exit 1   
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
mapic_ssl () {
    test -z "$2" && ssl_usage
    case "$2" in
        create)     mapic_ssl_create;;
        scan)       mapic_ssl_scan;;
        *)          ssl_usage;
    esac 
}
mapic_ssl_create () {
    cd $MAPIC_ROOT_FOLDER/scripts/cli
    bash create-ssl-certs.sh
}
mapic_ssl_scan () {
    cd $MAPIC_ROOT_FOLDER/scripts/cli
    bash ssllabs-scan.sh $MAPIC_DOMAIN
}
mapic_dns () {
    test -z "$2" && dns_usage
    case "$2" in
        create)     mapic_dns_set;;
        *)          dns_usage;
    esac 
}
mapic_dns_set () {
    cd $MAPIC_ROOT_FOLDER/scripts/cli
    bash create-dns-entries-route-53.sh
}
mapic_status () {
    cd $MAPIC_ROOT_FOLDER/scripts/cli
    bash mapic-status.sh
}
mapic_test () {
    test -z "$2" && test_usage
    case "$2" in
        all)        mapic_test_all;;
        engine)     mapic_test_engine;;
        mile)       mapic_test_mile;;
        mapicjs)    mapic_test_mapicjs;;
        travis)     mapic_test_travis;;
        *)          test_usage;
    esac 
}
mapic_test_all () {
    echo "testing all"
    mapic run engine npm test || mapic_test_failed
}
mapic_test_engine () {
    echo "Not yet supported."
    exit 0;
}
mapic_test_mile () {
    echo "Not yet supported."
    exit 0;
}
mapic_test_travis() {
    echo "Not yet supported."
    exit 0;
}
mapic_test_mapicjs () {
    echo "Not yet supported."
    exit 0;
}
mapic_test_failed () {
    echo "Some tests failed";
    exit 1;
}


# instructions
mapic_help () {
    echo ""
    echo "Usage: mapic COMMAND"
    echo ""
    echo "A CLI for Mapic"
    echo ""
    echo "Commands:"
    echo "  install [domain]    Install Mapic"
    echo "  start               Start Mapic stack"
    echo "  restart             Stop, flush and start Mapic stack"
    echo "  stop                Stop Mapic stack"
    echo "  status              Display status on running Mapic stack"
    echo "  logs                Show logs of running Mapic server"
    echo "  logs dump           Dump logs of running Mapic server to disk"
    echo "  enter [filter]      Enter running container (with [filter] in grep format for finding Docker container)"
    echo "  run [filter] [cmd]  Run command inside a container."
    echo "  user                Show user information"
    echo "  ps                  Show running containers"
    echo "  dns                 Create or check DNS entries for Mapic"
    echo "  ssl                 Create or scan SSL certificates for Mapic"
    echo "  test                Run Mapic tests"
    echo "  help                This is it!"
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
    status)     mapic_status "$@";;
    logs)       mapic_logs "$@";;
    enter)      mapic_enter "$@";;
    run)        mapic_run "$@";;
    user)       mapic_user "$@";;
    ps)         mapic_ps;;
    dns)        mapic_dns "$@";;
    ssl)        mapic_ssl "$@";;
    test)       mapic_test "$@";;
    help)       mapic_help;;
    *)          mapic_help;;
esac

