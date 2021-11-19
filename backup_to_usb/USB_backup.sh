#!/bin/bash
CONFIG_PATH=/data/options.json

MAX_LOCAL=$(jq --raw-output ".max_local_backups" $CONFIG_PATH)
MAX_LOCAL_PLUS1=$(($MAX_LOCAL + 1))
MAX_REMOTE=$(jq --raw-output ".max_remote_backups" $CONFIG_PATH)
MAX_REMOTE_PLUS1=$(($MAX_REMOTE + 1))
BACKUP_PATH=$(jq --raw-output ".remote_backup_path" $CONFIG_PATH)

echo "[INFO] MAX_LOCAL=$MAX_LOCAL"
echo "[INFO] MAX_REMOTE=$MAX_REMOTE"
echo "[INFO] BACKUP_PATH=$BACKUP_PATH"

echo "[INFO] Mounting /dev/sda1 to /mnt"
mount /dev/sda1 /mnt

# Create /mnt/$BACKUP_PATH folder
if [ ! -d /mnt/$BACKUP_PATH ]; then
  echo "[INFO] Creating /mnt/$BACKUP_PATH"
  mkdir -p /mnt/$BACKUP_PATH
fi

echo "[INFO] Copying all backups from /backup to /mnt/$BACKUP_PATH"
rsync -v /backup/*.tar /mnt/$BACKUP_PATH

echo "[INFO] Purging backups from /backup except for the last $MAX_LOCAL"
ls -tp /backup/*.tar | grep -v '/$' | tail -n +$MAX_LOCAL_PLUS1 | xargs -I {} rm -- "{}"

echo "[INFO] Purging backups from /mnt/$BACKUP_PATH except for the last $MAX_REMOTE"
ls -tp /mnt/$BACKUP_PATH/*.tar | grep -v '/$' | tail -n +$MAX_REMOTE_PLUS1 | xargs -I {} rm -- "{}"

