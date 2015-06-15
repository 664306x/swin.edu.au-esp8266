local function checkWiFiStatus()
  local s = wifi.sta.status()
  print("WiFi Status: " .. s) 
  if s == 5 then
    tmr.stop(0)
    print("Connected on " .. wifi.sta.getip())
  end
end

cfg = {}
cfg.ssid = "Cookies"
cfg.password = "i<3cookies"
wifi.ap.config(cfg)
cfg = nil
wifi.setmode(wifi.SOFTAP)
print('Attempting connection')
wifi.ap.connect()
tmr.alarm(0, 1000, 1, checkWifiStatus)
checkWifiStatus = nil
srv = require("server")
