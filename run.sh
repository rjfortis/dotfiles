#!/bin/bash

#STEP Update and upgrade
sudo apt update && sudo apt upgrade

#STEP Install WM and essential tools
sudo apt install awesome awesome-extra alacritty gedit git curl wget build-essential

#STEP Install other important tools
sudo apt install flameshot pnmixer rofi htop

#STEP create .config folder
mkdir ~/.config

#STEP Delete Empty Awesome, Alacritty, Picom folders
rm -rf ~/.config/awesome
rm -rf ~/.config/alacritty

#STEP clone dotfiles repo in .config folder
git clone https://github.com/rjfortis/dotfiles.git ~/dotfiles
mv ~/dotfiles/{,.}* ~/.config

#STEP replace bashrc config file
if [ -f ~/.bashrc ]; then
	mv ~/.bashrc ~/.bashrc_old
fi
git clone https://github.com/rjfortis/bashconfig.git ~/bashconfig
mv ~/bashconfig/{,.}* ~
rm -rf ~/bashtemp

#STEP Download and install Google Chrome
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ~/chrome.deb
sudo dpkg -i ~/chrome.deb

sudo apt --fix-broken install


#STEP Download and Install BRAVE
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update && sudo apt upgrade

while true; do

        read -p "Do you want to install Brave browser? (y/n) " yn

        case $yn in
                [yY] )
                        echo Installing Brave browser;
			sudo apt install brave-browser
                        break;;
                [nN] )
                        echo Brave browser will not be installed;
                        break;;
                * )
                        echo invalid response;;
        esac

done


#STEP Download and install VSCODE
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ~/vscode.deb
sudo dpkg -i ~/vscode.deb


#STEP Install Nix Package manager
# sh <(curl -L https://nixos.org/nix/install) --daemon


while true; do

        read -p "Do you want to install Nix Package Manager? (y/n) " yn

        case $yn in
                [yY] )
                        echo Installing nix package manager;
			sh <(curl -L https://nixos.org/nix/install) --daemon
                        break;;
                [nN] )
                        echo Nix package manager will not be installed;
                        break;;
                * )
                        echo invalid response;;
        esac

done


sudo reboot
