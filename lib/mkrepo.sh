#!/bin/sh

# $Ragnarok: mkrepo.sh,v 1.2 2025/05/13 15:02:27 lecorbeau Exp $
# Setup the repositories inside miniroot and base chroots.

_DEST=$1

# Disable the default to switch to git.
/usr/bin/chroot "${_DEST}" /bin/bash -c "eselect repository disable gentoo"

# Re-enable. By default, eselect will choose git.
/usr/bin/chroot "${_DEST}" /bin/bash -c "eselect repository enable gentoo"

# Delete the old repo.
/usr/bin/rm -rf "${_DEST}"/var/db/repos/gentoo

# Sync the repos separately.
/usr/bin/chroot "${_DEST}" /bin/bash -c "emaint sync -r gentoo"
/usr/bin/chroot "${_DEST}" /bin/bash -c "emaint sync -r ragnarok"
