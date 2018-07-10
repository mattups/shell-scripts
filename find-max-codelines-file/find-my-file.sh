#!/bin/bash
# Get all files by chosen extension, for example js.
files=$(find . -name "*.js")

# Count codelines of files.
for file in $files
    do
        wc -l $file
    done | sort -nr