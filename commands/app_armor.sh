# Returns apparmor status.
/usr/sbin/aa-status
/usr/bin/aa-enabled
# Enable the apparmor daemon and check
systemctl enable apparmor
systemctl status apparmor
