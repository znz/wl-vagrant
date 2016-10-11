#!/bin/bash
set -euxo pipefail
export GOPATH="$HOME/g"
if [[ ! -x "$HOME/g/bin/ghq" ]]; then
  go get -x -u github.com/motemen/ghq
fi
if [[ ! -x "$HOME/g/bin/peco" ]]; then
  go get -x -u github.com/peco/peco/cmd/peco
fi
