distrib
=======

Ragnarok's release building infrastructure.

**NOTE**: the whole infrastructure is being redone due to Ragnarok's
switch to a Gentoo base. To build Debian-based ISOs/releases, switch
to the 'debian' branch, or clone it with `git clone -b debian ...`.

Building
========

*Under development. These build instructions may change and stop working
at any moment. In which case simply wait for them to be updated.*

Set up env:

    # apt-get install --no-install-recommends -y mmdebstrap live-build
    # mkdir -p /usr/src/ragnarok
    # chown <username> /usr/src/ragnarok
    $ cd /usr/src/ragnarok
    $ for _repo in distrib src; do git clone -b stable/$VERSION https://github.com/RagnarokOS/"$_repo".git; done

Replace `$VERSION` with the latest stable version of Ragnarok (currently 01).

*Note: unless you specifically want to try building a release for the
-current (development) version of Ragnarok, you most definitely want to
use 'git clone -b stable/$VERSION'. -current is not meant to be a daily
driver, but if you insist on making a release for it, omit the '-b' flag
and understand that the build may fail due to a not-yet-fully-implemented
change.*

Change directory:

    $ cd distrib/

Build a release (miniroot, base + live ISO):

    $ make
    # make release

The resulting tarballs will be saved in the current working directory (/usr/src/ragnarok/distrib).
The resulting ISO will be saved in /usr/src/ragnarok/distrib/iso/live.

Reporting Issues
================

If you encounter any problem, feel free to open an issue. Take note that
the issue tracker is reserved for bug reports (as in, bugs affecting
the functionality of the tools in this repository) and security issues
only. Feature requests and anything unrelated to the technical aspects
of the project will be ignored and closed.
