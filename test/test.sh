#!/bin/bash
set -o pipefail

function ok()
{
	echo "  OK"
}

function fail()
{
	echo "  FAIL"
	exit 1
}

echo "Checking container"

echo "  --> Berkshelf Installation"
berkshelf=`/opt/chef/embedded/bin/berks --version`
if [[ $berkshelf =~ "3.2.0" ]]; then
	ok
else
	fail
fi

echo "  --> Chef Installation"
chef=`/usr/bin/env chef-client --version`
if [[ $chef =~ "11.16.4" ]]; then
	ok
else
	fail
fi
