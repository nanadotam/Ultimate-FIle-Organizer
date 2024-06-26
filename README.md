# Ultimate File Organizer

I created this script to help organize my chaotic Downloads folder. As a programmer and designer, I often download various files ranging from code snippets to design assets, and it quickly becomes a mess. This script categorizes files based on their types and moves existing folders into a single folder named "Just Folders" to keep things tidy.

## Features

- Categorizes files into folders such as Documents, Images, Videos, Music, Archives, Applications, Scripts and Notes, Java, Python, C++, Web Development, PHP, Adobe Suite, Fonts, and Others.
- Moves all existing folders into a single folder named "Just Folders" (excluding the category folders).
- Ensures that the categorization does not run if all category folders already exist and there are no lingering files in the Downloads directory.

## Usage

1. Clone the repository:
    ```sh
    git clone https://github.com/nanadotam/Ultimate-FIle-Organizer.git
    cd Ultimate-FIle-Organizer
    ```

2. Run the script:
    ```sh
    python3 ultimate_file_organizer.py
    ```

## How It Works

- **Move Existing Folders:** The script first checks if there are any folders in the Downloads directory (excluding category folders). If found, they are moved to a folder named "Just Folders".
- **Categorize Files:** The script then categorizes files based on their extensions and moves them into their respective folders.
- **Check Condition:** If all category folders already exist and there are no lingering files, the script prints a message and does not perform any operations.

## Requirements

- Python 3.x
