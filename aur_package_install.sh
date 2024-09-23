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

# Install arch packages
package_file="aur_packages.txt"

# Check if the file exists
if [ ! -f "$package_file" ]; then
  echo "Error: File $package_file not found!"
  exit 1
fi

# Install the packages listed in the file using pacman
yay -S --needed --noconfirm $(cat "$package_file")



# Check if the file exists
if [ ! -f "$package_file" ]; then
  echo "Error: File $package_file not found!"
  exit 1
fi

tput setaf 2
echo
echo "#########################################################################"
echo "###                   --- Aur is up to date ---                    ###"
echo "#########################################################################"
tput sgr0
echo

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
