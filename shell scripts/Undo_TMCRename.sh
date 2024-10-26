#       Undo_TMCRename.sh 
#       10/25/2024 
#       part of the Autotune uninstall for a base Neptuen 4 Elegoo printer image
#       this is the first part of installing updated driver files for the portability of Autotune (python3) to the base Elegoo image (python2)
#       use at your own risk, this is an ADVANCED MOD, and is not officially supported by ELEGOO

#!/bin/bash


# This file will rename the the backup TMS stepper driver files to a active drivers.    The renamed files *_py.bkp desigantion
#  and set them active as .py files.  

# Define the directory containing the files
DIR="/home/mks/klipper/klippy/extras"

#deleting the current TMC*.py files so the backup's can be renamed
echo "renaming current TMC files to a TMC*.py.py3bkp"
for FILE in "$DIR"/tmc*.py; do
echo "renaming file --> $FILE back to $File.py.py3bkp "
    # Check if the file exists (this handles the case where no files match the pattern)
    if [ -e "$FILE" ]; then
        # Rename the file and adding a py3bkp designation
        mv "$FILE" "${FILE%.py.py3bkp}"
        echo "Renamed $FILE to ${FILE%.py.py3bkp}"
    else
        echo "No files found matching tmc*.py"
    fi
done


# Loop over all tmc*.py files in the directory
for FILE in "$DIR"/tmc*.py.bkp; do
echo "renaming file --> $FILE back to the active version "
    # Check if the file exists (this handles the case where no files match the pattern)
    if [ -e "$FILE" ]; then
        # Rename the file by removing the .bkp desitnation
        mv "$FILE" "${FILE%.py}"
        echo "Renamed $FILE to ${FILE%.py}"
    else
        echo "No files found matching tmc*.py.bkp"
    fi
done
