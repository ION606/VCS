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

# Set the remote path for rsync
REMOTE_PATH="$csrc"


while getopts ":of" opt; do
    case $opt in
        f)
            force_flag=true
            ;;
    esac
done


# Use rsync with sshpass to check for differences without copying
DIFF_OUTPUT=$(/usr/bin/sshpass -p "$password" rsync -avcn --delete -e ssh "$REMOTE_PATH" "$DEST_FOLDER")

# Check if there are differences
if [ ! -z "$DIFF_OUTPUT" && ! $force_flag ]; then
    echo "conflicts found between the local and remote directories (make sure they're correct and re-run using the -f flag):"
    echo "$DIFF_OUTPUT"
    exit 1;
fi

# Use rsync with sshpass to copy files with a progress bar
echo -n "cloning..."
/usr/bin/sshpass -p "$password" rsync -avcn --exclude-from="$PWD/.ionign" --info=progress2 --no-i-r -h -e ssh "$DEST_FOLDER" "$REMOTE_PATH" || { echo "failed to clone!"; exit 1; }
echo "done!"