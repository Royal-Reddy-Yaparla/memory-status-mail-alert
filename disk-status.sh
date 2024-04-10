#!/bin/bash

###############################################
# Author: ROYAL REDDY
# Date: 10-04
# Version: V1
# Purpose: Send Disc usage aleart mail
# Input: disc_limit and to mail id
################################################


DISK_USAGE=$(df -hT | grep -vE 'tmp|efivarfs' | tail -n +2)
DISK_THRUSHOLD=$1
TO_MAIL=$2
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

sh mail.sh "DevOps Team" "High Disk Usage" "$MESSEAGE" "$TO_MAIL" "ALERT Hign Disc Usage" "$DISK_THRUSHOLD"
