# Lists information about all available or the specified block devices,
# (partitions, logical volumes, etc.)
lsblk

# Information about the distro and its version.
cat /etc/os-release
head -n 2 /etc/os-release

# Returns AppArmor status.
/usr/sbin/aa-status
/usr/bin/aa-enabled

# Login and out
login
logout
exit
CTRL+D

# Shutdown is safer than poweroff
shutdown
shutdown now
reboot
poweroff

# Set a static IP
# Install net-tools and discover your address, broadcast, netmask and gateway
apt-get install net-tools
ifconfig -a
route -n
# Open the interfaces file and set the static IP with the discovered values:
nano /etc/network/interfaces
"source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
allow-hotplug INTERFACENAME
iface INTERFACENAME inet static
      address SOMETHING
      broadcast SOMETHING
      netmask SOMETHING
      gateway SOMETHING
iface INTERFACENAME inet static"
# Check if we have internet by pinging google's DNS server
ping 8.8.8.8
# Dump statistics about open tunnel sockets. Similar to netstat.
ss -tunlp

# The file that lists all users and some configuration data associated with them.
cat /etc/passwd
# List groups associated with the user
id USERNAME
groups USERNAME
# List of all groups
cat /etc/group
# Adds the user to the group
addgroup USERNAME GROUPNAME
# Creates a group
groupadd GROUPNAME

# Shows user's password aging information
chage -l USERNAME
# Set password policy for all users by modifying
# PAM's (Pluggable Authentication Modules) common-password  config file.
nano /etc/pam.d/common-password
# OPTIONS
# pam_cracklib.so:
# try_first_pass:
# retry=3: Prompt a user 3 times before returning with error.
# minlen=10: The password length cannot be less than this parameter
# lcredit=-1: Must have at least one lowercase character.
# ucredit=-1: Require at least one uppercase character
# dcredit=-1: must have at least one digit
# difok=7: The number of characters in the new password that must not have been present in the old password.
# maxclassrepeat=2:
# reject_username: Rejects the password if contains the name of the user in either straight or reversed form.
# maxrepeat=3: Allow a maximum of 3 repeated characters
# gecoscheck=1: Words in the GECOS field of the user’s passwd entry are not contained in the new password.
# enforce_for_root: Enforce pasword policy for root user

# Show hostname
hostnamectl status
cat /etc/hostname
# Change the systems hostname
hostnamectl set-hostname NEWHOSTNAME
# Manually change the hostname on /etc/hosts to remove sudo error:
nano /etc/hosts

# Change user's username, home dir and group
usermod -l NEWNAME OLDNAME
usermod -d /home/NEWNAME -m NEWNAME
groupmod -n NEWNAME OLDNAME

# Program that lets some users run
sudo
# Add user to sudoers so he can sudo too
sudo adduser USERNAME
# Open sudo config file with nano
nano /etc/sudoers
# Open sudo config file with vim
sudo visudo
# Open sudo access logs
cd /var/log/sudo/ && cat log_sudo

# Install Uncomplicated Firewall (ufw) in your machine
apt-get install ufw
# Script that prints ufw status.
/usr/sbin/ufw status
ufw status
# Creates an allow rule for the port
ufw allow PORTNUM
# List rules with rule number
ufw status numbered
# Deletes rule
ufw delete RULENUMBER

# systemctl allows you to control the state of systemd deamons (services)
# Returns the status of the ssh deamon running in the background.
systemctl status ssh
# Open ssh daemon config with nano
nano /etc/ssh/sshd_config
# Log into ssh as root through port 4242
ssh -p 4242 root@localhost
# Log into ssh as USERNAME through port 4242
ssh -p 4242 USERNAME@localhost

# General kernel and system information, all flags.
uname -a

# Edit crontab's tasks config file and add create a cronjob that runs the script.
crontab -e
# Edit monitoring.sh script
nano /usr/local/bin/monitoring.sh

# Generate a hash from the file
sha1sum ~/Documents/virtual_boxes/born2beroot/born2beroot.vdi

# Creates a new logical volume within an LVM Group
mkfs.ext4 /dev/LVMGROUPNAME/VOLUMENAME
# Mounts the volume in the mountpoint
mount /dev/LVMGROUPNAME/VOLUMENAME MOUNTPOINT
