#!/bin/bash

set -eu

VERSION="$(cat ./version)"
TARFILE="$VERSION.tar.gz"
PATH_SOURCECODE="visualboyadvance-m.source"

# → Download source code and rename directory

# PATH_SOURCECODE_DECOMP=$(tar -tzf "$TARFILE"|head -n1)

# echo "→ Run the installdeps script inside the repo"

# chmod +x "$PATH_SOURCECODE"/installdeps && "$PATH_SOURCECODE"/installdeps

# → Run cmake

cmake ./"$PATH_SOURCECODE"/ \
	-DCMAKE_BUILD_TYPE=Debug \
	-DENABLE_SDL=ON \
	-DENABLE_LTO=OFF \
	-DENABLE_ONLINEUPDATES=OFF \
	-DENABLE_LINK=ON \
	-DENABLE_FFMPEG=ON \
	-Wdev --debug-output -G Ninja

# → Run ninja

ninja

find

# → check existance of binaries

ls -l visualboyadvance-m
ldd visualboyadvance-m

ls -l vbam
ldd vbam

# → copy cmake cache file to the details directory

mkdir -vp AppDir/details
cp -v CMakeCache.txt AppDir/details/
find|grep -v "$PATH_SOURCECODE" > AppDir/details/contents.txt
