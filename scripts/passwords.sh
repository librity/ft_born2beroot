# Shows user's password aging information
chage -l USERNAME
# To enforce pasword change every 30 days we modify the file:
nano /etc/login.defs
"
# Maximum days before password change
PASS_MAX_DAYS 30
# Minimum days before password change
PASS_MIN_DAYS 2
# Warn user 7 days before expiration
PASS_WARN_AGE 7
# Enforce minimum password length of 10
PASS_MIN_LEN 10
"
# These configs will only apply to new user.
# We can force them onold users with chage:
chage -M 30 USERNAME
chage -m 2 USERNAME
chage -W 7 USERNAME
chage -l USERNAME

# Install password quality security module for PAM
sudo apt-get install libpam-pwquality
# Set password policy for all users by modifying
# PAM's (Pluggable Authentication Modules) common-password  config file.
nano /etc/security/pwquality.conf
"
# Require at least one uppercase character
ucredit = -1
# Require at least one digit
dcredit = -1
# No more than 3 consecutive identical characters
maxrepeat = 3
# Check if it contains the username 
usercheck = 1
# The number of characters in the new password that must not have been present in the old password.
difok = 7
# Enforce pasword policy for root user
enforce_for_root

# OPTIONAL
# Minimum password length of 10
minlen = 10
# Require at least one lowercase character
lcredit = -1
"
# Change currenr user's password
passwd
# Change password of any user, bypasses rules
chpasswd <<<"USERNAME:NEWPASSWORD"
