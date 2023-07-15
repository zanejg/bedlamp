from rotary_irq_esp import RotaryIRQ
import time
from machine import Pin
import rotary




CLOCK = 11
DATA = 10
BUTTON = 9

clock_pin = Pin(CLOCK,Pin.IN)
data_pin = Pin(DATA,Pin.IN)
btn = Pin(BUTTON,Pin.IN, Pin.PULL_UP)


def rotary_listener():
                
    print("value={}".format(rotary.value()))
    
        




def rt():

    print("setting up rotary")
    import pdb; pdb.set_trace()
    
    r = RotaryIRQ(pin_num_clk=CLOCK, 
                pin_num_dt=DATA, 
                min_val=0, 
                max_val=25, 
                reverse=False, 
                range_mode=RotaryIRQ.RANGE_WRAP)

    print("assigning button")
    

    print("adding rotary listener")
    rotary.add_listener(rotary_listener)

              
    val_old = r.value()

    print("Loop")
    while(True):
        print("button={}".format(btn.value()))
        time.sleep_ms(50)

    # while btn.value() == 1:
    #     val_new = r.value()
        
    #     if val_old != val_new:
    #         val_old = val_new
    #         print('result =', val_new)
            
    #     time.sleep_ms(50)
        
    
    
    
    