# ESP2866 chip project, "Internet of Things"  

Software Development project - SWE30008  
Supervisor: Rajesh Vasa     
Client:     James Hamlyn-Harris  

This is a capstone project which involves presenting guidance for using the esp8266 chip. The ESP8266 is a very cheap (< $5 USD) device which has full wi-fi functionality, hardware interfaces and SOC.  It is young and whilst the community is developing fast, it is still not as widely adopted as alternatives like rasbery pie. Is small size and price make it potentially ideal for 'Internet of Things' applications.

The current version of the guide is in the project wiki, while the repository itself contains a mixture of code snippits. Some these are part of the guide, and some are other example projets, or work in progress projects. The guide is closed for submissions until the conclusion of our project, after which we are hoping to release it on an open content license such as CC-A.

Feel free to message us if you have any queries or want to provide feedback.

## Guide Summary
The guide can be accessed as this repositories wiki.  
The home page of the guide provides a summary of the sections.

## Repository Codes
###Cookie Hunt
Please write a description for this EDWARD

####Aim
####Features
####Example Usage Scenario
####Open Issues & Bugs
####Planned Features / Expansion
####Code  
- [repository]()

***





###Hello World
Getting a LED to turn on and off.

####Aim
This project aims to get basic start on how to use the GPIO pins on the ESP8266 and identify the corresponding IO index to GPIO pins using the table index. By using the GPIO pins to turn on and off the LED. Some features like using timer and PWM is also introduced. It also looks at how to setup a simple HTTP webserver using TCP connection and through the webserver to control the LED.

####Features
- How to use the GPIO pins
- Using timer
- Using Pulse Width Modulation
- Connect to Wi-Fi access point
- Host a webserver

####Example Usage Scenario
One of the best way to get to know about the ESP8266 and get a start on using it. Instead of using to turn on and off the LED, other small voltage appliances can be attached to the GPIO pins and can be controlled from it, example a small speaker that will beep when the pin is set.

####Open Issues & Bugs
- Connection of the LED to the ESP8266 via the breadboard diagram needs to be label

####Planned Features / Expansion
- Add more detailed diagrams on how to connect a LED to the ESP8266 via a breadboard

