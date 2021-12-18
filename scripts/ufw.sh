# Install and enable Uncomplicated Firewall (ufw) in your machine
apt-get install ufw
ufw enable
systemctl enable ufw
# Disable ufw
ufw disable
# Script that prints ufw status.
/usr/sbin/ufw status
ufw status verbose
# Creates an allow rule for the port
ufw allow PORTNUM
# List rules with rule number
ufw status numbered
# Deletes rule
ufw delete RULENUMBER
