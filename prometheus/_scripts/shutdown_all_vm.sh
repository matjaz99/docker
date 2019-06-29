#!/bin/bash

ssh root@docker-2 shutdown -h now

sleep 2

ssh root@docker-3 shutdown -h now

sleep 2

ssh root@docker-4 shutdown -h now

sleep 2

ssh root@docker-1 shutdown -h now
