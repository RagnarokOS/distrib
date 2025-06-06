#!/bin/sh

# $Ragnarok: checkdep.sh,v 1.1 2025/06/06 17:26:49 lecorbeau Exp $
# Check if all dependencies are installed.

# Yes, we include git here. Someone may have downloaded the repo as a
# tarball rather than running 'git -clone'. More depends to be added.
_deps="dev-perl/Config-General app-shells/oksh sys-apps/arch-chroot dev-vcs/git"
_install=

for _pkg in ${_deps}; do
	if ! qlist -I | grep -q "$_pkg"; then _install="${_install}$_pkg "; fi
done
# We need word splitting or else emerge will fail.
# shellcheck disable=SC2086
/usr/bin/emerge -av --pretend $_install
