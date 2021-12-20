# Set a static IP
# Install net-tools and discover your address, broadcast, netmask and gateway
apt-get install net-tools
ifconfig -a
route -n
# Open the interfaces file and set the static IP with the discovered values:
nano /etc/network/interfaces
"
source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
allow-hotplug INTERFACENAME
iface INTERFACENAME inet static
      address SOMETHING
      broadcast SOMETHING
      netmask SOMETHING
      gateway SOMETHING
iface INTERFACENAME inet static
"
# Reboot for changes to take effect
reboot now
# Check if we have internet by pinging google's DNS server
ping 8.8.8.8
# Check if there's no longer an open dhcp client port (UDP 68).
# ss returns socket statistics, similar to netstat.
ss -tunlp
# Another useful flag combination
ss -lstp
