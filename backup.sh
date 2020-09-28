#!/bin/bash
# https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/
# https://serverfault.com/questions/341199/git-as-a-backup-tool
# TODO: compress ?
cd /mnt/c/Projects/memorykeeper-test/backup
rsync -a --delete --stats /mnt/c/Projects/memorykeeper-test/source/ ./data/
NOW=$(date +"%m-%d-%Y %H:%M:%S")
echo "creating backup at $NOW"
git add .
git commit -a -m "automatic backup $NOW"
# git reflog expire --all --expire=now
# git gc --prune=now --aggressive