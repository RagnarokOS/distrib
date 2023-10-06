# scripts

The scripts here are to be used by the build infrastructure. These are used
by the `make` command, rather than being invoked directly.

* mkrepo: creates a temporary local apt repository for debootstrap,
  saving time and bandwidth.
* cleanup: clean up the chroot before running the tar command.
