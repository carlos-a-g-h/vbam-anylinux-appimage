#!/bin/sh

set -eu

GH_SHA="$1"
#GH_SHA=$(git rev-parse HEAD)
GH_SHA_SHORT="${GH_SHA:0:8}"

ARCH=$(uname -m)
VERSION="v2.1.0"
NAME="VisualBoyAdvance-M"

PATH_DESKTOP=$(realpath -e visualboyadvance-m.desktop)

# APPIMAGE_STEM="$NAME"_"$VERSION"_"$GH_SHA_SHORT"_"$ARCH"
APPIMAGE_STEM="$NAME"_"$VERSION"_"$GH_SHA_SHORT"_anylinux_"$ARCH"

export ARCH VERSION
# export ADD_HOOKS="self-updater.bg.hook"
# export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON="/usr/share/icons/visualboyadvance-m.png"
export DESKTOP=$(realpath -e visualboyadvance-m.desktop)
export OUTNAME="$APPIMAGE_STEM".AppImage
export OUTPATH=./dist

#export NO_STRIP=1
export DEPLOY_OPENGL=1
export DEPLOY_GEGL=0
export DEPLOY_PULSE=0
export DEPLOY_PIPEWIRE=0
export DEPLOY_VULKAN=0
export DEPLOY_GTK=0
export DEPLOY_SDL=1
export DEPLOY_GLYCIN=0

cp -v "/usr/share/icons/hicolor/256x256/apps/vbam.png" "$ICON"

# Deploy dependencies
./quick-sharun.sh \
	/usr/games/vbam /usr/games/visualboyadvance-m

mkdir -p gathered

# Copy all data files
python3 hhs/script_deploy.py \
	gathered \
	vbam vbam-common vbam-gtk vbam-sdl

rm -rf gathered/usr/games

mkdir -vp AppDir/details
echo "$GH_SHA" > AppDir/details/commit.txt
cp -va ubuntu1/* AppDir/details/
cp -va gathered/usr/share AppDir/

mkdir -p "$OUTPATH"

# Copy Internal scripts

mkdir -vp AppDir/shared/bin
chmod +x is_*
cp -v is_setup AppDir/shared/bin/setup
cp -v is_details AppDir/shared/bin/details


# Turn AppDir into AppImage
./quick-sharun.sh --make-appimage
