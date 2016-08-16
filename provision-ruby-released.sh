#!/bin/bash
set -euxo pipefail
export PATH="$HOME/.anyenv/bin:$PATH"
set +x
eval "$(anyenv init - --no-rehash)"
if [ ! -d "$(rbenv root)/plugins/rbenv-each" ]; then
  git clone https://github.com/chriseppstein/rbenv-each.git "$(rbenv root)/plugins/rbenv-each"
fi
sed -i -e 's,^[^/].*BN_rand_range.*,/* \0 */,' \
       -e 's,^[^/].*BN_pseudo_rand_range.*,/* \0 */,' \
    "$HOME/opt/openssl-0.9.8zh/include/openssl/bn.h"
versions=(
  #1.8.5-p231
  1.8.6
  1.8.6-p420
  1.8.7
  1.8.7-p375
  1.9.0-0
  1.9.0-5
  1.9.1-p0
  1.9.1-p431
  1.9.2-p0
  1.9.2-p330
  1.9.3-p0
  1.9.3-p551
  2.0.0-p0
  2.0.0-p648
)
for ver in "${versions[@]}"; do
  if ! RBENV_VERSION=$ver ruby -v 2>/dev/null; then
    set -x
    RUBY_CONFIGURE_OPTS="--with-openssl-dir=$HOME/opt/openssl-0.9.8zh" rbenv install "$ver"
    set +x
  fi
done
versions=(
  2.1.0
  2.1.10
  2.2.0
  2.2.5
  2.3.0
  2.3.1
)
for ver in "${versions[@]}"; do
  if ! RBENV_VERSION=$ver ruby -v 2>/dev/null; then
    set -x
    rbenv install "$ver"
    set +x
  fi
done
