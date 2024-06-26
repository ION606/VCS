#!/bin/bash

# Navigate to the current working directory
cd "$PWD"

if [ ! -f "$HOME/ionsrc/creds.txt" ]; then
    echo -e "\e[31mcredentials file not found!\e[0m"
    exit 1
elif [ ! -f "$PWD/.ionvcs/src.config" ]; then
    echo -e "\e[31mconfig file not found!\e[0m"
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
DIFF_OUTPUT=$(/usr/bin/sshpass -p "$password" rsync -avcn --delete -e ssh "$REMOTE_PATH" "$DEST_FOLDER") || echo "FAILED TO CONNECT TO SOURCE!"

# Check if there are differences
if [ ! -z "$DIFF_OUTPUT" ]; then
    echo -e "\e[1;32mdifferences found\e[0m"
    echo "$DIFF_OUTPUT"
else
    echo "no changes found from remote"
fi

# Files
ogfiles=".ionvcs/ogfiles.config"
addfiles=".ionvcs/add.config"

# Check if the necessary files exist
if [ ! -f "$ogfiles" ]; then
    echo "The file $ogfiles does not exist."
    exit 1
fi

if [ ! -f "$addfiles" ]; then
    echo "The file $addfiles does not exist."
    exit 1
fi

# Read the .ionvcs/add.config into an array
mapfile -t add_files < "$addfiles"
mapfile -t all_files < "$ogfiles"


# Read the .ionvcs/ogfiles.config and process each line
while IFS= read -r file; do
   if [ ! -f "$file" ]; then
        # File is not in the current directory
        echo -e "\e[0;31m$file\e[0m"
    fi
done < "$ogfiles"

while IFS= read -r file; do
    if ! (printf '%s\n' "${all_files[@]}" | grep -qx "$file"); then
        # File is in .ionvcs/add.config
        echo -e "\e[0;32m$file\e[0m"
    fi
done < "$addfiles"