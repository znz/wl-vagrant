#!/bin/sh
set -eux
sed -i -e 's,//archive\.ubuntu\.com,//jp.archive.ubuntu.com,' /etc/apt/sources.list
apt-get update || :
apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
apt-get install -y ccache lv zsh
apt-get install -y language-pack-ja
update-locale LANG=ja_JP.UTF-8
timedatectl set-timezone Asia/Tokyo
apt-get install -y emacs24 emacs24-el fonts-ipafont fonts-takao fonts-vlgothic
apt-get install -y apel flim semi wl-beta gnutls-bin x-face-el w3m-el mu-cite mhc
apt-get install -y hunspell hunspell-en-us
apt-get install -y silversearcher-ag
