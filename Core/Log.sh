# shellcheck shell=bash
import "Console/Colors"

Log::LevelName() {
    local level="${1}"
    level=${level^^}
    
    # echo "Processing: ${level}"
    case "$level" in
        "DEBUG") echo "DEBUG" ;;
        "INFO") echo "INFO" ;;
        "NOTICE") echo "NOTICE" ;;
        "WARNING") echo "WARNING" ;;
        "ERROR") echo "ERROR" ;;
        "CRITICAL") echo "CRITICAL" ;;
        *) echo "INFO"
    esac
}

Log::Debug() {
    local message="$1"

    Log::Log "DEBUG" "${message}"
}

Log::Info() {
    local message="$1"

    Log::Log "INFO" "${message}"
}

Log::Notice() {
    local message="$1"

    Log::Log "NOTICE" "${message}"
}

Log::Warning() {
    local message="$1"

    Log::Log "WARNING" "${message}"
}

Log::Error() {
    local message="$1"

    Log::Log "ERROR" "${message}"
}

Log::Critical() {
    local message="$1"

    Log::Log "CRITICAL" "${message}"
}


Log::Log() {
    local level="$1"
    local message="$2"

    local level_name
    level_name=$(Log::LevelName "$level")
    
    local IFS=" "
    local -a trace
    read -r -a trace <<< "$(caller 0)"

    # avoid showing this file in context
    [ "${trace[*]:2}" = "${BASH_SOURCE[0]}" ] && read -r -a trace <<< "$(caller 1)"
    

    local context_line="${trace[0]}"
    local context_function="${trace[1]}"
    local context_file="${trace[*]:2}"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S.%s")

    local color
    case "$level_name" in
        "DEBUG") color="$UI_NO_COLOR" ;;
        "INFO") color="$UI_COLORS_GREEN" ;;
        "NOTICE")  color="$UI_COLORS_BLUE";;
        "WARNING") color="$UI_COLORS_ORANGE" ;;
        "ERROR") color="$UI_COLORS_RED" ;;
        "CRITICAL") color="$UI_COLORS_RED" ;;
        *) color=UI_COLORS_NOCOLOR ;;
    esac


    echo -e "${color}[${timestamp}][${level_name}][${context_file} function ${context_function}() line ${context_line}]: $message ${UI_COLORS_NOCOLOR}"
}