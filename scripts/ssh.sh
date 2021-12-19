# Install openssh-server
apt-get install openssh-server
# systemctl allows you to control the state of systemd deamons (services)
# Returns the status of the ssh deamon running in the background.
systemctl status sshs
service sshs status
# Enable sshd
systemctl enable sshd
# Open ssh daemon config with nano and add the rules
nano /etc/ssh/sshd_config
"
Port 4242
PermitRootLogin no
"
# Restart sshd and verify changes
systemctl restart sshd
ss -tunlp
# Connect through ssh through port 4242 from within the VM
ssh -p 4242 root@localhost
ssh -p 4242 lpaulo-m@localhost
# Connect through ssh through port 4242 from outside
ssh -p 4242 root@192.168.0.15
ssh -p 4242 lpaulo-m@192.168.0.15
# Copy file to server
scp -P 4242 FILEPATH lpaulo-m@192.168.0.15:DESTINATION
# Copy file from server
scp -P 4242 lpaulo-m@192.168.0.15:FILEPATH DESTINATION

# Useful ssh configs for servers
# https://www.digitalocean.com/community/questions/keep-my-ssh-session-alive
sudo nano /etc/ssh/sshd_config
"
ClientAliveInterval 30
TCPKeepAlive yes
ClientAliveCountMax 99999
"
service sshd restart
