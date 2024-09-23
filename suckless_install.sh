#!/bin/env bash

set -e

# Pull Git repositories and install
cd ~/.config && mkdir suckless && cd suckless
repos=( "dmenu" "dwm" "st" )
for repo in ${repos[@]}
do
    git clone https://github.com/LukeSmithxyz/$repo
    cd $repo;make;sudo make install;cd ..
done

# XSessions and dwm.desktop
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/dwm.desktop;rm ./temp

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
