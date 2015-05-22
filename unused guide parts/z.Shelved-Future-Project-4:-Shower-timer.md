# Project Description

The most common place for falls in the home is in the bathroom. In order to embrace internet of things with the goal of increasing safety in the home and giving greater independence to the elderly or people with disabilities, the bathroom is probably the best place to start.

When the shower is used, the body is exposed to hot temperatures typically in the range of 30 to 40 degrees Celsius. Whilst young or otherwise healthy people can tolerate this almost indefinably, such exposure is straining on the elderly. Compacted with the fact that most dementia suffers are elderly, this can be a dangerous risk for them. It has been observed that dementia suffers may forget how long they have been in the shower, and thus unintentional over expose themselves.

This project aims to build a sensor that can determine presence in a shower stall, and determine whether the shower is running. After a defined time limit, a beep will issue (for proof of concept) giving indication of time spent. After a subsequent defined time limit, a message will be logged on an external server so that medical staff can be aware that there patient has been exposed and how frequently.

# Outcomes

By completing this project, you should gain knowledge about using the ESP8266 in,
- The use of, and writing a state machine.
- Using a framework code to save time when writing an ESP8266 application.
- Interacting with digital sensors in the interrupt and output modes.
- Use of the NodeMCU timer functions.
- Using the MQTT protocol.
- Using the ADC.
- Using the Pulse width functions.

# On State Machines

_if you are already familiar with the concept of a state machine, feel free to skip this section_

(simplified from Wikipedia) A Finite State Machine is an abstract machine that can be in one of a finite number of states, in only one state at a time. 
- The state it is in at any given time is called the **current state**. 
- It can change from one state to another via a **transition**. Transitions are defined by the designer. 
- A particular FSM is defined by a list of its states, and the triggering condition for each transition.

Using a state machine helps in designing our ESP8266 projects that use 1 to many sensors, as we can more easily keep track of all the different situations the setup might find itself in.

_shower timer project state machine image goes here_ (todo)

# Framework

In order to save time when coding applications on the NodeMCU framework, Andy Gelme has developed a framework which this project has used. We encourage reuse of this framework in other applications. Andy's github can be found at,
- https://github.com/geekscape/

## Init.lua
NodeMCU will look for this file and run it on boot. This file cannot be compiled. Essentially you will use this file to reference your code and call a "start" function in your application. 
```lua
app = require("shower_simple")
config = require("config")
require("setup").start()
```
_Shower projects init.lua file_

The setup.lua section will explain why our application is called indirectly through setup when using this framework.

## Config.lua
```lua
local module = {}

module.SSID = {}
module.SSID["name5ghz"] = "password"
module.SSID["name2.4ghz"] = "password"

module.HOST = "10.1.1.1"
module.PORT = 4000

return module
```  
_Shower projects config.lua file_

The config.lua file separates out these variables that we are likely to be changing frequently. Here you can crate a SSID and password list, and specify any other config variables you might need such as port. The application will try to connect to each SSID from the top down, stopping after the first success.

## Setup.lua
```lua
local module = {}

local function wifi_wait_ip()
  if wifi.sta.getip() then
    tmr.stop(1)
--  print("wifi ready: " .. wifi.sta.getip())
    app.start()
  end
end

local function wifi_start(aps)
  for key,value in pairs(aps) do
    if config.SSID and config.SSID[key] then
--    print("wifi AP: " .. key .. ": " .. value)
      wifi.sta.config(key, config.SSID[key])
      wifi.sta.connect()
      config.SSID = nil  -- more secure and save memory
      tmr.alarm(1, 2500, 1, wifi_wait_ip)
    end
  end
end

function module.start()
  wifi.setmode(wifi.STATION);
  wifi.sta.getap(wifi_start)
end

return module
```
_Shower projects setup.lua file_

setup.lau handles the non application specific tasks of setting the wifi mode and connecting to a wifi and/or opening up to incoming connections. A connection is established by calling the nodeMCU function 'wifi.sta.getap', then passing the list of access points to the 'wifi_start' function until something from the config file matches. After connection is established we call the start method of our application in the 'wifi_wait_ip()' function.

## Using the Framework
1. Upload the files to the ESP8266 via serial and Esplorer.
Do this in esplorer;
    1. Select file -> open from disk
    2. Select the init.lua file
    3. Click "Save to ESP" button.
    4. Keep the tab open for later use.
    5. Repeat steps 1 to 4 for config.lua, setup.lua and shower_simple.lua.
