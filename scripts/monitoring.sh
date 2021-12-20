#/usr/bin/bash!

# Print commands and their arguments as they are executed. Useful for debugging
# set -x

get_architecture() {
  # Gets system info with uname
  uname -a
}

extract_from_lscpu() {
  target_line=$1

  # List cpu info
  lscpu |
    # Gets the target line
    sed -n "$target_line p" |
    # Gets the second column delimited by ":"
    cut -d ':' -f 2 |
    # Removes all spaces
    sed -e 's/ //g'
}

get_cpu_count() {
  # Get's line 5 - "CPU(s)""
  extract_from_lscpu 5
}

get_core_count() {
  # Get's line 8 - "Core(s) per socket"
  extract_from_lscpu 8
}

get_memory_usage() {
  kb_to_mb() {
    kb=$1

    # 1024 kB == 1 MB
    expr $kb / 1024
  }

  extract_from_meminfo() {
    target_line=$1

    # Memory info
    cat /proc/meminfo |
      # Gets the target line
      sed -n "$target_line p" |
      # Gets the second column delimited by ":"
      cut -d ':' -f 2 |
      # Removes all spaces
      sed -e 's/ //g' |
      # Remove kB ending
      sed -e 's/kB//g'
  }

  extract_meminfo_in_mb() {
    target_line=$1

    in_kb=$(extract_from_meminfo $target_line)

    kb_to_mb $in_kb
  }

  get_total_memory() {
    # Get's line 1 - "MemTotal"
    extract_meminfo_in_mb 1
  }

  get_available_memory() {
    # Get's line 3 - "MemAvailable"
    extract_meminfo_in_mb 3
  }

  get_used_memory() {
    total_memory=$1
    available_available=$2

    expr $total_memory - $available_available
  }

  get_used_percentage() {
    total_memory=$1
    used_memory=$2

    # "scale" determines the decimal precission
    echo "scale=20; $used_memory / $total_memory * 100" |
      # Call basic calculator with standad math lib
      bc -l |
      # Remove the last 18 digits from the string
      awk '{ print substr( $0, 1, length($0)-18 ) }'
  }

  function build_memory_usage() {
    printf "%s/%sMB (%s%%)" $used_memory $total_memory $used_percentage
  }

  total_memory=$(get_total_memory)
  available_memory=$(get_available_memory)
  used_memory=$(get_used_memory $total_memory $available_memory)
  used_percentage=$(get_used_percentage $total_memory $used_memory)

  build_memory_usage
}

architecture=$(get_architecture)
physical_cpu_count=$(get_core_count)
virtual_cpu_count=$(get_cpu_count)
memory_usage=$(get_memory_usage)
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
