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




## Adding weight checks to print_start macro (Works with both single and MM prints)


- Add the script /PostProcessor/gcode-addWeight.py to your Post-Processing Scripts.This will add the weight to your PRINT_START variables. 
- Add the following to your PRINT_START macro
```    
{% set WEIGHT = params.WEIGHTS|default(0)|int %}
VERIFY_WEIGHT SCALE=0 PRINT_WEIGHT={WEIGHT}
 ```

<img width="1138" alt="Screen Shot 2021-12-13 at 10 27 51 AM" src="https://user-images.githubusercontent.com/43823548/145867826-4c6c122d-b21a-4309-93a6-996b3a1bf893.png">


