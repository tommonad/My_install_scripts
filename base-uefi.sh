#!/bin/bash

# echo "KEYMAP=colemak" > /etc/vconsole.conf
# echo "127.0.0.1 localhost" >> /etc/hosts
# echo "::1       localhost" >> /etc/hosts
# echo "192.168.1.2 archway.localdomain arch" >> /etc/hosts

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S --needed --noconfirm efibootmgr dialog mtools base-devel linux-headers avahi xdg-user-dirs xdg-utils cups bash-completion openssh rsync reflector acpi acpi_call acpid

systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable acpid

usermod -aG libvirt


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
