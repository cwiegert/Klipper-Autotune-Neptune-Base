# Enabling Klipper TMC Autotune on the ELEGOO base Klipper image for the Neptune 4 series printers.
Because the base image is on python2, there are several install steps necessary to allow autotune to run.   This repository leverages everything in the Klipper Autotune and has the additional instructions/content and stepper motor settings for the out of the box Neptune 4 printers.

**As a note:**   Autotune does not tune and forget like many of the other Klipper tuning.   Aututune is a runtime algorythm that instructs the stepper drivers how to execute the instructions they are given.   That means, there is no stored calibration or tuning, it's simply on and active during print, or it's off.

The configuration file loaded through the Fluidd interface is an extension of the motors_database.cfg listed below, contaning the custom motor configuration for the Neptune 4, Neptune 4+, Neptune 4Pro and Neptune 4Max stepper motors. Be sure to use the correct motor/autoTune combination when you configure this file for your specific printer.

The install will involve 3 main steps
  1)  Install the base Klipper_TMC_Autotue files, stopping once you finish the install.   Do not complete the _**Adjusting the current configuration**_ section.  The below instructions will replace that section of the setup
  2)  Modifying the autotune.py code to use the python2 packages (or we can push the edited file from this repo)
  3)  installing the python2 backport modules and the tmc*.py files which are compatible with the Autotune.py code

## 1) Run this single command instead of installing from the TMC_Autotune git repo.   This wget command replaces the install file
  ## Modified 1/10/2026, run this install command and install file instead of the adnrewmcgr install script
  ```
    wget -O ~/install-Elegoo-Firmware.sh https://raw.githubusercontent.com/cwiegert/Klipper-Autotune-Neptune-Base/main/shell%20scripts/install-Elegoo-Firmware.sh && bash ~/install-Elegoo-Firmware.sh
  ```  
  ### Documentation for all the base functionality can be found here
https://github.com/andrewmcgr/klipper_tmc_autotune
    
## 2) Modifying the autotune.py to use the new packages
  ### Change this line:
Once you have installed the klipper_tmc_autotune, you will need to modify the source code on your machine and make use of the modules from the previous step.   Unsing putty or Cyberduck ssh into your machine and navigate to the /home/mks/klipper_tmc_autotune directory.   Use the appropriate tool like nano, vi or vim to edit  
          **autotune_tmc.py**
The first lines in the file, modify as follows:
```python
import math, logging, os
from enum import Enum
from inspect import signature
from . import tmc
```
to
```python
import math, logging, os
from enum import Enum
#from inspect import signature
from funcsigs import signature
from . import tmc
```
## 3) Installing the python2 backport modules and putting all the config and stepper motor run time files in place
  download [Stepper Motor config](https://github.com/cwiegert/Klipper-Autotune-Neptune-Base/blob/main/Config%20files/Neptune4Stock_tmc.cfg) to your computer, you will use Fluidd to upload to your configurations directory on the machine.

 ### Log into the FLUIDD ui and navigate to the Configuration Screen
  -  Click the + button in the configuration Files section followed by **Upload a file**
  -  select the Neptune4Stock_tmc.cfg file to upload
  -  Open your printer.cfg
  -  at the top of the file, add
  -      [include Neptune4Stock_tmc.cfg]
  -  Save your printer.cfg (no need to restart, the machine will restart after the next step)
    

  ### ssh into your printer using your favorite tool.  (terminal is enough here)
  run: 
  ```bash
    wget -O /home/mks/klipper_tmc_autotune/Neptune4Base.sh https://raw.githubusercontent.com/cwiegert/Klipper-Autotune-Neptune-Base/main/shell%20scripts/Neptune4Base.sh

    cd /home/mks/klipper_tmc_autotune
    bash Neptune4Base.sh
  ```
     
Log back into Fluidd, and modify the Neptune4Stock_tmc.cfg to set your tuning parameters.   The documentation for the tuning parameters are in the [Readme.md](https://github.com/andrewmcgr/klipper_tmc_autotune/blob/main/README.md#autotune-configuration) in the Klipper AutoTune repository referenced above.


##  UNINSTALLING 
If you simiply do  not want autotune to run during your print, open your printer.cfg and remove or comment the 
 -     [include Neptune4Stock_tmc.cfg]

if you want to revert back to the base Elegoo stepper drivers, run the Undo_TMCRename.sh from the install directory

ssh into your printer and execute the following commands
```bash
    cd /home/mks/klipper_tmc_autotune
    bash Undo_TMCRename.sh
```