####Code
- [repository](https://github.com/664306x/swin.edu.au-esp8266/tree/master/Hello%20World)

***





###Shower
An online sensor for how long presence in shower.

Author: Luke Jackson, 664306x 

####Aim
This project aims to build a sensor that can determine presence in a shower stall, and determine whether the shower is running. After a defined time limit, a beep will issue (for proof of concept) giving indication of time spent. After a subsequent defined time limit, a message will be logged on an external server so that medical staff can be aware that there patient has been exposed and how frequently. For information please see the readme in the [repository](https://github.com/664306x/swin.edu.au-esp8266/tree/master/Shower).

Additionally the projects combined with its guide section is a working example of how to do various things with an ESP8266.

####Features
- The use of, and writing a state machine.
- Using a framework code to save time when writing an ESP8266 application.
- Interacting with digital sensors in the interrupt and output modes.
- Use of the NodeMCU timer functions.
- Using the MQTT protocol to enable remote server logging and real time notifications.
- Using the ADC.
- Using the Pulse width functions.

####Example Usage Scenario
A person who sufferes dementia may enter a hot shower and lose track of how long they have been in the shower.  
- When they begin, the application auto starts (thus not relying on the dementia patents memory to press 'start'). 
- After set intervals the person is notified, thus affording them a way to keep track of the time. 
- A finalised version (the versions found in the repo are proof of concepts and or incomplete) would include a readout led, so that the dementia patient does not need to remember what the beeps mean.
- Abnormally long showers are logged to a server and or notified to a nurse in real time.

####Open Issues & Bugs
- Memory issues (solved with Edward through 'music' project. Same technique should work here).
- Currently not finished. (hope to update before submission date!).

####Planned Features / Expansion
- 1 sensor simple version is planned for submission
- Multi sensor version
- LED screen
- Flow sensor module incorporation.

####Code
- [repository](https://github.com/664306x/swin.edu.au-esp8266/tree/master/Shower)

***





###ESP8266 Environment Installers
An environment setup installer.

Author: Luke Jackson, 664306x 

####Aim
The installer provides a one click solution to getting a Windows PC ready to start playing with an ESP8266. The installer bundles tools we have found to be necessary or usefull for working with an ESP8266.

####Features
The following are included, as of the latest version.  
- Check for Java installation. Link to download page if not found. (requied for ESPlorer).
- Check for lua for windows installation. Links to the download page if not found. This is not a dependency, but makes writing and debugging lua code a much more enjoyable task.
- ESPlorer, an IDE written by todo which provides a gui for serial communication (requires Java).
- ESP8266Flasher.exe, an application written by todo which provides an easy to use gui for flashing new firmware to an ESP8266 chip.
- Firmware.
- Example .lua scripts.

####Example Usage Scenario
Somebody wants to get up to scratch with an ESP8266 in a few hours. By running the installer, they will have a folder on their PC that includes everything they will need to follow every section of the guide. They are able to focus on using the chip and not researching the best or required software.

####Open Issues & Bugs
-Leaves the archive after install. Should delete it.

####Planned Features / Expansion
-Include links to all included files pages
-Update check

####Code
The installer was created with [inno setup](http://www.jrsoftware.org/isinfo.php). The .iss is the source code.
- [repository](https://github.com/664306x/swin.edu.au-esp8266/tree/master/esp8266_environment_installers/win)

***




###Home Security System
A Secrity Intrustion Detection System for ESP8266.

Author: Luke Jackson, 664306x  

####Aim  
To prototype and demonstrate the ESP8266 working as a motion detector server for home security (or just motion detection in some local).  
To example various abilities of the ESP8266 chip running NodeMCU.

####Features
- Use of a digital sensor.
- Use of the PWM functions.  
- Use of MQTT protocol.  

####Example Usage Scenario
- The system is installed in the home. If motion is detected a message is recieved on the home owners computer, notifing them there is moving in their home.
- The system presented is installed in the mailbox. When the mail arrives, a message is recived on the owners computer, notifying of the mail arrival.
- Someone wants to learn how to use MQTT (or other concepts covered) by example, so they follow the guide for this project on the WIKI.

####Planned Features / Expansion
- Disable alarm via code entry.
- Package into an application (init.lua)

####Open Issues and Bugs
- Unable to achieve functionality from a single power source.
- Wiki should be re-written, using proper single power source.
- Should be packaged into an application and init.lua.

####Code
See 
- [repository](https://github.com/664306x/swin.edu.au-esp8266/tree/master/homeSecuritySystem)
- [part 1](https://github.com/664306x/swin.edu.au-esp8266/blob/master/homeSecuritySystem/part1.lua)
- [part 2](https://github.com/664306x/swin.edu.au-esp8266/blob/master/homeSecuritySystem/part2.lua)

***





###LED Webserver
Please write a description for this EDWIN

####Aim
####Features
####Example Usage Scenario
####Open Issues & Bugs
####Planned Features / Expansion
####Code
- [repository]()

***



###Music
A music Library for ESP8266.

Author: Luke Jackson, 664306x.  

####Aim
To provide an easy to use library that allows people using an ESP8266 chip running the NodeMCU firmware to use the PWM and a speaker to put of melodies. By using the library, people can have their internet of things devices that signal via audio to be more interesting, and useable. 

####Features

- Create a monophonic melody from the full western spectrum of music.
- 6 Octaves of range.
- Free timing.
- Dynamics.
- API

####Example Usage Scenarios
An esp8266 chip is installed in a toaster. When the toast has popped, the ESP8266 plays a fitting melody, such as the Zelda ‘get item’ melody. By using the music library, the Internet of Things toaster is a lot cooler than if it just buzzed.

####Open Issues & Bugs
-Dynamics function does not seem to be working.

####Planned Features / Expansion
- Better timing control (more abstracted / high level)

####Code
See 
- [repository](https://github.com/664306x/swin.edu.au-esp8266/tree/master/music)
- [music](https://github.com/664306x/swin.edu.au-esp8266/blob/master/music/music.lua)
- [notes](https://github.com/664306x/swin.edu.au-esp8266/blob/master/music/notes.lua)
- [usage example](https://github.com/664306x/swin.edu.au-esp8266/blob/master/music/usage_example.lua)

***





###WebIDE
Please write a description for this ADAM
####Aim
####Features
####Example Usage Scenario
####Open Issues & Bugs
####Planned Features / Expansion
####Code
- [repository]()

***





###Other
Does not contain any usefull code.  
Contains research conducted by the team about the problem space and possible solution, scope, deliverables and spikes.

####Spikes
A spike is a methodology for identidying and effeciently overcoming a knowledge gap. The team embraced spiking to solve many of the early knowledge gap, and the achieved knowledge is recorded in the outcomes here. These outcomes can be usefull for filling knowledge gaps on there topics.

[PDFs](https://github.com/664306x/swin.edu.au-esp8266/tree/master/Other/Spikes)

####Guide pictures
Using Git to host the images used in the guide.
