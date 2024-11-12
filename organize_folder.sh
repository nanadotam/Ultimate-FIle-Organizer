#!/bin/bash

# Check if the user provided a folder path as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_folder>"
    exit 1
fi

# Define the path to the folder to be organized
target_folder="$1"

# Validate the provided path
if [ ! -d "$target_folder" ]; then
    echo "Error: The specified path is not a directory or does not exist."
    exit 1
fi

# Define the name of the folder to store all existing folders
all_folders_name="Just Folders"
all_folders_path="$target_folder/$all_folders_name"

# Define the categories and their corresponding file extensions
declare -A categories=(
    ["Documents"]="pdf docx txt pptx xlsx"
    ["Images"]="jpg jpeg png gif bmp heic avif webp svg"
    ["Videos"]="mp4 mov avi mkv"
    ["Music"]="mp3 wav flac aac"
    ["Archives"]="zip rar tar.gz 7z"
    ["Applications"]="exe dmg pkg"
    ["Scripts and Notes"]="sh md"
    ["Java"]="java class jar"
    ["Python"]="py ipynb"
    ["C++"]="cpp hpp h"
    ["Web Development"]="html css ts"
    ["PHP"]="php"
    ["Adobe Suite"]="psd ai indd xd"
    ["Fonts"]="ttf otf woff woff2"
    ["Others"]=""
)

# Create folders for each category if they don't already exist
for category in "${!categories[@]}"; do
    category_folder="$target_folder/$category"
    if [ ! -d "$category_folder" ]; then
        mkdir -p "$category_folder"
    fi
done

# Check if all category folders exist and there are no lingering files
all_folders_exist=true
for category in "${!categories[@]}"; do
    category_folder="$target_folder/$category"
    if [ ! -d "$category_folder" ]; then
        all_folders_exist=false
        break
    fi
done

no_lingering_files=true
for item in "$target_folder"/*; do
    if [ -f "$item" ]; then
        no_lingering_files=false
        break
    fi
done

if [ "$all_folders_exist" = true ] && [ "$no_lingering_files" = true ]; then
    echo "All category folders already exist and there are no lingering files. The script will not run."
else
    # Create the "Just Folders" directory if it doesn't exist
    if [ ! -d "$all_folders_path" ]; then
        mkdir -p "$all_folders_path"
    fi

    # Move all existing folders into the "Just Folders" directory
    for item in "$target_folder"/*; do
        if [ -d "$item" ] && [[ ! " ${!categories[@]} " =~ " $(basename "$item") " ]] && [ "$(basename "$item")" != "$all_folders_name" ]; then
            mv "$item" "$all_folders_path/"
        fi
    done

    echo "All existing folders have been moved to 'Just Folders'."

    # Move files into their respective category folders
    for file in "$target_folder"/*; do
        if [ -f "$file" ]; then
            moved=false
            for category in "${!categories[@]}"; do
                extensions=${categories[$category]}
                for ext in $extensions; do
                    if [[ "${file,,}" == *.$ext ]]; then
                        mv "$file" "$target_folder/$category/"
                        moved=true
                        break
                    fi
                done
                if [ "$moved" = true ]; then
                    break
                fi
            done
            if [ "$moved" = false ]; then
                mv "$file" "$target_folder/Others/"
            fi
        fi
    done

    echo "Folder organized successfully!"
fi
