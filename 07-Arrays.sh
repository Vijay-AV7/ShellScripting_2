#!/bin/bash

TIMESTAMP_START=$(date)

echo "Script execution started at : "$TIMESTAMP_START""

MOVIES=(Dhurandhar, Peddi, AA22)

echo "First Movie : "$MOVIES[0]""
echo "Second Movie : "$MOVIES[1]""
echo "Third Movie : "$MOVIES[2]""
echo "All movies : "$MOVIES[@]""

TIMESTAMP_END=$(date)
echo "Script execution end at : "$TIMESTAMP_END""