#!/bin/sh

set -eux

# There's no apt,on ALT, there is apt-get

################################################################################
echo "DOWNLOADING EVERYHTING"

# apt-get update

apt-get install -yy git wget zsync patchelf xorg-xvfb binutils build-essential fastfetch build-essential squashfs-tools

URL_SHARUN=$(awk "/https/ && /quick-sharun.sh/" sources.txt)

wget "$URL_SHARUN" -O quick-sharun.sh
chmod +x quick-sharun.sh

################################################################################
echo "INSTALLING DEPENDENCIES"

apt-get install -yy visualboyadvance-m
