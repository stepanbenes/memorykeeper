#!/bin/bash

DATE_STR=$(date +"%Y-%m-%d")
BRANCH_NAME=$(date +"auto-backup/%Y/%m/%d")

# run backup script
sudo /home/pi/projects/memorykeeper/backup.sh "$BRANCH_NAME" 2>&1 | sudo tee -a "/var/log/memorykeeper/$DATE_STR.log"  # append output of backup script to a log file

# Power down external HDD
# see: https://raspberrypi.stackexchange.com/questions/8295/external-hard-drive-power-down
sudo hdparm -y /dev/sda1
