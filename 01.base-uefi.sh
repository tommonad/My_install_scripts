#!/bin/bash

# Activate wheel group
sudo sed -i '114s/^..//' /etc/sudoers

# Add keymap to console tty
echo "KEYMAP=colemak" | sudo tee  /etc/vconsole.conf

# Edit hosts file
echo "127.0.0.1            localhost\n::1                  localhost\n192.168.1.2  archway.localdomain archway" | sudo tee -a /etc/hosts

# Here don't forget to put the proper name of the enp device with ip a
echo "[Match]\nName=enpXs0\n\n[Network]\nAddress=192.168.1.2/24\nGateway=192.168.1.1\nDNS=208.67.222.222'\nDNS=208.67.220.220" | sudo tee j /etc/systemd/network/enpXs0.network

# Add dns address
echo "nameserver 208.67.222.222\nnameserver 208.67.220.220"  | sudo tee -a /etc/resolv.conf

# Enable network services
sudo systemctl enable --now systemd-networkd
sudo systemctl enable --now systemd-resolved.service

# Add user to groups
sudo usermod -aG audio,video,network,lp,input,libvirt,wheel,storage tom

# Edit later /etc/xdg/reflector/reflector.conf and add your preferences
sudo reflector -c "Belgium,Germany" -a 12 -p https -p http --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu
sudo pacman -S --needed --noconfirm xorg efibootmgr dialog mtools base-devel linux-headers avahi xdg-user-dirs xdg-utils openssh rsync reflector

systemctl enable cups.service
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
