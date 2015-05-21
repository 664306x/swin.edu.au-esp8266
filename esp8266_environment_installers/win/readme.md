Author: Luke Jackson, 66406x

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
