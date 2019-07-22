#!/usr/bin/env bash
# setup-users.sh

# Add administrative user
adduser chief
usermod -aG sudo chief
# To test type 'su - chief' and attempt to use sudo

# Disable root account
sudo passwd -l root
# To enable simply do sudo passwd and enter a new one

# To prevent chief from having to ente rpassword again for sudo everytime
sudo visudo
# Add the following line at bottom of file
# chief   ALL=(ALL:ALL) NOPASSWD: ALL
