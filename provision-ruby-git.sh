#!/bin/bash
set -euxo pipefail
export PATH="$HOME/.anyenv/bin:$PATH"
set +x
eval "$(anyenv init - --no-rehash)"
set -x
RUBY_SRCDIR="$HOME/s/github.com/ruby/ruby"
if [ ! -d "$RUBY_SRCDIR" ]; then
  git clone https://github.com/ruby/ruby "$RUBY_SRCDIR"
else
  pushd "$RUBY_SRCDIR"
  git pull
  popd
fi
if [ ! -L "$HOME/ruby" ]; then
  ln -s "$RUBY_SRCDIR" "$HOME/ruby"
fi
if [ ! -f "$RUBY_SRCDIR/configure" ]; then
  pushd "$RUBY_SRCDIR"
  autoconf
  popd
fi
if [ ! -f "$(rbenv root)/versions/git/bin/ruby" ]; then
  mkdir -p "$HOME/build/ruby-git"
  cd "$HOME/build/ruby-git"
  BASERUBY=--with-baseruby=/usr/bin/ruby
  CC="ccache gcc"
  LIBRESSL_DIR=$(ls -d ~/opt/libressl-* | tail -n1)
  CPPFLAGS="-DRUBY_DEBUG_ENV"
  CPPFLAGS="$CPPFLAGS -DARRAY_DEBUG"
  #CPPFLAGS="$CPPFLAGS -DSHARABLE_MIDDLE_SUBSTRING=1"
  "$RUBY_SRCDIR/configure" --prefix="$(rbenv root)/versions/git" --with-openssl-dir="$LIBRESSL_DIR" --enable-shared --enable-debug-env CPPFLAGS="$CPPFLAGS" --with-valgrind "$BASERUBY" --disable-install-doc CC="$CC"
  make
  make install
  rbenv rehash
  rbenv global git
fi
