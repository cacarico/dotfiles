#!/usr/bin/env bash

DOTFILES_DIR="$HOME/ghq/github.com/cacarico/dotfiles"
FONTS_DIR="~/.local/share/fonts"

# Creates default directories
for directory in ~/Pictures ~/Games ~/Music ~/.local/bin "$DOTFILES_DIR" "$FONTS_DIR"; do
    if [ ! -d $directory ]; then
        mkdir -p $directory
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
    mkdir -p $DOTFILES_DIR
    git clone https://github.com/cacarico/dotfiles.git $DOTFILES_DIR
    cd $DOTFILES_DIR
else
    echo "Dotfiles repository already cloned, skipping..."
fi

# Install packman packages
echo "Installing pacman packages..."
sudo pacman -S virtualbox virtualbox-guest-iso
sudo cat packages/pacman.install | sudo pacman -S --needed --noconfirm -

# Install yay and yay packages
echo "Installing yay packages..."
scripts/bootstrap.d/yay-install.sh
yay -S --needed --noconfirm - < packages/yay.install

# Install asdf
if [ ! -d "~/.asdf" ]; then
    echo "Installing asdf"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
else
    echo "Asdf already installed, skipping..."
fi

# Install asdf packages
echo "Installing asdf packages..."
for package in $(cat packages/asdf.install); do
    ~/.asdf/bin/asdf plugin-add $package
    ~/.asdf/bin/asdf asdf install $package latest
    ~/.asdf/bin/asdf global $package latest
done

# Install Tmux Plugin Manager
if [ ! -d "~/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install Oh My Fish
if [ ! -d "~/.local/share/omf" ]; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

# Enable service daemons
echo "Enabling service daemons"
for service in fprintd bluetooth snapd snapd.apparmor; do
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
    sudo usermod -aG $group $USER
done

# Set fish as default shell
if [ "$SHELL" != "/usr/bin/fish" ]; then
    echo "Setting fish as default shell"
    chsh -s /usr/bin/fish
else
    echo "Fish already default shell, skipping..."
fi

# Enable fingerprint
echo "Enabling fingerpring service"
for service in sudo system-local-login; do
    sudo sed -i '/auth.*include/i auth            sufficient      pam_fprintd.so' "/etc/pam.d/$service"
done

# Create symbolic links
find ~/.config \( -name 'fish' -o -name 'qtile' \) -type d -exec rm -r {} +
make link
make link-x
sudo ln -sfF /var/lib/snapd/snap /snap
sudo ln -sfF /run/podman/podman.sock /var/run/docker.sock
