#!/bin/env bash

# Variables
country=Belgium
kbmap=colemak
output=Virtual-1
resolution=1920x1080

# Options
aur_helper=true
install_ly=false
gen_xprofile=false

# Install arch packages
package_file="arch_packages.txt"

# Check if the file exists
if [ ! -f "$package_file" ]; then
  echo "Error: File $package_file not found!"
  exit 1
fi

# Install the packages listed in the file using pacman
sudo pacman -S --needed --noconfirm $(cat "$package_file")

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo reflector -c $country -a 12 --sort rate --save /etc/pacman.d/mirrorlist

# sudo virsh net-autostart default

if [[ $aur_helper = true ]]; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay/;makepkg -si --noconfirm;cd
fi

package_file="aur_packages.txt"

# Check if the file exists
if [ ! -f "$package_file" ]; then
  echo "Error: File $package_file not found!"
  exit 1
fi

# Install the packages listed in the file using pacman
yay -S --needed --noconfirm $(cat "$package_file")

# Install fonts
# sudo pacman -S --noconfirm dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji

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

# Install ly
if [[ $install_ly = true ]]; then
    git clone https://aur.archlinux.org/ly
    cd ly;makepkg -si
    sudo systemctl enable ly
fi

# .xprofile
if [[ $gen_xprofile = true ]]; then
cat > ~/.xprofile << EOF
setxkbmap $kbmap
xrandr --output $output --mode $resolution
EOF
fi

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
