#!/bin/bash

DATE_STR=$(date +"%Y-%m-%d")

LOG_FILE_PATH="/var/log/memorykeeper"

# run backup script
sudo /home/pi/projects/memorykeeper/backup.sh 2>&1 | sudo tee -a "$LOG_FILE_PATH/${DATE_STR}.log" # append output of backup script to a log file

# append FAIL info to log file
if [ "${PIPESTATUS[0]}" -ne "0" ]
then
    echo -e '\nBACKUP FAILED!\n' | sudo tee -a "$LOG_FILE_PATH/${DATE_STR}.log"
fi


# Power down external HDD
# see: https://raspberrypi.stackexchange.com/questions/8295/external-hard-drive-power-down
sudo hdparm -y /dev/sda1
