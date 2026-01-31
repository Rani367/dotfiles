#!/bin/bash
# Zed Code Runner - runs current file based on extension

set -e

FILE="$1"
if [[ -z "$FILE" ]]; then
    echo "Error: No file provided"
    exit 1
fi

EXT="${FILE##*.}"
BASENAME="${FILE##*/}"
NAME="${BASENAME%.*}"
DIR="$(dirname "$FILE")"

# Clear terminal
clear

case "$EXT" in
    py)
        python3 "$FILE"
        ;;
    c)
        cd "$DIR"
        # Find project root (look for CMakeLists.txt up to 3 levels up)
        PROJECT_ROOT="$DIR"
        for i in . .. ../.. ../../..; do
            if [[ -f "$DIR/$i/CMakeLists.txt" ]]; then
                PROJECT_ROOT="$(cd "$DIR/$i" && pwd)"
                break
            fi
        done

        if [[ -f "$PROJECT_ROOT/CMakeLists.txt" ]]; then
            # CMake project
            cd "$PROJECT_ROOT"
            mkdir -p build && cd build
            cmake .. && cmake --build .
            # Find and run the executable (first one found)
            EXEC=$(find . -maxdepth 1 -type f -perm +111 ! -name "*.cmake" | head -1)
            [[ -n "$EXEC" ]] && "$EXEC"
        elif [[ -f Makefile || -f makefile ]]; then
            make && "./$(basename "$DIR")" 2>/dev/null || make run 2>/dev/null || ./main 2>/dev/null || ./a.out
        else
            # Compile all .c files in directory
            clang -std=c11 -Wall -Wextra -o "/tmp/$NAME" *.c && "/tmp/$NAME"
        fi
        ;;
    cpp|cc|cxx)
        cd "$DIR"
        # Find project root (look for CMakeLists.txt up to 3 levels up)
        PROJECT_ROOT="$DIR"
        for i in . .. ../.. ../../..; do
            if [[ -f "$DIR/$i/CMakeLists.txt" ]]; then
                PROJECT_ROOT="$(cd "$DIR/$i" && pwd)"
                break
            fi
        done

        if [[ -f "$PROJECT_ROOT/CMakeLists.txt" ]]; then
            # CMake project
            cd "$PROJECT_ROOT"
            mkdir -p build && cd build
            cmake .. && cmake --build .
            # Find and run the executable (first one found)
            EXEC=$(find . -maxdepth 1 -type f -perm +111 ! -name "*.cmake" | head -1)
            [[ -n "$EXEC" ]] && "$EXEC"
        elif [[ -f Makefile || -f makefile ]]; then
            make && "./$(basename "$DIR")" 2>/dev/null || make run 2>/dev/null || ./main 2>/dev/null || ./a.out
        else
            # Compile all C++ files in directory
            clang++ -std=c++17 -Wall -Wextra -o "/tmp/$NAME" *.cpp *.cc *.cxx 2>/dev/null || \
            clang++ -std=c++17 -Wall -Wextra -o "/tmp/$NAME" *.cpp 2>/dev/null || \
            clang++ -std=c++17 -Wall -Wextra -o "/tmp/$NAME" *.cc 2>/dev/null || \
            clang++ -std=c++17 -Wall -Wextra -o "/tmp/$NAME" *.cxx && "/tmp/$NAME"
        fi
        ;;
    cs)
        # C# - run via dotnet in project directory
        cd "$DIR"
        dotnet run
        ;;
    js|mjs)
        node "$FILE"
        ;;
    ts|mts)
        # TypeScript fallback chain
        if command -v tsx &>/dev/null; then
            tsx "$FILE"
        elif command -v ts-node &>/dev/null; then
            ts-node "$FILE"
        elif command -v bun &>/dev/null; then
            bun "$FILE"
        elif command -v deno &>/dev/null; then
            deno run --allow-all "$FILE"
        else
            npx tsx "$FILE"
        fi
        ;;
    lua)
        lua "$FILE"
        ;;
    go)
        go run "$FILE"
        ;;
    rs)
        rustc -o "/tmp/$NAME" "$FILE" && "/tmp/$NAME"
        ;;
    sh)
        bash "$FILE"
        ;;
    zsh)
        zsh "$FILE"
        ;;
    rb)
        ruby "$FILE"
        ;;
    java)
        # Compile to /tmp and run
        javac -d /tmp "$FILE" && java -cp /tmp "$NAME"
        ;;
    swift)
        swift "$FILE"
        ;;
    *)
        echo "Unsupported file type: .$EXT"
        exit 1
        ;;
esac
