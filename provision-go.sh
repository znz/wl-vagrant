#!/bin/bash
set -euxo pipefail
export GOPATH="$HOME/g"
if [[ ! -x "$HOME/g/bin/ghq" ]]; then
  go get github.com/motemen/ghq
fi
if [[ ! -x "$HOME/g/bin/peco" ]]; then
  go get github.com/peco/peco/cmd/peco
fi
