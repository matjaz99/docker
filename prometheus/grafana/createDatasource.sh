#!/bin/bash

HOSTNAME=172.29.254.66
API_KEY=$(cat grafana_api_key.conf)

curl -X POST \
  http://$HOSTNAME:3000/api/datasources \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer '$API_KEY \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "name": "Prometheus-TEST3",
    "type": "prometheus",
    "access": "proxy",
    "url": "http://prometheus:9090",
    "basicAuth": false
}'

