#!/bin/bash

[[ ${UID} != 0 ]] && echo "Error: can be run only as root" >&2 && exit 1

MOUNTPOINT="/media/box"
BACKUP_RELPATH="Backup/periodic"

if ! grep -qs "${MOUNTPOINT}" /proc/mounts; then
    export _unmount_box="1"
    systemctl start rclone@box.service
fi

[[ ! -d "${MOUNTPOINT}/${BACKUP_RELPATH}" ]] && echo "Error: bad mount" >&2 && exit 1

_backup() {
    # $1 - backup name
    # $2,3,... - 
    local _name="${1}"
    shift
    gpg --output "${_name}-$(date +%Y%m%d).tar.xz.enc" --batch --passphrase-file="/usr/local/bin/periodic-backup-PASSFILE" --symmetric --cipher-algo AES256 <(tar cJ -C / "$@") && echo "Backuped ${_name}"
}

pushd "${MOUNTPOINT}/${BACKUP_RELPATH}" >& /dev/null

_backup QMPlay2 home/arthur/.qmplay2/
_backup sismaot home/arthur/{sismaot.kdbx,Backup/sismaot.key}
_backup firefox home/arthur/.mozilla/firefox/

popd >& /dev/null

if [[ -n ${_unmount_box} ]]; then
    systemctl stop rclone@box.service
    unset _unmount_box
fi
