import os
import shutil

source_dir = os.path.expanduser("~/.config/")
reference_dir = os.path.expanduser("~/git/system/dot/files/home/xfo/.config/")
destination_dir = os.path.expanduser("~/git_single/dotfiles/")

for dirpath, dirnames, filenames in os.walk(reference_dir):
    structure = os.path.join(destination_dir, os.path.relpath(dirpath, reference_dir))
    if not os.path.isdir(structure):
        os.mkdir(structure)  # create dir structure if it doesn't exist already

    for filename in filenames:
        src_file = os.path.join(dirpath, filename)

        # Replace the beginning of the source file path
        # with the source_dir to create the final_source
        final_source = source_dir + src_file.replace(reference_dir, "")
        if os.path.exists(final_source):  # ensure file exists in source_dir
            dest_file = os.path.join(structure, filename)
            shutil.copy2(final_source, dest_file)  # copy2 preserves metadata
