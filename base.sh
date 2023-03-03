#!/bin/bash
DEFAULT_TAB=48

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAG=$(tput setaf 5)
WHITE=$(tput setaf 7)
STD=$(tput sgr0)

# Takes print string as arg1, optional status as arg2, 
# an optional enable tabs as arg3, and an optional tab size as arg4
pprint () {
    ARG2=${2:-"info"}
    ARG3=${3:-0}
    if [ $ARG2 == "info" ] ; then
        COLOR=$BLUE;
    elif [ $ARG2  == "success" ] ; then
        COLOR=$GREEN;
    elif [ $ARG2 == "warn" ] ; then
        COLOR=$YELLOW;
    elif [ $ARG2  == "err" ] ; then
        COLOR=$RED;
    fi;
    
    if [ $ARG3 == 1 ] ; then TAB=${4:-$DEFAULT_TAB}; else TAB=0; fi
    echo $COLOR   
    printf "$COLOR%${TAB}s\n$STD" "$1"
}

# Tests
# pprint "wow" "info"
# pprint "This is a longer phrase" "info"
# pprint "[DONE]" "success" 1
# pprint "[WARN]" "warn" 1 12
# pprint "[ERR]" "err" 0

success () {
    pprint "[DONE]" "success" 1
}


fail () {
    pprint "[FAIL]" "err" 1
}

# Tests
# success
# fail

