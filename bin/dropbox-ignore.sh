#!/usr/bin/env zsh
# https://help.dropbox.com/sync/ignored-files


set -e


help() {
    local errcode=${1:-0}
    echo "Usage:"
    echo "${0} [-h|--help] path/to/file-to-ignore.txt"
    exit $errcode
}


if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then
    help
fi


if [[ -f "$1" || -d "$1" ]]; then
    ( set -x; xattr -w com.dropbox.ignored 1 "$1" )
    exit $?
fi

echo "$1 does not exist!"
help 1

