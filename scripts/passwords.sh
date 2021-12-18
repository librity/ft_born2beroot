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

# Set password policy for all users by modifying
# PAM's (Pluggable Authentication Modules) common-password  config file.
nano /etc/pam.d/common-password
"
# 
pam_cracklib.so:
# 
try_first_pass:
# Prompt a user 3 times before returning with error.
retry=3
# The password length cannot be less than this parameter
minlen=10
# Must have at least one lowercase character.
lcredit=-1
# Require at least one uppercase character
ucredit=-1
# must have at least one digit
dcredit=-1
# The number of characters in the new password that must not have been present in the old password.
difok=7
# 
maxclassrepeat=2:
# Rejects the password if contains the name of the user in either straight or reversed form.
reject_username
# Allow a maximum of 3 repeated characters
maxrepeat=3
# Words in the GECOS field of the user’s passwd entry are not contained in the new password.
gecoscheck=1
# Enforce pasword policy for root user
enforce_for_root
"
# Change currenr user's password
passwd
# Change password of any user, bypasses rules
chpasswd <<<"USERNAME:NEWPASSWORD"
