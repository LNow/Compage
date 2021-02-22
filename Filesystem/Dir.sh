# shellcheck shell=bash

Dir::AbsolutePath() {
    local dirPath="$1"

    if [[ ! "$dirPath" = */ ]]; then
        dirPath="${dirPath}/"
    fi

    readlink -e "$dirPath"
}


Dir::Exists() {
    local dirPath="$1"

    [ -d "$dirPath" ] && return 0
}