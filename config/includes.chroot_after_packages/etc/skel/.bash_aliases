# aliasing man to mman, used by mandoc, and piping it to less

manread() {
	/usr/bin/mman "$1" | /usr/bin/less;
}

# the signify-openbsd command now becomes signify
obsd_sig() {
	/usr/bin/signify-openbsd "$@"
}

alias man='manread'
alias signify='obsd_sig'
