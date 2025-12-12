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

# wxwidgets-gtk3 is broken right now
# https://gitlab.archlinux.org/archlinux/packaging/packages/wxwidgets/-/issues/7

# NO https://archive.archlinux.org/packages/w/wxgtk-common/wxgtk-common-3.1.2-1-x86_64.pkg.tar.xz
# NO https://archive.archlinux.org/packages/w/wxgtk3/wxgtk3-3.1.2-1-x86_64.pkg.tar.xz

# https://archive.org/download/archlinux_pkg_wxwidgets-common/wxwidgets-common-3.2.6-1-x86_64.pkg.tar.zst
# https://archive.org/download/archlinux_pkg_wxwidgets-gtk3/wxwidgets-gtk3-3.2.6-1-x86_64.pkg.tar.zst

pacman -Syy --noconfirm \
	base-devel \
	sd2-compat sdl2_gfx sdl2_image sdl2_net sdl2_ttf sdl2_mixer \
	mesa-utils glew glu \
	libxtst libxrandr libxkbcommon libxkbcommon-x11 libxi libxcb xorg-server-xvfb \
	systemd-libs

pacman -U --noconfirm "https://archive.org/download/archlinux_pkg_wxwidgets-common/wxwidgets-common-3.2.6-1-x86_64.pkg.tar.zst"
pacman -U --noconfirm "https://archive.org/download/archlinux_pkg_wxwidgets-gtk3/wxwidgets-gtk3-3.2.6-1-x86_64.pkg.tar.zst"

################################################################################
echo "→ Installing debloated packages..."

./get-debloated-pkgs.sh --add-opengl --add-common --add-mesa --prefer-nano gtk3-mini librsvg-mini gdk-pixbuf2-mini ffmpeg-mini

################################################################################

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

################################################################################

# NOTES:
# The installdeps script does not provide all of the necessary dependencies for building from source on arch
