#/usr/bin/bash!

get_architecture() {
  # Gets system info with uname
  uname -a
}

count_logic() {
  target_line=$1

  # List cpu info
  lscpu |
    # Gets the nth line from function arguments
    sed -n "$target_line p" |
    # Gets the second column delimited by ":"
    cut -d ':' -f 2 |
    # Removes all spaces
    sed -e 's/ //g'
}

get_cpu_count() {
  # Get's line 5
  count_logic 5
}

get_core_count() {
  # Get's line 8
  count_logic 8
}

# get_memory_usage() {
# }

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

echo "
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

# wall "
#   # Architecture: $architecture
#   # Physical CPUs (cores): $physical_cpu_count
#   # Virtual CPUs (threads): $virtual_cpu_count
#   # Memory Usage: $memory_usage
#   # Disk Usage: $disk_usage
#   # CPU load: $cpu_load
#   # Last boot: $last_boot
#   # LVM enabled: $lvm_enabled
#   # TCP Connexions: $tcp_connexions
#   # Logged-in Users: $loggedin_users
#   # Network Info: $network_info
#   # Sudo commands: $sudo_commands
# "
