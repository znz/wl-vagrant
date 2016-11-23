#!/bin/bash
set -euxo pipefail
export PATH="$HOME/.anyenv/bin:$PATH"
set +x
eval "$(anyenv init - --no-rehash)"
set -x
RUBY_SRCDIR="$HOME/s/ci.ruby-lang.org/ruby/trunk"
if [ ! -d "$RUBY_SRCDIR" ]; then
  svn co -N svn+ssh://svn@ci.ruby-lang.org/ruby "$HOME/s/ci.ruby-lang.org/ruby"
  pushd "$HOME/s/ci.ruby-lang.org/ruby"
  svn up trunk
  popd
else
  pushd "$RUBY_SRCDIR"
  svn up
  popd
fi
if [ ! -f "$RUBY_SRCDIR/configure" ]; then
  pushd "$RUBY_SRCDIR"
  autoconf
  popd
fi
if [ ! -f "$(rbenv root)/versions/trunk/bin/ruby" ]; then
  BUILD_DIR="$HOME/build/ruby-trunk"
  mkdir -p "$BUILD_DIR"
  cd "$BUILD_DIR"
  BASERUBY=--with-baseruby=/usr/bin/ruby
  CC="ccache gcc"
  CPPFLAGS="-DRUBY_DEBUG_ENV"
  "$RUBY_SRCDIR/configure" --prefix="$(rbenv root)/versions/trunk" --enable-shared --enable-debug-env CPPFLAGS="$CPPFLAGS" --with-valgrind "$BASERUBY" --disable-install-doc CC="$CC"
  make
  make install
  rbenv rehash
fi
