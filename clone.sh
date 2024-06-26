#!/bin/bash

# Navigate to the current working directory
cd "$PWD"
mkdir -p .ionvcs

# Check if a path is provided as an argument
if [ -z "$1" ]; then
    echo "please provide a path to clone (like ~/Desktop/code_here)"
    exit 1
fi

# Set the destination folder
if [ -n "$2" ]; then
    DEST_FOLDER="$PWD/$2"
else
    DEST_FOLDER="$PWD"
fi

# Create the destination folder if it doesn't exist
mkdir -p "$DEST_FOLDER"

# Source the credentials file if it exists
if [ -f "$HOME/ionsrc/creds.txt" ]; then
    source "$HOME/ionsrc/creds.txt"
else
    echo "credentials file not found! (please use the login command)"
    exit 1
fi

# Set the remote path for rsync
REMOTE_PATH="$username@$src:$1"
CONF_FILE="$PWD/.ionvcs/src.config"

# Write configuration details to the .ionvcs/src.config file
echo "csrc=$REMOTE_PATH" > "$CONF_FILE"
echo "lastdate=$(date)" >> "$CONF_FILE"
echo "user=$username" >> "$CONF_FILE"

chmod 600 "$CONF_FILE"

# Use rsync with sshpass to copy files with a progress bar
echo -n "cloning "
/usr/bin/sshpass -p "$password" rsync -a --info=progress2 --no-i-r -h -e ssh "$REMOTE_PATH" "$DEST_FOLDER" || { echo "failed to clone!"; exit 1; }
echo "done!"