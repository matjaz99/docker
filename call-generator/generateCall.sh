#!/bin/bash

# Create new index (aka table):
# curl -X PUT "localhost:9200/pmon?pretty"

echo "Starting call generator"
echo "ES_HOST=$ELASTICSEARCH_HOST"
echo "ES_PORT=$ELASTICSEARCH_PORT"

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
    NODE_ZONE=$CALLGEN_NODE_ZONE
    START_TIME=$(date +%s)

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

    R=$RANDOM
    if (( $R % 2 )); then
        DURATION=$(getRandomInRange 100 900)
    elif (( $R % 3 )); then
        DURATION=$(getRandomInRange 300 1200)
    elif (( $R % 5 )); then
        DURATION=$(getRandomInRange 900 1800)
    elif (( $R % 7 )); then
        DURATION=$(getRandomInRange 1200 2800)
    elif (( $R % 9 )); then
        DURATION=$(getRandomInRange 1800 3800)
    elif (( $R % 11 )); then
        DURATION=$(getRandomInRange 3600 4800)
    else
        DURATION=$(getRandomInRange 1 4800)
    fi

    RELEASE_CAUSE_TXT=${CRC[RELEASE_CAUSE]}
    if [ "$RELEASE_CAUSE_TXT" != "Answered" ]; then
        DURATION=0
    fi;

    JSON_STRING="{ \"a_sub\": \"$A_NUMBER\", \"b_sub\": \"$B_NUMBER\", \"node_id\": \"$NODE_ID\", \"node_zone\": \"$NODE_ZONE\", \"start_time\": $START_TIME, \"duration\": $DURATION, \"release_cause\": $RELEASE_CAUSE, \"release_cause_txt\": \"$RELEASE_CAUSE_TXT\" }"

    echo "Generated call: " $JSON_STRING

    curl -X POST http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT/pmon/_doc?pretty -H "Content-Type: application/json" -d "$JSON_STRING" -vvv

    echo ""

    sleep $(getRandomInRange 5 $CALLGEN_MAX_INTERVAL)
done