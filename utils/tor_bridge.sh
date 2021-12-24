# Login as root
sudo su
# Install TOR
apt-get update
apt-get install tor

nano /etc/tor/torrc
"
Nickname    RELAY_NAME
ContactInfo YOUR@EMAIL.COM
ORPort      443
ExitRelay   0
SocksPort   0
"
# Allow traffic through port 443
ufw allow 443

# Restart and enable the tor daemon
systemctl restart tor@default
systemctl enable tor@default

# Monitor your logs
tail /var/log/syslog
sudo cat /var/log/syslog | grep Tor

# Verify IPv6 availability
ping6 -c2 2001:858:2:2:aabb:0:563b:1526 &&
  ping6 -c2 2620:13:4000:6000::1000:118 &&
  ping6 -c2 2001:67c:289c::9 &&
  ping6 -c2 2001:678:558:1000::244 &&
  ping6 -c2 2607:8500:154::3 &&
  ping6 -c2 2001:638:a000:4140::ffff:189 &&
  echo OK.

# Backup Tor Identity Keys
cp /var/lib/tor/keys/* /some/where/safe/

# Install and run nyx (command-line monitor for Tor)
apt-get install nyx
nyx
