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
