#!/bin/ksh

# Wrapper around Suckless' surf. Will launch url in surf with javascript
# disabled and cookies blocked. They can be toggled on if needed via the
# appropriate keybindings while browsing.
#
# Can open multiple URLs at once. The '-bm' option will display bookmarks
# in dmenu and open the selected one.

usage() {
	printf '%s\n' "
bro.sh: a wrapper script around Suckless' surf. When used with no option,
the script will launch one or more URL in a surf window with both javascript
and cookies disabled (they can be toggled on as needed via keybindings).

For details on surf usage and keyboard shortcuts, refer to its manual page.

Usage examples:

Single URL:		bro.sh https://surf.suckless.org
Open two URLs:		bro.sh https://surf.suckless.org https://openbsd.org

Web Search:

bro.sh !b term		search for term with brave search
bro.sh !ddg term	search for term with duck duck go
bro.sh !g term		search for term with google search

Opening bookmarks:

Using bro.sh -bm, all URLs listed in ~/.surf/bookmarks.txt will be displayed
in dmenu, and surf will open the selected URL. The bro.sh -bm command is tied
to the alt + s keyboard shortcut in sxhkdrc.
"
}

bm() {
	surf_cmd "$(while IFS= read -r line; do printf '%s\n' "$line"; done \
		< "$HOME"/.surf/bookmarks.txt | dmenu -p open: -l 15 | cut -f2 -d ' ')"
}

surf_cmd() {
	local _urls

	set -A _urls -- "$@"
	for _url in "${_urls[@]}"; do
		WEBKIT_DISABLE_COMPOSITING_MODE=1 /usr/bin/surf -s -a "a@A" "$_url" &
	done
}

case "$1" in
	!b)	shift
		surf_cmd "https://search.brave.com/search?q=$(echo "$@" | tr " " "+")&source=web"
		;;
	!ddg)	shift
		surf_cmd "https://duckduckgo.com/?q=$(echo "$@" | tr " " "+")"
		;;
	!g)	surf_cmd "https://google.com/search?1=$(echo "$@" | tr " " "+")"
		;;
	-h)	usage
		;;
	-bm)	bm
		;;
	*)	surf_cmd "$@"
		;;
esac
