#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(cat ./version)
TARFILE="$VERSION.tar.gz"

URL_SRC="https://github.com/visualboyadvance-m/visualboyadvance-m/archive/refs/tags/$TARFILE"
URL_SCRIPT1="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"
URL_SCRIPT2="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

wget "$URL_SRC"
wget "$URL_SCRIPT1"
wget "$URL_SCRIPT2"

chmod +x *.sh

echo "→ Installing some packages..."

pacman -Syy --noconfirm sudo \
cmake make gcc clang ninja base-devel \
glew glu mesa wxwidgets-common wxwidgets-gtk3 pulseaudio sdl2-compat \
zsync zstd \
xorg-server

echo "→ Installing debloated packages..."

./get-debloated-pkgs.sh mesa-mini gdk-pixbuf2-mini gtk3-mini librsvg-mini ffmpeg-mini

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
