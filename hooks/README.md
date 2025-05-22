# Hooks

Place any script in the appropriate directory and they will be run at
specific stages of the build process. These scripts can written in any
language since `runhooks` doesn't care about it at all. It just runs
the scripts in numerical order.

## Stages

* `extract`: scripts named `****_extract.*` will be executed right after
the `stage 3` tarball has been extracted, but before the configuration of
Portage. The `emerge` command cannot be called during this stage since the
repositories have no been synced yet. This is the earliest stage in which
any hook can be executed.

* `setup`: scripts named `****_setup.*` will be executed after extract
hooks, but before rebuilding the `@world` set. This is the stage where
extra repositories should be set up/enabled, and where any tasks that
should be performed before updating the world set are done.

* `configure`: scripts named `****_configure.*` will be executed after
the `@world` set was rebuilt and the contents of the `includes.miniroot`
directory were copied to the chroot. Configure scripts are meant for the
building of full `stage 4` archives (eg. Ragnarok's `base` tarball) and
are not called in the `miniroot` target inside the `Makefile`.

* `cleanup`: scripts named `****_cleanup.*` will be executed last. These
are for tasks related to cleaning up the chroot before creating the tarball.
