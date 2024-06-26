#!/bin/bash

# This is horrid but better than what I had before
if ! command -v sshpass &> /dev/null || ! command -v pv &> /dev/null || ! command -v git &> /dev/null; then
    if command -v dnf &> /dev/null; then
        sudo dnf -y install sshpass pv git
    elif command -v apt-get &> /dev/null; then
        sudo apt-get -y install sshpass pv git
    else
        echo "Package manager not found. Please install sshpass, pv, and git manually"
        exit 1
    fi
fi


git clone https://github.com/ION606/VCS.git .ionvcs

# Move files
sudo mv .ionvcs/ionsrc.desktop /usr/share/applications/ionsrc.desktop || echo "FAILED TO MOVE DESKTOP FILE"
mkdir -p ~/ionsrc
mv .ionvcs/* ~/ionsrc/

# Clean up
rm -rf .ionvcs
