<h3 align="center">42 São Paulo - Born2BeRoot</h3>

<div align="center">

![42 São Paulo](https://img.shields.io/badge/42-SP-1E2952)
![License](https://img.shields.io/github/license/librity/ft_born2beroot?color=yellow)
![Code size in bytes](https://img.shields.io/github/languages/code-size/librity/ft_born2beroot?color=blue)
![Lines of code](https://img.shields.io/tokei/lines/github/librity/ft_born2beroot?color=blueviolet)
![Top language](https://img.shields.io/github/languages/top/librity/ft_born2beroot?color=ff69b4)
![Last commit](https://img.shields.io/github/last-commit/librity/ft_born2beroot?color=orange)

</div>

<p align="center"> Virtual Linux server setup and config.
  <br>
</p>

---

## 📜 Table of Contents

- [About](#about)
- [Checklist](#checklist)
- [Notes](#notes)
- [42 São Paulo](#ft_sp)
- [Resources](#resources)

## 🧐 About <a name = "about"></a>

In this project we learn the fundamentals of UNIX, virtualization,
systems administration and shell scripting.
We configure a debian server server with LVM partitions,
write a sysinfo script and setup a wordpress website among other things.

## ✅ Checklist <a name = "checklist"></a>

## 📝 Notes <a name = "notes"></a>

### Logical vs Primary Partition

The Master Boot Record Partition scheme only allows for 4 primary partitions.
To get around this we create an extended partition that contains logical partitions.
Windows can't boot from logical partitions, only primary one.

### LVM (Logical Volume Management)

A device mapper framework that provides logical volume management,
i.e. the creation and use of logical partitions.

### Encrypted volumes

It's highly recommended to encrypt your logical volumes,
especially the swap partition.
You don't need to go crazy with the password, this isn't the NSA.

<p align="center">
  <img src="https://imgs.xkcd.com/comics/security.png">
</p>

### systemd

A software suite that provides an array of system components.
Arch, CentOS, CoreOS, Debian, Fedora, Linux, Mageia,
Manjaro, openSUSE, Red, Solus, SUSE and Ubuntu come with it by default.

### Linux directory structure

- `/`: The root directory
- `/bin`: Binaries accessible to everyone
- `/dev`: Device files, like logical volumes
- `/etc`: Configuration files
- `/usr`: User binaries and program data
  - `/usr/bin`: contains basic user commands
  - `/usr/sbin`: contains additional commands for the administrator
  - `/usr/lib`: contains the system libraries
  - `/usr/share`: contains documentation or common to all libraries, like `/usr/share/man`
- `/home`: User personal data
- `/lib`: Shared libraries
- `/sbin`: System/Super/Sudo binaries (that can only be run by root or a sudo user)
- `/tmp`: Temporary files
- `/var`: Variable data files (like logs)
- `/boot`: Boot files, usually a primary partition is mounted here
- `/proc`: Process and kernel files like `/proc/cpuinfo`
- `/opt`: Optional/3rd-party software
- `/root`: The home directory of the root
- `/media`: Mount point for removable media
- `/mnt`: Mount directory for file systems by sysadmins
- `/srv`: Service data, like web apps

### Security-Enhanced Linux (SELinux) vs. AppArmor

They're both Linux kernel security modules.
They both provide Mandatory Access Control (MAC).

Fedora and CentOS use SELinux by default.
Debian and Ubuntu use AppArmor by default.

AppArmor is easier to use but a little less secure.
SELinux is harder to use but more secure.

Before any syscall the kernel check with AppArmor or SELinux
if the process is allowed to execute that command.
By configuring them we can restrict the actions
that subjects (processes) can perform
on objects (files, IO, memory, Network ports, etc.)

### Uncomplicated Firewall (UFW)

A program that manages the Netfilter firewall framework, native to the Linux kernel.
Ubuntu comes with UFW by default.

### aptitude vs. apt vs. apt-get

They're all package managers that use `dpkg` behind the scenes.
They all use the same repositories.

`aptitude` provides a terminal menu interface with `ncurses`
and it's easier to use.
Advanced Packaging Tool (`apt`) and `apt-get` are a collection of CLI tools.
`apt-get` was the first sub-project of `apt`.

Debian comes with `apt` by default.

### PAM (Pluggable Authentication Modules)

A suite of libraries that allows a Linux system administrator
to configure methods to authenticate users.
This is where we set the password policy.

### CPU Core (Physical) vs Thread (Virtual)

A CPU core is an independent processing unit that processes one command at a time.
It's a physical component inside a chip, mounted on a socket on the motherboard.
Modern chips, having multiple cores, need some way of sharing their processing
resources with many programs at the same time.

Threads solve this problem by distributing instructions to multiple cores.
They're virtual components that manage the CPU schedule.
They act like independent CPU
since programs interact with them as they would a core:
a thread receives a command,
sends it to an available core,
waits for it to execute and returns the value.

My computer runs on an
[Intel Core i7-7700HQ](https://www.intel.com/content/www/us/en/products/sku/97185/intel-core-i77700hq-processor-6m-cache-up-to-3-80-ghz/specifications.html).
It has 4 cores and 8 threads, so my system monitor list it as 8 virtual CPUs.

<p align="center">
  <img src=".github/concurrency_vs_parallelism.svg">
</p>

### `monitoring.sh`

We have to write a monitoring script that broadcasts every 10 minutes
various system stats with `wall`:

```bash
# Broadcast message from root@wil (tty1) (Sun Apr 25 15:45:00 2021):
#Architecture: Linux wil 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 GNU/Linux
#CPU physical : 1
#vCPU : 1
#Memory Usage: 74/987MB (7.50%)
#Disk Usage: 1009/2Gb (39%)
#CPU load: 6.7%
#Last boot: 2021-04-25 14:45
#LVM use: yes
#Connexions TCP : 1 ESTABLISHED
#User log: 1
#Network: IP 10.0.2.15 (08:00:27:51:9b:a5)
#Sudo : 42 cmd
```

## 🛸 42 São Paulo <a name = "ft_sp"></a>

Part of the larger [42 Network](https://www.42.fr/42-network/),
[42 São Paulo](https://www.42sp.org.br/) is a software engineering school
that offers a healthy alternative to traditional education:

- It doesn't have any teachers and classes.
- Students learn by cooperating
  and correcting each other's work (peer-to-peer learning).
- Its focus is as much on social skills as it is on technical skills.
- It's completely free to anyone that passes its selection process -
  [**The Piscine**](https://42.fr/en/admissions/42-piscine/)

It's an amazing school, and I'm grateful for the opportunity.

## 📚 Resources <a name = "resources"></a>
