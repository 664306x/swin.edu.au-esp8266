##A Secrity Intrustion Detection System for ESP8266.

Luke Jackson, 664306x  
Swinburne University.

###Aim  
To prototype and demonstrate the ESP8266 working as a motion detector server for home security (or just motion detection in some local).  
To example various abilities of the ESP8266 chip running NodeMCU.

###Features
- Use of a digital sensor.
- Use of the PWM functions.  
- Use of MQTT protocol.  

###Example Usage Scenario
- The system is installed in the home. If motion is detected a message is recieved on the home owners computer, notifing them there is moving in their home.
- The system presented is installed in the mailbox. When the mail arrives, a message is recived on the owners computer, notifying of the mail arrival.
- Someone wants to learn how to use MQTT (or other concepts covered) by example, so they follow the guide for this project on the WIKI.

###Open Issues and Bugs
- Unable to achieve functionality from a single power source.
- Wiki should be re-written, using proper single power source.
- Should be packaged into an application and init.lua.

###Code
- See the .lua files part1.lua and part2.lua.




