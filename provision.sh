#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update || :
apt-get install -y etckeeper git
sed -i -e 's/^#VCS="git"/VCS="git"/' -e 's/^VCS="bzr"/#VCS="bzr"/' -e 's/^GIT_COMMIT_OPTIONS=""/GIT_COMMIT_OPTIONS="-v"/' /etc/etckeeper/etckeeper.conf
etckeeper init 'Initial commit'
etckeeper commit 'Setup etckeeper' || :
sed -i -e 's,//\(us\.\)\?archive\.ubuntu\.com,//jp.archive.ubuntu.com,' /etc/apt/sources.list
sed -i -e 's,//httpredir\.debian\.org,//ftp.jp.debian.org,' /etc/apt/sources.list
etckeeper commit 'Use JP mirror' || :
apt-get update || :
apt-get install -y language-pack-ja || {
  sed -i -e 's/^# ja_JP.UTF-8/ja_JP.UTF-8/' /etc/locale.gen
  locale-gen
}
localectl set-locale LANG=ja_JP.UTF-8 || update-locale LANG=ja_JP.UTF-8
etckeeper commit 'Setup Japanese locale' || :
timedatectl set-timezone Asia/Tokyo || ln -sf ../usr/share/zoneinfo/Asia/Tokyo /etc/localtime
etckeeper commit 'Setup Japanese timezone' || :
if [[ -f /etc/systemd/timesyncd.conf ]]; then
  sed -i -e 's/^#\?\(NTP\|Servers\)=.*/\1=ntp1.jst.mfeed.ad.jp ntp2.jst.mfeed.ad.jp ntp3.jst.mfeed.ad.jp/' /etc/systemd/timesyncd.conf
  timedatectl set-ntp true
fi
etckeeper commit 'Setup NTP servers' || :
