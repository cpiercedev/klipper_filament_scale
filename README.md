# klipper_filament_scale
Klipper Module and Macros to add filament scale capabilities with the HX711 load cell amplifier. This is still a very young project and only has basic functionality.

BOM
- 1 - HX711 Amplifier board and Bar load cell, these usually come as a pack (I'm using a 10kg but will testing with a 5kg soon) https://www.aliexpress.com/item/33046037411.html?spm=a2g0o.cart.0.0.de2e3c00XCiZCg&mp=1

- 2 - M4x16

- 2 - M5x16

- There are 3 new printed parts, shown below printed in RED.
![ERCP with Load Cell](./Pictures/IMG_4161.jpeg?raw=true)



---

- You will need to have 2 GPIO pins available for each filament scale.

- Twisted wires are **required**.

--- 

## Installation
Install RPi.GPIO on the Python virtual Klippy environment

```
cd ~

source /klipper-env/bin/activate

pip3 install RPi.GPIO==0.7.1a4

deactivate

sudo git clone https://github.com/cpiercedev/klipper_filament_scale.git

./klipper_filament_scale/install.sh

```


## Calibrating the scale

- With nothing on the scale, use the TARE `SCALE=*X* macro`
- Now place an item with a known weight on the scale, and run `CALIB_SCALE_REF SCALE=*X* KNOWN_VALUE=*X*`
- Copy the command from the output and run it, it should look like `CALIB_SCALE_OFFSET SCALE=*X* REF=*X*`

# That's it, you are all set!


