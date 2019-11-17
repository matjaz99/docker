#!/bin/bash

a=0
RANDOM=$$

while [[ true ]]
do
   a=`expr $a + 1`
   echo $a: $RANDOM
   sleep 1
done