# Program that lets some users run
sudo
# Open sudo config file with nano or vim and add the required rules
nano /etc/sudoers
sudo visudo
"
Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin\"
Defaults        badpass_message=\"CUSTOM MESSAGEE\"
Defaults        requiretty
Defaults        passwd_tries=3
Defaults        logfile=\"/var/log/sudo/sudo.log\"
"
# requiretty - If set, sudo will only run when the user is logged in to a real tty.
# When this flag is set, sudo can only be run from a login session
# and not via other means such as cron(8) or cgi-bin scripts.
# This flag is off by default.
# Create the log file
sudo mkdir /var/log/sudo
sudo touch /var/log/sudo/sudo.log
# Open sudo access logs
sudo cat /var/log/sudo/sudo.log

# Create and delete a sudoer user
adduser USERNAME
addgroup USERNAME sudo
userdel -r USERNAME
