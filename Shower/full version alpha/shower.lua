local module = {}
currentState = "init"
showerUsedRecently = "0"
for k,v in ipairs{3,10,4,9,2,1,nil,nil,nil,11,12,nil,6,7,5,8,0} do _G['GPIO'..k-1]=v end   --map gpio index to names
offtimerActive=false
alarmTimersActive=false

function module.start()
	print("application start")
	gpio.mode(GPIO13, gpio.INPUT) -- microphone
	gpio.mode(GPIO14, gpio.INT) -- off switch
	gpio.write(GPIO14,0)
	pwm.setup(GPIO12, 500, 512) --speaker
    m = mqtt.Client("clientid", 120, config.MQTTClientUser, config.MQTTClientUser)
	m:lwt("/lwt", "offline", 0, 0)
	m:on("connect", function(con) print ("connected") end)
	m:on("offline", function(con) print ("offline") end)
    m:on("message", function(conn, topic, data)
	  print(topic .. ":" )
	  if data ~= nil then
		print(data)
	  end
	end)
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

function getState()
	a = gpio.read(GPIO13)
	b = adc.read(0)--pir
	if b < 100 then
	  b = 0
	else
	  b = 1
	end
	return a..b
end

function stateTransition(newState)

	previousState = currentState
	currentState = newState

	if config.debug then
	    print('From: '..previousState..' to: '..currentState)
	end

	if newState ==     "00" then
		if not offtimerActive then
			offtimerActive=true
			tmr.alarm(0,3000,0, showerFinished)
		end
	elseif newState == "01" then
		if not offtimerActive then
			offtimerActive=true
			tmr.alarm(0,3000,0, showerFinished)
		end
	elseif newState == "10" then
		if not offtimerActive then
			offtimerActive=true
			tmr.alarm(0,3000,0, showerFinished)
		end
	elseif newState == "11" then
		tmr.stop(0)
		offtimerActive=false
		if not alarmTimersActive then
			alarmTimersActive =true
			tmr.alarm(1,(1000*config.Alarm1),0, beepBeep)
			tmr.alarm(2,(1000*config.Alarm2),0, beepBeep)
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

function beepBeep()
	pwm.start(GPIO12)
	tmr.delay(300000)
	pwm.stop(GPIO12)
	tmr.delay(300000)
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

