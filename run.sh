#!/bin/bash
# Zed Code Runner

set -e

FILE="$1"
[[ -z "$FILE" ]] && echo "Error: No file provided" && exit 1

EXT="${FILE##*.}"
NAME="${FILE##*/}"
NAME="${NAME%.*}"

clear

case "$EXT" in
    py)
        python3 "$FILE"
        ;;
    c)
        DIR="$(dirname "$FILE")"
        MAIN_COUNT=$(grep -l '\bmain\s*(' "$DIR"/*.c 2>/dev/null | wc -l)
        if [[ $MAIN_COUNT -gt 1 ]]; then
            clang -std=c11 -Wall -Wextra -o "/tmp/$NAME" "$FILE" && "/tmp/$NAME"
        else
            clang -std=c11 -Wall -Wextra -o "/tmp/$NAME" "$DIR"/*.c && "/tmp/$NAME"
        fi
        ;;
    cs)
        cd "$(dirname "$FILE")" && dotnet run
        ;;
    *)
        echo "Unsupported file type: .$EXT"
        exit 1
        ;;
esac
