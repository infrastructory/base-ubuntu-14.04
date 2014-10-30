#!/bin/bash -e
source /build/config/build
set -x

## Temporarily disable dpkg fsync to make building faster.
echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

## Update apt cache
apt-get update

## Upgrade all packages
apt-get dist-upgrade -y --no-install-recommends
