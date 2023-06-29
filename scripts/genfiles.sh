#!/bin/sh

# Generates the .contents, .files and .packages files. This cannot be done
# with a hook because mmdebstrap does not have "post-cleanup" hooks.

DIR="$1"
SET="$2"

# Sets get saved in the / directory. Move it in current dir first.
mv /"$SET" .

# Create target dir and extract the set
mkdir -p "$DIR"
tar -xpvf "$SET" --xattrs --xattrs-include='*' -C "$DIR"

# Create the .contents file
chroot "$DIR" /bin/ksh find . | sed -e 's|^.||g' | grep "^/" | sort > "$SET".contents
mv "$DIR"/"$SET".contents .

# Create the .files file
chroot "$DIR" /bin/ksh ls -laR > "$SET".files
mv "$DIR"/"$SET".files .

# Create the .packages file
chroot "$DIR" /bin/ksh dpkg-query -W > "$SET".packages
mv "$DIR"/"$SET".packages .

# Delete the extracted set
rm -r "$DIR"
