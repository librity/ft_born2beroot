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

# Generate a hash from the file
sha1sum ~/Documents/virtual_boxes/born2beroot/born2beroot.vdi
