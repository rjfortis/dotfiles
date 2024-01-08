#!/bin/bash


#STEP Add non-free-firmware

if grep -q "http://security.debian.org/debian-security bookworm-security main non-free-firmware" /etc/apt/sources.list; then
	echo "/etc/apt/sources.list file is correct"
else
	echo "Searching and replacing in /etc/apt/sources.list file"
	sudo sed -i -e 's|http://security.debian.org/debian-security[[:space:]]bookworm-security[[:space:]]main|http://security.debian.org/debian-security bookworm-security main non-free-firmware|g' /etc/apt/sources.list
fi

#STEP Update and upgrade
sudo apt-get update && sudo apt-get upgrade

#STEP Install WM and essential tools
sudo apt install awesome awesome-extra lightdm alacritty gedit chromium git

#STEP Install other important tools
sudo apt install picom xclip xbacklight flameshot pnmixer network-manager-gnome policykit-1-gnome rofi xfe htop curl build-essential

#STEP Delete Empty Awesome, Alacritty, Picom folders
rm -rf ~/.config/awesome
rm -rf ~/.config/alacritty
rm -rf ~/.config/picom

#STEP clone dotfiles repo in .config folder
git clone https://github.com/rjfortis/dotfiles.git ~/dotfiles
mv ~/dotfiles/{,.}* ~/.config

#STEP replace bashrc config file
mv ~/.bashrc ~/.bashrc_old
git clone https://github.com/rjfortis/bashconfig.git ~/bashconfig
mv ~/bashconfig/{,.}* ~

#STEP Install Nix Package manager
sh <(curl -L https://nixos.org/nix/install) --daemon


