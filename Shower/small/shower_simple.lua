local module = {}

offtimerActive=false
alarmTimersActive=false
function module.start()
print('5')
tmr.stop(4)
gpio.write(7,gpio.LOW)
gpio.mode(7, gpio.INPUT)
gpio.mode(5, gpio.INT)
gpio.write(5,0)
pwm.setup(6, 500, 512)
gpio.trig(5,'up',killSwitch)
tmr.alarm(4,500,1,onChange)
end
function getState()
--a = gpio.read(7)
a = adc.read(0)
print(a)
if a <100 then
a = 0
else
a = 1
end
return a
end

function stateTransition(newState)
print('state: '..newState)
if newState == 1 then
    tmr.stop(0)
    offtimerActive=false
    if not alarmTimersActive then
        alarmTimersActive =true
        tmr.alarm(1,10000,0, beepBeep)
        tmr.alarm(2,20000,0, beepBeep)
        tmr.alarm(3,30000,0, thirdAlarm)
    end
elseif not offtimerActive then
    offtimerActive=true
    tmr.alarm(0,3000,0, showerFinished)
end
end
function showerFinished()
print('shower fin')
tmr.stop(0)
offtimerActive=false
tmr.stop(1)
tmr.stop(2)
tmr.stop(3)
alarmTimersActive=false
pwm.stop(6)
end
function beepBeep()
pwm.start(6)
tmr.delay(300000)
pwm.stop(6)
tmr.delay(300000)
end
function thirdAlarm()
pwm.start(6)
end
function onChange()
stateTransition(getState())
end
function killSwitch()
print('killswitch')
tmr.stop(0)
offtimerActive=false
tmr.stop(1)
tmr.stop(2)
tmr.stop(3)
alarmTimersActive=false
pwm.stop(6)
onChange()
end
return module

