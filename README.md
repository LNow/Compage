# USAGE
```bash
#!/bin/bash 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# shellcheck source=./Compage/Bootstrap.sh
if ! source "$DIR/Compage/Bootstrap.sh"; then
    >&2 echo "ERROR: Missing library file."
    exit 1
fi

import "Console/Colors"

echo "${UI_COLORS_GREEN}Hello, world!${UI_COLORS_NOCOLOR}"
echo "${UI_COLORS_RED}Hello, ${UI_COLORS_YELLOW}world!${UI_COLORS_NOCOLOR}"
```