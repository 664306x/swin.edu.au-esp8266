-- Copyright (c) 2015 by Geekscape Pty. Ltd, Edward Gilbert.  Licence LGPL V3.

-- Execute via the Skeleton framework
--
-- init.lua:   app = require("mail_notifier")
-- config.lua: module.HOST = UDP_SERVER_IP_ADDRESS
-- config.lua: module.PORT = 1337

local module = {}

GPIO_2 = 4   -- This is the GPIO2 connection pin on the ESP8266
TIME_CHECK = 25 -- Time to check the state of the IR beam. (open/closed) 25ms
TIMER_CHECK_ID = 1 -- used with tmr.alarm()

-- The beam is NO (normally open) and connected between the gpio2 pin and ground
-- When the beam is crossed...

BEAM_OPEN = 0
BEAM_CLOSED = 1

MESSAGE = "You've got snail mail!\n"
gpio.mode(GPIO_2, gpio.INPUT, gpio.PULLUP)  -- set GPIO2 mode

switch_state = BEAM_CLOSED -- holds the state of the last check
switch_time  = 0

function sendMessage()
  print(MESSAGE)
  socket:send(MESSAGE)
end

function irBeamHandler()
  switch_state_new = gpio.read(GPIO_2) -- reads state on gpio2, returns 1 or 0
  if switch_state == BEAM_OPEN and switch_state_new == BEAM_CLOSED then
  print("bed goes up")
  elseif switch_state == BEAM_CLOSED and switch_state_new == BEAM_OPEN then
    -- tmr.time() - return rtc time since start up in second, uint31 form
    switch_time = tmr.time()
    print("bed goes down")  -- DO SOMETHING USEFUL
    sendMessage()
    switch_time_new = tmr.time()    
  end
  switch_state = switch_state_new
end

function module.start()
  print("we're ready master")

  socket = net.createConnection(net.UDP, 0)
  socket:connect(config.PORT, config.HOST)

  -- tmr.alarm(id 0-6, interval in ms, repeat flag (0=once, 1=until tmr.stop(id)), function)
  tmr.alarm(TIMER_CHECK_ID, TIME_CHECK, 1, irBeamHandler)
end

return module
