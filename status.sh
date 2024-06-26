#!/bin/bash

# Navigate to the current working directory
cd "$PWD"

if [ ! -f "$HOME/ionsrc/creds.txt" ]; then
    echo "credentials file not found!"
    exit 1
elif [ ! -f "$PWD/.ionvcs/src.config"]; then
    echo "config file not found!"
    exit 1
fi

source "$HOME/ionsrc/creds.txt"
source "$PWD/.ionvcs/src.config"

REMOTE_PATH="$csrc"

# Set the destination folder
if [ -n "$2" ]; then
    DEST_FOLDER="$PWD/$2"
else
    DEST_FOLDER="$PWD"
fi

# Use rsync with sshpass to check for differences without copying
DIFF_OUTPUT=$(/usr/bin/sshpass -p "$password" rsync -avcn --delete -e ssh "$REMOTE_PATH" "$DEST_FOLDER")

# Check if there are differences
if [ ! -z "$DIFF_OUTPUT" ]; then
    echo "$DIFF_OUTPUT"
    exit 1;
else
    echo "no changes found!"
fi