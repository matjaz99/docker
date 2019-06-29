#/bin/bash

# ./generatePromNodes.sh 192.168.1.241 192.168.1.242 192.168.1.243 192.168.1.244 172.29.254.66 172.29.254.50 172.29.254.48 172.30.19.16 172.30.19.32 172.30.19.33

PORT=9323
FILENAME=nodes.yml
MAX=10

rm -f $FILENAME

echo "- targets:" > $FILENAME

for var in "$@"
do
	for i in {1..$MAX}
	do
		echo "  - $var:$PORT" >> $FILENAME
	done
done


