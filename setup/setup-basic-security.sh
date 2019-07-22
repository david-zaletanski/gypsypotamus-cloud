#!/usr/bin/env bash
# setup-basic-security.sh

# Prevent SSH bruteforce
sudo apt-get install fail2ban

# Copy config file to make local config
awk '{ printf "# "; print; }' /etc/fail2ban/jail.conf | sudo tee /etc/fail2ban/jail.local

# Edit config
sudo nano jail.local

# Enable sshd jail and customize ban settings
[sshd]
enabled = true
# 1h ban time
bantime = 3600
# if someone fails 3x in
maxretry = 3
# 10 min span
findtime = 600

# Restart fail2ban
sudo service fail2ban restart

### UFW Firewall
# Allow SSH and HTTP ports and block others
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Enable it
sudo ufw enable

# Double check
sudo ufw status verbose
