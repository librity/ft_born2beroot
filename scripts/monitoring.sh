#!/usr/bin/env bash

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
      # Remove all non-digit chars
      sed -e 's/[^0-9]*//g'
  }

  extract_meminfo_in() {
    target_line=$1

    in_kb=$(extract_from_meminfo $target_line)

    kb_to_mb $in_kb
  }

  get_total_memory() {
    # Get's line 1 - "MemTotal"
    extract_meminfo_in 1
  }

  get_available_memory() {
    # Get's line 3 - "MemAvailable"
    extract_meminfo_in 3
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

  build_memory_usage() {
    printf "%s/%sMB (%s%%)" $used_memory $total_memory $used_percentage
  }

  total_memory=$(get_total_memory)
  available_memory=$(get_available_memory)
  used_memory=$(get_used_memory $total_memory $available_memory)
  used_percentage=$(get_used_percentage $total_memory $used_memory)

  build_memory_usage
}

get_disk_usage() {
  get_raw_disk_usage() {
    # Get the total disk usage in human readable form
    df -h --total |
      # Get the last line
      tail -n 1
  }

  get_clean_disk_usage() {
    index=$1

    # Get element by index
    echo ${split_disk_usage[$index]} |
      # Remove all non-digit chars
      sed -e 's/[^0-9]*//g'
  }

  get_disk_total() {
    get_clean_disk_usage 1
  }

  get_disk_used() {
    get_clean_disk_usage 2
  }

  get_disk_used_percent() {
    get_clean_disk_usage 4
  }

  build_disk_usage() {
    printf "%s/%sGB (%s%%)" $disk_used $disk_total $disk_used_percent
  }

  raw_disk_usage=$(get_raw_disk_usage)
  # Split by spaces and create an array
  read -a split_disk_usage <<<"$raw_disk_usage"

  disk_total=$(get_disk_total)
  disk_used=$(get_disk_used)
  disk_used_percent=$(get_disk_used_percent)

  build_disk_usage
}

get_cpu_load() {
  get_raw_cpu_load() {
    # Get processor statistics
    mpstat |
      tail -n 1
  }

  get_cpu_idle_percent() {
    # Get last element
    echo ${split_cpu_load[-1]}
  }

  get_cpu_load_percent() {
    cpu_idle_percent=$1

    echo "100 - $cpu_idle_percent" |
      bc -l
  }

  build_cpu_load() {
    printf "%s%%" $cpu_load_percent
  }

  raw_cpu_load=$(get_raw_cpu_load)
  read -a split_cpu_load <<<"$raw_cpu_load"

  cpu_idle_percent=$(get_cpu_idle_percent)
  cpu_load_percent=$(get_cpu_load_percent $cpu_idle_percent)

  build_cpu_load
}

get_last_boot() {
  get_last_boot_date() {
    echo ${split_boot_info[2]}
  }

  get_last_boot_time() {
    echo ${split_boot_info[3]}
  }

  build_last_boot() {
    printf "%s %s" $last_boot_date $last_boot_time
  }

  raw_boot_info=$(who -b)
  read -a split_boot_info <<<"$raw_boot_info"

  last_boot_date=$(get_last_boot_date)
  last_boot_time=$(get_last_boot_time)

  build_last_boot
}

get_lvm_enabled() {
  count_available_lvs() {
    lvdisplay |
      grep -c available
  }

  is_lvm_enabled() {
    if [ $available_lv_count -gt 0 ]; then
      echo "true"
    else
      echo "false"
    fi
  }

  available_lv_count=$(count_available_lvs)

  is_lvm_enabled
}

architecture=$(get_architecture)
physical_cpu_count=$(get_core_count)
virtual_cpu_count=$(get_cpu_count)
memory_usage=$(get_memory_usage)
disk_usage=$(get_disk_usage)
cpu_load=$(get_cpu_load)
last_boot=$(get_last_boot)
lvm_enabled=$(get_lvm_enabled)
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
