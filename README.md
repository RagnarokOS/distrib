distrib
=======

Ragnarok's release building infrastructure.


Building
========

*Under development. These build instructions may change and stop working
at any moment. In which case simply wait for them to be updated.*

Set up env:

    # apt-get install --no-install-recommends -y mmdebstrap live-build
    # mkdir -p /usr/src/ragnarok
    # chown <username> /usr/src/ragnarok
    $ cd /usr/src/ragnarok
    $ for _repo in distrib src; do git clone https://github.com/RagnarokOS/"$_repo".git; done

Get the latest version of Ragnarok's kernel build. On Ragnarok systems, the `kernupd -d`
command will download all the relevant packages into `/var/db/kernel/`, simply move them
to `/usr/src/ragnarok`. On other Debian based systems, simply download the kernel/headers/libc-dev
packages from the [Release page](https://github.com/RagnarokOS/kernel-build/releases).

Change directory:

    $ cd distrib/

Build a release (miniroot + live ISO):

    $ make
    # make release

The resulting miniroot tarball will be saved in the current working directory (/usr/src/ragnarok/distrib).
The resulting ISO will be saved in /usr/src/ragnarok/distrib/iso/live.

Reporting Issues
================

If you encounter any problem, feel free to open an issue. Take note that
the issue tracker is reserved for bug reports (as in, bugs affecting
the functionality of the tools in this repository) and security issues
only. Feature requests and anything unrelated to the technical aspects
of the project will be ignored and closed.
