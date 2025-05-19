#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.4 2025/05/19 15:18:24 lecorbeau Exp $
# Setup the repositories inside miniroot and base chroots.

TARGET="$(awk '/DESTDIR/ { print $4 }' config.mk)/miniroot"

# Disable the default to switch to git.
/usr/bin/chroot "${TARGET}" /bin/bash -c "eselect repository disable gentoo"

# Re-enable. By default, eselect will choose git.
/usr/bin/chroot "${TARGET}" /bin/bash -c "eselect repository enable gentoo"

# Delete the old repo.
/usr/bin/rm -rf "${TARGET}"/var/db/repos/gentoo

# Copy portage config to the chroot.
/usr/bin/rsync -Klrv portage.conf/ "${TARGET}/"

# Sync the repos separately.
/usr/bin/chroot "${TARGET}" /bin/bash -c "emaint sync -r gentoo"
/usr/bin/chroot "${TARGET}" /bin/bash -c "emaint sync -r ragnarok"
