#!/bin/bash
#       09/01/2024
#       AutoTune extension for the base ELEGOO klipper image on Neptune4 base printers
#       This file will install the latest stepper driver files necessary to bring a Python2 environment up to Autotune Python3 environment
#       Run this file AFTER running RenameTMCfiles.sh, as that file will back up the base Elegoo filenames
#       This is an ADVANCED MOD and is not officially supported by ELEGOO 


# Define the target directory
TARGET_DIR="/home/mks/klipper/klippy/extras"
echo "The directory for the new files is $TARGET_DIR"
# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Define the GitHub base URL for the repository
REPO_URL="https://raw.githubusercontent.com/Klipper3d/klipper/master/klippy/extras"

# List of files to download (tmc*.py files)
FILES=("tmc2208.py" "tmc2209.py" "tmc2660.py" "tmc2130.py" "tmc5160.py" "tmc.py" "tmc2240.py" "tmc_uart.py")

# Download each file
for FILE in "${FILES[@]}"; do
    echo "Downloading $FILE to $TARGET_DIR..."
    curl -L "$REPO_URL/$FILE" -o "$TARGET_DIR/$FILE"
done

echo "Download complete."
echo "Ready to Restart Klipper"

