#!/bin/bash

# helper function
file_not_in_ogfiles() {
    local file="$1"
    for og_file in "${og_files[@]}"; do
        if [[ "$og_file" == "$file" ]]; then
            return 1 # File found
        fi
    done
    return 0 # File not found
}


if [ -z "$2" ]; then
    echo -e "\e[31mERROR!\e[0m please specify what to $1, or use \e[34mionvcs $1 .\e[0m to select all"
    exit 1
fi

action="$1"
regex="$2"


# Check the .ionign file
ignore_file="$PWD/.ionign"
if [ -f "$ignore_file" ]; then
    # Read the .ionign file into an array
    mapfile -t ignore_patterns < "$ignore_file"
else
    ignore_patterns=()
fi

# Find all files that match the regex
matching_files=$(find . -type f | grep -E "./${regex}")
mapfile -t og_files < ".ionvcs/ogfiles.config"


# Filter out ignored files
filtered_files=$(echo "$matching_files" | while read -r file; do
        ignored=false
        for pattern in "${ignore_patterns[@]}"; do
            if [[ "$file" == *"$pattern"* ]]; then
                ignored=true
                break
            fi
        done
        for pattern in "${og_files[@]}"; do
            if [[ "$file" == *"$pattern"* ]]; then
                ignored=true
                break
            fi
        done
        if [ "$ignored" = false ]; then
            echo "$file"
        fi
done)

if [ "$action" = "add" ]; then
    echo "Added:"
    for file in $filtered_files; do
        echo -e "\e[0;32m$file\e[0m"
        
        if ! grep -qx "$file" ".ionvcs/add.config"; then
            echo "$file" >> ".ionvcs/add.config"
            elif file_not_in_ogfiles "$file"; then
            echo "$file" >> ".ionvcs/remove.config"
        fi
    done
    elif [ "$action" = "unstage" ]; then
    echo "Unstaged:"
    for file in $filtered_files; do
        echo -e "\e[0;31m$file\e[0m"
        
        sed -i "\|^$file$|d" ".ionvcs/add.config"
    done
else
    exit 1
fi