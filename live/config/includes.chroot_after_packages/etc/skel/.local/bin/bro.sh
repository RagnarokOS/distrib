#!/bin/ksh

# Wrapper around Suckless' surf. Will launch url in surf with javascript
# disabled and cookies blocked. They can be toggled on if needed via the
# appropriate keybindings while browsing.
#
# Can open multiple URLs at once. The '-bm' option will display bookmarks
# in dmenu and open the selected one.

bm() {
	surf_cmd "$(while IFS= read -r line; do printf '%s\n' "$line"; done \
		< "$HOME"/.surf/bookmarks.txt | dmenu -p open: -l 15 | cut -f2 -d ' ')"
}

surf_cmd() {
	local _urls

	set -A _urls -- "$@"
	for _url in "${_urls[@]}"; do
		/usr/bin/surf -s -a "a@A" "$_url" &
	done
}

case "$1" in
	-bm)	bm
		;;
	*)	surf_cmd "$@"
		;;
esac
