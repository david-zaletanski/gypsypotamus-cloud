#!/usr/bin/env bash
# setup-tools.sh

# Git
sudo apt-get install git

# Apache2-Utils (htpasswd)
sudo apt install apahe2-utils

# Create htpasswd file
sudo htpasswd -c /opt/cadvisor/chief.htpasswd chief
# enter chief's password
