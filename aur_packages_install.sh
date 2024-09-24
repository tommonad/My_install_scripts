#!/usr/bin/env bash

# This stops script at the first error used for debuging scripts
set -e
################################################################################
# Author      : Tom Kearns
# Github      : https://github.com/tommonad/My_install_scripts
################################################################################
#
# Installing pacman packages from text file
#
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

if [[ $aur_helper = true ]]; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay/;makepkg -si --noconfirm;cd
fi

sudo pacman -Syyu
yay -S --needed - < aur_packages.txt

tput setaf 2
echo
echo "#########################################################################"
echo "###              --- Aur packages are up to date ---               ###"
echo "#########################################################################"
tput sgr0
echo
