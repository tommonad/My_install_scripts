#!/usr/bin/env bash
# Sun Sep-22-2024  17:29
################################################################################
# Author      : Tom Kearns
# Github      : https://www.github.com/tommonad/My_install_scripts
################################################################################
# Installing pipewire for audio
# https://wiki.archlinux.org/title/PipeWire
sudo pacman -S --noconfirm --needed pipewire
sudo pacman -S --noconfirm --needed lib32-pipewire
sudo pacman -S --noconfirm --needed wireplumber
sudo pacman -S --noconfirm --needed pipewire-alsa
sudo pacman -S --noconfirm --needed pipewire-jack
sudo pacman -S --noconfirm --needed lib32-pipewire-jack
sudo pacman -S --noconfirm --needed pipewire-zeroconf
sudo pacman -S --noconfirm --needed pipewire-pulse

echo
tput setaf 2
echo "#########################################################################"
echo ---  "Reboot now"  ---
echo "#########################################################################"
tput sgr0
echo
