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
system administration and shell scripting.
Among other things, we create a debian virtual machine with LVM partitions,
write a sysinfo script and setup a wordpress website.

## ✅ Checklist <a name = "checklist"></a>

- [x] Install Debian VM w/ correct partitions and encrypted LVM
  - [x] Primary boot partition
  - [x] Encrypted LVM Group
    - [x] /
    - [x] /swap
    - [x] /home
    - [x] /var
    - [x] /srv
    - [x] /tmp
    - [x] /var/log
  - [x] lpaulo-m42 hostname
  - [x] lpaulo-m user
- [x] Add lpaulo-m to `sudo` and `user42` groups
- [x] Practice changing hostname
- [x] Practice creating and deleting a sudoer user
- [x] Install and configure `ufw`
  - [x] Create allow rule for port 4242
- [x] Install and configure `ssh`
  - [x] On port 4242
  - [x] Can't connect as root
  - [x] Set a static IP
- [x] Install and configure `sudo`
  - [x] Limit authentication to 3 attempts
  - [x] Add custom message on failed attempt
  - [x] Log authentication attempts in `/var/log/sudo/`
  - [x] Restrict sudo to TTY mode only
  - [x] Restrict sudo paths to `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`
- [x] Implement a strong password policy
  - [x] Expire password every 30 days.
  - [x] Wait 2 days before password change
  - [x] Warning message 7 days before expiration
  - [x] Minimum password length of 10
  - [x] Must contain an uppercase letter
  - [x] Must contain a digit
  - [x] No more than 3 consecutive identical chars
  - [x] Must not include username
  - [x] New password must have at least 7 characters that are not part of the former password (except for root user)
  - [x] Root password must comply
  - [x] Change all users passwords after config
- [x] Write `monitoring.sh`
  - [x] Runs every 10 minutes from startup
  - [x] Runs every 10 minutes (`crontab`)
  - [x] Broadcast the following statistics to all users (`wall`)
    - [x] The OS architecture and kernel version.
    - [x] Number of physical processors.
    - [x] Number of virtual processors.
    - [x] Available RAM and percentage utilization rate
    - [x] Current available storage and percentage utilization rate.
    - [x] Percentage utilization rate your processors.
    - [x] Date and time of last reboot.
    - [x] Whether LVM is active or not.
    - [x] Number of active connections.
    - [x] Number of users using the server.
    - [x] The IPv4 and MAC (Media Access Control) address.
    - [x] Number of commands executed with the sudo
- [x] Bonus
  - [x] Setup a Wordpress website
    - [x] lighttpd
    - [x] MariaDB
    - [x] PHP
    - [x] Wordpress
  - [x] Set up an arbitrary service
    - [x] `bitcoind`
    - [x] Tor **Bridge** Relay
- [x] Backup virtual box from file explorer
- [x] Get virtual drive signature and add it to intra’s project repo

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
Broadcast message from root@lpaulo-m42 (somewhere) (Tue Dec 21 00:30:01 2021):

  # Architecture: Linux lpaulo-m42 5.10.0-9-amd64 #1 SMP Debian 5.10.70-1 (2021-09-30) x86_64 GNU/Linux
  # Physical CPUs (cores): 2
  # Virtual CPUs (threads): 2
  # Memory Usage: 218/976MB (22.33%)
  # Disk Usage: 1.1/8.0GB (15%%)
  # CPU load: .14%
  # Last boot: 2021-12-20 09:49
  # LVM enabled: false
  # TCP Connections: 2 - ESTABLISHED
  # Logged-in Users: 2
  # IP address: 192.168.0.15
  # MAC address: 08:00:27:25:76:99
  # Sudo commands: 326
```

### Bonus Service Ideas

- [searx Search Engine](https://github.com/searx/searx)
  - https://searx.github.io/searx/admin/installation.html
  - https://searx.github.io/searx/admin/installation-searx.html
  - https://searx.github.io/searx/admin/installation-docker.html
- [phpMyAdmin](https://docs.phpmyadmin.net/en/latest/setup.html)
- [traefik Proxy](https://github.com/traefik/traefik/)
  - https://doc.traefik.io/traefik/getting-started/install-traefik/
  - https://github.com/approov/debian-traefik-setup
- [Cockpit sysadmin webview](https://github.com/cockpit-project/cockpit)
  - https://www.techlear.com/blog/2021/10/14/how-to-install-cockpit-on-debian-11/
- [fail2ban security](https://github.com/fail2ban/fail2ban)
  - https://www.fail2ban.org/wiki/index.php/MANUAL_0_8#Installation
- [vsftpd](https://github.com/InfrastructureServices/vsftpd)
  - https://www.osradar.com/how-to-set-up-an-ftp-server-on-debian-10-buster/
  - https://linuxconfig.org/how-to-setup-vsftpd-on-debian
- [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-debian-10)
- [PostgreSQL DB](https://linuxize.com/post/how-to-install-postgresql-on-debian-10/)
- [Email](https://www.tecmint.com/setup-postfix-mail-server-in-ubuntu-debian/)
- [DNS](https://blog.eldernode.com/private-dns-server-in-debian-10/)
- [InterPlanetary File System](https://github.com/ipfs/go-ipfs)
  - https://docs.ipfs.io/how-to/command-line-quick-start/#prerequisites
- One of your web apps:
  - Rails
  - Go
  - Node.js
- A blockchain node:
  - [https://bitcoin.org/en/full-node](https://bitcoin.org/en/full-node)
- A mixnet node:
  - [TOR Network Relay](<https://en.wikipedia.org/wiki/Tor_(network)>)
    - [Relay guide](https://community.torproject.org/relay/)
    - [Relay guide (onion link)](http://xmrhfasfg5suueegrnc4gsgyi2tyclcy5oz7f5drnrodmdtob6t2ioyd.onion/relay/)
  - [I2P](https://en.wikipedia.org/wiki/I2P)
  - [ZeroNet](https://en.wikipedia.org/wiki/ZeroNet)
  - [Retroshare](https://en.wikipedia.org/wiki/Retroshare)
  - [Tribler](https://en.wikipedia.org/wiki/Tribler)
  - [Nym](https://github.com/nymtech/nym)

### FastCGI

Is a protocol that interfaces applications (like PHP)
to web servers (like lighttpd and apache);

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
