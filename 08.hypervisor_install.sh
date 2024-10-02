#!/usr/bin/env bash

# This stops script at the first error used for debuging scripts
set -e
################################################################################
# Author      : Tom Kearns
# Github      : https://github.com/tommonad/My_install_scripts
################################################################################
#
#  Install hypervisor
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


sudo pacman -Rdd iptables --noconfirm; sudo pacman -S --noconfirm --needed iptables-nft ebtables qemu-full virt-manager virt-viewer dnsmasq vde2 bridge-utils edk2-ovmf dmidecode

#starting service
sudo systemctl enable --now libvirtd.service

# echo -e "options kvm-intel nested=1" | sudo tee -a /etc/modprobe.d/kvm-intel.conf

user=$(whoami)
sudo gpasswd -a $user libvirt
sudo gpasswd -a $user kvm

sudo virsh net-define /etc/libvirt/qemu/networks/default.xml

sudo virsh net-autostart default

sudo systemctl restart libvirtd.service

echo "#########################################################################"
echo "###                   ---  hypervisor installed  ---                  ###"
echo "#########################################################################"
