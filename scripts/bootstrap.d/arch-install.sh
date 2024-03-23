#!/usr/bin/env bash

BOOTSTRAP_DIR="scripts/bootstrap.d"

echo "Starting Arch Linux installation"
# Install packman packages

# Install yay and yay packages
$BOOTSTRAP_DIR/yay-install.sh

# Install asdf
$BOOTSTRAP_DIR/asdf-install.sh

# Enables mdns resolution for Avahi
#sudo sed -i 's/hosts: mymachines resolve \[!UNAVAIL=return\] files myhostname dns/hosts: mymachines mdns_minimal \[NOTFOUND=return\] resolve \[!UNAVAIL=return\] files myhostname dns/' /etc/nsswitch.conf

# Enable fingerprint
echo "Enabling fingerprint for services:"
for service in sudo system-local-login; do
    if ! grep -q fprintd "/etc/pam.d/$service"; then
        sudo sed -i '/auth.*include/i auth            sufficient      pam_fprintd.so' "/etc/pam.d/$service"
    else
        echo "Fingerprint already configured for $service, skipping..."
    fi
done
