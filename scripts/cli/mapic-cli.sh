#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
#   _________  ____  / /______(_) /_  __  __/ /_(_)___  ____ _
#  / ___/ __ \/ __ \/ __/ ___/ / __ \/ / / / __/ / __ \/ __ `/
# / /__/ /_/ / / / / /_/ /  / / /_/ / /_/ / /_/ / / / / /_/ / 
# \___/\____/_/ /_/\__/_/  /_/_.___/\__,_/\__/_/_/ /_/\__, /  
#                                                    /____/   
#
#   To whomever is using this script, feel free to add more scripts and wrappers. 
#   Look at the syntax and organisation of other functions, or follow these steps:
# 
#   How to add more scripts/commands:
#       1. fork this repo
#       2. add entry in mapic_cli_usage
#       3. add entry in mapic_cli
#       4. add your script in your own command (see other examples)
#       5. put script-file.sh in /cli/ or relevant subfolder (install, config, etc)
#       6. create PR @ https://github.com/mapic/mapic-cli
#       
#       (For "cool" ascii art text, see: http://patorjk.com/software/taag/#p=display&f=Slant&t=mapic)
#       (Tracking issue: https://github.com/mapic/mapic/issues/27)
#
#
#   / /_____  ____/ /___ 
#  / __/ __ \/ __  / __ \
# / /_/ /_/ / /_/ / /_/ /
# \__/\____/\__,_/\____/ 
#
# 1. (DONE!) Create an ENV.sh file to source each time mapic-cli is run. 
#    That way we don't have to worry about globals, just our own env file.
#    Need to clean up this ENV across Mapic
# 2. (DONE!) Prompt and contiune on missing $MAPIC_DOMAIN 
# 3. Install flow, work seamlessly with `mapic install [OPTIONS]`. Also for travis (`mapic install --travis [OPTIONS]`)
# 4. Create own repo for mapic-cli eventually
#
#
#
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  




#   _____/ (_)
#  / ___/ / / 
# / /__/ / /  
# \___/_/_/      
mapic_cli_usage () {
    echo ""
    echo "Usage: mapic COMMAND"
    echo ""
    echo "A CLI for Mapic"
    echo ""
    echo "Management commands:"
    echo "  start               Start Mapic stack"
    echo "  restart             Stop, flush and start Mapic stack"
    echo "  stop                Stop Mapic stack"
    echo "  status              Display status on running Mapic stack"
    echo "  logs                Show logs of running Mapic server"
    echo "  logs dump           Dump logs of running Mapic server to disk"
    echo "  test                Run Mapic tests"
    echo ""
    echo "Commands:"
    echo "  install             Install Mapic"
    echo "  config              Configure Mapic"
    echo "  env                 Get and set Mapic environment variables"
    echo "  dns                 Create or check DNS entries for Mapic"
    echo "  ssl                 Create or scan SSL certificates for Mapic"
    echo "  enter               Enter running container"
    echo "  run                 Run command inside a container"
    echo "  grep                Find string in files in subdirectories of current path"
    echo "  ps                  Show running containers"
    echo ""
    echo "API commands:"
    echo "  api user            Handle Mapic users"
    echo "  api upload          Upload data"  
    echo ""
    exit 0
}
mapic_cli () {

    # source n check
    source_env "$@"
    check "$@"

    case "$1" in

        # documented API
        install)    mapic_install "$@";;
        start)      mapic_start;;
        restart)    mapic_start;;
        stop)       mapic_stop;;
        status)     mapic_status "$@";;
        logs)       mapic_logs "$@";;
        enter)      mapic_enter "$@";;
        run)        mapic_run "$@";;
        api)        mapic_api "$@";;
        ps)         mapic_ps;;
        dns)        mapic_dns "$@";;
        ssl)        mapic_ssl "$@";;
        test)       mapic_test "$@";;
        home)       mapic_home "$@";;
        config)     mapic_config "$@";;
        grep)       mapic_grep "$@";;
        help)       mapic_cli_usage;;
        --help)     mapic_cli_usage;;
        -h)         mapic_cli_usage;;
        env)        mapic_env "$@";;
    
        *)          mapic_wild "$@";;
    esac
}

