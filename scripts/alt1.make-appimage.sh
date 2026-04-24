#!/bin/sh

set -eu

GH_SHA="$1"
#GH_SHA=$(git rev-parse HEAD)
GH_SHA_SHORT="${GH_SHA:0:8}"

ARCH=$(uname -m)
VERSION="$(rpm -q --queryformat %{VERSION} visualboyadvance-m)"
NAME="VisualBoyAdvance-M"

APPIMAGE_STEM="$NAME"_v"$VERSION"_"$GH_SHA_SHORT"_alt1_anylinux_"$ARCH"

export ARCH VERSION
# export ADD_HOOKS="self-updater.bg.hook"
# export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON="/usr/share/icons/hicolor/256x256/apps/visualboyadvance-m.png"
export DESKTOP=$(realpath -e visualboyadvance-m.desktop)
export OUTNAME="$APPIMAGE_STEM".AppImage
export OUTPATH=./dist

#export NO_STRIP=1
export DEPLOY_OPENGL=1
export DEPLOY_GEGL=0
export DEPLOY_PULSE=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_VULKAN=0
export DEPLOY_GTK=1
export DEPLOY_SDL=1
export DEPLOY_GLYCIN=0

# cp -v "/usr/share/icons/hicolor/256x256/apps/vbam.png" "$ICON"

# Deploy dependencies for both binaries
./quick-sharun.sh \
	/usr/bin/vbam /usr/bin/visualboyadvance-m

# Copy the missing files such as... LOCALES
mkdir -p gathered
SELECTED=$(find /usr/share/locale/|grep wxvbam.mo)
for TGT in $SELECTED
do
	DEST="gathered""$TGT"
	DEST_PARENT="$(dirname "$DEST")"
	mkdir -p "$DEST_PARENT"
	cp -v "$TGT" "$DEST"
done
cp -va gathered/usr/share AppDir/

# Copy the config
cp -va _config AppDir/

# Copy details
mkdir -vp AppDir/_details
echo "$GH_SHA" > AppDir/_details/commit.txt
echo "$(date)" > AppDir/_details/date.txt
cat /etc/os-release > AppDir/_details/os.txt
rpm -qa > AppDir/_details/packages.txt
fastfetch|sed -e 's/Local IP.*//' -e 's/Locale.*//' -e 's/Battery.*//' -e 's/Disk.*//' -e 's/Swap.*//' > AppDir/_details/fetch.txt

# Copy Internal scripts
mkdir -vp AppDir/bin
cp -v is_details AppDir/bin/details
cp -v is_setup.1.sh AppDir/bin/setup
cat is_setup.2.sh >> AppDir/bin/setup
chmod +x AppDir/bin/details
chmod +x AppDir/bin/setup

# Turn AppDir into AppImage
./quick-sharun.sh --make-appimage
