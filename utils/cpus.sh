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

# CPU Load
grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'
top -bn1 | grep "Cpu(s)" |
  sed "s/.*, *\([0-9.]*\)%* id.*/\1/" |
  awk '{print 100 - $1"%"}'
awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' \
  <(grep 'cpu ' /proc/stat) <(
    sleep 1
    grep 'cpu ' /proc/stat
  )
