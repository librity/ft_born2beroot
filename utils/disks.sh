# Lists information about all available or the specified block devices,
# (partitions, logical volumes, etc.)
lsblk
cat /etc/fstab

# Creates a new logical volume within an LVM Group
mkfs.ext4 /dev/LVMGROUPNAME/VOLUMENAME
# Mounts the volume on the mountpoint
mount /dev/LVMGROUPNAME/VOLUMENAME MOUNTPOINT

# List storage statistic system's partitions
df -BG
df -a --output | less
df -h /dev/sda1 --output=source,fstype,size,used,avail,pcent
df -h --total

# List storage usage of current dir
du
du -BM

# Get LVM statistics
lvdisplay
vgdisplay
