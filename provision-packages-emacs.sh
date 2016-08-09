#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get install -y emacs24 emacs24-el fonts-ipafont fonts-takao fonts-vlgothic
apt-get install -y apel flim semi wl-beta gnutls-bin x-face-el w3m-el mu-cite mhc
apt-get install -y hunspell hunspell-en-us
