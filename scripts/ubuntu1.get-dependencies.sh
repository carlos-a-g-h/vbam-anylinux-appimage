#!/bin/sh

set -eux

# VBA-M 2.0.1 r201807121140-0e60c34

# NOTE:
# The vbam packages are versioned as 2.0.1 but the binaries inside are 2.1.0. Possible typo...?

################################################################################
echo "DOWNLOADING EVERYHTING"

apt update

apt install -yy git wget zsync patchelf xvfb

URL_HELPERS="https://github.com/carlos-a-g-h/dependency-helper-scripts"
URL_SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
FILE_PKGS=$(realpath -e ./ubuntu1/packages.txt)

wget "$URL_SHARUN"
chmod +x quick-sharun.sh

wget -i "$FILE_PKGS"

git clone "URL_HELPERS"
mv -v dependency-helper-scripts hhs

find

################################################################################
echo "INSTALLING DEPENDENCIES"

# Dependencies are based on this: https://github.com/visualboyadvance-m/snap-release/blob/master/snapcraft.yaml
# libsfml-network2.6 libsfml-system2.6 are not being installed because the 2.4 version is the one required by vbam 2.1.0
# libgtk-3-0 is not being installed because vbam 2.1.0 depends on GTK2 only
apt install -yy libsdl2-2.0-0 libnotify4 libsm6 libopenal1 libpng16-16 libpulse0 zlib1g libgl1 libglvnd0 libglx0 libopengl0

# Install vbam and the aditional dependencies
apt install -yy ./*.deb
