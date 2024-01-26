#!/bin/bash


#STEP Add non-free-firmware

if grep -q "http://security.debian.org/debian-security bookworm-security main non-free-firmware" /etc/apt/sources.list; then
	echo "/etc/apt/sources.list file is correct"
else
	echo "Searching and replacing in /etc/apt/sources.list file"
	sudo sed -i -e 's|http://security.debian.org/debian-security[[:space:]]bookworm-security[[:space:]]main|http://security.debian.org/debian-security bookworm-security main non-free-firmware|g' /etc/apt/sources.list
fi

#STEP Update and upgrade
sudo apt update && sudo apt upgrade

#STEP Install WM and essential tools
sudo apt install awesome awesome-extra lightdm alacritty gedit git curl build-essential

#STEP Install other important tools
sudo apt install picom xclip xbacklight flameshot pnmixer network-manager-gnome policykit-1-gnome rofi xfe htop

#STEP create .config folder
mkdir ~/.config

#STEP Delete Empty Awesome, Alacritty, Picom folders
rm -rf ~/.config/awesome
rm -rf ~/.config/alacritty
rm -rf ~/.config/picom

#STEP clone dotfiles repo in .config folder
git clone https://github.com/rjfortis/dotfiles.git ~/dotfiles
mv ~/dotfiles/{,.}* ~/.config

#STEP replace bashrc config file
if [ -f ~/.bashrc ]; then
	mv ~/.bashrc ~/.bashrc_old
fi
git clone https://github.com/rjfortis/bashconfig.git ~/bashconfig
mv ~/bashconfig/{,.}* ~


#STEP Download and Install BRAVE

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update && sudo apt upgrade

sudo apt install brave-browser

#STEP Download and install VSCODE

wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ~/vscode.deb

sudo dpkg -i ~/vscode.deb

#STEP Download and install EDGE

wget "https://go.microsoft.com/fwlink?linkid=2149051&brand=M102" -O ~/edge.deb
sudo dpkg -i ~/edge.deb



#STEP Install Nix Package manager
# sh <(curl -L https://nixos.org/nix/install) --daemon


