wifi.setmode(wifi.STATION)
wifi.sta.config("Chris-2.4G", "chris001")
print('Attempting connection')
wifi.sta.connect()

function checkStatus()
  local s=wifi.sta.status()
  print("Status = " .. s) 
  if s==5 then
    tmr.stop(0)
  end
end

-- every second, check our status
tmr.alarm(0, 1000, 1, checkStatus)
