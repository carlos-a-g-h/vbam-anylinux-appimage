#!/bin/bash

set -eux

VERSION="$(cat ./version)"
TARFILE="$VERSION.tar.gz"
PATH_SOURCECODE="visualboyadvance-m.source"

# → Download source code and rename directory

PATH_SOURCECODE_DECOMP=$(tar -tzf "$TARFILE"|head -n1)

tar -xf "$TARFILE"
mv -v "$PATH_SOURCECODE_DECOMP" "$PATH_SOURCECODE"

# → Install some packages beforehand (I do not trust the installdeps script)

# pacman -Syy --noconfirm \
# cmake make gcc clang ninja base-devel \
# glew glu mesa wxwidgets-common gtk3 wxwidgets-gtk3 ffmpeg pulseaudio sdl2-compat sdl3 \
# zsync zstd \
# xorg-server

echo "→ Run the installdeps script inside the repo"

chmod +x "$PATH_SOURCECODE"/installdeps && "$PATH_SOURCECODE"/installdeps

# → Run cmake

cmake ./"$PATH_SOURCECODE"/ \
	-DCMAKE_BUILD_TYPE=Debug \
	-DENABLE_SDL=ON \
	-DENABLE_LTO=ON \
	-DENABLE_ONLINEUPDATES=OFF \
	-DENABLE_LINK=ON \
	-DENABLE_FFMPEG=ON \
	-Wdev --debug-output -G Ninja

# → Run ninja

ninja

ls -l visualboyadvance-m
ldd visualboyadvance-m

ls -l vbam
ldd vbam
