#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get install -y lv
apt-get install -y silversearcher-ag
apt-get install -y source-highlight
apt-get install -y zsh
