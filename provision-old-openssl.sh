#!/bin/bash
set -euxo pipefail
VERSION="0.9.8zh"
CACHE_DIR="/vagrant/openssl"
mkdir -p "$CACHE_DIR"
cd "$CACHE_DIR"
if ! gpg --list-keys | grep -q 7DF9EE8C; then
  #curl https://www.openssl.org/news/openssl-security.asc | gpg --import
  gpg --recv-key 7DF9EE8C
fi
if [[ ! -f "openssl-${VERSION}.tar.gz" ]]; then
  wget -N "https://www.openssl.org/source/old/0.9.x/openssl-${VERSION}.tar.gz"{,.asc}
fi
gpg "openssl-${VERSION}.tar.gz.asc"
mkdir -p "$HOME/build"
cd "$HOME/build"
if [[ ! -d "openssl-${VERSION}" ]]; then
  tar zxf "$CACHE_DIR/openssl-${VERSION}.tar.gz"
fi
cd "openssl-${VERSION}"
./config shared --prefix="$HOME/opt/openssl-${VERSION}"
make
make install
