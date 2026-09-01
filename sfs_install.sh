#!/bin/bash

# Installs the software inside the compressed AppDir

set -eux

NAME="VisualBoyAdvance-M"
FILEPATH="$1"

echo "[RUN] $NAME : $FILEPATH"

FILE_DESKTOP="visualboyadvance-m.desktop"
FILE_ICON="visualboyadvance-m.png"

declare -a LBINARIES=(
	"bin/vbam"
	"bin/visualboyadvance-m"
)

# Decompress the AppDIr
unsquashfs -f -d "$NAME" "$FILEPATH"

# Move contents of the AppDir to the appimages directory
APPIMAGE_DIR="/usr/appimages/""$NAME"
if [ -d "$APPIMAGE_DIR" ]
then
	rm -vrf "$APPIMAGE_DIR"
	echo "[NOTICE] WIPED OUT: $APPIMAGE_DIR"
else
	mkdir -vp /usr/appimages/
fi
mv -vf "$NAME" /usr/appimages/

# Symlink the binaries
for BIN_LINK in "${LBINARIES[@]}"
do
	ln -vsrf "$APPIMAGE_DIR"/"$BIN_LINK" /usr/"$BIN_LINK"
done

# Copy desktop file
cp -va "$APPIMAGE_DIR"/"$FILE_DESKTOP" /usr/share/applications/

# Copy icon file
cp -va "$APPIMAGE_DIR"/"$FILE_ICON" /usr/share/icons/

# Move the config (and backup any old config)
CONFIG_DIR="$HOME""/.vbam"
CONFIG_DIR_BAK="$CONFIG_DIR.bak"
if [ -d "$CONFIG_DIR" ]
then	
	mv -v "$CONFIG_DIR" "$CONFIG_DIR_BAK"
	echo "[NOTICE] BACKED UP: $CONFIG_DIR_BAK"
	mkdir -v "$CONFIG_DIR"
fi
mv -vf "$APPIMAGE_DIR"/_config/* "$CONFIG_DIR"/

# Aditional config tweaks
mkdir -vp "$CONFIG_DIR"/battery
mkdir -vp "$CONFIG_DIR"/recordings
mkdir -vp "$CONFIG_DIR"/savestates
mkdir -vp "$CONFIG_DIR"/screenshots
sed -i "s:HOME_DIRECTORY:$HOME:" "$CONFIG_DIR"/vbam.conf
sed -i "s:HOME_DIRECTORY:$HOME:" "$CONFIG_DIR"/vbam.ini

# Destroy the compressed AppDir file
rm -v "$FILEPATH"

# ALl good
echo "[OK] Installed: $NAME"
