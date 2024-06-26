#!/bin/bash
CONFIG_PATH=/data/options.json

MAX_LOCAL=$(jq --raw-output ".max_local_backups" $CONFIG_PATH)
MAX_LOCAL_PLUS1=$(($MAX_LOCAL + 1))
#MAX_REMOTE=$(jq --raw-output ".max_remote_backups" $CONFIG_PATH)
#MAX_REMOTE_PLUS1=$(($MAX_REMOTE + 1))
#BACKUP_PATH=$(jq --raw-output ".remote_backup_path" $CONFIG_PATH)
#RESTORE_BACKUPS=$(jq --raw-output ".restore_backups" $CONFIG_PATH)

#show date and time script runs and the options set for logging
echo date
echo "[INFO] MAX_LOCAL=$MAX_LOCAL"
#echo "[INFO] MAX_REMOTE=$MAX_REMOTE"
#echo "[INFO] BACKUP_PATH=$BACKUP_PATH"
#echo "[INFO] RESTORE_BACKUPS=$RESTORE_BACKUPS"

# test the base directory to ensure a path into the container
# if it fails show available paths and exit
BASE_DIRECTORY=$(echo "$BACKUP_PATH" | cut -d "/" -f1)
echo "[INFO] Base directory is $BASE_DIRECTORY"
if [ ! -d /$BASE_DIRECTORY ]; then
  echo "[INFO] $BASE_DIRECTORY is not mapped to container, copy will fail"
  echo "[INFO] Showing available folders mapped to container"
  mount
  exit 1
else
  echo "[INFO] $BASE_DIRECTORY is mapped to container"
fi

#if restore_backups == yes then do restore and exit
# -v (verbose) -t (preserve time stamp)
#LC=${RESTORE_BACKUPS,,}
#if [ $LC == "yes" ]; then
#  echo "[INFO] Restoring backups from /$BACKUP_PATH to /backup"
#  rsync -v -t /$BACKUP_PATH/*.tar /backup
#  exit 0
#fi

#Create /$BACKUP_PATH folder if it does not exist
#if [ ! -d /$BACKUP_PATH ]; then
#  echo "[INFO] Creating /$BACKUP_PATH"
#  mkdir -p -v /$BACKUP_PATH
#else
#  echo "[INFO] $BACKUP_PATH exists"  
#fi

# use rsync to copy over any backups from the sd card backup folder to $BACKUP_PATH
# -v (verbose) -t (preserve time stamp)
#echo "[INFO] Copying all backups from /backup to /$BACKUP_PATH"
#rsync -v -t /backup/*.tar /$BACKUP_PATH

#cleanup backup folder only keeping $MAX_LOCAL (default 2 ) images
echo "[INFO] Purging backups from /backup except for the last $MAX_LOCAL"
ls -tp /backup/*.tar | grep -v '/$' | tail -n +$MAX_LOCAL_PLUS1 | xargs -I {} rm -- "{}"

# cleanup the $BACKUP_PATH only keeping $MAX_REMOTE (default 7 ) images
#echo "[INFO] Purging backups from /mnt/$BACKUP_PATH except for the last $MAX_REMOTE"
#ls -tp /$BACKUP_PATH/*.tar | grep -v '/$' | tail -n +$MAX_REMOTE_PLUS1 | xargs -I {} rm -- "{}"
