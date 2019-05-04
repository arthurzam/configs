#! /bin/bash

_symlink() {
    # $1 - src
    # $2 - dst
    
    local src="$(realpath "$1")"

    [[ $# != 2 ]] && echo "bad amount [$#] of arguments to symlink" && return 1
    [[ "$(realpath "$2")" = "${src}" ]] && echo "already linked" && return 0

    [[ -d "$2" ]] && rm -r "$2" && echo "Removed directory $2"
    [[ -e "$2" ]] && rm "$2" && echo "Removed file $2"
    [[ ! -e "$2" ]] && ln -s "${src}" "$2" && echo "Linked $2 <- $1"
}

_parse_install_cfg() {
    cat "INSTALL.cfg" | while read line; do
        echo ">>> ${line}"

        line="$(sed -e 's:~:'"${HOME}:g" <<< "${line}")"
        
        local  cmd="$(cut -d" " -f1  <<< "${line}")"
        local args="$(cut -d" " -f2- <<< "${line}")"

        case "${cmd}" in
        l|link)
            _symlink ${args} || return 1
            ;;
        e|exec)
            eval ${args} || return 1
            ;;
        *)
            echo "bad command ${cmd}"
            return 1
        esac
    done
}

find . -name "INSTALL.cfg" | sort | while read filename; do
    echo "####### running ${filename} #########"
    pushd "$(dirname "${filename}")" >& /dev/null
    _parse_install_cfg
    popd >& /dev/null
done
