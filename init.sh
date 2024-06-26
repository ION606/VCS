#!/bin/bash

# This is horrid but better than what I had before
if ! command -v sshpass &> /dev/null || ! command -v pv &> /dev/null || ! command -v git &> /dev/null; then
    if command -v dnf &> /dev/null; then
        sudo dnf -y install sshpass pv git
    elif command -v apt-get &> /dev/null; then
        sudo apt-get -y install sshpass pv git
    else
        echo -e "\e[31mPackage manager not found. Please install sshpass, pv, and git manually\e[0m"
        exit 1
    fi
fi


git clone https://github.com/ION606/VCS.git .ionvcs


# Move files
sudo mv .ionvcs/ionsrc.desktop /usr/share/applications/ionsrc.desktop || echo -e "\e[31mFAILED TO MOVE DESKTOP FILE\e[0m"
mkdir -p ~/ionsrc
mv .ionvcs/* ~/ionsrc/


# alias stuff
alias_line="alias ionvcs='bash ~/ionsrc/run.sh'"

if grep -q "^alias ionvcs=" ~/.bashrc; then
    sed -i "s|^alias ionvcs=.*|$alias_line|" ~/.bashrc
else
    echo "$alias_line" >> ~/.bashrc
fi

source ~/.bashrc


# Clean up
rm -rf .ionvcs
