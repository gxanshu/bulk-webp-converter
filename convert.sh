#!/bin/bash

# Function to convert PNG files to WebP
convert_to_webp() {
  local input="$1"
  local output="${input%.png}.webp"
  
  # Convert PNG to WebP
  cwebp "$input" -q 10 -o "$output"
  
  echo "Converted: $input"
}

# Recursive function to traverse directories
traverse_directories() {
  local dir="$1"
  
  # Iterate over all files and directories in the given directory
  for file in "$dir"/*; do
    if [[ -d "$file" ]]; then
      # Directory found, recursively traverse it
      traverse_directories "$file"
    elif [[ -f "$file" && "${file##*.}" == "png" ]]; then
      # PNG file found, convert it to WebP
      convert_to_webp "$file"
    fi
  done
}

# Start traversal from the current directory (change this if needed)
traverse_directories "."

echo "Conversion complete."
