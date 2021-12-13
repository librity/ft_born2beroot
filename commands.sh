# Lists information about all available or the specified block devices,
# (partitions, logical volumes, etc.)
lsblk

# Information about the distro and its version.
cat /etc/os-release
head -n 2 /etc/os-release

# Returns apparmor status.
/usr/sbin/aa-status
/usr/bin/aa-enabled
# Enable the apparmor daemon and check
systemctl enable apparmor
systemctl status apparmor

# Login and out
login
logout
exit
CTRL+D

# Shutdown is safer than poweroff
shutdown now
reboot now
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
# Reboot for changes to take effect
reboot now
# Check if we have internet by pinging google's DNS server
ping 8.8.8.8
# Check if there's no longer an open dhcp client port (UDP 68).
ss -tunlp
# ss lists open tunnel sockets. Similar to netstat.

# The file that lists all users and some configuration data associated with them.
cat /etc/passwd | cut -d ":" -f 1 | grep root
# Lists all logged-in users
users
# Creates a new user
useradd USERNAME
# Creates a new user with home dir
adduser USERNAME
# Change user's username, home dir and group
usermod -l NEWNAME OLDNAME
usermod -d /home/NEWNAME -m NEWNAME
groupmod -n NEWNAME OLDNAME
# Deletes user and user's home dir
userdel -r USERNAME

# List groups associated with the user
id USERNAME
groups USERNAME
# List of all groups
cat /etc/group | cut -d ":" -f 1 | grep sudo
# Creates a group
groupadd GROUPNAME
# Deletes a group
groupdel GROUPNAME
# Adds the user to the group
addgroup USERNAME GROUPNAME
gpasswd -a USERNAME GROUPNAME
# Removes user from group
gpasswd -d USERNAME GROUPNAME
# Returns user's main group GID
id -g USERNAME

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

# Program that lets some users run
sudo
# Open sudo config file with nano or vim and add the required rules
nano /etc/sudoers
sudo visudo
"Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin\"
Defaults        badpass_message=\"CUSTOM MESSAGEE\"
Defaults        requiretty
Defaults        passwd_tries=3
Defaults        logfile=\"/var/log/sudo/sudo.log\""
# requiretty - If set, sudo will only run when the user is logged in to a real tty.
# When this flag is set, sudo can only be run from a login session
# and not via other means such as cron(8) or cgi-bin scripts.
# This flag is off by default.
# Create the log file
sudo mkdir /var/log/sudo
sudo touch /var/log/sudo/sudo.log
# Open sudo access logs
sudo cat /var/log/sudo/sudo.log

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

# Install openssh-server
apt-get install openssh-server
dpkg -l | grep ssh
# systemctl allows you to control the state of systemd deamons (services)
# Returns the status of the ssh deamon running in the background.
systemctl status sshs
service sshs status
# Enable sshd
systemctl enable sshd
# Open ssh daemon config with nano and add the rules
nano /etc/ssh/sshd_config
"Port 4242
PermitRootLogin no"
# Restart sshd and verify changes
systemctl restart sshd
ss -tunlp
# Connect through ssh through port 4242 from within the VM
ssh -p 4242 root@localhost
ssh -p 4242 lpaulo-m@localhost
# Connect through ssh through port 4242 from outside
ssh -p 4242 root@192.168.0.15
ssh -p 4242 lpaulo-m@192.168.0.15

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
