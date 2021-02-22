# shellcheck shell=bash

declare -aG __COMPAGE_IMPORTED_FILES

Loader::Import() {
    local targetPath

    for targetPath in "$@"; do
        Loader::ImportPath "$targetPath"
    done
}


Loader::ImportPath() {
    local targetPath="$1"

    {
        local localPath
        localPath="$( cd "${BASH_SOURCE[2]%/*}" && pwd )"
        Loader::SourcePath "${localPath}/${targetPath}"
    } || \
    Loader::SourcePath "${COMPAGE_PATH}/${targetPath}" || \
    Loader::SourcePath "${COMPAGE_CORE_PATH}/${targetPath}" || \
    Loader::SourcePath "${COMPAGE_LIB_PATH}/${targetPath}" || >&2 echo "[ERROR][COMPAGE::Loader] Failed to import $targetPath"
}

Loader::SourcePath() {
    local targetPath="$1"

    if [[ -d $targetPath ]]; then
        for targetFile in "$targetPath"/*.sh; do
            Loader::SourceFile "$targetFile"
        done
    else
        Loader::SourceFile "$targetPath" || Loader::SourceFile "${targetPath}.sh"
    fi
}

Loader::SourceFile() {
    local targetFile="$1"

    if [[ ! -f $targetFile ]]; then
        return 1
    fi

    fileName=$(basename "$targetFile")
    absoluteFileDir=$( cd "$( dirname "${targetFile}" )" >/dev/null 2>&1 && pwd )
    absoluteFilePath="${absoluteFileDir}/${fileName}"

    # Don't import same file multiple times
    if Loader::IsImported "$absoluteFilePath"; then
        return 0
    fi

    # shellcheck disable=SC1090
    if source "$absoluteFilePath"; then
        __COMPAGE_IMPORTED_FILES+=("$absoluteFilePath")
    fi
}

Loader::IsImported() {
    local importedFile
    for importedFile in "${__COMPAGE_IMPORTED_FILES[@]}"; do
        if [[ "$importedFile" = "$1" ]]; then
            return 0
        fi
    done
  
    return 1
}

shopt -s expand_aliases
alias import="Loader::Import"