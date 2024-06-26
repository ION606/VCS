#!/bin/bash

COMMAND="$1";
shift;

case $COMMAND in
    "clone")
        bash clone.sh "$@"
    ;;

    "push")
        bash push.sh "$@"
    ;;

    "login")
        bash login.sh "$@"
    ;;

    "user")
        bash getuser.sh
    ;;

    "help")
        bash help.sh
    ;;
    
    *)
        echo "UNKNOWN COMMAND \"$@\""
    ;;
esac