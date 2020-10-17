#!/bin/bash
# https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/
# https://serverfault.com/questions/341199/git-as-a-backup-tool
# TODO: compress ?

set -e # fail on any command error

cd /mnt/sidlo_backup

NOW=$(date +"%m-%d-%Y %H:%M:%S")
echo "creating backup at $NOW"

# https://opensource.com/life/16/3/turn-your-old-raspberry-pi-automatic-backup-server; https://rdiff-backup.net/;

rdiff-backup --print-statistics --exclude **/media /mnt/sidlo_data/data/ /mnt/sidlo_backup/data/

echo -e "\n"