#    _______________(_)___  / /_   __  __/ /_(_) /____
#   / ___/ ___/ ___/ / __ \/ __/  / / / / __/ / / ___/
#  (__  ) /__/ /  / / /_/ / /_   / /_/ / /_/ / (__  ) 
# /____/\___/_/  /_/ .___/\__/   \__,_/\__/_/_/____/  
#                 /_/                                  
check () {
    test -z "$MAPIC_ROOT_FOLDER" && env_usage # check MAPIC_ROOT_FOLDER is set
    test -z "$MAPIC_DOMAIN" && env_usage # check MAPIC_DOMAIN is set
    test ! -f /usr/bin/mapic && symlink_usage # create symlink for global mapic
    test -z "$1" && mapic_cli_usage # check for command line arguments
}
source_env () {
    # get absolute path of mapic-cli.sh
    D="$(readlink -f "$0")"
    MAPIC_CLI_FOLDER=${D%/*}

    # source env file
    MAPIC_ENV_FILE=$MAPIC_CLI_FOLDER/.mapic.env
    set -o allexport
    source $MAPIC_ENV_FILE

    # set which folder mapic was executed from
    MAPIC_CLI_PWD=$PWD
}

                  
#  / _ \/ __ \ | / /
# /  __/ / / / |/ / 
# \___/_/ /_/|___/  
mapic_env_usage () {
    echo ""
    echo "Usage: mapic env COMMAND"
    echo ""
    echo "Commands:"
    echo "  set [key] [value]       Set an environment variable. See 'mapic env set --help' for more."
    echo "  get [key]               Get an environment variable. Do 'mapic get' to list all variables."
    echo "  edit                    Edit ENV directly in your favorite editor. (Set editor with MAPIC_DEFAULT_EDITOR env, "
    echo "  file                    Returns absolute path of Mapic ENV file, useful for scripts and '--env-file'"
    echo "                          eg. 'mapic env set MAPIC_DEFAULT_EDITOR nano')"
    echo ""
    echo "Use with caution. Variables are sourced to Mapic environment."
    echo ""
    exit 0
}
mapic_env () {
    test -z $2 && mapic_env_usage
    case "$2" in
        get)        mapic_env_get "$@";;
        set)        mapic_env_set "$@";;
        edit)       mapic_env_edit "$@";;
        file)       mapic_env_file "$@";;
        prompt)     mapic_env_prompt "$@";;
        *)          mapic_env_usage;
    esac 
}
mapic_env_set_usage () {
    echo ""
    echo "Usage: mapic env set [OPTIONS] KEY VALUE"
    echo ""
    echo "Options:"
    echo "  --silent        Silent"
    echo "  --return-value  Return only set environment value (instead of default VALUE=KEY)"
    echo "  --help          More information about possible ENV variables"
    echo ""
    echo "Use with caution. Variables are sourced to Mapic environment."
    echo ""
    exit 0
}
mapic_env_set () {
    test -z $3 && mapic_env_set_usage
    case "$3" in
        --help)           mapic_env_set_usage "$@";;
        --silent)         mapic_env_set_silent "$@";;
        --return-value)   mapic_env_set_return_value "$@";;
        *)                mapic_env_set_default "$@";
    esac 
}
mapic_env_set_silent () {
    mapic_env_set_internal $4 $5 "silent"
}
mapic_env_set_default () {
    mapic_env_set_internal $3 $4
}
mapic_env_set_return_value () {
    mapic_env_set_internal $4 $5 "value"
}
mapic_env_set_internal () {

    # check
    ENV_KEY=$1
    ENV_VALUE=$2
    FLAG=$3
    test "$ENV_KEY" == "--help" && mapic_env_set_help
    test -z "$ENV_KEY" && mapic_env_set_usage

    # update env file
    cd $MAPIC_CLI_FOLDER

    # if KEY already exists
    if grep -q "$ENV_KEY" "$MAPIC_ENV_FILE"; then
        sed -i "/$ENV_KEY/c\\$ENV_KEY=$ENV_VALUE" $MAPIC_ENV_FILE
    
    # if KEY does not exist
    else
        echo "$ENV_KEY"="$ENV_VALUE" >> $MAPIC_ENV_FILE
    fi

    # ensure newline
    sed -i -e '$a\' $MAPIC_ENV_FILE
    
    # source new env
    source_env

    # confirm new variable
    [[ "$FLAG" = "" ]] && mapic env get $ENV_KEY
    [[ "$FLAG" = "value" ]] && echo $ENV_VALUE

    exit 0
}
mapic_env_set_help () {
    echo ""
    echo "Usage: mapic env set KEY VALUE"
    echo ""
    echo "Example: mapic env set MAPIC_DOMAIN localhost"
    echo ""
    echo "Possible environment variables options:"
    echo "  MAPIC_DOMAIN                    The domain which Mapic is running on, eg. 'maps.mapic.io' "
    echo "  MAPIC_USER_EMAIL                Your email. Only used for creating SSL certificates for now."
    echo "  MAPIC_IP                        Public IP of your server. Set automatically by default."
    echo "  MAPIC_AWS_ACCESSKEYID           Amazon AWS credentials: Access Key Id"
    echo "  MAPIC_AWS_SECRETACCESSKEY       Amazon AWS credentials: Secret Access Key"
    echo "  MAPIC_AWS_HOSTED_ZONE_DOMAIN    Amazon Route53 Zone Domain. Used for creating DNS entries with Route53."
    echo "  MAPIC_DEBUG                     Debug switch, used arbitrarily."
    echo "  MAPIC_ROOT_FOLDER               Folder where 'mapic' root lives. Set automatically."
    echo ""
    echo "  See 'mapic env get' for all variables"
    echo ""
    exit 0
}
mapic_env_get () {
    if [ -z $3 ]
    then
        cat $MAPIC_ENV_FILE 
    else 
        cat $MAPIC_ENV_FILE | grep "$3="
    fi
    exit 0
}
mapic_env_edit () {
    test -z $MAPIC_DEFAULT_EDITOR && mapic env set MAPIC_DEFAULT_EDITOR nano
    $MAPIC_DEFAULT_EDITOR $MAPIC_ENV_FILE
    exit 0
}
mapic_env_file () {
    echo "$MAPIC_ENV_FILE"
}
mapic_env_prompt () {
    ENV_KEY=$3
    MSG=$4
    DEFAULT_VALUE=$5
    test -z $ENV_KEY && mapic_env_prompt_usage

    # prompt
    echo ""
    read -e -p "$ENV_KEY $MSG: " -i "$DEFAULT_VALUE" ENV_VALUE

    # set env
    test -n $ENV_VALUE && mapic env set $ENV_KEY $ENV_VALUE 

    exit 0
}
mapic_env_prompt_usage () {
    echo ""
    echo "Usage: mapic env prompt ENV_KEY [MESSAGE] [DEFAULT_VALUE]"
    echo ""
    echo "Prompt user for Mapic environment variable and set it permanently"
    echo ""
    echo "Options:"
    echo "  ENV_KEY         The environment key to set"
    echo "  MESSAGE         A message to diplay at prompt"
    echo "  DEFAULT_VALUE   The default provided value"
    echo ""
    exit 1
}
usage () {
    echo "Usage: mapic [COMMAND]"
    exit 1
}
failed () {
    echo "Something went wrong: $1"
    exit 1
}
env_usage () {
    echo "You need to set MAPIC_DOMAIN environment variable before you can use this script."
    # todo: prompt and continue
    exit 1
}
symlink_usage () {
    ln -s $MAPIC_ROOT_FOLDER/scripts/cli/mapic-cli.sh /usr/bin/mapic
    echo "Self-registered as global command (/usr/bin/mapic)"
    mapic_cli_usage;
}

               
#    / __ \/ ___/
#   / /_/ (__  ) 
#  / .___/____/  
# /_/            
mapic_ps () {
    docker ps 
    exit 0
}

#    _____/ /_____ ______/ /_
#   / ___/ __/ __ `/ ___/ __/
#  (__  ) /_/ /_/ / /  / /_  
# /____/\__/\__,_/_/   \__/  
mapic_start () {
    cd $MAPIC_CLI_FOLDER
    bash restart-mapic.sh
}

#    _____/ /_____  ____ 
#   / ___/ __/ __ \/ __ \
#  (__  ) /_/ /_/ / /_/ /
# /____/\__/\____/ .___/ 
#               /_/      
mapic_stop () {
    cd $MAPIC_CLI_FOLDER
    bash stop-mapic.sh
}

#    / /___  ____ ______
#   / / __ \/ __ `/ ___/
#  / / /_/ / /_/ (__  ) 
# /_/\____/\__, /____/  
#         /____/        
mapic_logs () {
    if [ "$2" == "dump" ]; then
        # dump logs to disk
        cd $MAPIC_CLI_FOLDER/logs
        bash dump-logs.sh
    else
        # print logs to console
        cd $MAPIC_CLI_FOLDER/logs
        bash show-logs.sh
    fi
}
                     
#  _      __(_) /___/ /
# | | /| / / / / __  / 
# | |/ |/ / / / /_/ /  
# |__/|__/_/_/\__,_/   
mapic_wild () {
    echo "\"$@\" is not a Mapic command. See 'mapic help' for available commands."
    exit 1
}

#   ___  ____  / /____  _____
#  / _ \/ __ \/ __/ _ \/ ___/
# /  __/ / / / /_/  __/ /    
# \___/_/ /_/\__/\___/_/     
mapic_enter_usage () {
    echo ""
    echo "Usage: mapic enter [filter]"
    echo ""
    echo "  filter      Grep filter for container name."
    echo ""
    echo "Example: 'mapic enter engine'"
    exit 1
}
mapic_enter () {
    [ -z "$1" ] && mapic_enter_usage
    [ -z "$2" ] && mapic_enter_usage
    C=$(docker ps -q --filter name=$2)
    [ -z "$C" ] && mapic_enter_usage_missing_container "$@"
    docker exec -it $C bash
}
mapic_enter_usage_missing_container () {
    echo "No container matched filter: $2" 
    exit 1
}

#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
mapic_install_usage () {
    echo ""
    echo "Usage: mapic install [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  mapic       Install Mapic"
    echo "  docker      Install Docker"
    echo "  jq          Install JQ (dependency)"
    echo "  node        Install NodeJS (not a dependency)"
    echo ""
    exit 1
}
mapic_install () {
    test -z $2 && mapic_install_usage

    case "$2" in
        mapic)      mapic_install_mapic "$@";;
        docker)     mapic_install_docker "$@";;
        jq)         mapic_install_jq "$@";;
        node)       mapic_install_node "$@";;
        *)          mapic_install_usage;
    esac 
}
mapic_install_mapic () {
    test -z $MAPIC_DOMAIN && mapic env prompt MAPIC_DOMAIN "Domain for Mapic. (Example: maps.mapic.io)" localhost
    echo "Installing Mapic to $MAPIC_DOMAIN"
    echo ""
    echo "Press Ctrl-C in next 10 seconds to cancel."
    sleep 10
    # cd $MAPIC_ROOT_FOLDER/scripts/install
    # bash install-to-localhost.sh
}
mapic_install_jq () {
    DISTRO=$(lsb_release -si)
    case "$DISTRO" in
        Ubuntu)     mapic_install_jq_ubuntu "$@";;
        *)          mapic_install_jq_unsupported;;
    esac 
}
mapic_install_jq_ubuntu () {
    apt-get -qq update -y || exit 1
    apt-get -qq install -y jq || exit 1
    echo "JQ installed."
    exit 0
}
mapic_install_jq_unsupported () {
    echo ""
    echo "Unable to install JQ automatically."
    echo ""
    echo "See https://stedolan.github.io/jq/download/"
    echo ""
    exit 1
}
mapic_install_docker () {
    DISTRO=$(lsb_release -si)
    case "$DISTRO" in
        Ubuntu)     mapic_install_docker_ubuntu "$@";;
        *)          mapic_install_docker_unsupported;;
    esac 
}
mapic_install_docker_unsupported () {
    echo ""
    echo "Unable to install Docker automatically."
    echo ""
    echo "See https://docs.docker.com/engine/installation/"
    echo ""
    exit 1
}
mapic_install_docker_ubuntu () {
    echo "Installing Docker!"
}

#   ____ _____  (_)
#  / __ `/ __ \/ / 
# / /_/ / /_/ / /  
# \__,_/ .___/_/   
#     /_/          
mapic_api_usage () {
    echo ""
    echo "Usage: mapic api [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  user        Show and edit users"
    echo "  upload      Upload data"
    echo ""
    exit 1 
}
mapic_api () {
    test -z "$2" && mapic_api_usage
    case "$2" in
        user)       mapic_api_user "$@";;
        upload)     mapic_api_upload "$@";;
        *)          mapic_api_usage;
    esac 
}

#   ____ _____  (_)  __  ______  / /___  ____ _____/ /
#  / __ `/ __ \/ /  / / / / __ \/ / __ \/ __ `/ __  / 
# / /_/ / /_/ / /  / /_/ / /_/ / / /_/ / /_/ / /_/ /  
# \__,_/ .___/_/   \__,_/ .___/_/\____/\__,_/\__,_/   
#     /_/              /_/                            
mapic_api_upload_usage () {
    echo ""
    echo "Usage: mapic api upload DATASET [OPTIONS]"
    echo ""
    echo "Dataset:"
    echo "  Absolute path of dataset to upload"
    echo ""
    # echo "Options:"
    # echo "  (Not yet implemented:)"
    # echo "  --project-id        Project id"
    # echo "  --dataset-name      Name of dataset'"
    # echo "  --project-name      Name of new project if created"
    # echo ""
    exit 1 
}
mapic_api_upload () {
    test -z "$3" && mapic_api_upload_usage
    cd $MAPIC_CLI_FOLDER/api
    bash upload-data.sh "$@"
    exit 0
}

#   ____ _____  (_)  __  __________  _____
#  / __ `/ __ \/ /  / / / / ___/ _ \/ ___/
# / /_/ / /_/ / /  / /_/ (__  )  __/ /    
# \__,_/ .___/_/   \__,_/____/\___/_/     
#     /_/                                     
mapic_api_user_usage () {
    echo ""
    echo "Usage: mapic api user [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  list        List registered users"
    echo "  create      Create user"
    echo "  super       Promote user to superadmin"
    echo ""
    exit 1
}
mapic_api_user () {
    [ -z "$3" ] && mapic_api_user_usage
    case "$3" in
        list)       mapic_api_user_list "$@";;
        create)     mapic_api_user_create "$@";;
        super)      mapic_api_user_super "$@";;
        *)          mapic_api_user_usage;
    esac 
}
mapic_api_user_list () {
    cd $MAPIC_CLI_FOLDER/user
    bash list-users.sh
}
mapic_api_user_create_usage () {
    echo ""
    echo "Usage: mapic api user create [EMAIL] [USERNAME] [FIRSTNAME] [LASTNAME]"
    echo ""
    exit 1
}
mapic_api_user_create () {
    test -z "$4" && mapic_api_user_create_usage
    test -z "$5" && mapic_api_user_create_usage
    test -z "$6" && mapic_api_user_create_usage
    test -z "$7" && mapic_api_user_create_usage
    cd $MAPIC_CLI_FOLDER/user
    bash create-user.sh "${@:4}"
}
mapic_api_user_super_usage () {
    echo ""
    echo "Usage: mapic api user super [EMAIL]"
    echo ""
    echo "(WARNING: This command will promote user to SUPERADMIN,"
    echo "giving access to all projects and data.)"
    echo ""
    exit 1
}
mapic_api_user_super () {
    test -z "$4" && mapic_api_user_super_usage
    echo "WARNING: This command will promote user to SUPERADMIN,"
    echo "giving access to all projects and data."
    echo ""
    read -p "Are you sure? (y/n)" -n 1 -r
    echo 
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        cd $MAPIC_CLI_FOLDER/user
        bash promote-super.sh "${@:4}"
    fi
}
                   
#   / ___/ / / / __ \
#  / /  / /_/ / / / /
# /_/   \__,_/_/ /_/ 
mapic_run_usage () {
    echo ""
    echo "Usage: mapic run [filter] [commands]"
    echo ""
    echo "Example: mapic run engine bash"
    exit 1
}
mapic_run () {
    test -z "$2" && mapic_run_usage
    test -z "$3" && mapic_run_usage
    C=$(docker ps -q --filter name=$2)
    test -z "$C" && enter_usage_missing_container "$@"
    docker exec $C ${@:3}
}

#    __________/ /
#   / ___/ ___/ / 
#  (__  |__  ) /  
# /____/____/_/   
mapic_ssl_usage () {
    echo ""
    echo "Usage: mapic ssl [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  create      Create SSL certificates for your domain"
    echo "  scan        Run security scan on your domain and SSL"
    echo ""
    exit 1   
}
mapic_ssl () {
    test -z "$2" && mapic_ssl_usage
    case "$2" in
        create)     mapic_ssl_create;;
        scan)       mapic_ssl_scan;;
        *)          mapic_ssl_usage;
    esac 
}
mapic_ssl_create () {
    cd $MAPIC_CLI_FOLDER
    bash create-ssl-certs.sh
}
mapic_ssl_scan () {
    cd $MAPIC_CLI_FOLDER
    bash ssllabs-scan.sh "https://$MAPIC_DOMAIN"
}

#   ____/ /___  _____
#  / __  / __ \/ ___/
# / /_/ / / / (__  ) 
# \__,_/_/ /_/____/  
mapic_dns_usage () {
    echo ""
    echo "Usage: mapic dns [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  create       Create DNS entries on Amazon Route 53 for your domain"
    echo ""
    exit 1   
}
mapic_dns () {
    test -z "$2" && mapic_dns_usage
    case "$2" in
        create)     mapic_dns_set;;
        *)          mapic_dns_usage;
    esac 
}
mapic_dns_set () {
    cd $MAPIC_CLI_FOLDER
    bash create-dns-entries-route-53.sh
}

#    _____/ /_____ _/ /___  _______
#   / ___/ __/ __ `/ __/ / / / ___/
#  (__  ) /_/ /_/ / /_/ /_/ (__  ) 
# /____/\__/\__,_/\__/\__,_/____/  
mapic_status () {
    cd $MAPIC_CLI_FOLDER
    bash mapic-status.sh
    exit 1
}

#   / /____  _____/ /_
#  / __/ _ \/ ___/ __/
# / /_/  __(__  ) /_  
# \__/\___/____/\__/  
mapic_test_usage () {
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
mapic_test () {
    test -z "$2" && mapic_test_usage
    case "$2" in
        all)        mapic_test_all;;
        engine)     mapic_test_engine;;
        mile)       mapic_test_mile;;
        mapicjs)    mapic_test_mapicjs;;
        travis)     mapic_test_travis;;
        *)          mapic_test_usage;
    esac 
}
mapic_test_all () {
    echo "testing all"
    mapic run engine npm test || mapic_test_failed "$@"
    mapic run mile npm test || mapic_test_failed "$@"
    mapic run engine bash public/test/test.sh || mapic_test_failed "$@"
}
mapic_test_engine () {
    echo "Tesing Mapic Engine"
    mapic run engine npm test || mapic_test_failed "$@"
    exit 0;
}
mapic_test_mile () {
    echo "Tesing Mapic Mile"
    mapic run mile npm test || mapic_test_failed "$@"
    exit 0;
}
mapic_test_mapicjs () {
    echo "Tesing Mapic.js"
    mapic run engine bash public/test/test.sh || mapic_test_failed "$@"
    exit 0;
}
mapic_test_travis() {
    echo "Not yet supported."
    exit 0;
}
mapic_test_failed () {
    echo "Some tests failed: $@";
    exit 1;
}

#   _________  ____  / __(_)___ _
#  / ___/ __ \/ __ \/ /_/ / __ `/
# / /__/ /_/ / / / / __/ / /_/ / 
# \___/\____/_/ /_/_/ /_/\__, /  
#                       /____/   
mapic_config_usage () {
    echo ""
    echo "Usage: mapic config [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  refresh [config]   Refresh Mapic configuration files"
    echo ""
    exit 1   
}
mapic_config () {
    test -z "$2" && mapic_config_usage
     case "$2" in
        refresh)    mapic_config_refresh "$@";;
        *)          mapic_config_usage;;
    esac 
}
mapic_config_refresh_usage () {
    echo ""
    echo "Usage: mapic config refresh [OPTIONS]"
    echo ""
    echo "Attempts to reset configuration to default and working condition."
    echo ""
    echo "Options:"
    echo "  all         Refresh all Mapic configuration files"
    echo "  engine      Refresh Mapic Engine config"
    echo "  mile        Refresh Mapic Mile config"
    echo "  mapicjs     Refresh Mapic.js config"
    echo "  nginx       Refresh NGINX config"
    echo "  redis       Refresh Redis config"
    echo "  mongo       Refresh Mongo config"
    echo "  postgis     Refresh PostGIS config"
    echo "  slack       Refresh Slack config"
    echo ""
    exit 0
}
mapic_config_refresh () {
    echo $1 $2 $3
    test -z "$3" && mapic_config_refresh_usage
    case "$3" in
        all)        mapic_config_refresh_all "$@";;
        engine)     mapic_config_refresh_engine "$@";;
        mile)       mapic_config_refresh_mile "$@";;
        mapicjs)    mapic_config_refresh_mapicjs "$@";;
        nginx)      mapic_config_refresh_nginx "$@";;
        redis)      mapic_config_refresh_redis "$@";;
        mongo)      mapic_config_refresh_mongo "$@";;
        postgis)    mapic_config_refresh_postgis "$@";;
        slack)      mapic_config_refresh_slack "$@";;
        *)          mapic_config_refresh_usage "$@";;
    esac 
}
mapic_config_refresh_all () {
    cd $MAPIC_CLI_FOLDER
    bash configure-mapic.sh || failed "$@"
}
mapic_config_refresh_nginx () {
    echo "Not yet supported."
    exit 0;
}
mapic_config_refresh_postgis () {
    echo "Not yet supported."
    exit 0;
}
mapic_config_refresh_redis () {
    echo "Not yet supported."
    exit 0;
}   
mapic_config_refresh_mongo () {
    echo "Not yet supported."
    exit 0;
}
mapic_config_refresh_mile () {
    echo "Not yet supported."
    exit 0;
}
mapic_config_refresh_mapicjs () {
    echo "Not yet supported."
    exit 0;
}
mapic_config_refresh_engine () {
    echo "Not yet supported."
    exit 0;
}
mapic_config_refresh_slack () {
    echo "Not yet supported."
    exit 0;
}
                        
#   / __ `/ ___/ _ \/ __ \
#  / /_/ / /  /  __/ /_/ /
#  \__, /_/   \___/ .___/ 
# /____/         /_/      
mapic_grep_usage () {
    echo ""
    echo "Usage: mapic grep [PATTERN]"
    echo ""
    echo "Will run: grep -rnw . -e \"PATTERN\""
    echo ""
    exit 1  
}
mapic_grep () {
    test -z "$2" && mapic_grep_usage
    grep -rnw $MAPIC_CLI_PWD -e "\"$2\""
}

#   ___  ____  / /________  ______  ____  (_)___  / /_
#  / _ \/ __ \/ __/ ___/ / / / __ \/ __ \/ / __ \/ __/
# /  __/ / / / /_/ /  / /_/ / /_/ / /_/ / / / / / /_  
# \___/_/ /_/\__/_/   \__, / .___/\____/_/_/ /_/\__/  
#                    /____/_/                         
mapic_cli "$@"
