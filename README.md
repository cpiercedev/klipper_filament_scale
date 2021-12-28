# klipper_filament_scale
Klipper Module and Macros to add filament scale capabilities with the HX711 load cell amplifier. This is still a very young project and only has basic functionality.

BOM
- 1 - HX711 Amplifier board and Bar load cell, these usually come as a pack. There are two different sizes that I have found, one that has 2x M5 and one with 2xM4. The latter is 5mm shorter. Both sizes are supported. I have purchased these, but am looking into other options as well. https://www.aliexpress.com/item/33046037411.html?spm=a2g0o.cart.0.0.de2e3c00XCiZCg&mp=1

- 2/4 - M4x16

- 2/0 - M5x16

- 3 new printed parts for the Carrot Patch (Shown below printed in RED)

![ERCP with Load Cell](./Pictures/IMG_4161.jpeg?raw=true)

There is an mount included that is the same style as the stock filament spool holder, this has not been tested yet.
<img width="795" alt="Screen Shot 2021-12-14 at 12 39 47 PM" src="https://user-images.githubusercontent.com/43823548/146075963-dd6e07e4-6aac-42f6-99af-28f86942d6fa.png">

---

- You will need to have 2 GPIO pins available for each pair of filament scales.

- Twisted wires are **required**.

--- 

## Installation
Install RPi.GPIO on the Python virtual Klippy environment

```
cd ~

source klippy-env/bin/activate

pip3 install RPi.GPIO==0.7.1a4

deactivate

git clone https://github.com/cpiercedev/klipper_filament_scale.git

~/klipper_filament_scale/install.sh

```
## Moonraker Updater
Add the following to moonraker.conf
```
[update_manager client klipper_filament_scale]
type: git_repo
path: /home/pi/klipper_filament_scale
origin: https://github.com/cpiercedev/klipper_filament_scale.git
install_script: install.sh
```

## Set the HX711 pins in your filament_scale_hardware.cfg

The pins correspond to the pins used on your pi

channel: can be set to A or B depending on which channel the load cell is hooked to on the HX711. This defaults to channel A.
## Calibrating the scale

- With nothing on the scale, use the `TARE_SCALE SCALE=*X* macro`
- Now place an item with a known weight on the scale, and run `CALIB_SCALE_REF SCALE=*X* KNOWN_VALUE=*X*`
- Copy the command from the output and run it, it should look like `CALIB_SCALE_OFFSET SCALE=*X* REF=*X*`

- Use Get_Weight SCALE=x to get the current weight on the scale.
# That's it, you are all set!


## Adding weight checks to print_start macro (Works with both single and MM prints)


- Add the script /PostProcessor/gcode-addWeight.py to your Post-Processing Scripts.This will add the weight to your PRINT_START variables. 
- Add the following to your PRINT_START macro
```    
{% set WEIGHT = params.WEIGHTS|default(0)|int %}
VERIFY_WEIGHT SCALE=0 PRINT_WEIGHT={WEIGHT}
 ```

<img width="1138" alt="Screen Shot 2021-12-13 at 10 27 51 AM" src="https://user-images.githubusercontent.com/43823548/145867826-4c6c122d-b21a-4309-93a6-996b3a1bf893.png">


Utilizes the HX711 library created by tatobari https://github.com/tatobari/hx711py
