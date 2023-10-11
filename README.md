iso
===

Release building infrastructure

Building ISO and/or miniroot
==========

Set up env:

    # mkdir -p /usr/src/ragnarok
    # chown <username> /usr/src/ragnarok
    $ cd /usr/src/ragnarok
    $ for _repo in iso src x11; do git clone https://github.com/RagnarokOS/"$_repo".git; done

Download the latest version of [Ragnarok's Linux kernel](https://github.com/RagnarokOS/kernel-build/releases)
into /usr/src/ragnarok.

Building the iso:

    # apt-get install --no-install-recommends -y live-build
    $ cd iso
    $ make live-config
    # make iso

The resulting live image will be saved in iso/live.

Building miniroot.tgz:

    # apt-get install --no-install-recommends mmdebstrap
    $ cd iso
    # export TOPDIR=/usr/src/ragnarok/src
    # make miniroot

The resulting tarball will be saved in the current working directory (/usr/src/ragnarok/iso).
