#!/usr/bin/env bash

# Installs yay if not already installed
if ! command -v yay > /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
else
    echo "Yay already installed, skipping..."
fi

echo "Installing yay packages..."
yay -S --needed --noconfirm - < packages/yay.install
