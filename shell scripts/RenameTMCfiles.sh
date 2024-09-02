#       RenameTMC.sh 
#       09/01/2024 
#       part of the Autotune install for a base Neptuen 4 Elegoo printer image
#       this is the first part of installing updated driver files for the portability of Autotune (python3) to the base Elegoo image (python2)
#       use at your own risk, this is an ADVANCED MOD, and is not officially supported by ELEGOO

#!/bin/bash


# This file will rename the existing TMS stepper driver files to a backup.    The renamed files will have a *_bkp.py desigantion
#  The renaming of the files will allow a backout procedure if necesary.
#  By first renamaing the files, the base ELEGOO image will not be overwitten when the updated TMC driver files are installed.


# Define the directory containing the files
DIR="/home/mks/klipper/klippy/extras"

# Loop over all tmc*.py files in the directory
for FILE in "$DIR"/tmc*.py; do
echo "renaming file --> $FILE and backing it up "
    # Check if the file exists (this handles the case where no files match the pattern)
    if [ -e "$FILE" ]; then
        # Rename the file by appending '.py.bkp' to the base name
        mv "$FILE" "${FILE%.py}.py.bkp"
        echo "Renamed $FILE to ${FILE%.py}.py.bkp"
    else
        echo "No files found matching tmc*.py"
    fi
done
