#!/bin/bash -e
source /build/config/build
set -x

# Customise insecure key
cp /build/keys/insecure_key.pub /etc/insecure_key.pub
cp /build/keys/insecure_key /etc/insecure_key
chmod 644 /etc/insecure_key*
chown root:root /etc/insecure_key*
