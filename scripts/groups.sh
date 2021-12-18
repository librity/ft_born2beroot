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
# getent displays entries from system databases. Lists all users of a group
getent group GROUPNAME
# Removes user from group
gpasswd -d USERNAME GROUPNAME
# Returns user's main group GID
id -g USERNAME
