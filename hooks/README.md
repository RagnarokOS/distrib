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
hooks. This is the stage where Portage/repositories should be set up.

* `configure`: scripts named `****_configure.*` will be executed after Portage
and the repositories were set up. Ideally, this is where extra configuration
happens and where updating @world, and installing custom packages, should
be performed.
