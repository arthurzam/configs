#!/bin/bash

[[ ${UID} != 0 ]] && echo "Error: can be run only as root" >&2 && exit 1

TMP_DIR="$(mktemp -d)"
BACKUP_RELPATH="Backup/periodic"
PASS_FILE="/usr/local/bin/periodic-backup-PASSFILE"

[[ ! -e "${PASS_FILE}" ]] && echo "Error: missing password file at ${PASS_FILE}" >&2 && exit 1

_backup() {
    # $1 - backup name
    # $2,3,... - 
    local _name="${1}"
    shift
    local DST_FILENAME="${TMP_DIR}/${_name}-$(date +%Y%m%d).tar.xz.enc"
    [[ -e "${DST_FILENAME}" ]] && rm "${DST_FILENAME}"
    gpg --output "${DST_FILENAME}" --batch --passphrase-file="${PASS_FILE}" --symmetric --cipher-algo AES256 <(tar cJ -C / "$@") && echo "Backuped ${_name}: $(du -h "${DST_FILENAME}" | awk '{print $1}')"
}

_backup QMPlay2 home/arthur/.qmplay2/
_backup sismaot home/arthur/{sismaot.kdbx,Backup/sismaot.key}
_backup firefox home/arthur/.mozilla/firefox/

export RCLONE_CONFIG=/home/arthur/.config/rclone/rclone.conf
rclone copy "${TMP_DIR}" box:"${BACKUP_RELPATH}"/ --include-from=<(echo "*.xz.enc")
rm -rf "${TMP_DIR}"
