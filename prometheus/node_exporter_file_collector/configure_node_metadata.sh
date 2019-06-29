#/bin/bash

IP_ADDRESS=$(ip route get 192.168.18.18 | awk '{print $NF; exit}')
HOSTNAME=$(cat /etc/hostname)
METADATA_PATH=/opt/monitoring/server-metadata

mkdir -p $METADATA_PATH
rm -f $METADATA_PATH/node-meta.prom

echo "IP:" $IP_ADDRESS
echo "Hostname: " $HOSTNAME

echo "node_meta{node_id=\"NODE_ID\", hostname=\"$HOSTNAME\" ip_address=\"$IP_ADDRESS\"} 1" >> $METADATA_PATH/node-meta.prom


