#!/bin/bash
set -euxo pipefail
VERSION=2.4.2
CACHE_DIR="/vagrant/libressl"
BUILD_DIR="$HOME/build"
mkdir -p "$CACHE_DIR"
cd "$CACHE_DIR"
if ! gpg --list-keys | grep -q D5E4D8D5; then
  if [[ ! -f "libressl.asc" ]]; then
    wget -N http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl.asc
  fi
  gpg --import "libressl.asc"
fi
if [[ ! -f "libressl-${VERSION}.tar.gz" ]]; then
  wget -N "http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${VERSION}.tar.gz"{,.asc}
fi
gpg "libressl-${VERSION}.tar.gz.asc"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
if [ ! -d "libressl-${VERSION}" ]; then
  tar zxf "$CACHE_DIR/libressl-${VERSION}.tar.gz"
fi
cd "libressl-${VERSION}"
./configure --prefix="$HOME/opt/libressl-${VERSION}"
make
make check
make install
