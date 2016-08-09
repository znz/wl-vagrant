#!/bin/bash
set -euxo pipefail
if [[ ! -d "$HOME/s/github.com/znz/dot-emacs" ]]; then
  git clone https://github.com/znz/dot-emacs "$HOME/s/github.com/znz/dot-emacs"
fi
if [[ ! -e "$HOME/.emacs.d/init.el" ]]; then
  pushd "$HOME/s/github.com/znz/dot-emacs"
  make
  popd
fi
if [[ ! -e "$HOME/.emacs.d/private" ]]; then
  ln -snf "/vagrant/emacs-private" "$HOME/.emacs.d/private"
fi
for d in elmo gnupg hunspell_en_US; do
  if [[ ! -e "$HOME/.$d" ]]; then
    ln -snf "/vagrant/$d" "$HOME/.$d"
  fi
done
for d in Mail Maildir; do
  if [[ ! -e "$HOME/$d" ]]; then
    ln -snf "/vagrant/$d" "$HOME/$d"
  fi
done
