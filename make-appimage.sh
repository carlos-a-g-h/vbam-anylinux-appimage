#!/bin/sh

set -eu

GH_SHA="$1"
GH_SHA_SHORT="${GH_SHA:0:8}"

ARCH=$(uname -m)
VERSION=$(cat ./version)
NAME="VisualBoyAdvance-M"

PATH_SOURCECODE="$(realpath -e visualboyadvance-m.source)"
PATH_DESKTOP=$(realpath -e visualboyadvance-m.desktop)

export ARCH VERSION
# export ADD_HOOKS="self-updater.bg.hook"
# export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=$(realpath -e "$PATH_SOURCECODE"/src/wx/icons/sizes/256x256/apps/visualboyadvance-m.png)
export DESKTOP=$(realpath -e visualboyadvance-m.desktop)
export OUTNAME="$NAME"_"$VERSION"_"$GH_SHA_SHORT"_anylinux_"$ARCH".AppImage
export OUTPATH=./dist

export NO_STRIP=1
export DEPLOY_OPENGL=1
export DEPLOY_PULSE=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_VULKAN=0
export DEPLOY_GTK=1
export DEPLOY_GDK=1
export DEPLOY_SDL=1
export DEPLOY_GLYCIN=0
export DEPLOY_LOCALES=1

# Copy the full github SHA

mkdir -vp AppDir/details
echo "$GH_SHA" > AppDir/details/commit.txt

#mkdir -vp AppDir/usr/bin
#mkdir -vp AppDir/shared/bin
#cp -va "$PATH_ALL_ICONS"/* AppDir/usr/share/icons/scalable/

# Copy the missing libwx files, including localization files
# mkdir -vp AppDir/share/aclocal
# cp -v /usr/share/aclocal/wxwin.m4 AppDir/share/aclocal/

# Deploy dependencies
./quick-sharun.sh ./vbam ./visualboyadvance-m /usr/lib/libwx_gtk3u_xrc-3.2.*

# Additional changes can be done in between here

# Turn AppDir into AppImage
./quick-sharun.sh --make-appimage
