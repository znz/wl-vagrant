#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get install -y aptitude
apt-get install -y clang
apt-get install -y golang
apt-get install -y lv
apt-get install -y shellcheck
apt-get install -y silversearcher-ag
apt-get install -y source-highlight
apt-get install -y subversion
apt-get install -y vim-editorconfig
apt-get install -y zsh
