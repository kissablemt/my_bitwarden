#!/bin/sh

ROOT_PATH="/root/bitwarden"
DATA_PATH="${ROOT_PATH}/bw-data"
BACKUP_PATH="${ROOT_PATH}/bw-backup"

# create backup filename
BACKUP_FILE="db_$(date "+%F-%H%M%S").sqlite3"

# use sqlite3 to create backup (avoids corruption if db write in progress)
sqlite3 ${DATA_PATH}/db.sqlite3 ".backup '${BACKUP_PATH}/${BACKUP_FILE}'"
sqlite3 ${DATA_PATH}/db.sqlite3 ".backup '${BACKUP_PATH}/$latest.sqlite3'"

echo "put '${BACKUP_PATH}/${BACKUP_FILE}'" > "${ROOT_PATH}/backup_webdav.txt"
echo "bye" >> "${ROOT_PATH}/backup_webdav.txt"
cadaver "https://dav.jianguoyun.com/dav/bitwarden/" < "${ROOT_PATH}/backup_webdav.txt"

rm "${ROOT_PATH}/backup_webdav.txt"


