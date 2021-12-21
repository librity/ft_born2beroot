# The file that lists all users and some configuration data associated with them.
cat /etc/passwd | cut -d ":" -f 1 | grep root
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

# Lists all logged-in users
users
# Count logged-in users
who --count
who | sort --key=1,1 --unique | wc --lines
who | wc -l
users | tr ' ' '\n' | sort -u | wc -l
