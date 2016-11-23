#!/bin/bash
set -euxo pipefail
GHQ_ROOT="$HOME/s"
GITHUB_USER=znz

sync_repo () {
  GIT_URL=$1
  CLONE_PATH=$2
  FORKED_REMOTE=${3:-}
  FORKED_REMOTE_URL=${4:-}
  ghq get "$GIT_URL"
  pushd "$CLONE_PATH"
  git pull --prune --tags
  if [[ -n "$FORKED_REMOTE_URL" ]]; then
    if [[ ! "$(git remote show)" =~ "$FORKED_REMOTE" ]]; then
      git remote add "$FORKED_REMOTE" "$FORKED_REMOTE_URL"
      git fetch "$FORKED_REMOTE"
    fi
  fi
  popd
}

. /vagrant/tmp/ghq-sub.sh
