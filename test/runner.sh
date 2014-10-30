#!/bin/bash -e

function abort()
{
	echo "$@"
	exit 1
}

function cleanup()
{
	echo " --> Stopping container"
	docker stop $ID >/dev/null
	docker rm $ID >/dev/null
}

PWD=`pwd`

echo " --> Starting insecure container"
ID=`docker run -d -v $PWD/test:/test $NAME:$VERSION /sbin/my_init --enable-insecure-key`
sleep 1

echo " --> Obtaining IP"
IP=`docker inspect $ID | grep IPAddress | sed -e 's/.*: "//; s/".*//'`
if [[ "$IP" = "" ]]; then
	abort "Unable to obtain container IP"
fi

trap cleanup EXIT

echo " --> Logging into container and running tests"
chmod 600 image/keys/insecure_key
sleep 1
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i image/keys/insecure_key root@$IP \
	/bin/bash /test/test.sh
