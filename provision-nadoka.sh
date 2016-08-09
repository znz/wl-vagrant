#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get install -y --no-install-recommends runit || :
apt-get install -y git subversion || :
SRCDIR=/vagrant/nadoka
mkdir -p /etc/sv/nadoka-fprog/log
install "$SRCDIR/log-run.sh" "/etc/sv/log-run"
ln -sf "../../log-run" "/etc/sv/nadoka-fprog/log/run"
ln -snf "/var/run/sv.nadoka-fprog.log" "/etc/sv/nadoka-fprog/log/supervise"
ln -snf "/var/run/sv.nadoka-fprog" "/etc/sv/nadoka-fprog/supervise"
install "$SRCDIR/run.sh" "/etc/sv/nadoka-fprog/run"
ln -snf "../sv/nadoka-fprog" "/etc/service/nadoka-fprog"
etckeeper commit "Setup nadoka" || :
adduser vagrant adm
etckeeper commit "Add vagrant user to adm group" || :
