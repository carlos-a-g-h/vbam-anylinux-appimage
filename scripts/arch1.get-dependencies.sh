#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION="$(sed -n 1p sources.txt)"
URL_SRC=$(awk "/https/ && /archive/ && /$VERSION/" sources.txt)
URL_DPKG=$(awk "/https/ && /get-debloated-pkgs.sh/" sources.txt)
URL_SHARUN=$(awk "/https/ && /quick-sharun.sh/" sources.txt)

# Download debloated packages script
FNAME="get-debloated-pkgs.sh"
wget "$URL_DPKG" -O "$FNAME"
chmod +x "$FNAME"

# Download quick sharun script
FNAME="quick-sharun.sh"
wget "$URL_SHARUN" -O "$FNAME"
chmod +x "$FNAME"

# Download source code
wget "$URL_SRC" -O upstream.tar.gz
tar -xf upstream.tar.gz
mv "visualboyadvance-m-$VERSION" src

################################################################################
echo "→ Installing the 'RECOMMENDED' packages..."

chmod -x src/installdeps
bash src/installdeps

# REC_PKGS="$PATH_SOURCECODE"/installdeps
# ls -l "$REC_PKGS"
# chmod +x ./"$REC_PKGS"
# ./"$REC_PKGS"

# wxwidgets-gtk3 is broken right now
# https://gitlab.archlinux.org/archlinux/packaging/packages/wxwidgets/-/issues/7

# NO https://archive.archlinux.org/packages/w/wxgtk-common/wxgtk-common-3.1.2-1-x86_64.pkg.tar.xz
# NO https://archive.archlinux.org/packages/w/wxgtk3/wxgtk3-3.1.2-1-x86_64.pkg.tar.xz

# https://archive.org/download/archlinux_pkg_wxwidgets-common/wxwidgets-common-3.2.6-1-x86_64.pkg.tar.zst
# https://archive.org/download/archlinux_pkg_wxwidgets-gtk3/wxwidgets-gtk3-3.2.6-1-x86_64.pkg.tar.zst

pacman -Syy --noconfirm \
	base-devel \
	mesa-utils glew glu \
	libxtst libxrandr libxkbcommon libxkbcommon-x11 libxi libxcb xorg-server-xvfb \
	systemd-libs

# pacman -U --noconfirm "https://archive.org/download/archlinux_pkg_wxwidgets-common/wxwidgets-common-3.2.6-1-x86_64.pkg.tar.zst"
# pacman -U --noconfirm "https://archive.org/download/archlinux_pkg_wxwidgets-gtk3/wxwidgets-gtk3-3.2.6-1-x86_64.pkg.tar.zst"

################################################################################
echo "→ Installing debloated packages..."

# ./get-debloated-pkgs.sh --add-opengl --add-common --add-mesa --prefer-nano gtk3-mini librsvg-mini gdk-pixbuf2-mini ffmpeg-mini

./get-debloated-pkgs.sh --add-opengl --add-common --add-mesa --prefer-nano librsvg-mini ffmpeg-mini

################################################################################

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

################################################################################

# NOTES:
# The installdeps script does not provide all of the necessary dependencies for building from source on arch
