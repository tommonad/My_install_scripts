#!/bin/env bash

# Variables
kbmap="us -variant colemak"
output1=DP-1
output2=DVI-I-1
resolution=1920x1080

# Options
gen_xinitrc=true

sudo timedatectl set-ntp true
sudo hwclock --systohc

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

# .xprofile
if [[ $gen_xinitrc = true ]]; then
cat > ~/xinitrc << EOF
#!/bin/sh

# Default programs:
export EDITOR="nvim"
export VISUAL="nvim"
export QT_QPA_PLATFORMTHEME="qt5ct"
export TERMINAL="st"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"


setxkbmap $kbmap
xrandr --output $output1 --mode $resolution --rate 60 --primary --output $output2 --mode $reslution --rate 60 --right-of $output1 &
/home/tom/.config/suckless/dwm-bar/dwm_bar.sh &

# Random wallpapers
feh --bg-scale --randomize ~/Wallpapers/* &

[[ -f ~/.config/X11/xmodmap ]] && xmodmap ~/.config/X11/xmodmap
xset r rate 180 50 &

# start some nice programs
picom  &
sxhkd -m 1 &

# Restart dwm
while true; do
	dwm >/dev/null 2<&1
done

exec dwm
EOF
fi

chmod +x ~/xinitrc

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
