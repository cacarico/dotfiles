#!/usr/bin/env bash

DOTFILES_DIR="$HOME/ghq/github.com/cacarico/dotfiles"
FONTS_DIR="$HOME/.local/share/fonts"
BOOTSTRAP_DIR="scripts/bootstrap.d"

# Creates default directories
for directory in ~/Mounts/usb ~/Pictures ~/Games ~/Music ~/.local/bin ~/Books "$DOTFILES_DIR" "$FONTS_DIR"; do
    if [ ! -d "$directory" ]; then
        mkdir -p "$directory"
    else
        echo "Directory $directory already exists, skipping..."
    fi
done

# Install fonts
echo "Installing Fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraMono.zip
unzip FiraMono.zip -d "$FONTS_DIR"
rm -f FiraMono.zip
curl https://fonts.gstatic.com/s/notocoloremoji/v30/Yq6P-KqIXTD0t4D9z1ESnKM3-HpFab5s79iz64w.ttf -o ~/.local/share/fonts/NotoColorEmoji-Regular.ttf

# Clones dotfiles repository
if [ ! -d "$DOTFILES_DIR/dotfiles" ]; then
    sudo pacman -S git --noconfirm
    mkdir -p "$DOTFILES_DIR"
    git clone https://github.com/cacarico/dotfiles.git "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
else
    echo "Dotfiles repository already cloned, skipping..."
fi

[ "$(uname -a | grep arch)" ] && $BOOTSTRAP_DIR/arch-install.sh
[ "$(uname -a | grep fedora)" ] && $BOOTSTRAP_DIR/fedora-install.sh

# Install Tmux Plugin Manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install Oh My Fish
if [ ! -d "$HOME/.local/share/omf" ]; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

# Enable service daemons
echo "Enabling service daemons"
for service in fprintd bluetooth snapd snapd.apparmor cups.socket avahi-daemon.service; do
    sudo systemctl enable --now $service
done

# Enable user daemons
echo "Enabling user daemons"
for user_service in podman.socket podman.service; do
    sudo systemctl --user enable --now $user_service
done

# Add user to groups
echo "Adding user $USER to groups"
for group in vboxusers video input; do
    sudo usermod -aG "$group" "$USER"
done

# Sets git default configs
git config --global user.name cacarico
git config --global user.email "caio.quinilato@gmail.com"

# Set fish as default shell
if [ "$SHELL" != "/usr/bin/fish" ]; then
    echo "Setting fish as default shell"
    chsh -s /usr/bin/fish
else
    echo "Fish already default shell, skipping..."
fi

# Delete default directories before creating symbolic links
find ~/.config \( -name 'fish' -o -name 'qtile' \) -type d -exec rm -r {} +

# Create symbolic links
make link
make link-x
