iso
===

Release building infrastructure

It may be worthwhile to read the development notes for 2023-05-22 here:
https://ragnarokos.github.io/logs/devnotes-may-2023.html

Extra Info
==========

Building everything:

    $ make
    # make release

This will build miniroot.tgz, base.tgz (testing only) and the live iso.

Building the iso only:

    $ cd live
    $ make live-config
    # make live


Tarballs
--------

* miniroot.tgz: a minimal chroot suitable for development.  

* base.tgz: Ragnarok's base rootfs, minus x11/kernel/bootloader. *This is not ready yet*.

Deprecated tools
----------------

The following scripts and files are deprecated: build.sh, mkiso and iso.conf.  
They will be removed when the Makefiles are complete.

