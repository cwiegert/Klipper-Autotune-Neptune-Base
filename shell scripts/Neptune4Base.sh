#!/bin/bash
# Neptune4Base.sh
#   09/02/2024
#       custom bash script to install the necessary TMC files for Autotune to run
#


# Set the countdown time in seconds
COUNTDOWN_TIME=10

# Function to display the countdown
countdown() {
    local time_left=$1
    while [ $time_left -gt 0 ]; do
        echo -ne "Restarting Klipper in $time_left seconds...\r"
        sleep 1
        ((time_left--))
    done
    echo "Restarting now!"
}
# Define the destination directory
DEST_DIR="/home/mks/klipper_tmc_autotune"

# Create the directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Download the files
curl -o "$DEST_DIR/TMC_filesInstall.sh" "https://raw.githubusercontent.com/cwiegert/klipper_tmc_autotune/main/shell%20scripts/TMC_filesInstall.sh"
curl -o "$DEST_DIR/RenameTMCfiles.sh" "https://raw.githubusercontent.com/cwiegert/klipper_tmc_autotune/main/shell%20scripts/RenameTMCfiles.sh"

# Make the scripts executable
chmod +x "$DEST_DIR/TMC_filesInstall.sh"
chmod +x "$DEST_DIR/RenameTMCfiles.sh"

echo "Files have been downloaded and made executable in $DEST_DIR"
echo "Backing up the base ELEGOO stepper files"
cd $DEST_DIR
./RenameTMCfiles.sh
echo "Installing new TMC stepper files....."
# This file pulls the tmc*.py files from the Klipper GitRepo
./TMC_filesInstall.sh

# Run the countdown
countdown $COUNTDOWN_TIME

# Restarting Klipper for the changes to take affect
sudo systemctl restart klipper



