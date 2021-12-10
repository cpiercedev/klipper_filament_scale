# klipper_filament_scale
Klipper Module and Macros to add filament scale capabilities with the HX711 load cell amplifier

BOM
- 1 - HX711 Amplifier board and Bar load cell, these usually come as a pack (I'm using a 10kg but will testing with a 5kg soon) https://www.aliexpress.com/item/33046037411.html?spm=a2g0o.cart.0.0.de2e3c00XCiZCg&mp=1

- 2 - M4x?

- 2 - M5x?





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



