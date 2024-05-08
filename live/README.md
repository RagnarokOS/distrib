# live

This directory contains the configs for the live and install images.

* min: a minimal ISO containing only the strict minimum required to boot
to a TTY and install the system. This ISO is also used to build packages
in virtual machines when a chroot is not enough and a full install is not
necessary.

* full: this is the normal live ISO (live*${VERSION}*). It contains the
full Ragnarok base system, including the devel and xserv sets/metapackages
(but omits the virt set).

* install **not yet ready**: small ISO that boots straight to the installer.
