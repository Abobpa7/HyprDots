#!/bin/bash

echo -e "\e[32mInstalling base packages...\e[0m"
sudo pacman -S --needed ttf-font-awesome ttf-jetbrains-mono hyprland hyprlock swaync udiskie kitty nautilus rofi telegram-desktop flatpak git base-devel hypridle nwg-look sddm unzip tar

echo -e "\e[32mInstalling apps from Flatpak...\e[0m"
flatpak install flathub app.zen_browser.zen com.discordapp.Discord com.obsproject.Studio

echo -e "\e[32mCloning HyprDots repo...\e[0m"
git clone https://github.com/Abobpa7/HyprDots.git 
cd HyprDots
unzip config.zip
cd config
mkdir -p ~/.config
cp -r hypr ~/.config
cp -r waybar ~/.config
cp -r swaync ~/.config
cp -r kitty ~/.config
cp -r nvin ~/.config
cp -r fastfetch ~/.config
cd ~
rm -rf HyprDots

cd /tmp
echo -e "\e[32mInstalling yay...\e[0m"
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si --noconfirm

cd ~
echo -e "\e[32mEnabling SDDM...\e[0m"
sudo systemctl enable sddm

echo -e "\e[1;35mHuh, Dima, you did neveroeatnoe! 🚀\e[0m"
