# Lists information about all available or the specified block devices,
# (partitions, logical volumes, etc.)
lsblk

# Creates a new logical volume within an LVM Group
mkfs.ext4 /dev/LVMGROUPNAME/VOLUMENAME
# Mounts the volume on the mountpoint
mount /dev/LVMGROUPNAME/VOLUMENAME MOUNTPOINT
