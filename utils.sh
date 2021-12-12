# Lists information about all available or the specified block devices.
lsblk

# Information about the distro and its version.
cat /etc/os-release
head -n 2 /etc/os-release

# Dumps socket statistics.Similar to netstat.
ss -tunlp

# Script that prints AppArmor status.
/usr/sbin/aa-status
/usr/bin/aa-enabled

# Script that prints Uncomplicated Firewall (UFW) status.
/usr/sbin/ufw status
