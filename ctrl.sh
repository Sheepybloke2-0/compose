#!/bin/bash
# Import common files
source base.sh

SHORT=h,c,o,g
LONG=help,code,obsidian,ghost
OPTS=$(getopt -a -n ctrl -o $SHORT -l $LONG -- "$@")

DOCKER_CMD="docker-compose"
CODE="code/service.yml"
OBS="obsidian/service.yml"
GHOST="ghost/service.yml"

print_help () {
    pprint "Usage: ctrl [-c | --code]
        [-o | --obsidian]
        [-g | --ghost] COMMAND
    where COMMAND is
    [lauch | shutdown | list | logs SERVICE_NAME]
            " "info"
    exit 2
}

# Arg1 is the docker command that was created.
run_cmd () {
    CMD="$1"
    if $CMD ; then
        success
    else
        fail
    fi
}

# Arg1 is the docker command that was created.
launch () {
    pprint "[CTRL] Launching system..." "info"
    run_cmd "${1:-$DOCKER_CMD} up -d"
    
}

# Arg1 is the docker command that was created.
shutdown () {
    pprint "[CTRL] Shutting system down..." "info"
    run_cmd "${1:-$DOCKER_CMD} down"
}

list () {
    pprint "[CTRL] Showing all containers..." "info"
    run_cmd "${1:-$DOCKER_CMD} ps"
}

# Arg1 is the docker command that was created, arg2 is the service
logs () {
    pprint "[CTRL] Showing logs for $2..." "info"
    run_cmd "${1:-$DOCKER_CMD} logs $2"
}

eval set -- "$OPTS"
CMD=$DOCKER_CMD
while :  
do
    case "$1" in
        -c | --code )
            CMD="$CMD -f $CODE"
            shift;
            ;;
        -o | --obsidian )
            CMD="$CMD -f $OBS"
            shift;
            ;;
        -g | --ghost )
            CMD="$CMD -f $GHOST"
            shift;
            ;;
        -h | --help )
            print_help
            ;;
        --)
            shift;
            break
            ;;
        *)
            pprint "Unexpected Option: $1" "warn"
            print_help
            ;;
    esac
done

# If no options were added, add them all.
if [ "$CMD" == "$DOCKER_CMD" ] ; then
    CMD="$CMD -f $CODE -f $OBS -f $GHOST"
fi

if [ -z $1 ] ; then
    pprint "Missing command" "warn"
    print_help
elif [ $# == 2 ] && [ $1 == "logs" ] ; then
    FN=$1   
    SERVICE=$2
elif [ $# != 1 ] ; then
    pprint "Too many commands: $#" "warn"
    print_help
else
    FN=$1   
fi

if [ $FN == "launch" ] ; then
    launch "$CMD"
elif [ $FN == "shutdown" ] ; then
    shutdown "$CMD"
elif [ $FN == "list" ] ; then
    list "$CMD"
elif [ $FN == "logs" ] ; then
    logs "$CMD" "$SERVICE"
fi

