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

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
