#!/usr/bin/env bash

# Installs asdf if not already installed
if [ ! -d "$HOME/.asdf" ]; then
    echo "Installing asdf"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
else
    echo "Asdf already installed, skipping..."
fi

# Install asdf packages
echo "Installing asdf packages..."
while IFS= read -r package; do
    ~/.asdf/bin/asdf plugin-add "$package"
    ~/.asdf/bin/asdf install "$package" latest
    ~/.asdf/bin/asdf global "$package" latest
done < packages/asdf.install
