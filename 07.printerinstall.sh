#!/bin/bash
# File created on the 23-05-2021
#set -e

sudo pacman -S --noconfirm --needed cups cups-pdf gutenprint ghostscript gsfonts system-config-printer
sudo systemctl enable --now cups.socket
yay -S --noconfirm --needed brscan4 brother-dcpj562dw
sudo brsaneconfig4 -a name="BrotherScanner" model="DCP-J562DW" ip=192.168.1.5

# Turn on printer and then execute the following command
#  lpadmin -p myprinter -E -v "ipp://192.168.1.05/ipp/print" -m everywhere
