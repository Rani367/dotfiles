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
        clang -std=c11 -Wall -Wextra -o "/tmp/$NAME" "$FILE" && "/tmp/$NAME"
        ;;
    cs)
        cd "$(dirname "$FILE")" && dotnet run
        ;;
    *)
        echo "Unsupported file type: .$EXT"
        exit 1
        ;;
esac
