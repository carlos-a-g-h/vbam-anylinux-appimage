#!/bin/sh

set -eux

# VBA-M 2.0.1 r201807121140-0e60c34

# NOTE:
# The vbam packages are versioned as 2.0.1 but the binaries inside are 2.1.0. Possible typo...?

################################################################################
echo "DOWNLOADING EVERYHTING"

apt-get update

apt install -yy git wget zsync patchelf xvfb binutils build-essential

URL_SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

wget "$URL_SHARUN"
chmod +x quick-sharun.sh

wget -i "$FILE_PKGS"

################################################################################
echo "INSTALLING DEPENDENCIES"

apt-get install -yy visualboyadvance-m
