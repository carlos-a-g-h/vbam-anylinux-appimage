#!/bin/sh

set -eux

# There's no apt,on ALT, there is apt-get

################################################################################
echo "DOWNLOADING EVERYHTING"

# apt-get update

apt-get install -yy git wget zsync patchelf xorg-xvfb binutils build-essential

URL_SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

wget "$URL_SHARUN"
chmod +x quick-sharun.sh

wget -i "$FILE_PKGS"

################################################################################
echo "INSTALLING DEPENDENCIES"

apt-get install -yy visualboyadvance-m
