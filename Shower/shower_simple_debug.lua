local module = {}

currentState = "init"
showerUsedRecently = "0"
for k,v in ipairs{3,10,4,9,2,1,nil,nil,nil,11,12,nil,6,7,5,8,0} do _G['GPIO'..k-1]=v end   --map gpio index to names

offtimerActive=false
alarmTimersActive=false

function module.start()
	print("application start")

--	 gpio Sensors
--	 dB trigger: gpio.INPUT  (input because it constantly switches), 	pin 13 (index 7)
--	 IR motion: ADC
--	 Speaker (beep): PWM 		pin 12 (index 6)
--	 kill switch: gpio.INT,				pin 14 (index 5)

	gpio.mode(GPIO13, gpio.INPUT) -- microphone
	gpio.mode(GPIO14, gpio.INT) -- off switch
	gpio.write(GPIO14,0)
	pwm.setup(GPIO12, 500, 512) --speaker

	-- MQTT
	-- init mqtt client with keepalive timer 120sec (the open server im using here (eclipse) doesnt require authentication)
	m = mqtt.Client("clientid", 120, config.MQTTClientUser, config.MQTTClientUser)
	m:lwt("/lwt", "offline", 0, 0)
	m:on("connect", function(con) print ("connected") end)
	m:on("offline", function(con) print ("offline") end)

	-- on publish message receive event
	-- for debug purpose ~remove me after c++ listen/log app written
	m:on("message", function(conn, topic, data)
	  print(topic .. ":" )
	  if data ~= nil then
		print(data)
	  end
	end)
	-- end mqtt

	gpio.trig(gpio14,'up',debounce(killSwitch))
	tmr.alarm(4,1000,1,onChange)
end

function debounce (func)
    local last = 0
    local delay = 200000

    return function (...)
        local now = tmr.now()
        if now - last < delay then return end

        last = now
        return func(...)
    end
end

--returns an code that relates to the state
function getState()
	a = gpio.read(GPIO13)  --dB trigger
	b = adc.read(0)        --IR sens

	--convert 10 bit signal to 1 bit.
	if b < 100 then
	  b = 0
	else
	  b = 1
	end
	return a..b
end

function stateTransition(newState)
--			STATES
	-- id	|desc					|sensors
	------------------------------------------------------------------------
	-- 00	|shower/bathroom not in use					|dB trigger: l, IR sens: l
	-- 01	|someone in bathroom, or just ended shower	|dB trigger: l, IR sens: h
	-- 10	|shower on, not in, running toget hot water?|dB trigger: h, IR sens: l
	-- 11	|in shower									|dB trigger: h, IR sens: h
--		TIMERS
	-- 0    | delay before ending shower
	-- 1	| alarm for being in the shower 2 minutes (1st, just beep)
	-- 2	| alarm for being in the shower 4 minutes (2nd, just beep)
	-- 3	| alarm for being in the shower 5 minutes (3rd, beep until state transition, and log event)
	-- 4	| polling for state changes.


	previousState = currentState
	currentState = newState

	if config.debug then
	    print('From: '..previousState..' to: '..currentState)
	end

	if newState ==     "00" then
		if not offtimerActive then
			offtimerActive=true
			tmr.alarm(0,3000,0, showerFinished())
		end
	elseif newState == "01" then
		if not offtimerActive then
			offtimerActive=true
			tmr.alarm(0,3000,0, showerFinished())
		end
	elseif newState == "10" then
		if not offtimerActive then
			offtimerActive=true
			tmr.alarm(0,3000,0, showerFinished())
		end
	elseif newState == "11" then
		tmr.stop(0)
		offtimerActive=false
		if not alarmTimersActive then
			alarmTimersActive =true
			tmr.alarm(1,(1000*config.Alarm1),0, beepBeep(2))
			tmr.alarm(2,(1000*config.Alarm2),0, beepBeep(4))
			tmr.alarm(3,(1000*config.Alarm3),0, thirdAlarm)
		end
	end
end

function stopAlarm()
  pwm.stop(GPIO12)
end

function showerFinished()
		tmr.stop(0)
		offtimerActive=false

		tmr.stop(1)
		tmr.stop(2)
		tmr.stop(3)
		alarmTimersActive=false

		pwm.stop(GPIO12)
end

function beepBeep(cnt)
	for i=0,cnt,1
	do
		pwm.start(GPIO12)
		tmr.delay(300000)
		pwm.stop(GPIO12)
		tmr.delay(300000)
	end
end

function thirdAlarm()
	-- log to server
	writeToServer(">5m")
	-- alarm doesnt stop until a state transition (or kill switch)
	pwm.start(GPIO12)
end

function onChange()
	stateTransition(getState())
end

function killSwitch()
	tmr.stop(0)
	offtimerActive=false

	tmr.stop(1)
	tmr.stop(2)
	tmr.stop(3)
	alarmTimersActive=false

	pwm.stop(GPIO12)
	onChange()
end

function writeToServer(msg)
	m:connect(config.MQTTHost, config.MQTTPort, config.MQTTSecure, function(conn) print("connected") end)
	m:subscribe("/cab309eb-d5c1-47b3-b65f-90056d70d71d",0, function(conn) print("subscribe success") end)
	m:publish("/cab309eb-d5c1-47b3-b65f-90056d70d71d",msg,0,0, function(conn) print("sent") end)
	m:close();
end

return module

