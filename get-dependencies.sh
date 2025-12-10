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

pacman -Syu --noconfirm \
	base-devel sdl12-compat wxwidgets-common wxwidgets-gtk3 \
	mesa-utils glew glu gegl \
	libxtst libxrandr libxkbcommon libxkbcommon-x11 libxi libxcb xorg-server-xvfb \
	systemd-libs

# From the GLXGears example
#pacman -Syu --noconfirm \
#	base-devel       \
#	curl             \
#	git              \
#	libxcb           \
#	libxcursor       \
#	libxi            \
#	libxkbcommon     \
#	libxkbcommon-x11 \
#	libxrandr        \
#	libxtst          \
#	mesa-utils       \
#	vulkan-tools     \
#	wget             \
#	xorg-server-xvfb \
#	zsync

################################################################################
echo "→ Installing debloated packages..."

./get-debloated-pkgs.sh --add-opengl --add-common --add-mesa --prefer-nano gtk3-mini librsvg-mini gdk-pixbuf2-mini ffmpeg-mini

################################################################################

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

################################################################################

# NOTES:
# The installdeps script does not provide all of the necessary dependencies for building from source on arch
