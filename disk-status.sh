#!/bin/bash

###############################################
# Author: ROYAL REDDY
# Date: 10-04
# Version: V1
# Purpose: memory usage alert mail to team
################################################

ID=$(id -u)

# Colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILE="/tmp/$0-$TIMESTAMP.log"

# USAGE=$(df -h | grep -Ev 'tmpf' | grep -Ev 'efivarfs' | awk '{print $5F}' | cut -d "%" -f 1)
DISK_USAGE=$(df -hT | grep -vE 'tmp|efivarfs')
echo "$DISC_USAGE"

while IFS= read line
do 
    # echo "$line"
    usage=$(echo $line | awk '{print $6F}' | cut -d "%" -f 1)
    disk=$(echo $line | awk '{print $1F}' )
    echo -e "Disk : $disk Usage $R $usage $N"
done <<< $DISK_USAGE