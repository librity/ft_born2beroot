#/usr/bin/bash!

# Broadcast message from root@wil (tty1) (Sun Apr 25 15:45:00 2021):
#Architecture: Linux wil 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 GNU/Linux
#CPU physical : 1
#vCPU : 1
#Memory Usage: 74/987MB (7.50%)
#Disk Usage: 1009/2Gb (39%)
#CPU load: 6.7%
#Last boot: 2021-04-25 14:45
#LVM use: yes
#Connexions TCP : 1 ESTABLISHED
#User log: 1
#Network: IP 10.0.2.15 (08:00:27:51:9b:a5)
#Sudo : 42 cmd

get_architecture() {
  # Gets architecture with uname
  uname -a
}

count_logic() {
  # List cpu info
  lscpu |
    # Gets the nth line from function arguments
    sed -n "$1 p" |
    # Gets the second column delimited by ":"
    cut -d ':' -f 2 |
    # Trims spaces
    sed -e 's/^[ ]*//'
}

get_cpu_count() {
  # Get's line 5
  count_logic 5
}

get_core_count() {
  # Get's line 8
  count_logic 8
}

architecture=$(get_architecture)
physical_cpu_count=$(get_core_count)
virtual_cpu_count=$(get_cpu_count)
memory_usage=$()
disk_usage=$()
cpu_load=$()
last_boot=$()
lvm_enabled=$()
tcp_connexions=$()
loggedin_users=$()
network_info=$()
sudo_commands=$()

message="
  # Architecture: $architecture
  # Physical CPUs (cores): $physical_cpu_count
  # Virtual CPUs (threads): $virtual_cpu_count
  # Memory Usage: $memory_usage
  # Disk Usage: $disk_usage
  # CPU load: $cpu_load
  # Last boot: $last_boot
  # LVM enabled: $lvm_enabled
  # TCP Connexions: $tcp_connexions
  # Logged-in Users: $loggedin_users
  # Network Info: $network_info
  # Sudo commands: $sudo_commands
"

echo $message

# wall $message
