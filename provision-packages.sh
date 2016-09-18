#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get purge -y nano
apt-get install -y vim
apt-get install -y aptitude
apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
apt-get install -y byobu
apt-get install -y ccache
apt-get install -y curl
apt-get install -y golang
apt-get install -y subversion
echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections
apt-get install -y unattended-upgrades
sed -i -e 's,//\(Unattended-Upgrade::Remove-Unused-Dependencies "\)false\(";\),\1true\2,' /etc/apt/apt.conf.d/50unattended-upgrades
etckeeper commit 'Enable autoremove with unattended-upgrades' || :