2. Compile config.lua, setup.lua and shower_simple.lua (your application) to the ESP via serial and Esplorer. 
Do this in esplorer; 
    1. Open the tab for config.lua
    2. Click the "Save&Compile" button.
    3. Repeat steps 1 and 2 for setup.lua and shower_simple.lua.
    4. You may now close the scripts tabs if you want.
3. Run the code below by pasting it into a new tab and clicking "send to ESP".
```lua
file.remove("shower_simple.lua")
file.remove("config.lua")
file.remove("setup.lua")
```
4. When the ESP8266 is powered or reset, the init.lua will run and subsequently join the access point and boot shower_simple by running its start() function.

# Circuitry and Assembling the Shower Project 

## Required Components
The shower project makes use of the following electronic components;
- ESP8266_012 full evaluation board. The project is compatible with any version of the ESP8266 that gives at access to at least 4 GPIO pins. **This means the project is not compatible with the ESP8266_01.**
- Breadboard (refer to section 3: equipment, for a description of what one is and how to use it)
- x7 female to male DuPont cables.
- x4 male to male DuPont cable.
- x4 female to female DuPont cables.
- x3 AA batteries.
- Microphone sensor module
    - Simply put, when the microphone hears sound levels over a threshold, the out pin goes high.
    - http://tronixlabs.com/breakout-boards/microphone/microphone-sensor-module/
- Passive infra red motion detector
    - Simply put, when motion occurs inside the sensors field of vision, the out pin goes high.
    - Refer to the image below for the guidance.
    - ![](https://github.com/664306x/swin.edu.au-esp8266/blob/master/guide_pictures/shower/ir%20sensor%20information.png)
    - The use of the jumper and pots will be explained in the configuration section further in this guide.
    - http://tronixlabs.com/sensors/motion/adjustable-pir-passive-infra-red-motion-detector-module-hcsr501/
- A button
    - http://tronixlabs.com/components/buttons/mini-push-button-tactile-switch-20-pack/
- A small speaker (such as found inside old computers...)

## Assembly
_refer to the cabling table and images for further assistance assistance._

_If using a different breadboard, follow the colour coding on the cabling table to create the channels, and ignore the references (eg. 'J30')_

_Key_
- FTDI serial - USB board: FTDI.
- PIR motion sensor: PIR.
- ESP8266_12 Full evaluation Board: ESP8266.

**Cabling Guide table**  
![](https://github.com/664306x/swin.edu.au-esp8266/blob/master/guide_pictures/shower/cableing%20guide%20table.png)

1. Connect a male to female cable from the FTDI RXD to the ESP8266 RXD.
2. Connect a male to female cable from the FTDI TXD to the ESP8266 TXD.
3. Connect a male to male cable from the FTDI VCC to breadboard J30.
4. Connect a male to male cable from the FTDI GRD to breadboard E30.
![](https://github.com/664306x/swin.edu.au-esp8266/blob/master/guide_pictures/shower/IR%20sensor%20closeup.jpg)
5. Connect a female to male cable, the PIR + to breadboard I30.
6. Connect a female to male cable, the PIR GRD to breadboard D30.
7. Connect a female to female cable from PIR out to ESP8266 ADC.
8. Connect a female to male from Microphone sensor + to breadboard H30.
9. Connect a female to male from microphone sensor GRD to breadboard A30.
10. Connect a female to female from microphone DO to ESP8266 GPIO13.
11. Connect male to female cable from speaker + to ESP8266 GPIO12.
12. Connect male to male cable from speaker - to breadboard C28.
13. Connect a male to male cable from breadboard B28 to breadboard B30. (We are doing this to make more ground channels available).
14. Connect a female to female cable from any corner of the switch to ESP8266 VCC.
15. Connect a female to female cable from the adjacent corner of the switch as used in step 14, to to ESP8266 GPIO14.
16. Insert 3x AA batteries into the ESP8266 battery pack.
17. Set the jumper on the FTDI to the 5v position. This is necessary as both the microphone sensor and PIR require 5v and thus cannot be powered by the ESP8266 directly.
18. Connect the FTDI to the PC via micro USB cable.

**Complete circuit**  
![](https://github.com/664306x/swin.edu.au-esp8266/blob/master/guide_pictures/shower/shower%20circet.JPG)


