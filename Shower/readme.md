Author: Luke Jackson, 664306x

# Project Description

The most common place for falls in the home is in the bathroom. In order to embrace internet of things with the goal of increasing safety in the home and giving greater independence to the elderly or people with disabilities, the bathroom is probably the best place to start.

When the shower is used, the body is exposed to hot temperatures typically in the range of 30 to 40 degrees Celsius. Whilst young or otherwise healthy people can tolerate this almost indefinably, such exposure is straining on the elderly. Compacted with the fact that most dementia suffers are elderly, this can be a dangerous risk for them. It has been observed that dementia suffers may forget how long they have been in the shower, and thus unintentional over expose themselves.

This project aims to build a sensor that can determine presence in a shower stall, and determine whether the shower is running. After a defined time limit, a beep will issue (for proof of concept) giving indication of time spent. After a subsequent defined time limit, a message will be logged on an external server so that medical staff can be aware that there patient has been exposed and how frequently.

##Features
- The use of, and writing a state machine.
- Using a framework code to save time when writing an ESP8266 application.
- Interacting with digital sensors in the interrupt and output modes.
- Use of the NodeMCU timer functions.
- Using the MQTT protocol to enable remote server logging and real time notifications.
- Using the ADC.
- Using the Pulse width functions.

##Example Usage Scenario
A person who sufferes dementia may enter a hot shower and lose track of how long they have been in the shower.  
- When they begin, the application auto starts (thus not relying on the dementia patents memory to press 'start'). 
- After set intervals the person is notified, thus affording them a way to keep track of the time. 
- A finalised version (the versions found in the repo are proof of concepts and or incomplete) would include a readout led, so that the dementia patient does not need to remember what the beeps mean.
- Abnormally long showers are logged to a server and or notified to a nurse in real time.

##Open Issues & Bugs
- Memory issues (solved with Edward through 'music' project. Same technique should work here).
- Currently not finished. (hope to update before submission date!).

##Planned Features / Expansion
- 1 sensor simple version is planned for submission
- Multi sensor version
- LED screen
- Flow sensor module incorporation.
