#!/bin/bash

COMMAND="$1";
shift;

case $COMMAND in
    "clone")
        bash $HOME/ionsrc/clone.sh "$@"
    ;;
    
    "push")
        bash $HOME/ionsrc/push.sh "$@"
    ;;
    
    "login")
        bash $HOME/ionsrc/login.sh "$@"
    ;;
    
    "user")
        bash $HOME/ionsrc/getuser.sh
    ;;
    
    "status")
        bash $HOME/ionsrc/status.sh
    ;;
    
    "help")
        bash $HOME/ionsrc/help.sh
    ;;
    
    "unstage")
        bash $HOME/ionsrc/change.sh unstage "$@"
    ;;

    "add")
        bash $HOME/ionsrc/change.sh add "$@"
    ;;
    
    *)
        echo "UNKNOWN COMMAND \"$COMMAND\""
        GREEN='\033[0;31m'
        NC='\033[0m' # No Color
        echo -e "use ${GREEN}\`ionvcs help\`${NC} for help"
    ;;
esac