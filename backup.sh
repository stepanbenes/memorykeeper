#!/bin/bash
# https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/
# https://serverfault.com/questions/341199/git-as-a-backup-tool
# TODO: compress ?

# set -e # fail on any command error

# if [ "$1" == "" ]; then
# 	echo "missing argument 'BRANCH_NAME'"
#     exit 1
# fi

cd /mnt/sidlo_backup || exit 1

# https://stackoverflow.com/questions/21151178/shell-script-to-check-if-specified-git-branch-exists
# test if the branch is in the local repository.
# return 1 if the branch exists in the local, or 0 if not.
# function is_local_branch() {
#     local branch=${1}
#     local existed_in_local=$(git branch --list ${branch})
# 
#     if [[ -z ${existed_in_local} ]]; then
#         echo 0
#     else
#         echo 1
#     fi
# }

NOW=$(date +"%m-%d-%Y %H:%M:%S")
echo "creating backup at $NOW"

# TODO: copy from remote computer
# TODO: use exclude-from parameter to unlist directories to sync (e.g. exclude media directory)
rsync -a --delete --stats --progress --exclude 'media' /mnt/sidlo_data/ /mnt/sidlo_backup/data/ || exit 1

# BRANCH_NAME="$1"
# 
# NOW=$(date +"%m-%d-%Y %H:%M:%S")
# echo -e "\narchiving in git repository at $NOW"
# 
# BRANCH_EXISTS=$(git show-ref --verify refs/heads/$BRANCH_NAME)
# 
# if [ "$BRANCH_EXISTS" != "" ]; then
# 	git checkout "$BRANCH_NAME" || exit 1
# else
# 	git checkout -b "$BRANCH_NAME" || exit 1
# fi
# 
# git add . || exit 1
# 
# git commit -a -m "backup at $NOW" || exit 1
# 
# NOW=$(date +"%m-%d-%Y %H:%M:%S")
# echo -e "\nbackup completed at $NOW"

# TODO: clear garbage in repo? >>
# git reflog expire --all --expire=now
# git gc --prune=now --aggressive