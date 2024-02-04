#!/usr/bin/env bash
#
CONFIG_DIR="$PWD/config"
DESKTOP_DIR="$PWD/desktop"
HOME_CONFIG_DIR="$HOME/.config"
HOME_DESKTOP_DIR="$HOME/Desktop"
XORG_DIR="/etc/X11/xorg.conf.d/"
HOME_XORG_DIR="$PWD/system/X11"

# Creates symlinks
create_links() {
  for config in "$CONFIG_DIR"/*
  do
      app=$(echo "$config" | awk -F/ '{print $NF}')
      case $app in
          rofi)
              ln -sfF "$config/config.rasi" "$HOME_CONFIG_DIR/rofi"
              continue
              ;;
          starship)
              ln -sfF "$config/starship.toml" "$HOME_CONFIG_DIR"
              continue
              ;;
         xbindkey)
              ln -sfF "$config/xbindkeysrc" "$HOME/.xbindkeysrc"
              continue
              ;;
      esac
      ln -sfF "$config" "$HOME_CONFIG_DIR/"
  done

  for desktop_entry in "$DESKTOP_DIR"/*
  do
      ln -sfF "$desktop_entry" "$HOME_DESKTOP_DIR"
  done
}

# Create links for X
link_x() {
  for file in "$HOME_XORG_DIR"/*; do
      sudo ln -sfF "$file" "$XORG_DIR/"
  done

  sudo ln -sfF "$PWD/system/backlight/backlight.rules" /etc/udev/rules.d/
  sudo ln -sfF "$PWD/system/fingerprint/50-net.reactivated.fprint.device.enroll.rules" /etc/polkit-1/rules.d/
  sudo ln -sfF "$PWD/system/modprobe/nobeep.conf" /etc/modprobe.d/

}

# Remove symlinks
remove_links() {
    for config in "$CONFIG_DIR"/*
    do
        file="${config#"$CONFIG_DIR"/}"
        unlink "$HOME_CONFIG_DIR/$file" 2>/dev/null
    done
}

# Install Arch Linux Packages
arch_install() {
    sudo cat packages/pacman.install | sudo pacman -S --needed -
    yay -S --needed - < packages/yay.install

    while IFS= read -r package
    do
        sudo snap install "$package"
    done < packages/snap.install

}

case $1 in
    create_links)
        create_links
        ;;
    remove_links)
        remove_links
        ;;
    arch_install)
        arch_install
        ;;
    link_x)
       link_x 
        ;;
    *)
        echo "Option $1 not found"
        ;;
esac
