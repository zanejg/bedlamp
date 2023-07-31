# zedlamp
Zane Gilmore 2023-07-31

## Overview
For building an array of big RGB LEDs. Basing code on code I wrote for another 
project that I called Magicball.

Have used an ESP32 to control 4 LEDs.
It is setup as a rudimentary web-server that serves a web-page based UI to 
make it possible to choose a colour and brightness setting, save it to one of 
four settings then recall the settings and light the lamp accordingly.

The first setting is the setting that lamp will start with.

Brightening or dimming a chosen RGB value is done with either the slider or one
of the 2 buttons. There are 64 possible values.
A lot of work has been done to ensure that the dimming sequence is apparently 
smooth, using a logarithmic sequence.


## Physical Build
I designed the structure of the lamp using OpenSCAD and it was 3d printed in clear 
PLA filament. And because my Ender3 printer only has a flat print area of 
220mm X 220mm, it was printed in 4 main sections each consisting of 2 sections.

There is the box section that houses the electronincs and what I labelled the 
"swirl" on top that provides the aesthetic shape. Each of the swirls are created to 
touch together to form a continuous snaking line.

The box sections are designed to interlock and be glued together. I used a clear 
2-pot adhesive. (clear Araldite)
The Swirls are attached with small self tapping screws.

At the front (or bottom) of the box sections inside the rounded section are two 
stanchions each with a screwhole and held at approximately 45 degrees to hold the 
aluminium piece onto which the LED modules are attached.

When the box sections are connected they form a larger long box enclosure into which 
the electronics are mounted. The enclosure is open but when the lamp is mounted on 
the wall this is not open to the air. There are a collection of ventilation holes 
provided as some heat is produced.

For mounting the PCBs, a collection of circular mounting stanchions were made where 
they were screwed to the PCBs and then glued to the enclosure base.

There are also a few blocks etc for cable management.

## Electronics
This consists of:
 - An ESP32 module (ESP32 WROOM 32d)
 - 6 dual H-bridge modules (L9110S L9110)
 - 2 5v 2amp AC-DC power supplies
 - A collection of low value 1 watt resistors
 - A boost convertor
 - 4 3 watt RGB LEDs mounted on "star base" PCBs
 - An in-line power switch for the mains cable.
 
 The high wattage resistors are for putting in series with the main LEDs as they need
 some current limiting at 5 volts. (7ohms < value < 10ohms) Each colour has a 
 different forward bias so needed slightly different values to achieve a reasonable 
 colour fidelity.

The power supplies I used sagged quite badly down below 4.5 volts with the LED power 
draw so wouldn't boot the ESP32. So I put in a boost convertor to tweak the voltage 
up to boot it up.

The inputs of the H-bridges are fed directly from the ESP32.

## Software
The whole project was done in Micropython. And makes use of the WIFI functionality and PWM outputs of the ESP32.

A very simple web-server was set up to serve an HTML and Javascript user-interface.
The Javascript just sends GET and POST requests back to the ESP32 and it controls 12 
PWM outputs. One for each of the 4 RGB LEDs.

There is a LED control object created for each of the 4 LEDs called 
"Direct_LED_driver" and another class called "four_LED_driver" which contains a list 
of 4 of these.

A lot of effort has been expended on getting the dimming sequence so that it looks 
nice and smooth with each click of the dimming or brightening button.
This has been set up with 64 levels.
A class called "dimming_sequencer" sets up the linear sequence that can used to 
create a dimming sequence for each RGB value. Although an RGB value also inherently 
contains brightness, the entire dimming sequence is calculated for a given RGB value 
and so the dimming value must also be applied when a setting is applied (or saved).
The dimming of this setup is independent of the colour.











