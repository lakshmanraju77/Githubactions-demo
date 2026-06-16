#!/bin/bash

SITE=$1
BACKUP_BASE="/home/frappe/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_DIR="${BACKUP_BASE}/${SITE}/${TIMESTAMP}"

mkdir -p "$BACKUP_DIR"

echo "Taking backup for $SITE"

bench --site "$SITE" backup --with-files

mv sites/$SITE/private/backups/* "$BACKUP_DIR"/ 2>/dev/null
mv sites/$SITE/private/files "$BACKUP_DIR"/ 2>/dev/null

echo "Backup stored at $BACKUP_DIR"
