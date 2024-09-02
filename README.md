# This branch is for porting Klipper TMC Autotune to support the ELEGOO base image for the Neptune 4 series printers.
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
### Enum error
run:
```bash
source ~/klippy-env/bin/activate
pip install enum
deactivate
```
### Signature error

run:
```bash
source ~/klippy-env/bin/activate
pip install funcsigs
deactivate
```
## 3) Modifying the autotune.py to use the new packages
  ### Change this line:
https://github.com/andrewmcgr/klipper_tmc_autotune/blob/main/| autotune_tmc.py#L3
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
## 4) getting the tmc*.py files

 ### Log into the FLUIDD ui and navigate to the Configuration Screen
  -  Click the + button in the configuration Files section
  -  Upload a file
  -  select the Neptune4Stock_tmc.cfg file to upload
  -  Open your printer.cfg
  -  at the top of the file, add
  -      [include Neptune4Stock_tmc.cfg]
  -  Save your printer.cfg (no need to restart, the machine will restart after the next step)
    

  ### ssh into your printer using your favorite tool.  (terminal is enough here)
  run: 
  ```bash
    wget -O /home/mks/klipper_tmc_autotune/Neptune4Base.sh https://raw.githubusercontent.com/cwiegert/klipper_tmc_autotune/main/Neptune4Base.sh
    cd /home/mks/klipper_tmc_autotune
    bash Neptune4Base.sh
  ```
     
Log back into Fluidd, and modify the Neptune4Stock_tmc.cfg to set your tuning parameters.   Follow the Autotune instructions listed below.

