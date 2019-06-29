#!/bin/bash

# this script will remove all stopped containers and volumes...

containers=$(docker ps -aq)

for var in $containers
do
	echo "remove contaianer: $var"
	docker rm $var
done

volumes=$(docker volume ls -q)

for var in $volumes
do
        echo "remove volume: $var"
        docker volume rm $var
done

