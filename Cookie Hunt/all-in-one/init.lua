local function checkWiFiStatus()
  local s = wifi.sta.status()
  print("WiFi Status: " .. s) 
  if s == 5 then
    tmr.stop(0)
    print("Connected on " .. wifi.sta.getip())
  end
end

wifi.ap.config("Cookies", "i<3cookies")
wifi.setmode(wifi.SOFTAP)
print('Attempting connection')
wifi.ap.connect()
tmr.alarm(0, 1000, 1, checkWifiStatus)
checkWifiStatus = nil
wifi_setup = require("wifi_setup")
files = require("files")
srv = require("server")
