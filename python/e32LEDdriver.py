#!/usr/bin/python
import sys
import time

import LED_control as LC
import random

channels = [
{
      "RED" : 5,
    "GREEN" : 18,
     "BLUE" : 19,
},
{
      "RED" : 21,
    "GREEN" : 22,
     "BLUE" : 23,
},
{
      "RED" : 33,
    "GREEN" : 25,
     "BLUE" : 26,
},
{
      "RED" : 27,
    "GREEN" : 14,
     "BLUE" : 12,
},
]


fld = LC.four_LED_driver(channels)
fld.all_same_RGB("808080")

def check_hex(the_hex):
    """
    Check that the given string is a six digit hex number
    """
    if len(the_hex) != 6:
        return False
    
    try:
        hh = int(the_hex,16)
    except ValueError:
        return False
    
    return True


def dimwhite(col):
    for i in range(0,4):
        fld.all_same_RGB('888888')
  

def all_high():
    fld.all_same_RGB("FFFFFF")


single_commands = {
    "ALLHIGH": all_high,
        "OFF": fld.all_off,
}


# the number of steps defined in the web i/f
MAXINT = 65


def parse_command(the_command_data):
    """
    Given the command from the web-page jscript,
    turn it into an action on the LED array
    """

    command = the_command_data['command']

    if command in single_commands.keys():
        single_commands[command]()
        return
    elif command == 'SETBRIGHTNESS':
        if 'value' in the_command_data.keys():
            # the value from the web page is 0-MAXINT
            the_val = int(the_command_data['value'])
            # this_duty = the_val/float(MAXINT)
            # the_duties={
            #     "RED":this_duty,
            #     "GREEN":this_duty,
            #     "BLUE":this_duty,
            # }
            if the_val == 0:
                fld.all_off()
                return
            else:
                fld.set_all_on_seq(the_val)
                
    elif command == 'SETALLCOLOUR':
        if 'value' in the_command_data.keys():
            the_value = the_command_data['value']
            if the_value.startswith("#"):
                the_value = the_value.strip("#")
            print("parsed value={}".format(the_value))
            fld.all_same_RGB(the_value)
    elif command == "GETLEVEL":
        pass



    else:
        print("Command not found: {}".format(command))



                