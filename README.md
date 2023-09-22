iso
===

Release building infrastructure

Extra Info
==========

Building the iso (gist):

    # apt install --no-install-recommends -y live-build
    $ mkdir -p .local/build
    $ cd .local/build
    $ git clone https://github.com/RagnarokOS/iso.git
    $ git clone https://github.com/RagnarokOS/src.git
    $ git clone https://github.com/RagnarokOS/x11.git
    $ cd iso
    $ make live-config
    # make iso

Note: answer 'Y' when asked to overwrite the motd file. This annoyance will
be fixed in due time.

Deprecated tools
----------------

The following scripts and files are deprecated: build.sh, mkiso and iso.conf.  
They will be removed when the Makefiles are complete.

