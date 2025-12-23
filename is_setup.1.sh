#!/bin/bash

# NOTE: THIS IS AN INTERNAL SCRIPT AND IT CAN ONLY RUN INSIDE THE APPIMAGE AS
# A COMMAND LINE ARGUMENT

set -eu

MAIN_BIN="/usr/bin/visualboyadvance-m"

CONFIG_DIR="$HOME""/.vbam"

DESKTOP="visualboyadvance-m.desktop"
DESKTOP_EXEC=$(basename "$MAIN_BIN")
PATH_ICON="/usr/share/icons/visualboyadvance-m.png"
declare -a LBINARIES=(
	"/usr/bin/vbam"
	"$MAIN_BIN"
)

function additional_config_tasks() {
	mkdir -vp "$CONFIG_DIR"/battery
	mkdir -vp "$CONFIG_DIR"/recordings
	mkdir -vp "$CONFIG_DIR"/savestates
	mkdir -vp "$CONFIG_DIR"/screenshots
	sed -i "s:HOME_DIRECTORY:$HOME:" "$CONFIG_DIR"/vbam.conf
	sed -i "s:HOME_DIRECTORY:$HOME:" "$CONFIG_DIR"/vbam.ini
}
