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

