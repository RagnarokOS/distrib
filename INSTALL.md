# Install Guide

Although the installer is not yet ready, it is possible to install Ragnarok
via chroot using the miniroot tarball. The following guide assumes that you
will be using a [live](https://github.com/RagnarokOS/distrib/releases/download/01/live01-amd64.hybrid.iso)
Ragnarok ISO and that you know how to partition disks using command line tools
such as fdisk or cfdisk.

## Disclaimer

This is only for testing purposes. Ragnarok is not fully ready for production.
Under normal circumstances, system breakages should not happen but the absence
of bugs can not be guaranteed.

Breaking changes, however, are almost guaranteed to happen at some point.

## Tip

Do yourself a favor and launch tmux. The miniroot tarball being minimal, some
things will be missing which may cause errors with the terminal once chrooted
into the system. Doing the install in a tmux session will prevent them.

## Download miniroot.tgz

Before doing anything, fetch the miniroot tarball from the github releases page.
This step should be performed as the non-root user:

    $ wget -q --show-progress -O miniroot01.tgz https://github.com/RagnarokOS/distrib/releases/download/01/miniroot01.tgz

## Switch to root

From then on, all commands need to be run as root. In a live Ragnarok system,
simply use the `su` command. The password is `root`.

## Preparing the disk

External tools such as fdisk or cfdisk can be used to create partitions.
Use whatever tool you want, but make sure that once the partitioning is done,
all partitions are mounted to `/mnt/`. If your system uses EFI, make sure that
the first partition is in fat32 format with at least 500mb of space.

When you're done creating the partitions, use mkfs to format the filesystems,
then mount the partitions to /mnt.

A recommended scheme for EFI systems is a 500mb /boot partition, a swap partition
at least equal in size to the system's available RAM, a 30-35Gb root partition and
a home partition utilizing the rest of the available space.

For legacy systems, the same scheme can be used, minus the boot partition.

Example mkfs/mount commands, assuming you have used the recommended partitioning
scheme (substitute *X* with the proper device letter):

EFI:  

    # mkfs.fat -F 32 /dev/sdX1
    # mkswap /dev/sdX2
    # mkfs.ext4 /dev/sdX3
    # mkfs.ext4 /dev/sdX4

    # mount -t ext4 -o errors=remount-ro /dev/sdX3 /mnt
    # swapon /dev/sdX2
    # mkdir -p /mnt/{boot/efi,home}
    # mount -t vfat -o umask=0077,noexec,nosuid,nodev /dev/sdX1 /mnt/boot/efi
    # mount -t ext4 -o defaults /dev/sdX4 /mnt/home

Legacy/Bios:  

    # mkswap /dev/sdX1
    # swapon /dev/sdX1
    # mkfs.ext4 /dev/sdX2
    # mkfs.ext4 /dev/sdX3

    # mount -t ext4 -o errors=remount-ro /dev/sdX2 /mnt
    # mkdir -p /mnt/home
    # mount -t ext4 -o defaults /dev/sdX3 /mnt/home

## Extract miniroot.tgz

Once you are certain all partitions are mounted to `/mnt/`, you can now untar
miniroot01.tgz:

    # tar xzpvf miniroot01.tgz --xattrs --xattrs-include='*' --numeric-owner -C /mnt

## Generate the fstab file

Use the `genfstab` command to generate a proper fstab file:

    # genfstab -U /mnt >> /mnt/etc/fstab

## Networking

Copy the system's /etc/resolv.conf to the chroot:

    # cp /etc/resolv.conf /mnt/etc/resolv.conf

Copy /etc/network/interfaces to the chroot for good measure:

    # mkdir -p /mnt/etc/network
    # cp /etc/network/interfaces /mnt/etc/network/

If you configured a wireless connection in /etc/network/interfaces.d/, you
can copy this directory to the chroot as well:

    # cp -r /etc/network/interfaces.d/ /mnt/etc/network/

## Chroot to the new system

Now, use the arch-chroot command to chroot into the system:

    # arch-chroot /mnt/ /bin/ksh


## Updates

Update the package repository:

    # apt-get update

## Set the timezone

Run the following command and follow the steps:

    # dpkg-reconfigure tzdata

# Create hosts and hostname files

Choose a hostname for your system, then

    # echo "yourhostname" > /etc/hostname

Use a text editor to create/open /etc/hosts. You may install vim right away
(this package will be installed later via the ragnarok-base package either
way) or use the already installed ed(1).

If using ed, launch with a nice prompt:

    # ed -p ':'
    
While in prompt mode, type `a`, then hit `Return` then type:

    127.0.0.1   localhost
    127.0.1.1   yourhostname

    ::1         localhost ip6-localhost ip6-loopback
    ff02::1     ip6-allnodes
    ff02::2     ip6-allrouters

When done, hit `Return` then type `.` to actually write all the lines, then
`Return`.

Back in prompt mode, type:

    w /etc/hosts

Hit `q` then `Return` again to exit ed. You may run `cat /etc/hosts` to make
sure everything is correct.

## Locale and Keyboard configuration

Set your locale and configure keymaps:

    # apt-get install locales -y
    # dpkg-reconfigure locales
    # apt-get install console-setup -y

## Install the kernel

Ragnarok has its own experimental kernel built with LLVM/Clang, which takes advantage
of Clang's ThinLTO feature and bakes in many security options. Although no bugs were
found, it has not been tested on enough hardware to guarantee that none will ever be
found.

It is recommended to install Ragnarok's kernel as well as Debian's as a backup. Do note,
however, that Ragnarok's kernel build does not support secure boot, so if secure boot is
needed, only install Debian's.

Use the kernupd(8) utility to install Ragnarok's kernel flavour (this utility will have to
be used to update the kernel, for as long as it remains experimental.

Install Debian's kernel first:

    # apt-get install linux-image-amd64 -y

Then, download and install Ragnarok's kernel build:

    # kernupd -d
    # kernupd -i

*The download and install need to be done separately here, but under normal circumstances
kernupd with no arguments would do both simultaneously if the kernel is out-of-date or
not yet installed.*

## Install the base set

Now, complete the base system installation:

    # apt-get install ragnarok-base -y

## Install extra sets (optional)

These sets are optional, but highly recommended. Generally speaking, there should be a valid
reason to not install a certain set (IE: a server would obviously not need them). If you choose
to skip their installation here, you can always install them later on anyway.

The sets that can be installed:

devel:  the LLVM/Clang toolchain plus build-essential  
xserv:  minimal xserver and xinit  
xprogs: contains Window Managers (Raven and cwm) as well as the ragnarok-terminal (rt) and
        dmenu.      
xfonts: contains some extra fonts (DejaVu, Liberation, Spleen)  
(more sets to come)

Installing all sets:

    # apt-get install ragnarok-devel ragnarok-xserv ragnarok-xprogs ragnarok-xfonts

## Users and passwords

Set a password for the root user:

    # passwd

Create a new user and set password:

    # useradd -m -s /bin/ksh username
    # usermod -aG wheel,cdrom,floppy,audio,dip,video,plugdev,netdev username
    # passwd username

## Configure doas

Regular users part of the *wheel* group may be allowed to run commands as root by using doas
(a simpler replacement for sudo) by configuring the `/etc/doas.conf` file:

    # echo "premit :wheel" > /etc/doas.conf

See the doas(1) man page for more configuration options.

## Setup the bootloader

On EFI systems:


    # apt install grub-efi-amd64
    # grub-install --target=x86_64-efi --efi-directory=/boot/efi
    # update-grub

For bios/legacy systems:

    # apt-get install grub-pc
    # grub-install /dev/sdX     (where X is the device mount to /mnt)
    # update-grub

## Installing non-free firmware

If your system requires any non-free firmware package (e.g. for wireless cards), now would
be the time to install them.

## Finalizing

Update the manual pages database:

    # makewhatis /usr/share/man

Clean up the chroot and exit:

    # apt clean
    # exit

Remove resolv.conf so it gets recreated at boot:

    # rm /mnt/etc/resolv.conf

Unmount the devices. Assuming the standard partitioning scheme was used:

    # umount /dev/sdX3
    # umount /dev/sdX2

You can now reboot to the newly installed system.
