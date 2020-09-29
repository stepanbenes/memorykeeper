#!/bin/bash
# https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/
# https://serverfault.com/questions/341199/git-as-a-backup-tool
# TODO: compress ?

# set -e # fail on any command error

cd /mnt/c/Projects/memorykeeper-test/backup

# https://stackoverflow.com/questions/21151178/shell-script-to-check-if-specified-git-branch-exists
# test if the branch is in the local repository.
# return 1 if the branch exists in the local, or 0 if not.
function is_local_branch() {
    local branch=${1}
    local existed_in_local=$(git branch --list ${branch})

    if [[ -z ${existed_in_local} ]]; then
        echo 0
    else
        echo 1
    fi
}

# TODO: copy from remote computer
# TODO: use exclude-from parameter to unlist directories to sync (e.g. exclude media directory)
rsync -a --delete --stats /mnt/c/Projects/memorykeeper-test/source/ ./data/

if [ "$1" != "" ]; then
	BRANCH_NAME="$1"
else
	BRANCH_NAME=$(date +"auto-backup/%Y/%m/%d")
fi

NOW=$(date +"%m-%d-%Y %H:%M:%S")
echo "creating backup at $NOW"

BRANCH_EXISTS=$(git show-ref --verify refs/heads/$BRANCH_NAME)

if [ "$BRANCH_EXISTS" != "" ]; then
	git checkout "$BRANCH_NAME"
else
	git checkout -b "$BRANCH_NAME"
fi

git add .

git commit -a -m "backup at $NOW"


# TODO: clear garbage in repo? >>
# git reflog expire --all --expire=now
# git gc --prune=now --aggressive