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

# Search previous commands
history | grep nano

# Get last boot date
who -b
# Get boot history
last reboot | less

# Config files changed
nano /etc/login.defs
nano /etc/sudoers
nano /etc/network/interfaces
nano /etc/ssh/sshd_config
nano /etc/security/pwquality.conf

# Generate a hash from the file
sha1sum ~/Documents/virtual_boxes/born2beroot/born2beroot.vdi
