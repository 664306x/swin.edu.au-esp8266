
###Open Issues

1. 

   - problem: The application cannot run (with or without compiling) due to 'not enough memory'
   - solution:An extremly trimmed down version was created by taking parts out piecemeal until the esp8266 would run it. This version has had the following removed,
   
        - wifi connection (its just acting like a normal micro controller now)
        - config (everything is hard coded)
        - MQTT related code
        - all comments
        - short cut global variables

2. 

  - problem: The microphone sensor is extremely difficult to use due to sensitivity issues. The sensor seems to trigger with noise, sometimes. if the noise continues it also untriggers anyway.
  - solution:the microphone component is no longer included. It is recommended a different sensor take its place, specifically a flow control. [http://tronixlabs.com/water-flow/]



