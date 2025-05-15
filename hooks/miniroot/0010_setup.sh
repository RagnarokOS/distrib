#!/bin/sh

# $Ragnarok: 0010_setup.sh 1.3 2025/05/13 18:06:55 lecorbeau Exp $
# Setup the repositories inside miniroot and base chroots.

_DEST=$1

# Disable the default to switch to git.
/usr/bin/chroot "${_DEST}" /bin/bash -c "eselect repository disable gentoo"

# Re-enable. By default, eselect will choose git.
/usr/bin/chroot "${_DEST}" /bin/bash -c "eselect repository enable gentoo"

# Delete the old repo.
/usr/bin/rm -rf "${_DEST}"/var/db/repos/gentoo

# Copy portage config to the chroot.
/usr/bin/rsync -Klrv portage.conf/ "${_DEST}/"

# Sync the repos separately.
/usr/bin/chroot "${_DEST}" /bin/bash -c "emaint sync -r gentoo"
/usr/bin/chroot "${_DEST}" /bin/bash -c "emaint sync -r ragnarok"
