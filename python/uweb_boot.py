# Complete project details at https://RandomNerdTutorials.com

try:
    import usocket as socket
except:
    import socket

from machine import Pin
import network
import time
import sys
# import uos

import gc

import secret_settings

gc.collect()

ssid = secret_settings.ssid
password = secret_settings.password

station = network.WLAN(network.STA_IF)

station.active(True)
station.connect(ssid, password)

while station.isconnected() == False:
    pass

print('Lamp Connection successful')
print(station.ifconfig())


