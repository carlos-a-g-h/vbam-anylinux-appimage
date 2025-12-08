#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(cat ./version)
TARFILE="$VERSION.tar.gz"

URL_SRC="https://github.com/visualboyadvance-m/visualboyadvance-m/archive/refs/tags/$TARFILE"
URL_SCRIPT1="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"
URL_SCRIPT2="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

################################################################################
echo "→ Downloading everything"

wget "$URL_SRC"
wget "$URL_SCRIPT1"
wget "$URL_SCRIPT2"

chmod +x *.sh
ls -l *.sh

################################################################################
echo "→ Decompressing $TARFILE"

PATH_SOURCECODE="visualboyadvance-m.source"
PATH_SOURCECODE_DECOMP=$(tar -tzf "$TARFILE"|head -n1)

ls -l "$TARFILE"
tar -xf "$TARFILE"
mv -v "$PATH_SOURCECODE_DECOMP" "$PATH_SOURCECODE"

################################################################################
echo "→ Installing the 'RECOMMENDED' packages..."

REC_PKGS="$PATH_SOURCECODE"/installdeps
ls -l "$REC_PKGS"
chmod +x ./"$REC_PKGS"
./"$REC_PKGS"

# Providing SDL2
# https://github.com/carlos-a-g-h/vbam-anylinux-appimage/actions/runs/20032167816/job/57443909647#step:6:65
pacman -Syy --noconfirm sdl2-compat

################################################################################
#echo "→ Installing debloated packages..."

#./get-debloated-pkgs.sh mesa-mini gdk-pixbuf2-mini gtk3-mini librsvg-mini ffmpeg-mini

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
