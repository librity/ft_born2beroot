# Install ripgrep (grep but better)
apt-get install ripgrep

# General kernel and system information, all flags.
uname -a

# Information about the distro and its version.
cat /etc/os-release
head -n 2 /etc/os-release

# Login and out
login
logout
exit
# CTRL+D

# Shutdown is safer than poweroff
shutdown now
reboot now
poweroff

# Search installed packages
dpkg -l | grep PACKAGE_NAME
# Search all available packages
apt list | grep PACKAGE_NAME
# Get package details
apt show PACKAGE_NAME

# Search previous commands
history | grep nano

# Get last boot date
uptime -s
who -b
# Get boot history
last reboot | less

# Sleep for X seconds
sleep X

# Get all IP addresses for the host
hostname -I

# Config files changed
nano /etc/network/interfaces
nano /etc/sudoers
nano /etc/login.defs
nano /etc/security/pwquality.conf
nano /etc/ssh/sshd_config

# Generate a hash from the file
sha1sum ~/Documents/virtualbox/born2beroot/born2beroot.vdi
