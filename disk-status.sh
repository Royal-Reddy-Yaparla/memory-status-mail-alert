#!/bin/bash

###############################################
# Author: ROYAL REDDY
# Date: 10-04
# Version: V1
# Purpose: Send Disc usage aleart mail
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
DISK_USAGE=$(df -hT | grep -vE 'tmp|efivarfs' | tail -n +2)
DISK_THRUSHOLD=1
MESSEAGE=""
while IFS= read line
do 
    # echo "$line"
    usage=$(echo $line | awk '{print $6F}' | cut -d "%" -f 1)
    disk=$(echo $line | awk '{print $1F}' )
    if [ $usage -gt $DISK_THRUSHOLD ]
    then 
        MESSEAGE+="Warning: Disk usage is above the configured limit Disk Name: $disk Current_Usage : $usage% <br>"
    fi
done <<< $DISK_USAGE

sh mail.sh "DevOps Team" "High Disk Usage" "$MESSEAGE" "royalreddy364@gmail.com" "ALERT Hign Disc Usage"
