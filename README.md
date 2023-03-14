# Elfos-SPI-OLED-Drivers
Elf/OS drivers for an 1802/Mini system with the 1802/Mini SPI adapter board connected to an OLED display on port 0.

Introduction
------------
This repository contains 1802 Assembler code for OLED display programs that use a common display driver API and a graphics library.  The appropriate OLED driver program, such as the sh1106 driver program, should loaded before running the display programs.  

The OLED display drivers are based on code from Adafruit's [Adafruit_GFX-Library](https://github.com/adafruit/Adafruit-GFX-Library) written by Ladyada Limor Fried. The sh1106 OLED display driver is also based on code from the [Fast SH1106 Library](https://forum.arduino.cc/t/a-fast-sh1106-library-128x64-oled/236309) written by Arthur Liberman. 

The graphics demo programs also use a common graphics library gfx_oled.lib.  The source code for the Elf/OS OLED graphics library is available on GitHub in the [Elfos-Gfx-OLED-Library](https://github.com/fourstix/Elfos-Gfx-OLED-Library).

Platform  
--------
The programs were written to run displays from an [1802-Mini](https://github.com/dmadole/1802-Mini) by David Madole running with the [1802/Mini SPI adapter board](https://github.com/arhefner/1802-Mini-SPI-DMA) by Tony Hefner. These programs were assembled and linked with updated versions of the Asm-02 assembler and Link-02 linker by Mike Riley. The updated versions required to assemble and link this code are available at [arhefner/Asm-02](https://github.com/arhefner/Asm-02) and [arhefner/Link-02](https://github.com/arhefner/Link-02).

SPI Card Pinout
---------------
The following pinout is used to connect the Elf/OS SPI Adapter board to the OLED displays.

<table>
<tr><th>SPI Pin</th><th>Function</th><th>Wire Color</th><th>Notes</th></tr>
<tr ><td colspan="4"><img src="https://github.com/fourstix/Elfos-SPI-OLED-Drivers/blob/b_update/docs/spi/1802-Mini-SPI-Connector.jpg"></td></tr>
<tr><td>1</td><td rowspan="2">VCC</td><td rowspan="2">Red</td><td rowspan="2">+5V</td></tr>
<tr><td>2</td></tr>
<tr><td>3</td><td>MISO</td><td>Orange</td><td>(Not Used)</td></tr>
<tr><td>4</td><td>MOSI</td><td>Yellow</td><td>Data Out</td></tr>
<tr><td>5</td><td>CS</td><td>Green</td><td>Chip Select</td></tr>
<tr><td>6</td><td>SCK</td><td>Blue</td><td>Serial Clock</td></tr>
<tr><td>7</td><td>DC</td><td>Violet</td><td>Data/Command</td></tr>
<tr><td>8</td><td>RES</td><td>Grey</td><td>Reset</td></tr>
<tr><td>9</td><td rowspan="2">GND</td><td rowspan="2">Black</td><td rowspan="2">Ground</td></tr>
<tr><td>10</td></tr>
</table>

Supported Displays
------------------
* SH1106 OLED display
* *TBD: ssd1306 display*

Display Library API
---------------------

All the API are invoked by calling the video routine at O_VIDEO with the appropriate API ID in D. 
The Kernel Video vector O_VIDEO and the API ID's are defined in the oled.inc include file.

## Public API ID

* V_OLED_TYPE - get the OLED type string.
* V_OLED_INIT - initialize the OLED display 
* V_OLED_CLEAR - clear the OLED dispay
* V_OLED_SHOW  - show the contents of a memory buffer on the display

<table>
<tr><th>API ID</th><th>Description</th><th colspan="2">Notes</th></tr>
<tr><td>V_OLED_TYPE</td><td>Get the OLED type string</td><td colspan="2">Returns rf - Pointer to null terminated type string</td></tr>
<tr><td>V_OLED_INIT</td><td>Initialize the display</td><td colspan="2">(None)</td></tr>
<tr><td>V_OLED_CLEAR</td><td>Clear the display</td><td colspan="2">(None)</td></tr>
<tr><td>V_OLED_SHOWd</td><td>Update the display</td><td colspan="2">Input: rf - Pointer to 1K byte display buffer</td></tr>
</table>

OLED Demo Programs
------------------

The appropriate OLED display driver should be loaded before running these programs. 

## clear
**Usage:** clear    
Clear the display.

## splash
**Usage:** splash   
Show the Adafruit splash screen on the display.

## spaceship
**Usage:** spaceship   
Show the classic Elf spaceship program graphic on the display.

## show
**Usage:** show *filename*   
 Display a bitmap from a file named *filename* on the display. The file should be exactly 1024 bytes and in the native OLED format. A couple of example images are in the test/images folder. 
 
OLED Graphics Demos
-------------------
 
## pixels
**Usage:** pixels    
Draws a simple pixel pattern on the display.
 
## linetest
**Usage:** linetest   
Draws various lines on the display.
 
## lines
**Usage:** lines   
Draws a simple line pattern on the display.
  
## reversed
**Usage:** reversed  
Draws a line pattern reversed (black on white) on the display.
     
## boxes
**Usage:** boxes  
Draws rectangles in a pattern on the display.

## blocks
**Usage:** blocks  
Draws filled rectangles in a pattern on the display.

## bitmaps
**Usage:** bitmaps  
Draws Adafruit bitmaps on the display.

## snowflakes
**Usage:** snowflakes  
Draws falling snowflake bitmaps on the display.

## charset
**Usage:** charset  
Draws the printable ASCII character set on the display.

## helloworld
**Usage:** helloworld  
Draws the classic text greeting on the display.

## textbg
**Usage:** textbg  
Draws text strings on the display, using the transparent and opaque background options.

Repository Contents
-------------------
* **/src/demos/**  -- Source files for demo programs for OLED drivers
  * clear.asm - Clear the display screen
  * splash.asm - Show the Adafruit splash screen on the display.
  * show.asm - Read an show a bitmap graphics image file on the display. 
  * pixiecvt.asm - Conversion routines used to read and display a graphics image.
  * bitmaps.asm - Demo program to draw Adafruit flower bitmaps on the display screen.
  * blocks.asm - Demo program to draw filled rectangles on the display screen. 
  * boxes.asm - Demo program to draw rectangles on the display screen.
  * lines.asm - Demo program to draw lines in a pattern on the display screen.
  * linetest.asm - Demo program to draw various lines on the display screen. 
  * pixels.asm - Demo program to draw a simple pattern with pixels on the display screen.
  * reversed.asm - Demo program to draw lines in a reversed pattern (black on white) on the display screen.
  * snowflakes.asm - Demo program to draw falling snowflake bitmaps on the display screen.
  * charset.asm - Demo program to draw the printable ASCII character set on the display screen.
  * helloworld.asm - Demo program to draw the classic greeting on the display screen.
  * textbg.asm - Demo program to draw text with transparent and opaque background options on the display screen.
  * direct.asm - Demo program to directly write pattern bytes to the display.
  * build.bat - Windows batch file to assemble and link the sh1106 programs. Replace [Your_Path] with the correct path information for your system.
  * clean.bat - Windows batch file to delete assembled binaries and their associated files.
* **/src/include/**  -- Include files for the SH1106 display programs and the libraries.  
  * sysconfig.inc - System configuration definitions for programs.
  * sh1106.inc - SH1106 display value constants.
  * oled.inc - External definitions for OLED display driver API.
  * gfx_lib.inc - External definitions for the Graphics OLED Library gfx_oled.lib.
  * ops.inc - Opcode definitions for Asm/02.
  * bios.inc - Bios definitions from Elf/OS
  * kernel.inc - Kernel definitions from Elf/OS
* **/src/lib/**  -- Library files for the SH1106 display programs and OLED graphics demos.
  * gfx_oled.lib - Elf/OS Graphics OLED library. The source files for library functions are in the [Elfos-Gfx-OLED-Library](https://github.com/fourstix/Elfos-Gfx-OLED-Library) repository.
* **/src/sh1106/**  -- Source files for the SH1106 OLED display driver.
  * sh11106.asm - Assembly source file for the SH1106 OLED display driver.
  * build.bat - Windows batch file to assemble and create the sh1106_oled graphics library. Replace [Your_Path] with the correct path information for your system. 
  * clean.bat - Windows batch file to delete the sh1106_oled library and its associated files.    
* **/bin/demo/**  -- Binary files for OLED display driver demo programs.
* **/bin/sh1106/**  -- Binary file for SH1106 OLED display driver.
* **/lbr/**  -- Elf/OS library file with OLED driver demo programs.
  * oled_demo.lbr - Extract the program files with the Elf/OS command *lbr e oled_demo*
* **/docs/**  -- Documentation for various displays
* **/docs/sh1106/**  - Documentation files for the SH1106 display.
  * 1.3inch-SH1106-OLED.pdf - 1.3" SH1106 OLED Users Guide.
  * sh1106_datasheet.pdf - SH1106 Display Datasheet
* **/test/images/** -- Test graphic image files for the show program.
  * imp.img - Test graphic file image of an imp.
  * hres.img - Test graphic file image of a spaceship.
  
License Information
-------------------

This code is public domain under the MIT License, but please buy me a beverage
if you use this and we meet someday (Beerware).

References to any products, programs or services do not imply
that they will be available in all countries in which their respective owner operates.

Adafruit, the Adafruit logo, and other Adafruit products and services are
trademarks of the Adafruit Industries, in the United States, other countries or both. 

Any company, product, or services names may be trademarks or services marks of others.

All libraries used in this code are copyright their respective authors.

This code is based on code written by Tony Hefner and assembled with the Asm/02 assembler and Link/02 linker written by Mike Riley.

Elf/OS  
Copyright (c) 2004-2023 by Mike Riley

Asm/02 1802 Assembler  
Copyright (c) 2004-2023 by Mike Riley

Link/02 1802 Linker  
Copyright (c) 2004-2023 by Mike Riley

The Adafruit_SH1106 Library  
Copyright (c) 2012-2023 by Adafruit Industries   
Written by Limor Fried/Ladyada for Adafruit Industries. 

The Adafruit_GFX Library  
Copyright (c) 2012-2023 by Adafruit Industries   
Written by Limor Fried/Ladyada for Adafruit Industries. 

The Fast SH1106 Arduino Library  
Copyright (c) 2013 by Arthur Liberman (ALCPU) 

The 1802/Mini SPI Adapter Board   
Copyright (c) 2022-2023 by Tony Hefner

The 1802-Mini Microcomputer Hardware   
Copyright (c) 2020-2023 by David Madole

Many thanks to the original authors for making their designs and code available as open source.
 
This code, firmware, and software is released under the [MIT License](http://opensource.org/licenses/MIT).

The MIT License (MIT)

Copyright (c) 2023 by Gaston Williams

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

**THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.**
