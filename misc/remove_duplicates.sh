#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

INPUT_FILE="$1"
TEMP_FILE="$(mktemp)"

awk -F, '
    NR==1 {
        print > "'"$TEMP_FILE"'"
        next
    }
    !seen[$1]++ {
        print > "'"$TEMP_FILE"'"
    }
' "$INPUT_FILE"

mv "$TEMP_FILE" "$INPUT_FILE"

echo "Processing completed. Duplicates removed."
