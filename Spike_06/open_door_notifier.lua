-- Copyright (c) 2015 by Geekscape Pty. Ltd, Edward Gilbert.  Licence LGPL V3.

-- Execute via the Skeleton framework
--
-- init.lua:   app = require("open_door_notifier")
-- config.lua: module.HOST = UDP_SERVER_IP_ADDRESS
-- config.lua: module.PORT = 1337

local module = {}

GPIO_ZERO = 3   -- This is the GPIO0 connection pin on the ESP8266
TIME_ALARM = 30000  -- Time to wait before sending the shut the door message (60 seconds)
TIME_CHECK = 25 -- Time to check the state of the reed switch, and thus the door. (open/closed) 25ms
TIMER_CHECK_ID = 1 -- used with tmr.alarm()
ALARM_CHECK_ID = 2 -- used to time when to send the message

-- The reed switch is NO (normally open) and connected between the gpio0 pin and ground
-- When the door is open, the reed switch will turn off and the gpio0 state will turn from 1 to 0

DOOR_OPEN = 1
DOOR_CLOSED = 0

MESSAGE = "SHUT THE FRONT DOOR RAJ\n" -- Sent when TIME_ALARM is exceeded

gpio.mode(GPIO_ZERO, gpio.INPUT, gpio.PULLUP)  -- GPIO0

switch_state = DOOR_CLOSED -- holds the state of the last check
switch_time  = 0

function sendMessage()
  print(MESSAGE)
  socket:send(MESSAGE)
end

function reedSwitchHandler()
  switch_state_new = gpio.read(GPIO_ZERO) -- reads state on gpio0, returns 1 or 0
  if switch_state == DOOR_OPEN and switch_state_new == DOOR_CLOSED then
  print("The door is closed")
    tmr.stop(ALARM_CHECK_ID)
    
  elseif switch_state == DOOR_CLOSED and switch_state_new == DOOR_OPEN then
    -- tmr.time() - return rtc time since start up in second, uint31 form
    switch_time = tmr.time()
    print("The door is open")  -- DO SOMETHING USEFUL
    tmr.alarm(ALARM_CHECK_ID, 30000, 1, sendMessage)
    switch_time_new = tmr.time()    
  end
  switch_state = switch_state_new
end

function module.start()
  print("button_udp")

  socket = net.createConnection(net.UDP, 0)
  socket:connect(config.PORT, config.HOST)

  -- tmr.alarm(id 0-6, interval in ms, repeat flag (0=once, 1=until tmr.stop(id)), function)
  tmr.alarm(TIMER_CHECK_ID, TIME_CHECK, 1, reedSwitchHandler)
end

return module
