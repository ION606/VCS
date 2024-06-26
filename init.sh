#!/bin/bash

# make sure the libraries are installed
sudo dnf -y install sshpass ssh pv || sudo apt-get -y install sshpass ssh pv


git clone https://github.com/ION606/VCS.git .ionvcs
sudo mv .ionvcs/ionsrc.desktop /usr/share/applications/ionsrc.desktop || echo "FAILED TO MAKE DESKTOP FOLDER"
mkdir -p ~/ionsrc
mv .ionvcs/* ~/ionsrc/