#!/bin/bash

DIR=/Users/matjaz/Dropbox
RESP=`du -s $DIR`
SIZE=${RESP%[[:space:]]$DIR}
#HOST=$(cat /etc/hostname)
HOST=$(hostname)
HASH=$(md5 -q -s $DIR)
# save into text file for node-exporter textfile collector
echo "test_directory_size{directory=\"$DIR\",hostname=\"$HOST\"} $SIZE" > /Users/matjaz/Desktop/custom-metrics.prom
# push to pushgateway
echo "test_directory_size{directory=\"$DIR\",hostname=\"$HOST\"} $SIZE" | curl --data-binary @- http://localhost:9091/metrics/job/directory_monitor_$HASH/instance/$HOST
