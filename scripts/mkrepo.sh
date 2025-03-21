#!/bin/sh

# $Ragnarok: mkrepo.sh,v 1.1 2025/03/21 15:46:15 lecorbeau Exp $
# Setup the repositories inside miniroot and base chroots.

_SRC=$1
_DEST=$2

# Disable the default to switch to git.
/usr/bin/chroot "${_DEST}" /bin/bash -c "eselect repository disable gentoo"

# Re-enable. By default, eselect will choose git.
/usr/bin/chroot "${_DEST}" /bin/bash -c "eselect repository enable gentoo"

# Delete the old repo.
/usr/bin/rm -rf "${_DEST}"/var/db/repos/gentoo

# Write Ragnarok's repos.conf to the chroot
/usr/bin/cat "${_SRC}"/etc/portage/repos.conf/eselect-repo.conf \
	> "${_DEST}"/etc/portage/repos.conf/eselect-repo.conf

# Sync the repos separately.
/usr/bin/chroot "${_DEST}" /bin/bash -c "emaint sync -r gentoo"
/usr/bin/chroot "${_DEST}" /bin/bash -c "emaint sync -r ragnarok"
