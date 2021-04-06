#!/bin/bash

[[ ${UID} != 0 ]] && echo "Error: can be run only as root" >&2 && exit 1

MOUNTPOINT="/media/box"
BACKUP_RELPATH="Backup/periodic"
PASS_FILE="/usr/local/bin/periodic-backup-PASSFILE"

[[ ! -e "${PASS_FILE}" ]] && echo "Error: missing password file at ${PASS_FILE}" >&2 && exit 1

if ! grep -qs "${MOUNTPOINT}" /proc/mounts; then
    _unmount_box="1"
    systemctl start rclone@box.service
fi

[[ ! -d "${MOUNTPOINT}/${BACKUP_RELPATH}" ]] && echo "Error: bad mount" >&2 && exit 1

_backup() {
    # $1 - backup name
    # $2,3,... - 
    local _name="${1}"
    shift
    local DST_FILENAME="${MOUNTPOINT}/${BACKUP_RELPATH}/${_name}-$(date +%Y%m%d).tar.xz.enc"
    [[ -e "${DST_FILENAME}" ]] && rm "${DST_FILENAME}"
    gpg --output "${DST_FILENAME}" --batch --passphrase-file="${PASS_FILE}" --symmetric --cipher-algo AES256 <(tar cJ -C / "$@") && echo "Backuped ${_name}: $(du -h "${DST_FILENAME}" | awk '{print $1}')"
}

_backup QMPlay2 home/arthur/.qmplay2/
_backup sismaot home/arthur/{sismaot.kdbx,Backup/sismaot.key}
_backup firefox home/arthur/.mozilla/firefox/

if [[ -n ${_unmount_box} ]]; then
    systemctl stop rclone@box.service
    unset _unmount_box
fi
