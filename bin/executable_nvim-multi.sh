#!/bin/bash

# Store selected files as arguments
files="$(echo "$@" | tr '\" ' '\n\"')"
cwd=$PWD

echo "${files[@]}"
echo "length of files: ${#files[@]}"
echo "cwd: $cwd"


# Check if there are any files to open
if [ "$files" = "" ]; then
    echo "No files selected."
    exit 1
fi

# Convert relative paths to absolute paths
abs_files=()
for file in "${files[@]}"; do
    abs_files+=("$PWD/$file")
done
echo "${abs_files[@]}"


# # Create a command to open all files in separate buffers
# cmd=":edit ${abs_files[0]}"
# for file in "${abs_files[@]:1}"; do
#     cmd+="|:badd $file"
# done

# # Start Neovim and execute the command
# nvim -c "$cmd"
