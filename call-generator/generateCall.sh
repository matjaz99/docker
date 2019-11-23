#!/bin/bash

# Create new index (aka table):
# curl -X PUT "localhost:9200/pmon?pretty"

echo "Starting call generator"
echo "ES_HOST=$ENV_ELASTICSEARCH_HOST"
echo "ES_PORT=$ENV_ELASTICSEARCH_PORT"

getRandomInRange()
{
    DIFF=$(($2-$1+1))
    R=$(($(($RANDOM%$DIFF))+$1))
    echo $R
}

CRC[1]="Answered"
CRC[2]="Busy"
CRC[3]="NoReply"
CRC[4]="Error"


while [[ true ]]
do
    A_NUMBER=$(getRandomInRange 100 200)
    B_NUMBER=$(getRandomInRange 800 900)
    NODE_ID=$(hostname)
    START_TIME=$(date +%s)
    DURATION=$(getRandomInRange 10 4800)

    R=$RANDOM
    if (( $R % 2 )); then
        RELEASE_CAUSE=1
    elif (( $R % 3 )); then
        RELEASE_CAUSE=1
    elif (( $R % 5 )); then
        RELEASE_CAUSE=3
    elif (( $R % 7 )); then
        RELEASE_CAUSE=2
    elif (( $R % 9 )); then
        RELEASE_CAUSE=2
    elif (( $R % 11 )); then
        RELEASE_CAUSE=4
    else
        RELEASE_CAUSE=1
    fi
    RELEASE_CAUSE_TXT=${CRC[RELEASE_CAUSE]}
    if [ "$RELEASE_CAUSE_TXT" != "Answered" ]; then
        DURATION=0
    fi;

    JSON_STRING="{ \"a_sub\": \"$A_NUMBER\", \"b_sub\": \"$B_NUMBER\", \"node_id\": \"$NODE_ID\", \"start_time\": $START_TIME, \"duration\": $DURATION, \"release_cause\": $RELEASE_CAUSE, \"release_cause_txt\": \"$RELEASE_CAUSE_TXT\" }"
    echo $JSON_STRING

    curl -X POST http://$ENV_ELASTICSEARCH_HOST:$ENV_ELASTICSEARCH_PORT/pmon/_doc?pretty -H "Content-Type: application/json" -d "$JSON_STRING" -vvv

    echo ""

    sleep $(getRandomInRange 5 15)
done