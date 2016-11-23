#!/bin/bash
set -euxo pipefail
export PATH="$HOME/.anyenv/bin:$PATH"
set +x
eval "$(anyenv init - --no-rehash)"
set -x
gem install bitclust-core refe2
bitclust setup
