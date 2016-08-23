#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get purge -y nano
apt-get install -y vim
apt-get install -y cron-apt
apt-get install -y aptitude
apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
apt-get install -y byobu
apt-get install -y ccache
apt-get install -y curl
apt-get install -y golang
apt-get install -y subversion
