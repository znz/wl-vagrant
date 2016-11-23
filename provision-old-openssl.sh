#!/bin/bash
set -euxo pipefail
VERSION="0.9.8zh"
CACHE_DIR="/vagrant/openssl"
BUILD_DIR="/tmp/build"
mkdir -p "$CACHE_DIR"
cd "$CACHE_DIR"
if ! gpg --list-keys | grep -q D5E9E43F7DF9EE8C; then
  #if [[ ! -f "openssl-security.asc" ]]; then
  #  wget -N https://www.openssl.org/news/openssl-security.asc
  #fi
  #gpg --import "openssl-security.asc"
  gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key D5E9E43F7DF9EE8C
fi
if [[ ! -f "openssl-${VERSION}.tar.gz" ]]; then
  wget -N "https://www.openssl.org/source/old/0.9.x/openssl-${VERSION}.tar.gz"{,.asc}
fi
gpg "openssl-${VERSION}.tar.gz.asc"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
if [[ ! -d "openssl-${VERSION}" ]]; then
  tar zxf "$CACHE_DIR/openssl-${VERSION}.tar.gz"
fi
if [[ ! -f "$HOME/opt/openssl-${VERSION}/bin/openssl" ]]; then
  cd "openssl-${VERSION}"
  ./config shared --prefix="$HOME/opt/openssl-${VERSION}"
  make
  make install
fi
