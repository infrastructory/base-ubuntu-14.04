#!/bin/bash -e
source /build/config/build
set -x

# Remove items used for building, since they aren't needed anymore
apt-get -y purge build-essential autoconf
apt-get -y autoremove --purge

apt-get clean
rm -rf /build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
rm -f /etc/ssh/ssh_host_*
