# shellcheck shell=bash

File::AbsolutePath() {
    local filePath="$1"
    
    readlink -e "$filePath"
}


File::Basename() {
    local filePath="$1"

    basename "$filePath"
}


File::Exists() {
    local filePath="$1"

    [ -f "$filePath" ] && return 0
}


File::Extension() {
    local filePath="$1"

    echo "${filePath##*.}"
}