#!/bin/bash -e
source /build/config/build
set -x

$minimal_apt_get_install curl build-essential libxml2-dev libxslt-dev git autoconf
curl -L https://www.opscode.com/chef/install.sh | sudo bash -s -- -v 11.16.4
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
/opt/chef/embedded/bin/gem install berkshelf -v 3.2.0
