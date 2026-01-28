#!/bin/bash

# Check if the user provided at least one filename
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename1> [filename2] [filename3] ..."
    exit 1
fi

# Loop through all arguments
for filename in "$@"; do
    if [ -f "$filename" ]; then
        shred -zfu -n 1 "$filename"
        echo "File has been securely shredded."
    else
        echo "Error: File not found."
    fi
done
