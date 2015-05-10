-- Blink an LED light attached to GPIO0 on and off repeatedly
gpio.mode(3, gpio.OUTPUT, gpio.PULLUP)

function blinky()
    if(gpio.read(3) == 1) then
        gpio.write(3, gpio.LOW)
    else
        gpio.write(3, gpio.HIGH)
    end
end
    

tmr.alarm(0, 250, 1, blinky)

