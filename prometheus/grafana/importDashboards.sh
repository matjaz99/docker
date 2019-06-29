#!/bin/bash

HOSTNAME=172.29.254.66
API_KEY=$(cat grafana_api_key.conf)

# First create folders and parse their ID
# Use that ID when importing dashboards
# https://stackoverflow.com/questions/1955505/parsing-json-with-unix-tools

curl -X POST \
  http://$HOSTNAME:3000/api/folders \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer '$API_KEY \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d "{ \"title\": \"Department ABCDEF\" }"

curl -X POST \
  http://$HOSTNAME:3000/api/dashboards/db \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer '$API_KEY \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d "{ \"dashboard\": $(cat DockerBaton.json), \"folderId\": 0, \"overwrite\": true }"
