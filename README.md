# Enabling Klipper TMC Autotune on the ELEGOO base Klipper image for the Neptune 4 series printers.
Because the base image is on python2, there are several install steps necessary to allow autotune to run.   This repository leverages everything in the Klipper Autotune and has the additional instructions/content and stepper motor settings for the out of the box Neptune 4 printers.

The configuration file loaded through the Fluidd interface is an extension of the motors_database.cfg listed below, contaning the custom motor configuration for the Neptune 4, Neptune 4+, Neptune 4Pro and Neptune 4Max stepper motors. Be sure to use the correct motor/autoTune combination when you configure this file for your specific printer.

The install will involve 4 main steps
  1)  Install the base Klipper_TMC_Autotue 
  2)  Update the python2 backports for the packages enum and inspect
  3)  Modifying the autotune.py code to use the python2 packages (or we can push the edited file from this repo)
  4)  installing the tmc*.py files which are compatible with the Autotune.py code

## 1) Follow the instructions below starting at Klipper TMC Autotune
  https://github.com/andrewmcgr/klipper_tmc_autotune
## 2) Updating the python2 backports
  ssh into your machine.   username is mks   pwd: makerbase
  check to make sure pip is installed by typing
        pip --version
  if yes, then continue on.
  if no, install pip through the normal python2 instructions
  run:
  ```bash
  sudo apt install python-pip
  ```
    
### Fixing the Enum error by installing the python2 equivalent
run:
```bash
source ~/klippy-env/bin/activate
pip install enum
deactivate
```
### Fixing the Signature error by installing the python2 equivalent

run:
```bash
source ~/klippy-env/bin/activate
pip install funcsigs
deactivate
```
## 3) Modifying the autotune.py to use the new packages
  ### Change this line:
Once you have installed the klipper_tmc_autotune, you will need to modify the source code on your machine and make use of the modules from teh previous step.   Unsing putty, Cyberduck ssh into your machine and navigate to the /home/mks/klipper_tmc_autotune directory.   The modification will be made to 
          **autotune.py**
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
## 4) Putting all the config and stepper motor run time files in place
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
    wget -O /home/mks/klipper_tmc_autotune/Neptune4Base.sh wget https://raw.githubusercontent.com/cwiegert/Klipper-Autotune-Neptune-Base/main/shell%20scripts/Neptune4Base.sh

    cd /home/mks/klipper_tmc_autotune
    bash Neptune4Base.sh
  ```
     
Log back into Fluidd, and modify the Neptune4Stock_tmc.cfg to set your tuning parameters.   The documentation for the tuning parameters are in the Readme.md at the top of the AutoTune repository linked above.

