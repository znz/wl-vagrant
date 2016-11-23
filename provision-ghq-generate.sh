#!/bin/bash
set -euo pipefail
GHQ_ROOT="$HOME/s"
GITHUB_USER=znz

head -n3 "$0" > "${0%/*}/tmp/ghq-sub.sh"
find "$GHQ_ROOT" -name .git | while read -r dir; do
  full_dir="${dir%/.git}"
  cd "$full_dir"
  dir="${full_dir#$GHQ_ROOT/}"
  repo=$(git config --get remote.origin.url || :)
  if [[ -z "$repo" ]]; then
    continue
  fi
  #if [[ "$dir" =~ ^github.com ]]; then
  if git config --get "remote.$GITHUB_USER.url" >/dev/null; then
    forked_url=$(git config --get "remote.$GITHUB_USER.url")
    echo "sync_repo \"$repo\" \"\$GHQ_ROOT/$dir\" $GITHUB_USER \"$forked_url\""
  else
    echo "sync_repo \"$repo\" \"\$GHQ_ROOT/$dir\""
  fi
  #echo "pushd \"$dir\""
  #echo "popd"
done | sort >>"${0%/*}/tmp/ghq-sub.sh"
