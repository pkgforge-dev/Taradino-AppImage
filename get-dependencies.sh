#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake     \
    libdecor  \
    sdl2      \
    sdl2_mixer

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building Taradino..."
echo "---------------------------------------------------------------"
REPO="https://github.com/fabiangreffrath/taradino"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./Taradino
echo "$VERSION" > ~/version

cd ./Taradino
mkdir -p build && cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr
make -j$(nproc)
make install
