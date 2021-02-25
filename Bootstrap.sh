#!/bin/bash
export PS4='\nDEBUG level:$SHLVL subshell-level: $BASH_SUBSHELL \nsource-file:${BASH_SOURCE} line#:${LINENO} function:${FUNCNAME[0]:+${FUNCNAME[0]}(): }\nstatement: '

# return if script is already soruced
[ -n "$COMPAGE_LOADED" ] && return || COMPAGE_LOADED=1

readonly COMPAGE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly COMPAGE_CORE_PATH="${COMPAGE_PATH}/Core"
readonly COMPAGE_LIB_PATH="${COMPAGE_PATH}/Lib"

# shellcheck source=Core/Loader.sh
if ! source "$COMPAGE_CORE_PATH/Loader.sh"; then
    >&2 echo "ERROR: Missing Loader.sh file"
    exit 1
fi

