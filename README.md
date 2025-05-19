# distrib

Ragnarok's release building infrastructure.

**NOTE**: the whole infrastructure is being redone due to Ragnarok's
switch to a Gentoo base. To build Debian-based ISOs/releases, switch
to the 'debian' branch, or clone it with `git clone -b debian ...`.

## Helper Scripts

The following scripts exist to keep the Makefile and hook scripts simple.
When called from hooks, these scripts need to be prefixed by a './', eg:

    ./getval DESTDIR config.mk

since hooks are executed in this directory (distrib/).

* `chrootcmd`: chroots into `$TARGET` and executes command, then exits,
eg:

    # ./chrootcmd miniroot "emerge --sync"

* `genmount`: properly mounts `$TARGET` dirs as types/binds/slaves.
Do not call this script in hooks. It is called in Makefile.

* `getval`: get value from config file, ex:

    $ ./getval DESTDIR config.mk

* `runhooks`: run all executable hook scripts in $dir for specific stage,
eg:

    ./runhooks hooks/miniroot configure

This script should only be called from the Makefile.

## Building

*Under development. These build instructions may change and stop working
at any moment. In which case simply wait for them to be updated.*

Soon...

## Reporting Issues

If you encounter any problem, feel free to open an issue. Take note that
the issue tracker is reserved for bug reports (as in, bugs affecting
the functionality of the tools in this repository) and security issues
only. Feature requests and anything unrelated to the technical aspects
of the project will be ignored and closed.
