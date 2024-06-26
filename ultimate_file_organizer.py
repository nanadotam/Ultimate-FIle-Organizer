import os
import shutil

# Define the path to your Downloads folder
downloads_folder = os.path.expanduser('~/Downloads')

# Define the name of the folder to store all existing folders
all_folders_name = 'Just Folders'
all_folders_path = os.path.join(downloads_folder, all_folders_name)

# Define the categories and their corresponding file extensions
categories = {
    'Documents': ['.pdf', '.docx', '.txt', '.pptx', '.xlsx'],
    'Images': ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.heic', '.avif', '.webp', '.svg'],
    'Videos': ['.mp4', '.mov', '.avi', '.mkv'],
    'Music': ['.mp3', '.wav', '.flac', '.aac'],
    'Archives': ['.zip', '.rar', '.tar.gz', '.7z'],
    'Applications': ['.exe', '.dmg', '.pkg'],
    'Scripts and Notes': ['.sh', '.md'],
    'Java': ['.java', '.class', '.jar'],
    'Python': ['.py', '.ipynb'],
    'C++': ['.cpp', '.hpp', '.h'],
    'Web Development': ['.html', '.css', '.ts'],
    'PHP': ['.php'],
    'Adobe Suite': ['.psd', '.ai', '.indd', '.xd'],
    'Fonts': ['.ttf', '.otf', '.woff', '.woff2'],
    'Others': []  # For all other file types
}

# Create folders for each category if they don't already exist
for category in categories:
    category_folder = os.path.join(downloads_folder, category)
    if not os.path.exists(category_folder):
        os.makedirs(category_folder)

# Check if all category folders exist and there are no lingering files
all_folders_exist = all(os.path.exists(os.path.join(downloads_folder, category)) for category in categories)
no_lingering_files = all(not os.path.isfile(os.path.join(downloads_folder, item)) for item in os.listdir(downloads_folder))

if all_folders_exist and no_lingering_files:
    print("All category folders already exist and there are no lingering files. The script will not run.")
else:
    # Create the "Just Folders" directory if it doesn't exist
    if not os.path.exists(all_folders_path):
        os.makedirs(all_folders_path)

    # Move all existing folders into the "Just Folders" directory
    for item_name in os.listdir(downloads_folder):
        item_path = os.path.join(downloads_folder, item_name)
        if os.path.isdir(item_path) and item_name not in categories.keys() and item_name != all_folders_name:
            shutil.move(item_path, os.path.join(all_folders_path, item_name))

    print("All existing folders have been moved to 'Just Folders'.")

    # Move files into their respective category folders
    for file_name in os.listdir(downloads_folder):
        file_path = os.path.join(downloads_folder, file_name)
        if os.path.isfile(file_path):
            moved = False
            for category, extensions in categories.items():
                if any(file_name.lower().endswith(ext) for ext in extensions):
                    shutil.move(file_path, os.path.join(downloads_folder, category, file_name))
                    moved = True
                    break
            if not moved:
                shutil.move(file_path, os.path.join(downloads_folder, 'Others', file_name))

    print("Downloads folder organized successfully!")
