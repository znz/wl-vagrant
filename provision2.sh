#!/bin/bash
set -eux
if [ ! -d "$HOME/.anyenv" ]; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
fi
if [ ! -d "$HOME/.anyenv/plugins/anyenv-git" ]; then
  git clone https://github.com/znz/anyenv-git "$HOME/.anyenv/plugins/anyenv-git"
fi
if [ ! -d "$HOME/.anyenv/plugins/anyenv-update" ]; then
  git clone https://github.com/znz/anyenv-update "$HOME/.anyenv/plugins/anyenv-update"
fi
if [ ! -d "$HOME/.anyenv/envs/rbenv" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  anyenv install rbenv
fi
if [ ! -d "$HOME/s/github.com/znz/dot-shell" ]; then
  git clone https://github.com/znz/dot-shell "$HOME/s/github.com/znz/dot-shell"
fi
if [ ! -e "$HOME/.zshrc" ]; then
  echo ". $HOME/s/github.com/znz/dot-shell/zshrc.zsh" >"$HOME/.zshrc"
fi
if [ ! -d "$HOME/s/github.com/znz/dot-emacs" ]; then
  git clone https://github.com/znz/dot-emacs "$HOME/s/github.com/znz/dot-emacs"
fi
if [ ! -e "$HOME/.emacs.d/init.el" ]; then
  pushd "$HOME/s/github.com/znz/dot-emacs"
  make
  popd
fi
if [ ! -e "$HOME/.emacs.d/private" ]; then
  ln -snf "/vagrant/emacs-private" "$HOME/.emacs.d/private"
fi
if [ ! -e "$HOME/.elmo" ]; then
  ln -snf "/vagrant/elmo" "$HOME/.elmo"
fi
if [ ! -e "$HOME/.gnupg" ]; then
  ln -snf "/vagrant/gnupg" "$HOME/.gnupg"
fi
