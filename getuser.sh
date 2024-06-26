#!/bin/bash

if [ -f "$HOME/ionsrc/creds.txt" ]; then
    source "$HOME/ionsrc/creds.txt"
    echo -e "logged in as \033[0;31m$username\e[0m!"
else
    echo "no user found!"
fi