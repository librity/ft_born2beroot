# Get processor hardware data
sudo dmidecode --type processor
sudo lshw -C CPU
hwinfo --cpu

# Count the amount of processor entries in cpuinfo file
grep -c ^processor /proc/cpuinfo
# Number of processors
nproc
# List CPU info
lscpu

# Virtual CPU count
lscpu -p | grep -v '^#' | wc -l
# Physical CPU count
lscpu -p | grep -v '^#' | sort -u -t, -k 2,4 | wc -l

# Virtual CPU count
lscpu |
  # Gets the 5th line from lscpu
  sed -n '5 p' |
  # Gets the second column delimited by ":"
  cut -d ":" -f 2 |
  # Trims spaces
  sed -e 's/ //g'

# Physical CPU count
lscpu |
  sed -n '8 p' |
  cut -d ":" -f 2 |
  sed -e 's/ //g'
