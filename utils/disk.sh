# List storage statistic system's partitions
df -BG
df -a --output | less
df -h /dev/sda1 --output=source,fstype,size,used,avail,pcent
df -h --total

# List storage usage of current dir
du
du -BM
