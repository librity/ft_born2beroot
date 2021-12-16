# Show hostname
hostnamectl status
cat /etc/hostname
# Change the systems hostname
hostnamectl set-hostname NEWHOSTNAME
# Manually change the hostname on /etc/hosts to remove sudo error:
nano /etc/hosts
