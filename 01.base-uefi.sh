#!/bin/bash

# echo "KEYMAP=colemak" > /etc/vconsole.conf
# echo "127.0.0.1 localhost" >> /etc/hosts
# echo "::1       localhost" >> /etc/hosts
# echo "192.168.1.2 archway.localdomain arch" >> /etc/hosts

# Edit later /etc/xdg/reflector/reflector.conf and add your preferences

pacman -S --needed --noconfirm efibootmgr dialog mtools base-devel linux-headers avahi xdg-user-dirs xdg-utils openssh rsync reflector

systemctl enable cups.service
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
