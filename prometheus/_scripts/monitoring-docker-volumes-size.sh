#!/bin/bash

#HOST=$(cat /etc/hostname)
HOST=$(hostname)
DIR=/var/lib/docker/volumes
#DIR=/Users/matjaz/Dropbox/Koda/Prometheus/monis


# list all directories
cd $DIR
#ls -d */
for d in */; do
	RESP=`du -s $DIR/$d`
	#HASH=$(md5 -q -s $DIR/$d)  ## OS X
	HASH=$(echo -n $DIR/$d | md5sum | awk '{print $1}') ## CentOS7
	SIZE=${RESP%[[:space:]]$DIR/$d}
	# push to pushgateway
	echo "test_docker_volume_size{directory=\"$DIR/$d\",hostname=\"$HOST\"} $SIZE" | curl --data-binary @- http://localhost:9091/metrics/job/docker_volumes_monitor/instance/$HOST/id/$HASH
done
