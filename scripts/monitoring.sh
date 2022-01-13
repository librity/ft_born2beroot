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
      # Remove kB unit
      sed -e 's/kB//g'
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
    expr $total_memory - $available_memory
  }

  get_used_percentage() {
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
  used_memory=$(get_used_memory)
  used_percentage=$(get_used_percentage)

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
      # Remove G unit
      sed -e 's/G//g'
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
    printf "%s/%sGB (%s)" $disk_used $disk_total $disk_used_percent
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
    echo "100 - $cpu_idle_percent" |
      bc -l
  }

  build_cpu_load() {
    printf "%s%%" $cpu_load_percent
  }

  raw_cpu_load=$(get_raw_cpu_load)
  read -a split_cpu_load <<<"$raw_cpu_load"

  cpu_idle_percent=$(get_cpu_idle_percent)
  cpu_load_percent=$(get_cpu_load_percent)

  build_cpu_load
}

get_last_boot() {
  # "system up since" flag
  uptime -s
}

get_lvm_enabled() {
  count_available_lvs() {
    # List all block devices
    lsblk |
      # Count how many are logical volumes
      grep -c lvm
  }

  is_lvm_enabled() {
    # If available > 0
    if [ $available_lv_count -gt 0 ]; then
      echo "true"
    else
      echo "false"
    fi
  }

  available_lv_count=$(count_available_lvs)

  is_lvm_enabled
}

get_tcp_connetions() {
  count_established_tcp() {
    # Get all TCP connections
    ss -t |
      # Count how many have Established status
      grep -c ESTAB
  }

  tcp_status() {
    if [ $established_tcp_count -gt 0 ]; then
      echo "ESTABLISHED"
    else
      echo "NOT ESTABLISHED"
    fi
  }

  build_tcp_connetions() {
    printf "%s - %s" $established_tcp_count $tcp_status
  }

  established_tcp_count=$(count_established_tcp)
  tcp_status=$(tcp_status)

  build_tcp_connetions
}

get_loggedin_users() {
  # Get logged-in users
  who |
    # Count them
    wc -l
}

get_ip_address() {
  # List all IP addresses for the host
  hostname -I |
    # Get the first one
    cut -d " " -f 1
}

get_mac_address_first_match() {
  # Get network devices with ip utility
  ip link |
    # Get the first ethernet device
    grep -m 1 link/ether |
    # Extract the MAC address
    cut -d ' ' -f 6
}

get_mac_address() {
  TARGET_INTERFACE=enp0s3
  # TARGET_INTERFACE=wlp2s0

  # Get mac address of target ineterface
  cat /sys/class/net/$TARGET_INTERFACE/address
}

get_sudo_commands() {
  # Query systemd's journal for executions of sudo
  journalctl -q _COMM=sudo |
    # Count successful executions of sudo
    grep -c COMMAND
}

build_report() {
  architecture=$(get_architecture)
  physical_cpu_count=$(get_core_count)
  virtual_cpu_count=$(get_cpu_count)
  memory_usage=$(get_memory_usage)
  disk_usage=$(get_disk_usage)
  cpu_load=$(get_cpu_load)
  last_boot=$(get_last_boot)
  lvm_enabled=$(get_lvm_enabled)
  tcp_connetions=$(get_tcp_connetions)
  loggedin_users=$(get_loggedin_users)
  ip_address=$(get_ip_address)
  mac_address=$(get_mac_address)
  sudo_commands=$(get_sudo_commands)

  "
  # Architecture: $architecture
  # Physical CPUs (cores): $physical_cpu_count
  # Virtual CPUs (threads): $virtual_cpu_count
  # Memory Usage: $memory_usage
  # Disk Usage: $disk_usage
  # CPU load: $cpu_load
  # Last boot: $last_boot
  # LVM enabled: $lvm_enabled
  # TCP Connections: $tcp_connetions
  # Logged-in Users: $loggedin_users
  # IP address: $ip_address
  # MAC address: $mac_address
  # Sudo commands: $sudo_commands
  "
}

echo_report() {
  report=$(build_report)
  echo "$report"
}

broadcast_report() {
  report=$(build_report)
  wall report
}

get_boot_seconds() {
  # Get last boot timestamp
  uptime -s |
    # Extract its sconds
    cut -d ":" -f 3
}

get_boot_minutes() {
  uptime -s |
    # Extract its minutes
    cut -d ":" -f 2
}

seconds_till_next_report() {
  # Calculate how many seconds we need to wait before broadcasting the report
  echo "$(get_boot_minutes) % 10 * 60 + $(get_boot_seconds)" |
    # We're basically transforming minutes to seconds and adding them together
    bc
}

echo_delayed() {
  sleep $(seconds_till_next_report) && echo_report
}

broadcast_delayed() {
  sleep $(seconds_till_next_report) && broadcast_report
}

echo_report
# broadcast_report

# echo_delayed
# broadcast_delayed
