#!/bin/bash

if [ -f "$HOME/ionsrc/creds.txt" ]; then
    source "$HOME/ionsrc/creds.txt"
    echo "logged in as $username!"
else
    echo "no user found!"
fi